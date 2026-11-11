# LUMI Performance Analysis and Optimization Workshop, Copenhagen, 11-13 November 2026

**[Registration is via the LUMI web site.](https://lumi-supercomputer.eu/events/lumi-profiling-and-optimization-workshop-on-site/)**


## Course organisation

-   Location: [University of Copenhagen, Panum and Mærsk Tower, Blegdamsvej 3B, 2200 Copenhagen, Denmark](https://maps.app.goo.gl/YSgVHpUqN3ExZ81x9),
    Room Panum - 21.2.22a (11-12 November) and Panum – Mødelokale, Bygn. 7.15.149 on (13 November).

-   [Travel and local information](local_info.md)

-   [Schedule](schedule.md)

-   [HedgeDoc for questions](https://siili.rahtiapp.fi/performance-optimization-nov26?both)

    This document is for questions during the course by course participants only.
    It will not be checked before the course. If you have issues joining the project,
    please contact the LUMI helpdesk instead.

-   Course project: `project_465003358`.
    This project should only be used during the course and be used for the course exercise 
    sessions only.

-   Reservations:

    -   Day 1: `workshop-day1` (on the `standard-g` Slurm partition)

    -   Day 2: `workshop-day2` for GPU (on the `standard-g` Slurm partition)

    -   Day 3: `workshop-day3` (on the `standard-g` Slurm partition)

<!--
ReservationName=workshop-day1 StartTime=2026-11-11T10:00:00 EndTime=2026-11-11T18:00:00 Duration=08:00:00
   Nodes=nid[005881-005884,006612-006616,006884-006887,007544-007547] NodeCnt=17 CoreCnt=1088 Features=(null) PartitionName=standard-g Flags=
   TRES=cpu=2176
   Users=(null) Groups=(null) Accounts=project_465003358 Licenses=(null) State=INACTIVE BurstBuffer=(null)
   MaxStartDelay=(null)

ReservationName=workshop-day2 StartTime=2026-11-12T10:00:00 EndTime=2026-11-12T18:00:00 Duration=08:00:00
   Nodes=nid[005881-005884,006612-006616,006884-006887,007544-007547] NodeCnt=17 CoreCnt=1088 Features=(null) PartitionName=standard-g Flags=
   TRES=cpu=2176
   Users=(null) Groups=(null) Accounts=project_465003358 Licenses=(null) State=INACTIVE BurstBuffer=(null)
   MaxStartDelay=(null)

ReservationName=workshop-day3 StartTime=2026-11-12T10:00:00 EndTime=2026-11-12T14:00:00 Duration=04:00:00
   Nodes=nid[005124-005125,005530-005532,005923-005925,006875-006877,007107-007109,007801-007803] NodeCnt=17 CoreCnt=1088 Features=(null) PartitionName=standard-g Flags=
   TRES=cpu=2176
   Users=(null) Groups=(null) Accounts=project_465003358 Licenses=(null) State=INACTIVE BurstBuffer=(null)
   MaxStartDelay=(null)
-->


## Course materials

Materials will follow as the course progresses

Due to copyright issues some of the materials are only available to current LUMI users and have to be
downloaded from LUMI.

**Note:** Some links in the table below are dead and will remain so until after the end of the course.

::spantable::

| Presentation | slides | recording |
|:-------------|:-------|:----------|
| **Day 1** @span |  |  |
| [Welcome and introduction](M100_Course_Introduction.md) | / | [recording](M100_Course_Introduction.md) |
| [Architecture, Programming and Runtime Environment](M101_HPE_PE.md) | [slides](M101_HPE_PE.md#materials) | [lumi](M101_HPE_PE.md) |
| [Exercises #1](ME101_HPE_PE.md) | / | / |
| [Compilers, libraries, runtime, single-core optimisations](M102_Compilers.md) | [slides](M102_Compilers.md#materials) | [lumi](M102_Compilers.md) |
| [Performance Analysis with Perftools](M103_Perftools.md) | [slides](M103_Perftools.md#materials) | [lumi](M103_Perftools.md) |
| [Advanced Performance Analysis](M104_AdvancedPerformanceAnalysis.md) | [slides](M104_AdvancedPerformanceAnalysis.md#materials) | [lumi](M104_AdvancedPerformanceAnalysis.md) |
| [Exercises #2](ME104_Session_2.md) | / | / |
| **Extras** @span |  |  |
| [Appendix: Links to documentation](A01_Documentation.md) | / | / |

::end-spantable::

<!--
| [Exercises #2](ME104_Session_2.md) | / | / |
| [Interactive demo: Strategies for code optimization](M105_Demo_Optimizing_Code.md) | [lumi](M105_Demo_Optimizing_Code.md#materials) | / |
| **Day 2** @span |  |  |
| [MPI Optimizations](M201_MPI.md) | [slides](M201_MPI.md) | [lumi](M201_MPI.md) |
| [Exercises #4](ME201_MPI.md) | / | / |
| [I/O Optimizations](M202_IO.md) | [slides](M202_IO.md) | [lumi](M202_IO.md) |
| [Exercises #5](ME202_IO.md) | / | / |
| [AMD Profiling Tools and GPU optimisations 1](M203_AMD_tools_1.md) | [slides](M203_AMD_tools_1.md#materials) | [recording](M203_AMD_tools_1.md) |
| [Exercises #6](ME203_AMD_tools_1.md) | / | / |
| [AMD Profiling Tools and GPU optimisations 2](M204_AMD_tools_2.md) | [slides](M204_AMD_tools_2.md#materials) | [recording](M204_AMD_tools_2.md) |
| [Exercises #7](ME204_AMD_tools_2.md) | / | / |
| **Day 3** @span |  |  |
| [Best practices: GPU Optimization, tips & tricks](M301_Best_Practices_GPU_Optimization.md) | [slides](M301_Best_Practices_GPU_Optimization.md#materials) | [recording](M301_Best_Practices_GPU_Optimization.md) |
| [Exercises #8](ME301_Best_Practices_GPU_Optimization.md) | / | / |
-->


<!--
## Making the exercises after the course

### HPE

The exercise material remains available in the course archive on LUMI:

-   The PDF notes in `/appl/local/training/paow-20260511/files/LUMI-paow-20260511-Exercises_HPE.pdf`

-   The other files for the exercises in either a
    bzip2-compressed tar file `/appl/local/training/paow-20260511/files/LUMI-paow-20260511-Exercises_HPE.tar.bz2` or
    an uncompressed tar file `/appl/local/training/paow-20260511/files/LUMI-paow-20260511-Exercises_HPE.tar`.

To reconstruct the exercise material in your own home, project or scratch directory, all you need to do is run:

```
tar -xf /appl/local/training/paow-20260511/files/LUMI-paow-20260511-Exercises_HPE.tar.bz2
```

in the directory where you want to work on the exercises. This will create the `Exercises/HPE` subdirectory
from the training project. 

However, instead of running the `lumi_c.sh` or `lumi_g.sh` scripts that only work for the course as 
they set the course project as the active project for Slurm and also set a reservation, use the
`lumi_c_after.sh` and `lumi_g_after.sh` scripts instead, but first edit them to use one of your
projects.


### AMD

See the notes at each session.

Files for the exercises can be downloaded as either a
[bzip2-compressed tar file](https://462000265.lumidata.eu/paow-20260511/files/LUMI-paow-20260511-Exercises_AMD.tar.bz2)
or an [uncompressed tar file](https://462000265.lumidata.eu/paow-20260511/files/LUMI-paow-20260511-Exercises_AMD.tar)
and are also archived on LUMI as either the
bzip2-compressed tar file `/appl/local/training/paow-20260511/files/LUMI-paow-20260511-Exercises_AMD.tar.bz2` or
an uncompressed tar file `/appl/local/training/paow-20260511/files/LUMI-paow-20260511-Exercises_AMD.tar`.

There is no guarantee though that the software that is referred to on the system, will be there forever
or will still work after an update of the system.

!!! Warning
    The software and exercises were tested thoroughly at the time of the course. LUMI however is in
    continuous evolution and changes to the system may break exercises and software
-->
