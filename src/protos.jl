
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

# nicer implementation of show
function Base.show(io::IO, proto::ProtoType)
    println(io, "$(typeof(proto)) {")
    m = meta(typeof(proto))
    flds = m.ordered
    props = [fld.fld for fld in flds if hasproperty(proto, fld.fld)]
    for prop in props
        println(io, "  $prop: $(getproperty(proto, prop))")
    end
    println(io, "}")
end
