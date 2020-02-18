module MiniQhull

using Libdl

export delaunay_init_and_compute
export delaunay_fill_cells
export delaunay_free
export delaunay

include("load.jl")
include("bindings.jl")

function delaunay(dim::Int32,numpoints::Int32,points::Vector{Float64}) 
    numcells = Ref{Int32}()
    delaunay_init_and_compute(dim,numpoints,points,numcells)
    cells = Vector{Int32}(undef,(dim+1)*numcells[])
    delaunay_fill_cells(dim, numcells[], cells)
    delaunay_free()
    cells
end

end # module
