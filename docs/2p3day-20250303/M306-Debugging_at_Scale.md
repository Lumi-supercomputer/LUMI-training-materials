# Debugging at Scale – gdb4hpc, valgrind4hpc, ATP, stat

*Presenter: Thierry Braconnier (HPE)*

Tools discussed:

-   [STAT: Stack Trace Analysis Tool](https://cpe.ext.hpe.com/docs/24.03/debugging-tools/index.html#stat-stack-trace-analysis-tool) (module `cray-stat`)

-   [ATP: Abnormal Termination Processing](https://cpe.ext.hpe.com/docs/24.03/debugging-tools/index.html#atp-abnormal-termination-processing) (module `atp`)

-   [GDB for HPC](https://cpe.ext.hpe.com/docs/24.03/debugging-tools/index.html#gdb4hpc) (module `gdb4hpc`).
    Works for CPU and GPU.

-   [CCDB - Cray comparative Debugger](https://cpe.ext.hpe.com/docs/24.03/debugging-tools/index.html#ccdb-cray-comparative-debugger)

-   [Valgrind for HPC](https://cpe.ext.hpe.com/docs/24.03/debugging-tools/index.html#valgrind4hpc)
    (module `valgrid4hpc`)

-   [Sanitizers for HPC](https://cpe.ext.hpe.com/docs/24.03/debugging-tools/index.html#sanitizers4hpc)
    (module `sanitizers4hpc`)

-   `CRAY_ACC_DEBUG` environment variable for CCE OpenaCC/OpenMP offload


<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001726/Slides/HPE/06_debugging_at_scale.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-306-Debugging_at_Scale.pdf`

-   Recording: `/appl/local/training/2p3day-20250303/recordings/306-Debugging_at_Scale.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  How gdb4hpc launch call maps to srun? I mean number of ranks per node and cpus per task?

    -   *You can use `--launcher-args="--tasks-per-node=4"` for example to inject arguments that will be passed to srun in the launch command. If you start gdb4hpc and type "help launch" you can get more information on this.*

