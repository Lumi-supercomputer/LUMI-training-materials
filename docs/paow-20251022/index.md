# Announcement: LUMI Performance Analysis and Optimization Workshop, Tallinn, 22-24 October 2025

!!! Note
    If you are looking for course materials of this course, check the materials of the 
    [previous edition in June 2024](../paow-20240611/index.md).

## Course organisation

-   Location: [Room #SOC-423, Akadeemia tee 3, 12611 Tallinn, Estonia (TalTech School of Business and Governance)](https://www.google.com/maps/place/TalTech+School+of+Business+and+Governance/@59.3969697,24.6637115,17z/data=!4m6!3m5!1s0x469295aa094a8085:0x485c0c53f2beafc6!8m2!3d59.3966531!4d24.6700325!16s%2Fg%2F11clwfsnsy?entry=ttu&g_ep=EgoyMDI1MTAwMS4wIKXMDSoASAFQAw%3D%3D)

    The TalTech Campus is easy to reach with public transportation from the city centre.

-   [Schedule](schedule.md)

<!--
-   [HedgeDoc for questions](https://md.sigma2.no/lumi-performance-workshop-june24?both)

-   Course project: `project_465002175`

-   Reservations:

    -   Day 1: on partition `standard`: `LUMI_profiling_1`

    -   Day 2: on partition `standard-g`: `LUMI_profiling_2`  
-->


## Course materials

Materials will follow as the course progresses

<!--
Due to copyright issues some of the materials are only available to current LUMI users and have to be
downloaded from LUMI.

**Note:** Some links in the table below are dead and will remain so until after the end of the course.
-->

<!--
::spantable::

| Presentation | slides | recording |
|:-------------|:-------|:----------|
| **Day 1** @span |  |  |
| [Introduction](M100_Course_Introduction.md) | / | [recording](M100_Course_Introduction.md) |
| [Architecture, Programming and Runtime Environment](M101_HPE_PE.md) | [slides](M101_HPE_PE.md#materials) | [recording](M101_HPE_PE.md) |
| [Exercises #1](ME101_HPE_PE.md) | / | / |
| [Compilers, libraries, runtime, single-core optimisations](M102_Compilers.md) | [slides](M102_Compilers.md#materials) | [recording](M102_Compilers.md) |
| [Performance Analysis with Perftools](M103_Perftools.md) | [slides](M103_Perftools.md#materials) | [recording](M103_Perftools.md) |
| [Exercises #2](ME103_Perftools.md) | / | / |
| [Advanced Performance Analysis](M104_AdvancedPerformanceAnalysis.md) | [slides](M104_AdvancedPerformanceAnalysis.md#materials) | [recording](M104_AdvancedPerformanceAnalysis.md) |
| [Exercises #3](ME104a_AdvancedPerformanceAnalysis.md) | / | / |
| [Exercises #4](ME104b_AdvancedPerformanceAnalysis.md) | / | / |
| **Day 2** @span |  |  |
| [MPI Optimizations](M201_MPI.md) | [slides](M201_MPI.md) | [recording](M201_MPI.md) |
| [Exercises #5](ME201_MPI.md) | / | / |
| [I/O Optimizations](M202_IO.md) | [slides](M202_IO.md) | [recording](M202_IO.md) |
| [Exercises #6](ME202_IO.md) | / | / |
| [AMD Profiling Tools and GPU optimisations 1](M203_AMD_tools_1.md) | [slides](M203_AMD_tools_1.md#materials) | [recording](M203_AMD_tools_1.md) |
| [Exercises #7](ME203_AMD_tools_1.md) | / | / |
| [AMD Profiling Tools and GPU optimisations 2](M204_AMD_tools_2.md) | [slides](M204_AMD_tools_2.md#materials) | [recording](M204_AMD_tools_2.md) |
| [Exercises #8](ME204_AMD_tools_2.md) | / | / |
| **Day 3** @span |  |  |
| [Best practices: GPU Optimization, tips & tricks](M301_Best_Practices_GPU_Optimization.md) | [slides](M301_Best_Practices_GPU_Optimization.md#materials) | [recording](M301_Best_Practices_GPU_Optimization.md) |
| [Exercises #9](ME301_Best_Practices_GPU_Optimization.md) | / | / |
| **Extras** @span |  |  |
| [Appendix: Links to documentation](A01_Documentation.md) | / | / |

::end-spantable::
-->

<!--
## Making the exercises after the course

### HPE

The exercise material remains available in the course archive on LUMI:

-   The PDF notes in `/appl/local/training/paow-20251022/files/LUMI-paow-20251022-Exercises_HPE.pdf`

-   The other files for the exercises in either a
    bzip2-compressed tar file `/appl/local/training/paow-20251022/files/LUMI-paow-20251022-Exercises_HPE.tar.bz2` or
    an uncompressed tar file `/appl/local/training/paow-20251022/files/LUMI-paow-20251022-Exercises_HPE.tar`.

To reconstruct the exercise material in your own home, project or scratch directory, all you need to do is run:

```
tar -xf /appl/local/training/paow-20251022/files/LUMI-paow-20251022-Exercises_HPE.tar.bz2
```

in the directory where you want to work on the exercises. This will create the `Exercises/HPE` subdirectory
from the training project. 

However, instead of running the `lumi_c.sh` or `lumi_g.sh` scripts that only work for the course as 
they set the course project as the active project for Slurm and also set a reservation, use the
`lumi_c_after.sh` and `lumi_g_after.sh` scripts instead, but first edit them to use one of your
projects.

### AMD

See the notes at each session.

There is no guarantee though that the software that is referred to on the system, will be there forever
or will still work after an update of the system.

!!! Warning
    The software and exercises were tested thoroughly at the time of the course. LUMI however is in
    continuous evolution and changes to the system may break exercises and software
-->


