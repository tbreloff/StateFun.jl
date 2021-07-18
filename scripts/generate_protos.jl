using ProtoBuf

"""
NOTE: For this function to work, you need to have your Julia binary accessible such that this returns something:
    which julia
"""

function generate_protobuf_layer(pkgdir::String; remove_existing_files = false)
    proto_dir = joinpath(pkgdir, "protos")
    # Find all *.proto files.
    proto_files = []
    for (dir, subdirs, files) in walkdir(proto_dir)
        for fn in files
            if endswith(fn, ".proto")
                push!(proto_files, "$dir/$fn")
            end
        end
    end
    # proto_files = map(filter((dir, subdirs, files) -> endswith(x, ".proto"), readdir(proto_dir)), x -> "$"
    # Add the path to each file.
    # proto_files = [joinpath(proto_dir, f) for f in proto_files]

    # Add the directory of the Julia plugin for Protobuf to the path so
    # the Protobuf compiler can find it.
    plugin_dir = joinpath(pathof(ProtoBuf) |> dirname, "..", "plugin")
    ENV["PATH"] = string(plugin_dir, ":", ENV["PATH"])

    # # Add the path to the Julia binary so the Protobuf compiler can
    # # call back to Julia.
    # ENV["PATH"] = string(JULIA_HOME, ":", ENV["PATH"])
    
    # This instructs the plugin to generate a Foo_pb module instead of a
    # Foo module.
    ENV["JULIA_PROTOBUF_MODULE_POSTFIX"] = 1

    # Generate the files directly into the src/Foo_pb directory.
    outdir = joinpath(pkgdir, "src", "protos")
    if remove_existing_files
        for f in readdir(outdir)
            rm(joinpath(outdir, f))
        end
    end

    # Call the Protobuf compiler.
    ProtoBuf.protoc(`-I=$(proto_dir) --julia_out=$(outdir) $(proto_files)`)
end

pkgdir = joinpath(@__DIR__, "..")
generate_protobuf_layer(pkgdir)
# ProtoBuf.protoc(`-I=$dir/protos --julia_out=jlout --plugin=protoc-gen-julia=/home/tom/.julia/v0.6/ProtoBuf/plugin/protoc-gen-julia io/kafka-egress.proto sdk/request-reply.proto types/types.proto`)
