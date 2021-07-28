export Context

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
send a message to another function
"""
function send_message(context::Context, address::Address, value; duration::Union{Nothing, Dates.TimePeriod}=nothing)
    argument = make_argument(context.statefuns, value)
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
    argument = make_argument(context.statefuns, value)
    msg = FromFunction_EgressMessage(
        egress_namespace=egress_namespace,
        egress_type=egress_type,
        argument=argument
    )
    push!(context.invocation_response, :outgoing_egresses, msg)
end

