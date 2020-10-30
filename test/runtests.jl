using MiniQhull
using Test

if MiniQhull.QHULL_WRAPPER_LOADED[]
    @testset "MiniQhull" begin
        @test delaunay(2,4,[0,0,0,1,1,0,1,1]) == delaunay([0 0 1 1; 0 1 0 1])
    end
    @testset "MiniQhull with flags" begin
        c0 = delaunay([0 0 1 1; 0 1 0 1])
        c1 = delaunay([0 0 1 1; 0 1 0 1], nothing)
        @test c1 == c0
        c2 = delaunay([0 0 1 1; 0 1 0 1], "qhull d Qt Qbb Qc Qz")
        @test c2 == c0
        c3 = delaunay([0 0 1 1; 0 1 0 1], "qhull d Qbb Qc QJ Pp")
        # QJ randomizes ("joggles") the input, so the output is not deterministic
        @test size(c3) == (3, 2)
        c4 = delaunay([0 0 1 1; 0 1 0 1], SubString("qhull d Qt Qbb Qc Qz", 1:20))
        @test c4 == c0
    end
end
