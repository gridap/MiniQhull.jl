
#include <libqhull_r/libqhull_r.h>

qhT* new_qhull_handler();
int delaunay_init_and_compute_r(qhT *qh, int dim, int numpoints, coordT *points, int* numcells);
int delaunay_fill_cells_r(qhT *qh, int dim, int num_cells, int *cells);
int delaunay_free_r(qhT *qh);

