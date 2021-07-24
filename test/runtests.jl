using Test, StateFun
import JSON3

# @testset "protos" begin
#     a1 = Address(_type="xxx")
#     data = serialize(a1)
#     a2 = deserialize(data, Address)
#     data2 = serialize(a2)
#     # @test a1 == a2
#     @test data == data2
# end

@testset "serdes" begin
    @testset "protos" begin
        statefuns = StatefulFunctions(types=[("json", JSON3.Object)])
        StateFun.serialize(o::JSON3.Object) = Vector{UInt8}(JSON3.write(o))
        StateFun.deserialize(io::IO, ::Type{JSON3.Object}) = JSON3.read(io)

        bytes = Vector{UInt8}(JSON3.write(Dict(:name => "Bob")))
        argument = TypedValue(typename="json", value=bytes)
        @show argument
        o = StateFun.get_message(statefuns, argument)
        @test typeof(o) <: JSON3.Object
        @test o.name == "Bob"
    end
end