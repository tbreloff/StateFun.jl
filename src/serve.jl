using Mux

export serve_functions

"""
Create a Mux server to handle Stateful Functions requests
"""
function serve_functions(funcs::StatefulFunctions)
    @app app = (Mux.defaults, # use Mux.prod_defaults later

        page("/statefun", req -> begin
            # req is a dict of Symbol to value
            println("REQ: $req")

            # deserialize the bytes into a ToFunction proto
            tofunc = deserialize(req[:data], ToFunction)

            println("tofunc: $tofunc")
            fromfunc = try
                handle(funcs, tofunc)
            catch e
                println("error: $e")
                FromFunction()
            end
            println("fromfunc: $fromfunc")

            # return the serialized FromFunction
            serialize(fromfunc)
        end),

        Mux.notfound()
    )

    port = length(ARGS)>1 ? parse(Int64, ARGS[1]) : 8000
    println("Going to serve at http://localhost:$port")
    wait(serve(app, port))
end
