
import Dates

export StorageSpec, store, store!, register!

struct StorageSpec
    name::String
    _type::Type
    expire_after_call::Union{Nothing,Dates.TimePeriod}
    expire_after_write::Union{Nothing,Dates.TimePeriod}
end

# TODO macro so that you can put something like this in your function to initialize storage:
#     @store x::Int64 = 1
# which would register a new storage value with name "x" and default/starting value 1

function StorageSpec(name::String, _type::Type; expire_after_call=nothing, expire_after_write=nothing) 
    StorageSpec(name, _type, expire_after_call, expire_after_write)
end

function make_expiration_spec(spec::StorageSpec)
    mode, millis = if !isnothing(spec.expire_after_call)
        FromFunction_ExpirationSpec_ExpireMode.AFTER_INVOKE, Dates.toms(spec.expire_after_call)
    elseif !isnothing(spec.expire_after_write)
        FromFunction_ExpirationSpec_ExpireMode.AFTER_WRITE, Dates.toms(spec.expire_after_write)
    else
        FromFunction_ExpirationSpec_ExpireMode.NONE, 0
    end
    FromFunction_ExpirationSpec(
        mode=mode,
        expire_after_millis=millis
    )
end

"""
Holds both the initial persisted state and any updates.
"""
struct Storage{T}
    initial_state_value::Union{Nothing, T}

    # starts as nothing.
    # missing means "delete"
    # any T value means "update"
    mutated_value::Union{Nothing, Missing, T}
end

existing_state(value::T, ::Type{SUP}) where {SUP, T<:SUP} = Storage{SUP}(value, nothing)
existing_state(value::T) where T = existing_state(value, T)

new_state(value::T, ::Type{SUP}) where {SUP, T<:SUP} = Storage{SUP}(nothing, value)
new_state(value::T) where T = new_state(value, T)

"""
get the currently-stored value.
"""
function store(storage::Storage)
    isnothing(storage.mutated_value) ? storage.initial_state_value : storage.mutated_value
end

"""
    store!(::Storage{T}, value::T)
update the currently-stored value
"""
store!(storage::Storage{T}, value::T) where T = storage.mutated_value = value

"""
    store!(::Storage)
delete the stored value
"""
store!(storage::Storage) = storage.mutated_value = missing
