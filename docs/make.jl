using Documenter
using MiniQhull

makedocs(;
    modules=[MiniQhull],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/gridap/MiniQhull.jl/blob/{commit}{path}#L{line}",
    sitename="MiniQhull.jl",
    authors="Francesc Verdugo <fverdugo@cimne.upc.edu>, Víctor Sande <vsande@cimne.upc.edu>",
    assets=String[],
)

deploydocs(;
    repo="github.com/gridap/MiniQhull.jl",
)
