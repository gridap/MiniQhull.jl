using MiniQhull
using Test
using StaticArrays

@testset "MiniQhull" begin
    @test delaunay(2,4,[0,0,0,1,1,0,1,1]) == delaunay([0 0 1 1; 0 1 0 1])
end

@testset "Custom array-type" begin
    pts = [[0.,0.], [0.,1.], [1.,0.], [1.,1.]]
    dim = 2
    x = reinterpret(Float64, [SVector{dim, Float64}(pt) for pt in pts])
    @test delaunay(dim, length(pts), x) ==  [4 4; 2 3; 1 1]
end

@testset "Vector of vectors" begin
    pts = [[0.,0.], [0.,1.], [1.,0.], [1.,1.]]

    @testset "Vector of regular vectors" begin
        @test delaunay(pts) == [4 4; 2 3; 1 1]
    end

    @testset "Vector of tuples" begin
        tups = [(0.,0.,), (0.,1.,), (1.,0.,), (1.,1., )]
        @test delaunay(tups) == [4 4; 2 3; 1 1]
    end

    @testset "Vector of SVectors" begin
        @test delaunay([SVector{2, Float64}(pt) for pt in pts]) == [4 4; 2 3; 1 1]
    end
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
    c4 = delaunay([0 0 1 1; 0 1 0 1], GenericString("qhull d Qt Qbb Qc Qz"))
    @test c4 == c0
end
