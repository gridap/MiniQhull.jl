
# int delaunay_init_and_compute( int dim, int numpoints, coordT *points, int* numcells);
function delaunay_init_and_compute(dim::Int32, numpoints::Int32, points::Vector{Float64}, numcells::Ref{Int32})
    @check_if_loaded
    ccall(delaunay_init_and_compute_ptr[], 
        Cint, (
            Cint, 
            Cint,
            Ptr{Cdouble},
            Ptr{Cint}
            ), 
        dim, 
        numpoints, 
        points, 
        numcells
        )
end


# int delaunay_fill_cells(int dim, int num_cells, int *cells);
function delaunay_fill_cells(dim::Int32, numcells::Int32, cells::Vector{Int32})
    @check_if_loaded
    ccall(delaunay_fill_cells_ptr[], 
        Cint, (
            Cint, 
            Cint,
            Ptr{Cint}
            ), 
        dim, 
        numcells,
        cells)
end

#int delaunay_free()
function delaunay_free()
    @check_if_loaded
    ccall(delaunay_free_ptr[], Cvoid, ())
end


