using Mux, StateFun, ProtoBuf
import JSON3

"""
This follows the greeter example in the flink stateful function playground.
It's based on the python example.
"""

# handle our greeter func
function greeter_handler(context::Context, o::JSON3.Object)
    person = o.name
    println("greeting! $person")
end

# handle our person func
function person_handler(context::Context, o::JSON3.Object)
    person = o.name
    println("person $person")
end

# define our functions and types
handler = StatefulFunctions(functions = Dict(
    "example/greeter" => greeter_handler,
    "example/person" => person_handler
), types = [
    # note: in the python greeter example, the message/argument content is a json object like {"name": "Bob"}
    ("example/GreetRequest", JSON3.Object)
])

# need to tell StateFun how to (de)serialize our messages
StateFun.serialize(o::JSON3.Object) = Vector{UInt8}(JSON3.write(o))
StateFun.deserialize(io::IO, ::Type{JSON3.Object}) = JSON3.read(io)

# start the statefun service
serve_functions(handler)