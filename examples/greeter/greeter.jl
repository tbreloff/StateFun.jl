"""
Start a Genie web server which hosts the stateful functions.
"""
module GreeterServer

using Genie, StateFun

const FuncMap = Dict{String, Function}

struct StatefulFunctions
    functions::FuncMap
end
StatefulFunctions() = StatefulFunctions(FuncMap())
register(functions::StatefulFunctions, func::Function) = push!(functions.functions, func)

function handle(functions::StatefulFunctions, payload) 
    # deserialize payload into invocation/context
    # get address and attempt to match to registered function
    # call function with context/message
    # build invocation reply and return
end

struct RequestReplyHandler
    functions::StatefulFunctions
end



route("greet", method=POST) do
    payload = rawpayload()
    resp = handle(functions, payload)
    # todo: serialize/package response
end

# start the server
up(6666, "127.0.0.1")

end #module