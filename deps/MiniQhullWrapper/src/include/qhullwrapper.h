
#include <libqhull/libqhull.h>

int delaunay_init_and_compute( int dim, int numpoints, coordT *points, int* numcells);
int delaunay_fill_cells(int dim, int num_cells, int *cells);
int delaunay_free();

