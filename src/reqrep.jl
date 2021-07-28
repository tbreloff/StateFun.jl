
"""
return any StorageSpecs which aren't referenced in the ToFunction
"""
function get_missing_specs(statefun::StatefulFunction, invocation::ToFunction_InvocationBatchRequest)
    state_names = if hasproperty(invocation, :state)
        Set(state.state_name for state in invocation.state)
    else
        Set{String}()
    end
    @show state_names
    [spec for spec in statefun.storage_specs if spec.name ∉ state_names]
end

"""
when there are registered storage specs which are not included in the
ToFunction state, then reply with the missing specs.
"""
function make_incomplete_invocation(statefuns::StatefulFunctions, missing_specs::Vector{StorageSpec})
    incomplete = FromFunction_IncompleteInvocationContext()
    for missing_spec in missing_specs
        @show missing_spec
        push!(incomplete, :missing_values, FromFunction_PersistedValueSpec(
            state_name = missing_spec.name,
            expiration_spec = make_expiration_spec(missing_spec),
            type_typename = get_typename(statefuns, missing_spec._type)
        ))
    end
    FromFunction(incomplete_invocation_context=incomplete)
end

"""
successful case... build a FromFunction given the Context
"""
function make_fromfunction(context::Context)
    throw("todo: build the fromfunction from the context")
end

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

    missing_specs = get_missing_specs(func, batch)
    isempty(missing_specs) || return make_incomplete_invocation(statefuns, missing_specs)

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
        func.func(context, msg)
    end

    # return the FromFunction that has been built up through context calls.
    make_fromfunction(context)
end
