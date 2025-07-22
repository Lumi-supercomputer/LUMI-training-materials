# Performance Analysis and Optimization Workshop, Oslo, 11-2 June 2024

## Course organisation

-   Location: [Talltech Campus](https://maps.app.goo.gl/kjHg2t7NMV2UQr3WA), Tallinn, Estonia.

    The exact building and room is TBA.

    The Talltech Campus is easy to reach with public transportation from the city centre.

-   [Schedule](schedule.md)

<!--
-   [HedgeDoc for questions](https://md.sigma2.no/lumi-performance-workshop-june24?both)

-   Course project: `project_465001154`

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
| Presentation | slides | recording |
|:-------------|:-------|:----------|
| [Introduction](M_1_00_Course_Introduction.md) | / | [recording](M_1_00_Course_Introduction.md) |
| [Architecture, Programming and Runtime Environment](M_1_01_HPE_PE.md) | [slides](M_1_01_HPE_PE.md#materials) | [recording](M_1_01_HPE_PE.md) |
| [Exercises #1](ME_1_01_HPE_PE.md) | / | / |
| [Performance Analysis with Perftools](M_1_02_Perftools.md) | [slides](M_1_02_Perftools.md#materials) | [recording](M_1_02_Perftools.md) |
| [Improving Single-Core Efficiency](M_1_03_PerformanceOptimization.md) | [slides](M_1_03_PerformanceOptimization.md#materials) | [recording](M_1_03_PerformanceOptimization.md) |
| [Application Placement](M_1_04_ApplicationPlacement.md) | [slides](M_1_04_ApplicationPlacement.md#materials) | [recording](M_1_04_ApplicationPlacement.md) |
| [Demo and Exercises Part 1](M_1_05_PerformanceAnalysisAtWork_1.md) | [slides](M_1_05_PerformanceAnalysisAtWork_1.md#materials) | [recording](M_1_05_PerformanceAnalysisAtWork_1.md) |
| [Demo and Exercises Part 2](M_1_06_PerformanceAnalysisAtWork_2.md) | [slides](M_1_06_PerformanceAnalysisAtWork_2.md#materials) | [recording](M_1_06_PerformanceAnalysisAtWork_2.md) |
| [AMD Profiling Tools Overview & Omnitrace](M_2_01_AMD_tools_1.md) | [slides](M_2_01_AMD_tools_1.md#materials) | [recording](M_2_01_AMD_tools_1.md) |
| [Exercises #2](ME_2_01_AMD_tools_1.md) | / | / |
| [Introduction to Omniperf](M_2_02_AMD_tools_2.md) | [slides](M_2_02_AMD_tools_2.md#materials) | [recording](M_2_02_AMD_tools_2.md) |
| [Exercises #3](ME_2_02_AMD_tools_2.md) | / | / |
| [MPI Optimizations](M_2_03_MPI.md) | [slides](M_2_03_MPI.md) | [recording](M_2_03_MPI.md) |
| [Exercises #4](ME_2_03_MPI.md) | / | / |
| [I/O Optimizations](M_2_04_IO.md) | [slides](M_2_04_IO.md) | [recording](M_2_04_IO.md) |
| [Exercises #5](ME_2_04_IO.md) | / | / |
| [Appendix: Links to documentation](M_A01_Documentation.md) | / | / |
-->

<!--
## Making the exercises after the course

### HPE

The exercise material remains available in the course archive on LUMI:

-   The PDF notes in `/appl/local/training/paow-20240611/files/LUMI-paow-20240611-Exercises_HPE.pdf`

-   The other files for the exercises in either a
    bzip2-compressed tar file `/appl/local/training/paow-20240611/files/LUMI-paow-20240611-Exercises_HPE.tar.bz2` or
    an uncompressed tar file `/appl/local/training/paow-20240611/files/LUMI-paow-20240611-Exercises_HPE.tar`.

To reconstruct the exercise material in your own home, project or scratch directory, all you need to do is run:

```
tar -xf /appl/local/training/paow-20240611/files/LUMI-paow-20240611-Exercises_HPE.tar.bz2
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


