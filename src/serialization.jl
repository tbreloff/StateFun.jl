
import Serialization

"""
Implement this method for your type in order to do custom serialization.
Should return Vector{UInt8}
"""
function serialize end

"""
Implement this method for your type in order to do custom deserialization.
    deserialize(io::IO, ::Type{T})
"""
function deserialize end


"""
backup uses julia's serialization module
"""
function serialize(value)
    io = IOBuffer()
    Serialization.serialize(io, value)
    take!(io)
end

"""
backup uses julia's serialization module
"""
function deserialize(io::IO, ::Type)
    Serialization.deserialize(io)
end

function deserialize(bytes::AbstractVector{UInt8}, ::Type{T}) where T
    io = IOBuffer(bytes)
    deserialize(io, T)
end

# PROTOS

function serialize(proto::ProtoType)
    io = IOBuffer()
    writeproto(io, proto)
    take!(io)
end

deserialize(io::IO, ::Type{T}) where {T<:ProtoType} = readproto(io, T())
