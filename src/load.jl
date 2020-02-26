deps_jl = joinpath(@__DIR__, "..", "deps", "deps.jl")

if !isfile(deps_jl)
  error("Package MiniQhull not installed properly.")
end

include(deps_jl)

const new_qhull_handler_ptr         = Ref{Ptr}()
const delaunay_init_and_compute_ptr = Ref{Ptr}()
const delaunay_fill_cells_ptr       = Ref{Ptr}()
const delaunay_free_ptr             = Ref{Ptr}()
const QHULL_WRAPPER_LOADED = Ref(false)

function __init__()
    if QHULL_WRAPPER_FOUND
        flags = Libdl.RTLD_LAZY | Libdl.RTLD_DEEPBIND | Libdl.RTLD_GLOBAL
        QHULL_WRAPPER = Libdl.dlopen(QHULL_WRAPPER_LIB_PATH, flags)

        MiniQhull.new_qhull_handler_ptr[]         = Libdl.dlsym(QHULL_WRAPPER,:new_qhull_handler)
        MiniQhull.delaunay_init_and_compute_ptr[] = Libdl.dlsym(QHULL_WRAPPER,:delaunay_init_and_compute)
        MiniQhull.delaunay_fill_cells_ptr[]       = Libdl.dlsym(QHULL_WRAPPER,:delaunay_fill_cells)
        MiniQhull.delaunay_free_ptr[]             = Libdl.dlsym(QHULL_WRAPPER,:delaunay_free)
        QHULL_WRAPPER_LOADED[] = true
    else
        QHULL_WRAPPER_LOADED[] = false
    end
end


macro check_if_loaded()
  quote
    if ! QHULL_WRAPPER_LOADED[]
      error("QHULL WRAPPER is not properly loaded")
    end
  end
end


