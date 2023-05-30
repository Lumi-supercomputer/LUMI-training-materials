# Compilers and Parallel Programming Models

*Presenter: Alfio Lazzaro (HPE)*


-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-1_05_Compilers_and_Parallel_Programming_Models.pdf`
    -   `/project/project_465000524/slides/HPE/04_Compilers_and_Programming_Models.pdf` (temporary, for the lifetime of the project)

These materials can only be distributed to actual users of LUMI (active user account).

## Q&A

10. Rocm has two backends, HIP and OpenCL that cannot be made available at the same time, i.e. the packages conflict. Could you give some background why is that and why OpenCL and HIP in Rocm cannot coexist?

    **Answer** [Sam AMD] I believe OpenCL and HIP supporting libraries can coexist in the system. Having the two models coexist in the same application I'll have to investigate as I didn't try that before.

11. So what approach should one use to compile code which uses MPI, OpenMP threads (but no OpenMP offload), and HIP all in one code and in the same source code files as well?

    **Answer** [Sam AMD] If you are building HIP code in the source file you need to rule out GNU. I'd try with the Cray wrappers (CC) with `-x hip` to point out you want that to be interpreted as an HIP source code. Because you care about OpenMP you need to enable it with -fopenmp. You could always use the ROCm clang and link MPI in if you feel confortable with it. Order matters: `-fopenmp` needs to come prior to `-x hip`.
    
    **Reply** Currently Loaded Modules:

    ```
    1) craype-accel-amd-gfx90a   3) craype/2.7.19      5) libfabric/1.15.2.0   7) cray-mpich/8.1.23       9) PrgEnv-cray/8.3.3  11) craype-x86-trento 2) cce/15.0.0                4) cray-dsmml/0.2.2   6) craype-network-ofi   8) cray-libsci/22.12.1.1  10) rocm/5.2.3
    ````

    I compile with:
    `CC -g -O3 -fopenmp -x hip`
    Trying to link with:
    `CC -fopenmp --hip-link -o executable sourceobjects.o libraries`
    I get
    Warning: Ignoring device section hip-amdgcn-amd-amdhsa-gfx90a

