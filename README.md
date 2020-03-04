# MiniQhull

[![Build Status](https://travis-ci.com/gridap/MiniQhull.jl.svg?branch=master)](https://travis-ci.com/gridap/MiniQhull.jl)
[![Codecov](https://codecov.io/gh/gridap/MiniQhull.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/gridap/MiniQhull.jl)

[MiniQhull](https://github.com/gridap/MiniQhull.jl) ([Qhull](http://www.qhull.org/)-based Delaunay triangulation).

## Documentation

The `MiniQhull` julia package provides a single function `delaunay` overloaded with 2 methods:

### Coordinates vector

```julia
delaunay(dim::Integer, numpoints::Integer, points::Vector) -> Matrix{Int32}
```
Compute the Delaunay triangulation of a cloud of points in an arbitrary dimension `dim`. The length of vector `points` must be `dim*numpoints`. Vector `points` holds data in "component major order", i.e., components are consequitive within the vector. The returned matrix has shape `(dim+1, nsimplices)`, where `nsimplices` is the number of
simplices in the computed delaunay triangulation.

### Coordinates matrix

```julia
delaunay(points::Matrix) -> Matrix{Int32}
```
In this variant, the cloud of points is specified by a matrix with `size(matrix) == (dim, numpoints)`.


## Examples

```julia
using MiniQhull
dim          = 2
numpoints    = 4
coordinates  = [0,0,0,1,1,0,1,1]
connectivity = delaunay(dim, numpoints, coordinates)
# output
3×2 Array{Int32,2}:
 4  4
 2  3
 1  1
```

```julia
using MiniQhull
coordinates  = [0 0 1 1; 0 1 0 1]
connectivity = delaunay(coordinates)
# output
3×2 Array{Int32,2}:
 4  4
 2  3
 1  1
```

## Installation

**MiniQhull** is installed when you add and use it into another project.

Please, ensure that your system fulfill the requirements (see below).

To include into your project form Julia REPL, use the following commands:

```
pkg> add MiniQhull
julia> using MiniQhull
```

If, for any reason, you need to manually build the project, write down the following commands in the Julia REPL:
```
pkg> add MiniQhull
pkg> build MiniQhull
julia> using MiniQhull
```

### Requirements

The `MiniQhull` package requires the [Qhull](http://www.qhull.org/) reentrant library installed in your system. 
It can be installed in any path on your local machine as long as you export the environment variable `QHULL_ROOT_DIR` containing the installation directory. If this environment variable is not set, `MiniQhull` will try to find the library in the usual linux user library directory (`/usr/lib`).

`MiniQhull` also requires any C compiler installed on the system.

#### Qhull installation

##### From Sources

Custom installation of `Qhull` can be performed as described in the official [Qhull installation instructions](http://www.qhull.org/README.txt). 
You can find the latest source code in the oficial [Qhull download section](http://www.qhull.org/download/).

##### Debian-based installation from package manager

The reentrant `Qhull` library can be installed with `apt` in recent Debian-based linux distributions as follows:

```
$ sudo apt-get install update
$ sudo apt-get install libqhull-r7 libqhull-dev
```

If you need to install a C compiler, it can be also obtained by means of `apt` tool:
```
$ sudo apt-get update
$ sudo apt-get gcc
```

## Continuous integration

In order to use `MiniQhull` in continuous integration jobs, you must ensure that its installation requirements are fullfilled in the CI environment.

If your CI process is based on `Travis-CI` you can add the following block at the beginning of your `.travis.yml` file:

```
addons:
  apt:
    update: true
    packages:
    - gcc
    - libqhull-r7
    - libqhull-dev
```

