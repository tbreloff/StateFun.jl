FROM julia:1.6.2

WORKDIR /opt/StateFun

# copy this package into the /opt directory in the container
# ensure this is a git repo... Pkg needs it when adding
RUN apt-get -y update && apt-get -y install git
RUN git init

# warm up
COPY Project.toml .
COPY Manifest.toml .
RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.precompile()'

# add the package and precompile it
COPY src src
COPY scripts/run_server.jl .
# COPY examples/greeter/greeter.jl examples/greeter/greeter.jl
# COPY scripts/setup_docker_env.jl setup_docker_env.jl
# RUN julia setup_docker_env.jl
# RUN julia -e 'using Pkg; Pkg.activate("."); Pkg.precompile()'

# ensure the package's environment will be activated on julia startup
RUN mkdir -p /root/.julia/config
RUN echo 'using Pkg; Pkg.activate("."); using Revise' > /root/.julia/config/startup.jl

# run julia
ENTRYPOINT ["julia", "run_server.jl"]