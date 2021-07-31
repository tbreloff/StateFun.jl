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

    Context(statefuns::StatefulFunctions, tofunc::ToFunction) = new(
        statefuns, 
        tofunc,
        Dict{String, Storage}(), 
        nothing, 
        FromFunction_InvocationResponse()
    )
end

function init_storage(statefuns::StatefulFunctions, tofunc::ToFunction)
    d = Dict{String, Storage}()
    for state in tofunc.invocation.state
        # state is PersistedValue
        T = get_type(statefuns, state.state_value.typename)
        value = deserialize(typed_value.value, T)
        storage = existing_state(value, T)
        d[state.state_name] = storage
    end
    d
end

"""
compare what's been stored in the storage dict with the original
tofunc and add state mutations to the invocation_response
"""
function add_state_mutations!(context::Context)
    @show context.storage
    @show context.invocation_response
    for (state_name, storage) in context.storage
        if ismissing(storage.mutated_value)
            if !isnothing(storage.initial_state_value)
                # need to delete this state
                state_chg = FromFunction_PersistedValueMutation(
                    mutation_type=FromFunction_PersistedValueMutation_MutationType.DELETE,
                    state_name=state_name
                )
                push!(context.invocation_response, :state_mutations, state_chg)
            end
        elseif !isnothing(storage.mutated_value)
            if storage.mutated_value != storage.initial_state_value
                # updated value
                state_chg = FromFunction_PersistedValueMutation(
                    mutation_type=FromFunction_PersistedValueMutation_MutationType.MODIFY,
                    state_name=state_name,
                    state_value=make_argument(context.statefuns, storage.mutated_value)
                )
                push!(context.invocation_response, :state_mutations, state_chg)
            end
        end
    end
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

