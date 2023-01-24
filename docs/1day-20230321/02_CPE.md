# The HPE Cray Programming Environment

Every user needs to know the basics about the programming environment as after all
most software is installed through the programming environment, and to some extent
it also determines how programs should be run.

##  The development environment on LUMI

<figure markdown style="border: 1px solid #000">
  ![Slide 2](img/LUMI-1day-20230321-CPE/Dia2.png){ loading=lazy }
</figure>

Long ago, Cray made designed its own processors and hence had to develop their own
compilers. They kept doing so, also when they moved to using more standard components,
and had a lot of expertise in that field, especially when it comes to the needs of 
scientific codes, programming models that are almost only used in scientific computing
or stem from such projects, and as they develop their own interconnects, it does make sense
to also develop an MPI implementation that can use the interconnect in an optimal way.
They also have a long tradition in developing performance measurement and analysis tools 
and debugging tools that work in the context of HPC.

The first important component of the HPE Cray Programming Environment is the compilers.
Cray still builds its own compilers for C/C++ and Fortran, called the Cray Compiling
Environment (CCE). Furthermore, the GNU compilers are also supported on every Cray system,
though at the moment AMD GPU support is not enabled. Depending on the hardware of the 
system other compilers will also be provided and integrated in the environment. On LUMI
two other compilers are available: the AMD AOCC compiler for CPU-only code and the 
AMD ROCm compilers for GPU programming. Both contain a C/C++ compiler based on Clang and
LLVM and a Fortran compiler which is currently based on the former PGI frontend with
LLVM backend. The ROCm compilers also contain the support for HIP, AMD's CUDA clone.

The second component is the Cray Scientific and Math libraries, containing the usual
suspects as BLAS, LAPACK and ScaLAPACK, and FFTW, but also some data libraries and
Cray-only libraries.

The third component is the Cray Message Passing Toolkit. It provides an MPI implementation
optimized for Cray systems, but also the Cray SHMEM libraries, an implementation of
OpenSHMEM 1.5.

The fourth component is some Cray-unique sauce to integrate all these components, and 
support for hugepages to make memory access more efficient for some programs that 
allocate huge chunks of memory at once.

Other components include the Cray Performance Measurement and Analysis Tools and the 
Cray Debugging Support Tools that will not be discussed in this one-day course, and
Python and R modules that both also provide some packages compiled with support for the
Cray Scientific Libraries.

We will now discuss some of these components in a little bit more detail, but refer
to the 4-day trainings that we organise three times a year with HPE for more material.


## The Cray Compiling Environment

<figure markdown style="border: 1px solid #000">
  ![Slide 3](img/LUMI-1day-20230321-CPE/Dia3.png){ loading=lazy }
</figure>

The Cray Compiling Environment are the default compilers on many Cray systems and on LUMI.
These compilers are designed specifically for scientific software in an HPC environment.
The current versions use an LLVM-based backend with extensions by HPE Cray for
automatic vectorization and shared memory parallelization, technology that they
have experience with since the late '70s or '80s.

The compiler offers extensive standards support.
The C and C++ compiler is essentially Clang with LLVM, and the version numbering of the CCE
currently follows the major versions of the Clang compiler used. The support for C and C++
language standards corresponds to that of Clang.
The Fortran compiler uses a frontend developed by HPE Cray, but an LLVM-based backend. 
The compiler supports most of Fortran 2018 (ISO/IEC 1539:2018). The CCE Fortran compiler
is known to be very strict with language standards. Programs that use GNU or Intel extensions
will usually fail to compile, and unfortunately since many developers only test with these
compilers, much Fortran code is not fully standards compliant and will fail.

All CCE compilers support OpenMP, with offload for AMD and NVIDIA GPUs. They claim full
OpenMP 4.5 support with partial (and growing) support for OpenMP 5.0 and 5.1. More 
information about the OpenMP support is found by checking a manual page:
```
man intro_openmp
```
which does require that the `cce` module is loaded.
The Fortran compiler also supports OpenACC for AMD and NVIDIA GPUs. That implementation
claims to be fully OpenACC 2.0 compliant, and offers partial support for OpenACC 2.x/3.x. 
Information is available via
```
man intro_openacc
```
AMD and HPE Cray still recommend moving to OpenMP which is a much broader supported standard.
There are no plans to also support OpenACC in the C/C++ compiler.

