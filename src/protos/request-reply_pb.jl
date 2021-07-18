# syntax: proto3
using ProtoBuf
import ProtoBuf.meta

mutable struct Address <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function Address(; kwargs...)
        obj = new(meta(Address), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct Address
const __meta_Address = Ref{ProtoMeta}()
function meta(::Type{Address})
    ProtoBuf.metalock() do
        if !isassigned(__meta_Address)
            __meta_Address[] = target = ProtoMeta(Address)
            allflds = Pair{Symbol,Union{Type,String}}[:namespace => AbstractString, :_type => AbstractString, :id => AbstractString]
            meta(target, Address, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_Address[]
    end
end
function Base.getproperty(obj::Address, name::Symbol)
    if name === :namespace
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :_type
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :id
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct TypedValue <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function TypedValue(; kwargs...)
        obj = new(meta(TypedValue), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct TypedValue
const __meta_TypedValue = Ref{ProtoMeta}()
function meta(::Type{TypedValue})
    ProtoBuf.metalock() do
        if !isassigned(__meta_TypedValue)
            __meta_TypedValue[] = target = ProtoMeta(TypedValue)
            allflds = Pair{Symbol,Union{Type,String}}[:typename => AbstractString, :has_value => Bool, :value => Vector{UInt8}]
            meta(target, TypedValue, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_TypedValue[]
    end
end
function Base.getproperty(obj::TypedValue, name::Symbol)
    if name === :typename
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :has_value
        return (obj.__protobuf_jl_internal_values[name])::Bool
    elseif name === :value
        return (obj.__protobuf_jl_internal_values[name])::Vector{UInt8}
    else
        getfield(obj, name)
    end
end

mutable struct ToFunction_PersistedValue <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ToFunction_PersistedValue(; kwargs...)
        obj = new(meta(ToFunction_PersistedValue), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ToFunction_PersistedValue
const __meta_ToFunction_PersistedValue = Ref{ProtoMeta}()
function meta(::Type{ToFunction_PersistedValue})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ToFunction_PersistedValue)
            __meta_ToFunction_PersistedValue[] = target = ProtoMeta(ToFunction_PersistedValue)
            allflds = Pair{Symbol,Union{Type,String}}[:state_name => AbstractString, :state_value => TypedValue]
            meta(target, ToFunction_PersistedValue, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ToFunction_PersistedValue[]
    end
end
function Base.getproperty(obj::ToFunction_PersistedValue, name::Symbol)
    if name === :state_name
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :state_value
        return (obj.__protobuf_jl_internal_values[name])::TypedValue
    else
        getfield(obj, name)
    end
end

mutable struct ToFunction_Invocation <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ToFunction_Invocation(; kwargs...)
        obj = new(meta(ToFunction_Invocation), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ToFunction_Invocation
const __meta_ToFunction_Invocation = Ref{ProtoMeta}()
function meta(::Type{ToFunction_Invocation})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ToFunction_Invocation)
            __meta_ToFunction_Invocation[] = target = ProtoMeta(ToFunction_Invocation)
            allflds = Pair{Symbol,Union{Type,String}}[:caller => Address, :argument => TypedValue]
            meta(target, ToFunction_Invocation, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ToFunction_Invocation[]
    end
end
function Base.getproperty(obj::ToFunction_Invocation, name::Symbol)
    if name === :caller
        return (obj.__protobuf_jl_internal_values[name])::Address
    elseif name === :argument
        return (obj.__protobuf_jl_internal_values[name])::TypedValue
    else
        getfield(obj, name)
    end
end

mutable struct ToFunction_InvocationBatchRequest <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ToFunction_InvocationBatchRequest(; kwargs...)
        obj = new(meta(ToFunction_InvocationBatchRequest), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ToFunction_InvocationBatchRequest
const __meta_ToFunction_InvocationBatchRequest = Ref{ProtoMeta}()
function meta(::Type{ToFunction_InvocationBatchRequest})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ToFunction_InvocationBatchRequest)
            __meta_ToFunction_InvocationBatchRequest[] = target = ProtoMeta(ToFunction_InvocationBatchRequest)
            allflds = Pair{Symbol,Union{Type,String}}[:target => Address, :state => Base.Vector{ToFunction_PersistedValue}, :invocations => Base.Vector{ToFunction_Invocation}]
            meta(target, ToFunction_InvocationBatchRequest, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_ToFunction_InvocationBatchRequest[]
    end
end
function Base.getproperty(obj::ToFunction_InvocationBatchRequest, name::Symbol)
    if name === :target
        return (obj.__protobuf_jl_internal_values[name])::Address
    elseif name === :state
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{ToFunction_PersistedValue}
    elseif name === :invocations
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{ToFunction_Invocation}
    else
        getfield(obj, name)
    end
end

mutable struct ToFunction <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function ToFunction(; kwargs...)
        obj = new(meta(ToFunction), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct ToFunction
const __meta_ToFunction = Ref{ProtoMeta}()
function meta(::Type{ToFunction})
    ProtoBuf.metalock() do
        if !isassigned(__meta_ToFunction)
            __meta_ToFunction[] = target = ProtoMeta(ToFunction)
            fnum = Int[100]
            allflds = Pair{Symbol,Union{Type,String}}[:invocation => ToFunction_InvocationBatchRequest]
            oneofs = Int[1]
            oneof_names = Symbol[Symbol("request")]
            meta(target, ToFunction, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_ToFunction[]
    end
end
function Base.getproperty(obj::ToFunction, name::Symbol)
    if name === :invocation
        return (obj.__protobuf_jl_internal_values[name])::ToFunction_InvocationBatchRequest
    else
        getfield(obj, name)
    end
end

const FromFunction_PersistedValueMutation_MutationType = (;[
    Symbol("DELETE") => Int32(0),
    Symbol("MODIFY") => Int32(1),
]...)

mutable struct FromFunction_PersistedValueMutation <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function FromFunction_PersistedValueMutation(; kwargs...)
        obj = new(meta(FromFunction_PersistedValueMutation), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct FromFunction_PersistedValueMutation
const __meta_FromFunction_PersistedValueMutation = Ref{ProtoMeta}()
function meta(::Type{FromFunction_PersistedValueMutation})
    ProtoBuf.metalock() do
        if !isassigned(__meta_FromFunction_PersistedValueMutation)
            __meta_FromFunction_PersistedValueMutation[] = target = ProtoMeta(FromFunction_PersistedValueMutation)
            allflds = Pair{Symbol,Union{Type,String}}[:mutation_type => Int32, :state_name => AbstractString, :state_value => TypedValue]
            meta(target, FromFunction_PersistedValueMutation, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_FromFunction_PersistedValueMutation[]
    end
end
function Base.getproperty(obj::FromFunction_PersistedValueMutation, name::Symbol)
    if name === :mutation_type
        return (obj.__protobuf_jl_internal_values[name])::Int32
    elseif name === :state_name
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :state_value
        return (obj.__protobuf_jl_internal_values[name])::TypedValue
    else
        getfield(obj, name)
    end
end

mutable struct FromFunction_Invocation <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function FromFunction_Invocation(; kwargs...)
        obj = new(meta(FromFunction_Invocation), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct FromFunction_Invocation
const __meta_FromFunction_Invocation = Ref{ProtoMeta}()
function meta(::Type{FromFunction_Invocation})
    ProtoBuf.metalock() do
        if !isassigned(__meta_FromFunction_Invocation)
            __meta_FromFunction_Invocation[] = target = ProtoMeta(FromFunction_Invocation)
            allflds = Pair{Symbol,Union{Type,String}}[:target => Address, :argument => TypedValue]
            meta(target, FromFunction_Invocation, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_FromFunction_Invocation[]
    end
end
function Base.getproperty(obj::FromFunction_Invocation, name::Symbol)
    if name === :target
        return (obj.__protobuf_jl_internal_values[name])::Address
    elseif name === :argument
        return (obj.__protobuf_jl_internal_values[name])::TypedValue
    else
        getfield(obj, name)
    end
end

mutable struct FromFunction_DelayedInvocation <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function FromFunction_DelayedInvocation(; kwargs...)
        obj = new(meta(FromFunction_DelayedInvocation), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct FromFunction_DelayedInvocation
const __meta_FromFunction_DelayedInvocation = Ref{ProtoMeta}()
function meta(::Type{FromFunction_DelayedInvocation})
    ProtoBuf.metalock() do
        if !isassigned(__meta_FromFunction_DelayedInvocation)
            __meta_FromFunction_DelayedInvocation[] = target = ProtoMeta(FromFunction_DelayedInvocation)
            allflds = Pair{Symbol,Union{Type,String}}[:delay_in_ms => Int64, :target => Address, :argument => TypedValue]
            meta(target, FromFunction_DelayedInvocation, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_FromFunction_DelayedInvocation[]
    end
end
function Base.getproperty(obj::FromFunction_DelayedInvocation, name::Symbol)
    if name === :delay_in_ms
        return (obj.__protobuf_jl_internal_values[name])::Int64
    elseif name === :target
        return (obj.__protobuf_jl_internal_values[name])::Address
    elseif name === :argument
        return (obj.__protobuf_jl_internal_values[name])::TypedValue
    else
        getfield(obj, name)
    end
end

mutable struct FromFunction_EgressMessage <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function FromFunction_EgressMessage(; kwargs...)
        obj = new(meta(FromFunction_EgressMessage), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct FromFunction_EgressMessage
const __meta_FromFunction_EgressMessage = Ref{ProtoMeta}()
function meta(::Type{FromFunction_EgressMessage})
    ProtoBuf.metalock() do
        if !isassigned(__meta_FromFunction_EgressMessage)
            __meta_FromFunction_EgressMessage[] = target = ProtoMeta(FromFunction_EgressMessage)
            allflds = Pair{Symbol,Union{Type,String}}[:egress_namespace => AbstractString, :egress_type => AbstractString, :argument => TypedValue]
            meta(target, FromFunction_EgressMessage, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_FromFunction_EgressMessage[]
    end
end
function Base.getproperty(obj::FromFunction_EgressMessage, name::Symbol)
    if name === :egress_namespace
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :egress_type
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :argument
        return (obj.__protobuf_jl_internal_values[name])::TypedValue
    else
        getfield(obj, name)
    end
end

mutable struct FromFunction_InvocationResponse <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function FromFunction_InvocationResponse(; kwargs...)
        obj = new(meta(FromFunction_InvocationResponse), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct FromFunction_InvocationResponse
const __meta_FromFunction_InvocationResponse = Ref{ProtoMeta}()
function meta(::Type{FromFunction_InvocationResponse})
    ProtoBuf.metalock() do
        if !isassigned(__meta_FromFunction_InvocationResponse)
            __meta_FromFunction_InvocationResponse[] = target = ProtoMeta(FromFunction_InvocationResponse)
            allflds = Pair{Symbol,Union{Type,String}}[:state_mutations => Base.Vector{FromFunction_PersistedValueMutation}, :outgoing_messages => Base.Vector{FromFunction_Invocation}, :delayed_invocations => Base.Vector{FromFunction_DelayedInvocation}, :outgoing_egresses => Base.Vector{FromFunction_EgressMessage}]
            meta(target, FromFunction_InvocationResponse, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_FromFunction_InvocationResponse[]
    end
end
function Base.getproperty(obj::FromFunction_InvocationResponse, name::Symbol)
    if name === :state_mutations
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{FromFunction_PersistedValueMutation}
    elseif name === :outgoing_messages
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{FromFunction_Invocation}
    elseif name === :delayed_invocations
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{FromFunction_DelayedInvocation}
    elseif name === :outgoing_egresses
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{FromFunction_EgressMessage}
    else
        getfield(obj, name)
    end
end

const FromFunction_ExpirationSpec_ExpireMode = (;[
    Symbol("NONE") => Int32(0),
    Symbol("AFTER_WRITE") => Int32(1),
    Symbol("AFTER_INVOKE") => Int32(2),
]...)

mutable struct FromFunction_ExpirationSpec <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function FromFunction_ExpirationSpec(; kwargs...)
        obj = new(meta(FromFunction_ExpirationSpec), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct FromFunction_ExpirationSpec
const __meta_FromFunction_ExpirationSpec = Ref{ProtoMeta}()
function meta(::Type{FromFunction_ExpirationSpec})
    ProtoBuf.metalock() do
        if !isassigned(__meta_FromFunction_ExpirationSpec)
            __meta_FromFunction_ExpirationSpec[] = target = ProtoMeta(FromFunction_ExpirationSpec)
            allflds = Pair{Symbol,Union{Type,String}}[:mode => Int32, :expire_after_millis => Int64]
            meta(target, FromFunction_ExpirationSpec, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_FromFunction_ExpirationSpec[]
    end
end
function Base.getproperty(obj::FromFunction_ExpirationSpec, name::Symbol)
    if name === :mode
        return (obj.__protobuf_jl_internal_values[name])::Int32
    elseif name === :expire_after_millis
        return (obj.__protobuf_jl_internal_values[name])::Int64
    else
        getfield(obj, name)
    end
end

mutable struct FromFunction_PersistedValueSpec <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function FromFunction_PersistedValueSpec(; kwargs...)
        obj = new(meta(FromFunction_PersistedValueSpec), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct FromFunction_PersistedValueSpec
const __meta_FromFunction_PersistedValueSpec = Ref{ProtoMeta}()
function meta(::Type{FromFunction_PersistedValueSpec})
    ProtoBuf.metalock() do
        if !isassigned(__meta_FromFunction_PersistedValueSpec)
            __meta_FromFunction_PersistedValueSpec[] = target = ProtoMeta(FromFunction_PersistedValueSpec)
            allflds = Pair{Symbol,Union{Type,String}}[:state_name => AbstractString, :expiration_spec => FromFunction_ExpirationSpec, :type_typename => AbstractString]
            meta(target, FromFunction_PersistedValueSpec, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_FromFunction_PersistedValueSpec[]
    end
end
function Base.getproperty(obj::FromFunction_PersistedValueSpec, name::Symbol)
    if name === :state_name
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    elseif name === :expiration_spec
        return (obj.__protobuf_jl_internal_values[name])::FromFunction_ExpirationSpec
    elseif name === :type_typename
        return (obj.__protobuf_jl_internal_values[name])::AbstractString
    else
        getfield(obj, name)
    end
end

mutable struct FromFunction_IncompleteInvocationContext <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function FromFunction_IncompleteInvocationContext(; kwargs...)
        obj = new(meta(FromFunction_IncompleteInvocationContext), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct FromFunction_IncompleteInvocationContext
const __meta_FromFunction_IncompleteInvocationContext = Ref{ProtoMeta}()
function meta(::Type{FromFunction_IncompleteInvocationContext})
    ProtoBuf.metalock() do
        if !isassigned(__meta_FromFunction_IncompleteInvocationContext)
            __meta_FromFunction_IncompleteInvocationContext[] = target = ProtoMeta(FromFunction_IncompleteInvocationContext)
            allflds = Pair{Symbol,Union{Type,String}}[:missing_values => Base.Vector{FromFunction_PersistedValueSpec}]
            meta(target, FromFunction_IncompleteInvocationContext, allflds, ProtoBuf.DEF_REQ, ProtoBuf.DEF_FNUM, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, ProtoBuf.DEF_ONEOFS, ProtoBuf.DEF_ONEOF_NAMES)
        end
        __meta_FromFunction_IncompleteInvocationContext[]
    end
end
function Base.getproperty(obj::FromFunction_IncompleteInvocationContext, name::Symbol)
    if name === :missing_values
        return (obj.__protobuf_jl_internal_values[name])::Base.Vector{FromFunction_PersistedValueSpec}
    else
        getfield(obj, name)
    end
end

mutable struct FromFunction <: ProtoType
    __protobuf_jl_internal_meta::ProtoMeta
    __protobuf_jl_internal_values::Dict{Symbol,Any}
    __protobuf_jl_internal_defaultset::Set{Symbol}

    function FromFunction(; kwargs...)
        obj = new(meta(FromFunction), Dict{Symbol,Any}(), Set{Symbol}())
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
end # mutable struct FromFunction
const __meta_FromFunction = Ref{ProtoMeta}()
function meta(::Type{FromFunction})
    ProtoBuf.metalock() do
        if !isassigned(__meta_FromFunction)
            __meta_FromFunction[] = target = ProtoMeta(FromFunction)
            fnum = Int[100,101]
            allflds = Pair{Symbol,Union{Type,String}}[:invocation_result => FromFunction_InvocationResponse, :incomplete_invocation_context => FromFunction_IncompleteInvocationContext]
            oneofs = Int[1,1]
            oneof_names = Symbol[Symbol("response")]
            meta(target, FromFunction, allflds, ProtoBuf.DEF_REQ, fnum, ProtoBuf.DEF_VAL, ProtoBuf.DEF_PACK, ProtoBuf.DEF_WTYPES, oneofs, oneof_names)
        end
        __meta_FromFunction[]
    end
end
function Base.getproperty(obj::FromFunction, name::Symbol)
    if name === :invocation_result
        return (obj.__protobuf_jl_internal_values[name])::FromFunction_InvocationResponse
    elseif name === :incomplete_invocation_context
        return (obj.__protobuf_jl_internal_values[name])::FromFunction_IncompleteInvocationContext
    else
        getfield(obj, name)
    end
end

export Address, TypedValue, ToFunction_PersistedValue, ToFunction_Invocation, ToFunction_InvocationBatchRequest, ToFunction, FromFunction_PersistedValueMutation_MutationType, FromFunction_PersistedValueMutation, FromFunction_Invocation, FromFunction_DelayedInvocation, FromFunction_EgressMessage, FromFunction_InvocationResponse, FromFunction_ExpirationSpec_ExpireMode, FromFunction_ExpirationSpec, FromFunction_PersistedValueSpec, FromFunction_IncompleteInvocationContext, FromFunction
