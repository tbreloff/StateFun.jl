using Test, StateFun

@testset "protos" begin
    a1 = Address(_type="xxx")
    data = serialize(a1)
    a2 = deserialize(data, Address)
    data2 = serialize(a2)
    # @test a1 == a2
    @test data == data2
end
