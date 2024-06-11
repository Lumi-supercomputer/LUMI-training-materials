# LUMI Architecture, Programming and Runtime Environment

*Presenter: Harvey Richardson (HPE)*

## Materials

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001154/Slides/HPE/01_Architecture_PE_modules_slurm.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/paow-20240611/files/LUMI-paow-20240611-1_01_Architecture_PE_modules_slurm.pdf`

-   Recording: `/appl/local/training/paow-20240611/recordings/1_01_HPE_PE.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  PAT only with the Cray compiler or all other back end ?

    -    Assuming by back-end you mean other compilers (GNU, AMD), the answer is yes. You should be able to use cray PAT with the different compilers.

2.  How to control number of openmp threads for libsci if it called inside a nasted openmp loop?
    -   The library is "OpenMP-aware", so it will not spawn nested threads if it is already inside an OpenMP region. 
   
    Can you use nested OpenMP, e.g., on 16 cores use 4 threads at the outer level, having 4 threads for each LibSci routine? It is possible to set nested parallelism via OpenMP environment variables.

    -   It is not possible, the library will check that you are inside a parallel region and will do in serial only.

    What if I really want to do it like this, other options for the libs could be used?

    -   (Kurt) You are of course free to compile any other BLAS and Lapack implementation which may support nested parallelism. But it does imply that you cannot use pre-compiled software on LUMI that is built with \ cray-libsci\ .

3.  Question in the room about which target modules should be used:

    -   The difference is likely not that large as there is not really an instruction set difference between zen2 and
        zen3, but there are differences in the cache architecture and in the latency of various instructions.

    -   Technically speaking: `craype-x86-milan` on the regular compute nodes, `craype-x86-rome` on the login nodes and
        the nodes for data analytics (`largemem` and `lumid` Slurm partitions), and `craype-x86-trento` for the GPU nodes.

4.  Question in the room about the limited number of packages in `cray-python`: Why these and no others?

    -    (Kurt) These are actually packages were linking to the Cray libraries is either essential (mpi4py) or where you need to take care to link to Cray LibSci if you want the performance offered by that library.

5.  Fortran code for AMD GPU which compiler should be choose on LUMI?
 
    a.  OpenMP offload
   
       -   Cray Fortran is defnitely more mature than the Fortran compiler included with ROCm (the latter in the `amd` module / `PrgEnv-amd`)

           The system update that is planned to start on August 19 will be a big upgrade for ROCm and its compilers.

    b.  hipfort
   
       -   Hipfort is a library to facilitate the implementation of C bindings 
           for the HIP runtime and libraries.
           You can use that with any compiler.

6.  aocc flang, which flags could match the performance as gfortran (most of the code do with double complex number)?

    -   It is difficult to tell for sure what will improve performance to match or exceed some other compiler. This will always need experimentation. Compilers have different defaults to floating point operation ordering, heuristics controlling unrolling and inlining. So, I'd start there and see the flags that influence. We can look into something more specific if there is a repro to experiement with. 
