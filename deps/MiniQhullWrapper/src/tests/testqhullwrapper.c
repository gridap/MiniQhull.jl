
#include <stdio.h>
#include <stdlib.h> 
#include <qhullwrapper.h>

int main(int argc, char *argv[]) {

    int error;
    int numcells;
    int dim = 2;
    int numpoints = 4;
    int *cells;
    double points[] = {0.0,0.0,0.0,1.0,1.0,0.0,1.0,1.0};

    error = delaunay_init_and_compute( dim, numpoints, points, &numcells );
    printf("[ERROR=%d] (delaunay_init_and_compute) numcells = %d \n", error, numcells );
    if (error != 0) exit(error);

    cells = (int *) malloc((dim+1)*numcells * sizeof(int));
    error = delaunay_fill_cells(dim, numcells, cells );
    printf("[ERROR=%d] (delaunay_fill_cells) cells [ ", error);
    for(int i = 0; i < (dim+1)*numcells; i++)
            printf("%d ", cells[i]);
    printf("] \n");
    if (error != 0) exit(error);

    error = delaunay_free();
    if (error != 0) exit(error);
    printf("[ERROR=%d] (delaunay_free) \n", error );

    exit(error);
}
