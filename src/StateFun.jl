module StateFun

include("protos.jl")

export ReqRepHandler, handle

"""
Register handlers with the given addresses.
"""
struct ReqRepHandler
    handlers::Dict{String, Function}
end

function handle(handler::ReqRepHandler, tofunc::ToFunction)
    invocations = tofunc.invocation.invocations
    println("invs: $invocations")
    typename = invocations[1].argument.typename
    println("typename: $typename")
    if in(handler.handlers, typename)
        println("handling")
        handler.handlers[typename](tofunc)
    else
        println("error")
        error("No handler for $typename: $tofunc")
    end
end


end # module
