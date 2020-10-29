
#include <stdio.h>
#include <stdlib.h> 
#include <qhullwrapper.h>

int main(int argc, char *argv[]) {

    int error=0;
    int numcells=0;
    int dim = 2;
    int numpoints = 4;
    int *cells;
    qhT *qh;
    double points[] = {0.0,0.0,0.0,1.0,1.0,0.0,1.0,1.0};

    qh = new_qhull_handler();
    printf("[ERROR=%d] (delaunay_init_and_compute) *qh = %p \n", error, qh);
    error = delaunay_init_and_compute(qh, dim, numpoints, points, &numcells, NULL);
    printf("[ERROR=%d] (delaunay_init_and_compute) numcells = %d \n", error, numcells);
    if (error != 0) exit(error);

    cells = (int *) malloc((dim+1)*numcells * sizeof(int));
    error = delaunay_fill_cells(qh, dim, numcells, cells );
    printf("[ERROR=%d] (delaunay_fill_cells) cells [ ", error);
    for(int i = 0; i < (dim+1)*numcells; i++)
            printf("%d ", cells[i]);
    printf("] \n");
    if (error != 0) exit(error);

    error = delaunay_free(qh);
    if (error != 0) exit(error);
    printf("[ERROR=%d] (delaunay_free) \n", error );

    exit(error);
}
