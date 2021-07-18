# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct BooleanWrapper <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function BooleanWrapper(; kwargs...)
        obj = new(meta(BooleanWrapper), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct BooleanWrapper
const __meta_BooleanWrapper = Ref{ProtoMeta}()
function meta(::Type{BooleanWrapper})
    ProtoBuf.metalock() do
        if !isassigned(__meta_BooleanWrapper)
            __meta_BooleanWrapper[] = target = ProtoMeta(BooleanWrapper)
            allflds = Pair{Symbol,Union{Type,String}}[:value => Bool]
            meta(target, BooleanWrapper, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_BooleanWrapper[]
    end
end
function Base.getproperty(obj::BooleanWrapper, name::Symbol)
    if name === :value
        return (obj.__protobuf_jl_internal_values[name])::Bool
    else
        getfield(obj, name)
    end
end

mutable struct IntWrapper <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function IntWrapper(; kwargs...)
        obj = new(meta(IntWrapper), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct IntWrapper
const __meta_IntWrapper = Ref{ProtoMeta}()
function meta(::Type{IntWrapper})
    ProtoBuf.metalock() do
        if !isassigned(__meta_IntWrapper)
            __meta_IntWrapper[] = target = ProtoMeta(IntWrapper)
            wtype = Dict(:value => :sfixed32)
            allflds = Pair{Symbol,Union{Type,String}}[:value => Int32]
            meta(target, IntWrapper, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, wtype, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_IntWrapper[]
    end
end
function Base.getproperty(obj::IntWrapper, name::Symbol)
    if name === :value
        return (obj.__protobuf_jl_internal_values[name])::Int32
    else
        getfield(obj, name)
    end
end

mutable struct FloatWrapper <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function FloatWrapper(; kwargs...)
        obj = new(meta(FloatWrapper), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct FloatWrapper
const __meta_FloatWrapper = Ref{ProtoMeta}()
function meta(::Type{FloatWrapper})
    ProtoBuf.metalock() do
        if !isassigned(__meta_FloatWrapper)
            __meta_FloatWrapper[] = target = ProtoMeta(FloatWrapper)
            allflds = Pair{Symbol,Union{Type,String}}[:value => Float32]
            meta(target, FloatWrapper, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_FloatWrapper[]
    end
end
function Base.getproperty(obj::FloatWrapper, name::Symbol)
    if name === :value
        return (obj.__protobuf_jl_internal_values[name])::Float32
    else
        getfield(obj, name)
    end
end

mutable struct LongWrapper <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function LongWrapper(; kwargs...)
        obj = new(meta(LongWrapper), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct LongWrapper
const __meta_LongWrapper = Ref{ProtoMeta}()
function meta(::Type{LongWrapper})
    ProtoBuf.metalock() do
        if !isassigned(__meta_LongWrapper)
            __meta_LongWrapper[] = target = ProtoMeta(LongWrapper)
            wtype = Dict(:value => :sfixed64)
            allflds = Pair{Symbol,Union{Type,String}}[:value => Int64]
            meta(target, LongWrapper, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, wtype, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_LongWrapper[]
    end
end
function Base.getproperty(obj::LongWrapper, name::Symbol)
    if name === :value
        return (obj.__protobuf_jl_internal_values[name])::Int64
    else
        getfield(obj, name)
    end
end

mutable struct DoubleWrapper <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function DoubleWrapper(; kwargs...)
        obj = new(meta(DoubleWrapper), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct DoubleWrapper
const __meta_DoubleWrapper = Ref{ProtoMeta}()
function meta(::Type{DoubleWrapper})
    ProtoBuf.metalock() do
        if !isassigned(__meta_DoubleWrapper)
            __meta_DoubleWrapper[] = target = ProtoMeta(DoubleWrapper)
            allflds = Pair{Symbol,Union{Type,String}}[:value => Float64]
            meta(target, DoubleWrapper, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_DoubleWrapper[]
    end
end
function Base.getproperty(obj::DoubleWrapper, name::Symbol)
    if name === :value
        return (obj.__protobuf_jl_internal_values[name])::Float64
    else
        getfield(obj, name)
    end
end

mutable struct StringWrapper <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function StringWrapper(; kwargs...)
        obj = new(meta(StringWrapper), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct StringWrapper
const __meta_StringWrapper = Ref{ProtoMeta}()
function meta(::Type{StringWrapper})
    ProtoBuf.metalock() do
        if !isassigned(__meta_StringWrapper)
            __meta_StringWrapper[] = target = ProtoMeta(StringWrapper)
            allflds = Pair{Symbol,Union{Type,String}}[:value => AbstractString]
            meta(target, StringWrapper, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_StringWrapper[]
    end
end
function Base.getproperty(obj::StringWrapper, name::Symbol)
    if name === :value
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

export BooleanWrapper, IntWrapper, FloatWrapper, LongWrapper, DoubleWrapper, StringWrapper
