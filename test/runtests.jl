using Test, StateFun
import JSON3

@testset "protos" begin
    @testset "roundtrip" begin
        a1 = Address(_type="xxx")
        data = StateFun.serialize(a1)
        a2 = StateFun.deserialize(data, Address)
        data2 = StateFun.serialize(a2)
        # surprisingly round trip doesn't work as defaults are added
        @test_broken data == data2
    end

    @testset "push to array" begin
        x = FromFunction_InvocationResponse()
        push!(x, :outgoing_messages, FromFunction_Invocation())
        @test length(x.outgoing_messages) == 1
    end
end

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

    @testset "args" begin
        # this test is going to use the default serialization defined in julia base
        # in order to serialize and deserialize our new type.
        struct MyType i::Int64 end
        statefuns = StatefulFunctions(types=[("mytype", MyType)])
        import Serialization
        mt = MyType(5)
        io = IOBuffer()
        Serialization.serialize(io, mt)
        bytes = take!(io)
        @assert bytes == StateFun.serialize(mt)
        mt2 = StateFun.deserialize(bytes, MyType)
        @assert mt == mt2
    end
end

@testset "storage" begin
    @testset "store" begin
        statefuns = StatefulFunctions(types=[("int", Int64)])
        tofunc = ToFunction()
        context = Context(statefuns, tofunc)

        # ensure we are storing the value and can retreive it
        store!(context, "xxx", 5)
        @test store(context, "xxx") == 5

        # make sure we can populate the FromFunction correctly and load it

    end

    @testset "incomplete" begin
        func = StatefulFunction(x -> begin end)
        push!(func, StorageSpec("xx/aa", Int64))
        statefuns = StatefulFunctions(functions=Dict("xx/yy"=>func))
        tofunc = ToFunction(invocation=ToFunction_InvocationBatchRequest(
            target=Address(namespace="xx", _type="yy", id="id")
        ))
        fromfunc = StateFun.handle(statefuns, tofunc)
        @test hasproperty(fromfunc, :incomplete_invocation_context)
        missing_values = fromfunc.incomplete_invocation_context.missing_values
        @show missing_values
        @test length(missing_values) == 1
    end

    @testset "complete" begin
        func = StatefulFunction((context::Context, i::Int64) -> store!(context, "xx/aa", i+1))
        push!(func, StorageSpec("xx/aa", Int64))
        statefuns = StatefulFunctions(functions=Dict("xx/yy"=>func), types=[("int", Int64)])
        addr = Address(namespace="xx", _type="yy", id="id")
        tofunc = ToFunction(invocation=ToFunction_InvocationBatchRequest(
            target=addr,
            state=[ToFunction_PersistedValue(state_name="xx/aa", state_value=make_argument(statefuns, 5))],
            invocations=[ToFunction_Invocation(caller=addr, argument=make_argument(statefuns, 20))]
        ))
        # we expect the handler to store 21 in the state
        fromfunc = StateFun.handle(statefuns, tofunc)
        @show fromfunc
        @test hasproperty(fromfunc, :invocation_result)
    end
end