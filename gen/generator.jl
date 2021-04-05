using Pkg
using Pkg.Artifacts
using Clang.Generators
using Clang.Generators.JLLEnvs
using Qhull_jll

cd(@__DIR__)

include_dir = joinpath(Qhull_jll.artifact_dir, "include")

for target in JLLEnvs.JLL_ENV_TRIPLES
    @info "processing $target"

    # programmatically add options
    options = Dict{String,Any}(
        "general" => Dict{String,Any}(),
        "codegen" => Dict{String,Any}(),
        )
    general, codegen = options["general"], options["codegen"]
    general["library_name"] = "libqhull_r"
    general["output_file_path"] = joinpath(@__DIR__, "..", "lib", "$target.jl")
    general["use_julia_native_enum_type"] = true
    general["use_deterministic_symbol"] = true
    general["printer_blacklist"] = [
        "qh_SEARCHdist",
        "FORALLpoints",
        "qh_CPUclock",
        "qh_SECticks",
        "qh_RANDOMint",
        "qh_DISToutside",
        "qh_USEfindbestnew",
        ]
    codegen["field_access_method_list"] = [
        "qhT",
        "setT",
    ]

    args = get_default_args(target)
    push!(args, "-I$include_dir")

    ctx = create_context(Qhull_jll.libqhull_r_h, args, options)

    build!(ctx)
end
