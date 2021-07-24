
export StatefulFunctions, Context

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

        register(o, "int_value", IntWrapper)
        register(o, "float_value", FloatWrapper)
        register(o, "long_value", LongWrapper)
        register(o, "str_value", StringWrapper)
        register(o, "double_value", DoubleWrapper)
        register(o, "bool_value", BooleanWrapper)
        
        for (typename, _type) in types
            register(o, typename, _type)
        end

        o
    end
end

function register(statefuns::StatefulFunctions, typename::String, ::Type{T}) where T
    statefuns.type_map[typename] = T
    statefuns.typename_map[T] = typename
end

get_function(statefuns::StatefulFunctions, typename::String) = statefuns.functions[typename]
get_type(statefuns::StatefulFunctions, name::String) = statefuns.type_map[name]
get_typename(statefuns::StatefulFunctions, _type::Type) = statefuns.typename_map[_type]


# """
# Holds everything we need in order to use a type either in stateful 
# functions storage or message.
# """
# struct TypeInfo
#     typename::String
#     _type::Type
#     serializer::Function # serializes the type to bytes
#     deserializer::Function # serializes the type to bytes
# end

"""
The typename of an address in StateFun is the string representing the function that the
message is being passed to.
"""
typename(address::Address) = "$(address.namespace)/$(address._type)"


function handle(statefuns::StatefulFunctions, tofunc::ToFunction)
    batch = tofunc.invocation

    # get the target function to call
    target_address = batch.target
    func_typename = typename(target_address)
    println("func_typename: $func_typename")
    func = get_function(statefuns, func_typename)
    println("func: $func")

    # init context
    context = Context()
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

struct ValueSpec
    name::String
    _type::Type
    # expire_after_call::TimeDelta
    # expire_after_write::TimeDelta
end

# TODO macro so that you can put something like this in your function to initialize storage:
#     @store x::Int64 = 1
# which would register a new storage value with name "x" and default/starting value 1

# function ValueSpec(name::String, _type::Type; expire_after_call=nothing, expire_after_write=nothing) 
#     ValueSpec(name, _type, expire_after_call, expire_after_write)
# end

"""
Holds both the initial persisted state and any updates.
"""
struct Storage
    value_spec::ValueSpec
    initial_storage::ToFunction_PersistedValue
    # TODO: manage state changes
end

"""
Manages all inputs, updates, and messages to sent in a function.
The goal is to build up a FromFunction that can be sent back to
the stateful functions runtime.
"""
mutable struct Context
    storage::Dict{String, Storage}
    caller::Union{Address, Nothing}
    fromfunc::FromFunction

    Context() = new(Dict{String, Storage}(), nothing, FromFunction())
end

