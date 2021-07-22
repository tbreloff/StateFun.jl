import SimpleContainerGenerator

cd(@__DIR__)
mkpath("greeter_example")
cd("greeter_example")

pkgs = [
    "ProtoBuf",
    "Genie"
    # "StateFun"
]
julia_version = v"1.6.2"

SimpleContainerGenerator.create_dockerfile(pkgs;
                                           julia_version = julia_version,
                                           output_directory = pwd())

# run(`docker build -t statefunjl/greeter_example .`)
