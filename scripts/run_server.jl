using Mux, StateFun, ProtoBuf

@app app = (Mux.defaults, # use Mux.prod_defaults later

    page("/statefun", req -> begin
        # req is a dict of Symbol to value
        println("REQ: $req")
        
        # pull out the raw byte payload in the :data field
        io = IOBuffer(req[:data])

        # deserialize the bytes into a ToFunction proto
        proto = ToFunction()
        println(proto)
        readproto(io, proto)

        println("tofunc: $proto")
        ""
    end),

    Mux.notfound()
)

port = length(ARGS)>1 ? parse(Int64, ARGS[1]) : 8000
println("Going to serve at http://localhost:$port")
wait(serve(app, port))