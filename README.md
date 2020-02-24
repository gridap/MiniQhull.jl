# MiniQhull

[![Build Status](https://travis-ci.com/gridap/MiniQhull.jl.svg?branch=master)](https://travis-ci.com/gridap/MiniQhull.jl)
[![Codecov](https://codecov.io/gh/gridap/MiniQhull.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/gridap/MiniQhull.jl)

[MiniQhull](https://github.com/gridap/MiniQhull.jl) ([Qhull](http://www.qhull.org/)-based Delaunay triangulation).

## Basic Usage

```julia
    dim          = Int32(2)
    numpoints    = Int32(4)
    points       = Vector{Float64}([0,0,0,1,1,0,1,1])
    connectivity = delaunay(dim, numpoints, points)
```

## Installation

**MiniQhull** itself is installed when you add and use it into another project.

Please, ensure that your system fulfill the requirements.

To include into your project form Julia REPL, use the following commands:

```
pkg> add MiniQhull
julia> using MiniQhull
```

If, for any reason, you need to manually build the project (e.g., you added the project with the wrong environment resulting a build that fails, you have fixed the environment and want to re-build the project), write down the following commands in Julia REPL:
```
pkg> add MiniQhull
pkg> build MiniQhull
julia> using MiniQhull
```

### Requirements

`MiniQhull` julia package requires [Qhull](http://www.qhull.org/) reentrant library installed in a system path. Reentrant `Qhull` library can be installed in any path on your local machine. In order to succesfull describe your custom installation to be located by `MiniQhull`, you must export `QHULL_ROOT_DIR` environment variable. If this environment variables are not available, `MiniQhull` will try to find the library in the usual linux user library directory (`/usr/lib`).

`MiniQhull` also requires any C compiler installed on the system.


#### Basic Qhull installation on Debian-based systems

Reentrant `Qhull` can be obtained from the default repositories of your Debian-based OS by means of `apt` tool.

Basic reentrant `Qhull` installation in order to use it from `MiniQhull` julia package is as follows:

```
$ sudo apt-get update
$ sudo apt-get libqhull-r7 libqhull-dev
```

If you need to install a C compiler, it can be also obtained by means of `apt` tool:
```
$ sudo apt-get update
$ sudo apt-get gcc
```

## Continuous integration

In order to take advantage of `MiniQhull` julia package during continuous integration, you must ensure that the requirements are fullfilled in the CI environment.

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

