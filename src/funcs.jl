
import Dates

export StatefulFunctions, Context, store, store!

"""
Maintains all registered types and functions.
"""
struct StatefulFunctions
    # maps address's typename to the registered function
    functions::Dict{String, Function}

    # maps the typename of a TypedValue to its type
    type_map::Dict{String, Type}
    # the reverse lookup
    typename_map::Dict{Type, String}

    function StatefulFunctions(; functions = Dict{String, Function}(), types = Tuple{String, Type}[])
        o = new(functions, Dict{String, Type}(), Dict{Type, String}())

        register!(o, "int_value", IntWrapper)
        register!(o, "float_value", FloatWrapper)
        register!(o, "long_value", LongWrapper)
        register!(o, "str_value", StringWrapper)
        register!(o, "double_value", DoubleWrapper)
        register!(o, "bool_value", BooleanWrapper)
        
        for (typename, _type) in types
            register!(o, typename, _type)
        end

        o
    end
end

function register!(statefuns::StatefulFunctions, typename::String, ::Type{T}) where T
    statefuns.type_map[typename] = T
    statefuns.typename_map[T] = typename
end

get_function(statefuns::StatefulFunctions, typename::String) = statefuns.functions[typename]
get_type(statefuns::StatefulFunctions, name::String) = statefuns.type_map[name]

function get_typename(statefuns::StatefulFunctions, _type::Type)
    if _type in statefuns.typename_map
        statefuns.typename_map[_type]
    else
        for (k, v) in statefuns.typename_map
            if _type <: k
                return v
            end
        end
    end
end

"""
The typename of an address in StateFun is the string representing the function that the
message is being passed to.
"""
typename(address::Address) = "$(address.namespace)/$(address._type)"


"""
This is the main handler which maps ToFunction --> FromFunction
"""
function handle(statefuns::StatefulFunctions, tofunc::ToFunction)
    batch = tofunc.invocation

    # get the target function to call
    target_address = batch.target
    func_typename = typename(target_address)
    println("func_typename: $func_typename")
    func = get_function(statefuns, func_typename)
    println("func: $func")

    # init context
    context = Context(statefuns, tofunc)
    println("context: $context")
    for state in batch.state
        println("state: $state")
        # storage = Storage(state) # TODO init correctly
        # context.storage[state.state_name] = storage
    end

    for invocation in batch.invocations
        # add a caller address if there is one
        caller_address = hasproperty(invocation, :caller) ? invocation.caller : nothing
        context.caller = caller_address
        println("caller_address: $caller_address")

        # extract and deserialize the message
        msg = get_message(statefuns, invocation.argument)

        # call the function
        # note: the FromFunction is being built inside the function call.
        func(context, msg)
    end

    # return the FromFunction that has been built up through context calls.
    context.fromfunc
end

function get_message(statefuns::StatefulFunctions, argument::TypedValue)
    msg_typename = argument.typename
    msg_type = get_type(statefuns, msg_typename)
    println("msg_type: $msg_type")
    msg = deserialize(argument.value, msg_type)
    println("msg: $msg")
    msg
end

# struct ValueSpec
#     name::String
#     _type::Type
#     expire_after_call::Dates.TimePeriod
#     expire_after_write::Dates.TimePeriod
# end

# TODO macro so that you can put something like this in your function to initialize storage:
#     @store x::Int64 = 1
# which would register a new storage value with name "x" and default/starting value 1

# function ValueSpec(name::String, _type::Type; expire_after_call=nothing, expire_after_write=nothing) 
#     ValueSpec(name, _type, expire_after_call, expire_after_write)
# end

"""
Holds both the initial persisted state and any updates.
"""
struct Storage{T}
    initial_state_value::Union{Nothing, T}

    # starts as nothing.
    # missing means "delete"
    # any T value means "update"
    mutated_value::Union{Nothing, Missing, T}
end

existing_state(value::T, ::Type{SUP}) where {SUP, T<:SUP} = Storage{SUP}(value, nothing)
existing_state(value::T) where T = existing_state(value, typeof(T))

