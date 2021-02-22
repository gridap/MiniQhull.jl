module MiniQhull

using Libdl

export delaunay

include("load.jl")
include("bindings.jl")

function _delaunay(dim::Int32, numpoints::Int32, points, flags::Union{Nothing,AbstractString})
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

function delaunay(dim::Integer, numpoints::Integer, points::AbstractVector{T}, flags::Union{Nothing,AbstractString}=nothing) where T
    @assert numpoints*dim == length(points)
    _delaunay(Int32(dim), Int32(numpoints), float.(points), flags)
end

# If input data are already Float64, then no conversion is needed
function delaunay(dim::Integer, numpoints::Integer, points::AbstractVector{Float64}, flags::Union{Nothing,AbstractString}=nothing) 
    @assert numpoints*dim == length(points)
    _delaunay(Int32(dim), Int32(numpoints), points, flags)
end


function delaunay(points::AbstractMatrix,
    flags::Union{Nothing,AbstractString}=nothing)
    _delaunay(Int32(size(points,1)), Int32(size(points,2)), Array{Float64}(points), flags)
end


get_dim(points::AbstractVector{T}) where T = length(eltype(points))
get_dim(points::AbstractVector{NTuple{N, T}}) where {N, T} = N
get_dim(points::AbstractVector{T}) where T <: Vector = length(points[1])

# Generic fallback for when points are of some type where it is possible to get a 
# column-major vector by calling `reinterpret(Float64, points)`. This avoids extra 
# allocations, and is more efficient than using regular vectors. 
# An example would be using `SVector`s or tuples as points.
function delaunay(points::AbstractVector{T}, flags=nothing) where {T} 
    numpoints = length(points)
    _delaunay(Int32(get_dim(points)), Int32(numpoints), reinterpret(Float64, points), flags)
end

# It is also conceivable that a user would want to use regular vectors as points. In that 
# case, we need to flatten the list of points and collect (allocates, and is slow).
function delaunay(points::AbstractVector{T}, flags=nothing) where {T <: Vector}
    numpoints = length(points)
    _delaunay(Int32(get_dim(points)), Int32(numpoints), 
        Base.Iterators.Flatten(points) |> collect, flags)
end


end # module
