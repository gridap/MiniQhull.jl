module MiniQhull

using Libdl

export delaunay

include("load.jl")
include("bindings.jl")

function _delaunay(dim::Int32, numpoints::Int32, points::Array{Float64}, flags::Union{Nothing,AbstractString}) 
    numcells = Ref{Int32}()
    qh = new_qhull_handler()
    qh == C_NULL && error("Qhull handler is null")
    cflags = flags===nothing ? C_NULL : flags
    ierror = delaunay_init_and_compute(qh, dim, numpoints, points, numcells, cflags)
    ierror != 0 && error("Failure on delaunay_init_and_compute function")
    cells = Matrix{Int32}(undef,dim+1,numcells[])
    ierror = delaunay_fill_cells(qh, dim, numcells[], cells)
    ierror != 0 && error("Failure on delaunay_fill_cells function")
    ierror = delaunay_free(qh)
    ierror != 0 && error("Failure on delaunay_free function")
    cells
end

function delaunay(dim::Integer, numpoints::Integer, points::Vector,
                  flags::Union{Nothing,AbstractString}=nothing)
    @assert numpoints*dim == size(points,1)
    _delaunay(Int32(dim), Int32(numpoints), Vector{Float64}(points), flags)
end

function delaunay(points::Matrix,
    flags::Union{Nothing,AbstractString}=nothing)
    _delaunay(Int32(size(points,1)), Int32(size(points,2)), Array{Float64}(points), flags)
end

end # module
