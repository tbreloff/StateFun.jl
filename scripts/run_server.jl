using Mux, StateFun, ProtoBuf

function greet_handler(context::Context, person::String)
    println("greeting! $person")
end
function person_handler(context::Context, person::String)
    println("person $person")
end

handler = StatefulFunctions(functions = Dict(
    "example/GreetRequest" => greet_handler,
    "example/person" => person_handler
))

# TODO: need to register a type with name "example/GreetRequest"
# which is a json object like: {"name": "Bob"}
# and will also need json serialization for it

serve_functions(handler)