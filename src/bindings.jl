
# qhT* new_qhull_handler();
function new_qhull_handler()
    ccall((:new_qhull_handler, QhullMini_jll.qhullwrapper), Ptr{Cvoid}, (),)
end

# int delaunay_init_and_compute( int dim, int numpoints, coordT *points, int* numcells);
function delaunay_init_and_compute(qh::Ptr{Cvoid}, dim::Int32, numpoints::Int32, points, numcells::Ref{Int32}, flags::Union{Ptr{Nothing},AbstractString})
    ccall((:delaunay_init_and_compute, QhullMini_jll.qhullwrapper),
        Cint, (
            Ptr{Cvoid},
            Cint,
            Cint,
            Ptr{Cdouble},
            Ptr{Cint},
            Cstring
        ),
        qh,
        dim,
        numpoints,
        points,
        numcells,
        flags
    )
end

# int delaunay_fill_cells(int dim, int num_cells, int *cells);
function delaunay_fill_cells(qh::Ptr{Cvoid}, dim::Int32, numcells::Int32, cells::Array{Int32})
    ccall((:delaunay_fill_cells, QhullMini_jll.qhullwrapper),
        Cint, (
            Ptr{Cvoid},
            Cint,
            Cint,
            Ptr{Cint}
        ),
        qh,
        dim,
        numcells,
        cells)
end

#int delaunay_free()
function delaunay_free(qh::Ptr{Cvoid})
    ccall((:delaunay_free, QhullMini_jll.qhullwrapper), Cint, (Ptr{Cvoid},), qh)
end
