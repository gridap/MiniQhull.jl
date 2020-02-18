using MiniQhull
using Test

@testset "MiniQhull.jl" begin
    dim = Int32(2)
    numpoints=Int32(4)
    points=Vector{Float64}([0,0,0,1,1,0,1,1])
    @test delaunay(dim,numpoints,points) == [4,2,1,4,3,1]
end
