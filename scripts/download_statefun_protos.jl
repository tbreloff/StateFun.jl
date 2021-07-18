
"""
This file downloads the protobuf message specs which we need to interpret Stateful Functions
incoming and outgoing messages.
"""

baseurl = "https://raw.githubusercontent.com/apache/flink-statefun/release-3.0/statefun-sdk-protos/src/main/protobuf"
files = Dict(
    "io" => ["kafka-egress"],
    "sdk" => ["request-reply"],
    "types" => ["types"]
)

println(@__DIR__)

for (dir, fs) in files
    println(dir)
    println(fs)
    for f in fs
        url = joinpath(baseurl, dir, "$f.proto")
        destdir = joinpath(@__DIR__, "..", "protos", dir)
        mkpath(destdir)
        dest = joinpath(destdir, "$f.proto")
        println("downloading $url to $dest")
        download(url, dest)
    end
end
