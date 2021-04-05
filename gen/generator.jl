using Clang.Generators
using Qhull_jll

cd(@__DIR__)

include_dir = joinpath(Qhull_jll.artifact_dir, "include")

options = load_options(joinpath(@__DIR__, "generator.toml"))

ctx = create_context(Qhull_jll.libqhull_r_h, ["-I$include_dir"], options)

build!(ctx)
