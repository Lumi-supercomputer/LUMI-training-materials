# Compilers and Parallel Programming Models

*Presenters: Harvey Richardson and Alfio Lazzaro (HPE)*

<!-- Course materials will be provided during and after the course. -->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001726/Slides/HPE/02_Compilers_and_Programming_Models.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-302-Compilers_and_Parallel_Programming_Models.pdf`

-   Recording: `/appl/local/training/2p3day-20250303/recordings/302-Compilers_and_Parallel_Programming_Models.mp4`

<!--
-   Could add references from the last slide?
-->

These materials can only be distributed to actual users of LUMI (active user account).

!!! Note "Alternative for modifying `LD_LIBRARY_PATH`"
    Instead of using
    ```LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH```,
    you can also use the module [lumi-CrayPath](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-CrayPath/). 
    Loading it essentially does that setting for `LD_LIBRARY_PATH`, unloading tries to restore the old situation, 
    and reloading while the module is already loaded, will adapt to a possibly modified `$CRAY_LD_LIBRARY_PATH`. 
    (So basically use it after loading all other modules that you need.)


## Q&A

1.  Can managed memory be activated on openmp with amd gpu?

    -   *I'll check with the speakers but we should have talks coming up about the ways of using memory on the AMD GPUs (the XNACK story).
        but the short answer is, of course.*


2.  Differences between PrgEnv-cray and Prg-amd

    -   *Explained two days ago in the introductory part of the course. PrgEnv-cray loads the Cray compilers (cce module), PrgEnv-amd loads the ROCm compiles (rocm and amd modules). Both use clang/LLVM for C/C++ with their own extensions, but the Fortran compilers are very different.*

    Considering that I want to use OpenMP with AMD gpus in C++ are they interchangeable?

    -   *On paper, yes, in practice, no, as they both use their own OpenMP runtime library so support for OpenMP features and bugs in that support, are different. Some code may work with one but not with the other.*

3.  What are the performance differences between GNU and Cray compilers, how much do we suffer by using gcc/gfortran?

    -   *You can only know by trying on your code, as for each compiler you will find benchmarks where one is better and benchmarks where another one is better. For C/C++ they are close, for Fortran gfortran is far behind in optimisation technology compared to Cray Fortran. But then Cray Fortran is so strict on standards that it may not work for your code if you use GNU extensions...*

    -   *One of the exercises on day 1 of this 5-day course actually uses both C and Fortran compilers to compile some rather simple code and show the differences... See https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/E102-CPE/#compilation-of-a-program-2-a-program-with-blas Obviously, this is just one small example and not representative for all code, but it does show something...*


4.  In summary if I want to compile a code written in C++ with GPU offloading i need to load the modules: 

    ```
    #module load craype-x86-trento
    #module load PrgEnv-cray or #module load PrgEnv-amd
    #module load craype-accel-amd-gfx90a
    #module load rocm
    ```

    and then I use the flag -fopenmp?

    -   *We've discussed a better way to work with those modules in day 1 of the course, but yes, this should work.*

7.  I was lost when you said: can NVIDIA HPC toolkit load on LUMI?

    -   *No. LUMI is an AMD system. For completeness they did show the two programming environments they have for other systems also. NVIDIA HPC toolkit is proprietary and only supports NVIDIA GPUs. We have some A40s for visualisaton but they should not be used for compute.*

    -   *That comment was just to indicate that the programming environment (in general) supports a range of architectures. Some parts of it will not be available on particular systems, so for example with LUMI we would not install the nvhpc parts as it makes no sense.*
