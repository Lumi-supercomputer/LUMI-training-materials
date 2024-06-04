# Compilers and Parallel Programming Models

*Presenter: Alfio Lazzaro (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001098/Slides/HPE/04_Compilers_and_Programming_Models.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-1_05_Compilers_and_Parallel_Programming_Models.pdf`

-   Recording: `/appl/local/training/4day-20240423/recordings/1_05_Compilers_and_Parallel_Programming_Models.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

!!! Note "Alternative for modifying `LD_LIBRARY_PATH`"
    Instead of using
    ```LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH```,
    you can also use the module [lumi-CrayPath](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-CrayPath/). 
    Loading it essentially does that setting for `LD_LIBRARY_PATH`, unloading tries to restore the old situation, 
    and reloading while the module is already loaded, will adapt to a possibly modified `$CRAY_LD_LIBRARY_PATH`. 
    (So basically use it after loading all other modules that you need.)

## Q&A

1.  Should we compile something on access node?

    -   It is usually fine. Cray Programming environment (`PrgEnv-` modules) does cross-compilation 
        but you need to understand what is your target architecture (`craype-` modules are responsible for that). 
        For clarity LUMI Software Environment provides `partition` modules `/L` (for login nodes architecture) 
        and `/C`, `/G` for CPU and AMD GPU nodes accordingly. 

    -   Very big compiles should be done in a job.

    -   The [last talk on day 2](extra_2_07_LUMI_Software_Stacks.md) will also give some more information 
        about environments we offer that make configuring the target modules easier.

2.  Can I write a code in which offloading is performed with HIP and CPU parallelization is with OpenMP in the same source code?

     -   Yes, you can. In this case you have to add `-fopenmp -xhip` in this order.

3.  Does LibSci have a sparse solver like pardiso solver in MKL? If no, does LUMI have a sparse solver of any kind in the modules?


    -   From AMD point of view check https://github.com/ROCm/hipSPARSE, HPE can answer for the LibSci.

    -   No in libsci, only dense

    -   If any particular libraries are of interest then we would be able to suggest the best way to build them.

