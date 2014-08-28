NB. lapacke manifest

CAPTION=: 'LAPACKE'

DESCRIPTION=: 0 : 0
LAPACK version 3.X is a comprehensive FORTRAN library that does linear algebra operations including matrix inversions, least squared solutions to linear sets of equations, eigenvector analysis, singular value decomposition, etc. It is a very comprehensive and reputable package that has found extensive use in the scientific community.

This package contains the LAPACKE C Interface to LAPACK
http://www.netlib.org/lapack/lapacke.html

Binary for Linux, install liblapacke (or similar) from your distro repository.
For 64-bit windows, it needs 6 dll files,
libblas.dll liblapack.dll liblapacke.dll : from http://icl.cs.utk.edu/lapack-for-windows/lapack/#libraries
libgcc_s_sjlj-1.dll libgfortran-3.dll libquadmath-0.dll : runtime dll files from mingw
)

VERSION=: '1.0.3'

RELEASE=: 'j602 j701 j801'

FILES=: 0 : 0
lapacke.ijs
test.ijs
test0.ijs
)

PLATFORMS=: ''
