# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct KafkaProducerRecord <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function KafkaProducerRecord(; kwargs...)
        obj = new(meta(KafkaProducerRecord), Dict{Symbol,Any}(), Set{Symbol}())
        values = obj.__protobuf_jl_internal_values
        symdict = obj.__protobuf_jl_internal_meta.symdict
        for nv in kwargs
            fldname, fldval = nv
            fldtype = symdict[fldname].jtyp
            (fldname in keys(symdict)) || error(string(typeof(obj), " has no field with name ", fldname))
            if fldval !== nothing
                values[fldname] = isa(fldval, fldtype) ? fldval : convert(fldtype, fldval)
            end
        end
        obj
    end
end # mutable struct KafkaProducerRecord
const __meta_KafkaProducerRecord = Ref{ProtoMeta}()
function meta(::Type{KafkaProducerRecord})
    ProtoBuf.metalock() do
        if !isassigned(__meta_KafkaProducerRecord)
            __meta_KafkaProducerRecord[] = target = ProtoMeta(KafkaProducerRecord)
            allflds = Pair{Symbol,Union{Type,String}}[:key => AbstractString, :value_bytes => Vector{UInt8}, :topic => AbstractString]
            meta(target, KafkaProducerRecord, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_KafkaProducerRecord[]
    end
end
function Base.getproperty(obj::KafkaProducerRecord, name::Symbol)
    if name === :key
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :value_bytes
        return (obj.__protobuf_jl_internal_values[name])::Vector{UInt8}
    elseif name === :topic
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

export KafkaProducerRecord
