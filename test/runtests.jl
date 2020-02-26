using MiniQhull
using Test

if MiniQhull.QHULL_WRAPPER_LOADED[]
    @testset "MiniQhull" begin
        @test delaunay(2,4,[0,0,0,1,1,0,1,1]) == delaunay([0 0 1 1; 0 1 0 1])
    end
end
