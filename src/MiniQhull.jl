module MiniQhull

using Libdl

export delaunay

include("load.jl")
include("bindings.jl")

function _delaunay(dim::Int32,numpoints::Int32,points::Array{Float64}) 
    numcells = Ref{Int32}()
    qh = new_qhull_handler()
    qh == C_NULL && error("Qhull handler is null")
    error = delaunay_init_and_compute(qh, dim, numpoints, points, numcells)
    error != 0 && error("Failure on delaunay_init_and_compute function")
    cells = Matrix{Int32}(undef,dim+1,numcells[])
    error = delaunay_fill_cells(qh, dim, numcells[], cells)
    error != 0 && error("Failure on delaunay_fill_cells function")
    error = delaunay_free(qh)
    error != 0 && error("Failure on delaunay_free function")
    cells
end

function delaunay(dim::Integer, numpoints::Integer, points::Vector) 
    @assert numpoints*dim == size(points,1)
    _delaunay(Int32(dim), Int32(numpoints), Vector{Float64}(points))
end

function delaunay(points::Matrix) 
    _delaunay(Int32(size(points,1)), Int32(size(points,2)), Array{Float64}(points))
end

end # module