The CCE compilers also offer support for some PGAS (Partitioned Global Address Space) languages.
UPC 1.2 is supported, as is Fortran 2008 coarray support. These implementations do not require a
preprocessor that first translates the code to regular C or Fortran. There is also support
for debugging with ARM Forge.

Lastly, there are also bindings for MPI.


## Scientific and math libraries

<figure markdown style="border: 1px solid #000">
  ![Slide 4](img/LUMI-1day-20230321-CPE/Dia4.png){ loading=lazy }
</figure>

Some mathematical libraries have become so popular that they basically define an API for which
several implementations exist, and CPU manufacturers and some open source groups spend a significant
amount of resources to make optimal implementations for each CPU architecture.

The most notorious library of that type is BLAS, a set of basic linear algebra subroutines
for vector-vector, matrix-vector and matrix-matrix implementations. It is the basis for many
other libraries that need those linear algebra operations, including Lapack, a library with
solvers for linear systems and eigenvalue problems.

The HPE Cray LibSci library contains BLAS and its C-interface CBLAS, and LAPACK and its
C interface LAPACKE. It also adds ScaLAPACK, a distributed memory version of LAPACK, and BLACS, the 
Basic Linear Algebra Communication Subprograms, which is the communication layer used by ScaLAPACK.
The BLAS library combines implementations from different sources, to try to offer the most optimal
one for several architectures and a range of matrix and vector sizes.

LibSci also contains one component which is HPE Cray-only: IRT, the Iterative Refinement Toolkit, 
which allows to do mixed precision computations for LAPACK operations that can speed up the generation
of a double precision result with nearly a factor of two for those problems that are suited for
iterative refinement. If you are familiar with numerical analysis, you probably know that the matrix should
not be too ill-conditioned for that.

There is also a GPU-optimized version of LibSci, called LibSCi_ACC, which contains a subset of the
routines of LibSci. We don't have much experience in the support team with this library though.
It can be compared with what Intel is doing with oneAPI MKL which also offers GPU versions of some of
the traditional MKL routines.

Another separate component of the scientific and mathematical libraries is FFTW3, 
Fastest Fourier Transfoerms in the West, which comes with
optimized versions for all CPU architectures supported by recent HPE Cray machines.

Finally, the scientific and math libraries also contain HDF5 and netCDF libraries
in sequential and parallel versions.


## Cray MPI

<figure markdown style="border: 1px solid #000">
  ![Slide 5](img/LUMI-1day-20230321-CPE/Dia5.png){ loading=lazy }
</figure>

HPE Cray build their own MPI library with optimisations for their own interconnects.
The Cray MPI library is derived from the ANL MPICH 3.4 code base and fully support the 
ABI (Application Binary Interface) of that application which implies that in principle
it should be possible to swap the MPI library of applications build with that ABI with
the Cray MPICH library. Or in other words, if you can only get a binary distribution of
an application and that application was build against an MPI library compatible with 
the MPICN 3.4 ABI (which includes Intel MPI) it should be possible to exchange that
library for the Cray one to have optimised communication on the Cray Slingshot interconnect.

Cray MPI contains many tweaks specifically for Cray systems.
HPE Cray claim improved algorithms for many collectives, an asynchornous
progress engine to improve overlap of communications and computations, 
customizable collective buffering when using MPI-IO, and
optimized remote memory access (MPI one-sided communication) which also supports
passive remote memory access.

When used in the correct way (some attention is needed when linking applications) it is allo fully
GPU aware with currently support for AMD and NVIDIA GPUs.

The MPI library also supports bindings for Fortran 2008.

MPI 3.1 is almost completely supported, with two exceptions. Dynamic process management is not
supported (and a problem anyway on systems with batch schedulers), and when using CCE
MPI_LONG_DOUBLE and MPI_C_LONG_DOUBLE_COMPLEX are also not supported.

The Cray MPI library does not support the `mpirun` or `mpiexec` commands, which is in fact
allowed by the standard which only requires a process starter and suggest `mpirun` or `mpiexec` 
depending on the version of the standard. Instead the Slurm `srun` command is used as the 
process starter. This actually makes a lot of sense as the MPI application should be mapped
correctly on the allocated resources, and the resource manager is better suited to do so.

Cray MPI on LUMI is layered on top of libfabric, which in turn uses the so-called Cassini provider
to interface with the hardware. UCX is not supported on LUMI (but Cray MPI can support it when used
on InfiniBand clusters). It also uses a GPU Transfer Library (GTL) for GPU-aware MPI.





