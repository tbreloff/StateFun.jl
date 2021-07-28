
export StatefulFunctions, StatefulFunction, make_argument, make_value

struct StatefulFunction
    func::Function
    storage_specs::Vector{StorageSpec}
    StatefulFunction(func::Function) = new(func, Vector{StorageSpec}())
end

function Base.push!(statefun::StatefulFunction, storage_spec::StorageSpec)
    push!(statefun.storage_specs, storage_spec)
end

"""
Maintains all registered types and functions.
"""
struct StatefulFunctions
    # maps address's typename to the registered function
    functions::Dict{String, StatefulFunction}

    # maps the typename of a TypedValue to its type
    type_map::Dict{String, Type}
    # the reverse lookup
    typename_map::Dict{Type, String}

    function StatefulFunctions(; functions = Dict{String, StatefulFunction}(), types = Tuple{String, Type}[])
        o = new(functions, Dict{String, Type}(), Dict{Type, String}())

        register!(o, "int_value", IntWrapper)
        register!(o, "float_value", FloatWrapper)
        register!(o, "long_value", LongWrapper)
        register!(o, "str_value", StringWrapper)
        register!(o, "double_value", DoubleWrapper)
        register!(o, "bool_value", BooleanWrapper)
        
        for (typename, _type) in types
            register!(o, typename, _type)
        end

        o
    end
end

function register!(statefuns::StatefulFunctions, typename::String, ::Type{T}) where T
    statefuns.type_map[typename] = T
    statefuns.typename_map[T] = typename
end

get_function(statefuns::StatefulFunctions, typename::String) = statefuns.functions[typename]
get_type(statefuns::StatefulFunctions, name::String) = statefuns.type_map[name]

function get_typename(statefuns::StatefulFunctions, _type::Type)
    if haskey(statefuns.typename_map, _type)
        statefuns.typename_map[_type]
    else
        for (k, v) in statefuns.typename_map
            if _type <: k
                return v
            end
        end
    end
end

"""
The typename of an address in StateFun is the string representing the function that the
message is being passed to.
"""
typename(address::Address) = "$(address.namespace)/$(address._type)"


function get_message(statefuns::StatefulFunctions, argument::TypedValue)
    msg_typename = argument.typename
    msg_type = get_type(statefuns, msg_typename)
    @show msg_type
    msg = deserialize(argument.value, msg_type)
    @show msg
    msg
end

"""
create a TypedValue by using the registered typename and defined serialization
"""
function make_argument(statefuns::StatefulFunctions, value)
    T = typeof(value)
    typename = get_typename(statefuns, T)
    bytes = serialize(value)
    TypedValue(typename=typename, has_value=true, value=bytes)
end

function make_value(statefuns::StatefulFunctions, typed_value::TypedValue)
    T = get_type(statefuns, typed_value.typename)
    deserialize(typed_value.value, T)
end