new_state(value::T, ::Type{SUP}) where {SUP, T<:SUP} = Storage{SUP}(nothing, value)
new_state(value::T) where T = new_state(value, typeof(T))

"""
get the currently-stored value.
"""
function store(storage::Storage)
    isnothing(storage.mutated_value) ? storage.initial_state_value : storage.mutated_value
end

"""
    store!(::Storage{T}, value::T)
update the currently-stored value
"""
store!(storage::Storage{T}, value::T) where T = storage.mutated_value = value

"""
    store!(::Storage)
delete the stored value
"""
store!(storage::Storage) = storage.mutated_value = missing

"""
Manages all inputs, updates, and messages to sent in a function.
The goal is to build up a FromFunction that can be sent back to
the stateful functions runtime.
"""
mutable struct Context
    statefuns::StatefulFunctions
    tofunc::ToFunction
    storage::Dict{String, Storage}
    caller::Union{Address, Nothing}
    # used in good states
    invocation_response::FromFunction_InvocationResponse
    # used in bad/error states
    incomplete_invocation_context::FromFunction_IncompleteInvocationContext

    Context(statefuns::StatefulFunctions, tofunc::ToFunction) = new(
        statefuns, 
        tofunc,
        Dict{String, Storage}(), 
        nothing, 
        FromFunction_InvocationResponse(),
        FromFunction_IncompleteInvocationContext()
    )
end

function init_storage(statefuns::StatefulFunctions, tofunc::ToFunction)
    d = Dict{String, Storage}()
    for state in tofunc.invocation.state
        # state is PersistedValue
        # state_name
        # state_value::TypedValue
        T = get_type(statefuns, state.state_value.typename)
        value = deserialize(typed_value.value, T)
        storage = existing_state(value, T)
        d[state.state_name] = storage
    end
    d
end

"""
get the currently-stored value.
"""
function store(context::Context, state_name::String)
    if haskey(context.storage, state_name)
        store(context.storage[state_name])
    else
        nothing
    end
end

"""
    store!(::Storage{T}, value::T)
update the currently-stored value
"""
function store!(context::Context, state_name::String, value::T) where T
    if haskey(context.storage, state_name)
        store!(context.storage[state_name], value)
    else
        context.storage[state_name] = new_state(value)
    end
end

"""
    store!(::Storage)
delete the stored value
"""
function store!(context::Context, state_name::String)
    if haskey(context.storage, state_name)
        store!(context.storage[state_name])
    end
end

"""
create a TypedValue by using the registered typename and defined serialization
"""
function make_argument(context::Context, value)
    T = typeof(value)
    typename = get_typename(context.statefuns, T)
    bytes = serialize(value)
    TypedValue(typename=typename, _has_value=true, value=bytes)
end

function make_value(statefuns::StatefulFunctions, typed_value::TypedValue)
    T = get_type(statefuns, typed_value.typename)
    deserialize(typed_value.value, T)
end

"""
send a message to another function
"""
function send_message(context::Context, address::Address, value; duration::Union{Nothing, Dates.TimePeriod}=nothing)
    argument = make_argument(context, value)
    if (isnothing(duration))
        # send
        invocation = FromFunction_Invocation(target=address, argument=argument)
        push!(context.invocation_response, :outgoing_messages, invocation)
    else
        # send delayed
        millis = Dates.Millisecond(duration).value
        delayed_invocation = FromFunction_DelayedInvocation(
            is_cancellation_request=false,
            delay_in_ms=millis,
            target=address,
            argument=argument
        )
        push!(context.invocation_response, :delayed_invocations, delayed_invocation)
    end
end

function send_egress(context::Context, value, egress_namespace::String, egress_type::String)
    argument = make_argument(context, value)
    msg = FromFunction_EgressMessage(
        egress_namespace=egress_namespace,
        egress_type=egress_type,
        argument=argument
    )
    push!(context.invocation_response, :outgoing_egresses, msg)
end

