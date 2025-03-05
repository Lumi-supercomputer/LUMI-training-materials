# Debugging at Scale – gdb4hpc, valgrind4hpc, ATP, stat

*Presenter: Thierry Braconnier (HPE)*

Tools discussed:

-   [STAT: Stack Trace Analysis Tool](https://cpe.ext.hpe.com/docs/latest/debugging-tools/stat/index.html) (module `cray-stat`)

-   [ATP: Abnormal Termination Processing](https://cpe.ext.hpe.com/docs/latest/debugging-tools/atp/index.html) (module `atp`)

-   [GDB for HPC](https://cpe.ext.hpe.com/docs/latest/debugging-tools/gdb4hpc/index.html) (module `gdb4hpc`).
    Works for CPU and GPU.

-   [Valgrind for HPC](https://cpe.ext.hpe.com/docs/latest/debugging-tools/valgrind4hpc/guides/user_guide.html)
    (module `valgrid4hpc`)

-   [Sanitizers for HPC](https://cpe.ext.hpe.com/docs/latest/debugging-tools/sanitizers4hpc/guides/user_guide.html)
    (module `sanitizers4hpc`)

-   `CRAY_ACC_DEBUG` environment variable for CCE OpenaCC/OpenMP offload


Course materials will be provided during and after the course.

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001726/Slides/HPE/06_debugging_at_scale.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-306-Debugging_at_Scale.pdf`

<!--
-   Recording: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-306-Debugging_at_Scale.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  How gdb4hpc launch call maps to srun? I mean number of ranks per node and cpus per task?

    -   *You can use `--launcher-args="--tasks-per-node=4"` for example to inject arguments that will be passed to srun in the launch command. If you start gdb4hpc and type "help launch" you can get more information on this.*

