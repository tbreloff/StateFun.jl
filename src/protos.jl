
using ProtoBuf

# from types
export BooleanWrapper, DoubleWrapper, FloatWrapper, IntWrapper, LongWrapper, StringWrapper

# from reqreply_pb
export Address, FromFunction, FromFunction_DelayedInvocation, FromFunction_EgressMessage, 
    FromFunction_ExpirationSpec, FromFunction_ExpirationSpec_ExpireMode, 
    FromFunction_IncompleteInvocationContext, FromFunction_Invocation, FromFunction_InvocationResponse, 
    FromFunction_PersistedValueMutation, FromFunction_PersistedValueMutation_MutationType, 
    FromFunction_PersistedValueSpec, ToFunction, ToFunction_Invocation, ToFunction_InvocationBatchRequest, 
    ToFunction_PersistedValue, TypedValue

# from egress
export KafkaProducerRecord

# pull in all the proto defs from the generated files
module Protos
    include("protos/io_pb.jl")
end # Protos
using .Protos.io_pb.statefun_pb.sdk_pb.egress_pb
using .Protos.io_pb.statefun_pb.sdk_pb.reqreply_pb
using .Protos.io_pb.statefun_pb.sdk_pb.types_pb

# --- TODO ---
# These methods should maybe be added to ProtoBuf.jl...

# nicer implementation of show
function Base.show(io::IO, proto::ProtoType)
    println(io, "$(typeof(proto)) {")
    m = meta(typeof(proto))
    flds = m.ordered
    props = [fld.fld for fld in flds if hasproperty(proto, fld.fld)]
    for prop in props
        prop_str = replace(string(getproperty(proto, prop)), "\n" => "\n  ")
        println(io, "  $prop: $prop_str")
    end
    print(io, "}")
end


"""
Assuming the given field of the proto expects a vector, add a value to it.
Note: creates a new vector if the field is uninitialized.]
"""
function Base.push!(proto::ProtoType, field::Symbol, value)
    vec = if !hasproperty(proto, field)
        m = meta(typeof(proto))
        attr = m.symdict[field]
        @assert attr.jtyp <: Vector
        vec = attr.jtyp() # init a vector of the proper type
        setproperty!(proto, field, vec)
        vec
    else
        getproperty(proto, field)
    end
    println(typeof(vec))
    push!(vec, value)
end
