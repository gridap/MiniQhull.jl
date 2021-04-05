module MiniQhull

using Libdl

export delaunay

include("LibQhull.jl")
using .LibQhull
using .LibQhull: vertexT, setelemT

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

"""
    delaunay(dim::Integer, numpoints::Integer, points::AbstractVector,
        [flags::AbstractString]) → Matrix{Int32}

Compute the Delaunay triangulation of a cloud of points in an arbitrary dimension `dim`.
The vector `points` holds the data in "component major order", i.e., components are
consecutive within the vector. The vector `points` therefore must have length
`dim * numpoints`.

The returned matrix has shape `(dim + 1, nsimplices)`, where `nsimplices` is the number of
simplices in the computed Delaunay triangulation.

You can override the default set of flags that Qhull uses by passing an additional
positional `flags` argument. The default set of flags is `qhull d Qt Qbb Qc Qz` for up to
3 dimensions, and `qhull d Qt Qbb Qc Qx` for higher dimensions. The flags you pass override
the default flags, i.e. you have to pass all the flags that Qhull should use.

## Example: passing a column-major ordered vector of points

In this case, the dimension and number of points must be specified.

```julia
using MiniQhull
dim          = 2
numpoints    = 4
coordinates  = [0,0,0,1,1,0,1,1]
connectivity = delaunay(dim, numpoints, coordinates)
# output
3×2 Array{Int32,2}:
 4  4
 2  3
 1  1
```

    delaunay(points::AbstractMatrix, [flags::AbstractString]) -> Matrix{Int32}

In this variant, the cloud of points is specified by a matrix with
`size(matrix) == (dim, numpoints)`.

## Example: passing a matrix of points

```julia
using MiniQhull
coordinates  = [0 0 1 1; 0 1 0 1]
connectivity = delaunay(coordinates)
# output
3×2 Array{Int32,2}:
 4  4
 2  3
 1  1
```

    delaunay(points::AbstractVector{T}, [flags::AbstractString]) where T -> Matrix{Int32}

In this variant, the cloud of points is specified by a vector of points.

`points` can a `Vector{Vector}` but this is slow, because the data needs to be flattened
and collected before passing the data to Qhull.

```julia
pts = [[0.,0.], [0.,1.], [1.,0.], [1.,1.]]
delaunay(pts)
# output
3×2 Array{Int32,2}:
 4  4
 2  3
 1  1
```

A more efficient alternative is of `points` has the same memory layout as a column-major
vector, that is, if `T` is some type such that `reinterpret(Float64, points)` yields
a column-major vector of the points. This avoids extra memory allocations, and is useful
if you have a large number of points to triangulate. Examples are using equal-length tuples
or `SVector`s to represent the points.

```julia
using MiniQhull, StaticArrays
dim = 3
npts = 500
pts = [SVector{dim, Float64}(rand(dim)) for i = 1:npts];
flags = "qhull d Qbb Qc QJ Pp" # some custom flags
connectivity = delaunay(pts, flags)
```

"""
function delaunay end

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
