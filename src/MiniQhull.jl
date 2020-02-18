module MiniQhull

using Libdl

export delaunay

include("load.jl")
include("bindings.jl")

function delaunay(dim::Int32,numpoints::Int32,points::Vector{Float64}) 
    numcells = Ref{Int32}()
    qh = new_qhull_handler()
    qh == C_NULL && error("Qhull handler is null")
    error = delaunay_init_and_compute(qh, dim,numpoints,points,numcells)
    error != 0 && error("Failure on delaunay_init_and_compute function")
    cells = Vector{Int32}(undef,(dim+1)*numcells[])
    error = delaunay_fill_cells(qh, dim, numcells[], cells)
    error != 0 && error("Failure on delaunay_fill_cells function")
    error = delaunay_free(qh)
    error != 0 && error("Failure on delaunay_free function")
    cells
end

end # module
