# Advanced LUMI Training, March 3-7, 2025

## Course organisation

-   Location: KTH, Stockholm, Sweden

-   [Draft schedule](schedule.md)

<!--
-   [HedgeDoc for questions](https://md.sigma2.no/lumi-general-course-mar25?both)

-   During the course, there are two Slurm reservations available:

    -   CPU nodes: `lumic_ams`
    -   GPU nodes: `lumig_ams`

    They can be used in conjunction with the training project `project_465001362`.

    Note that the reservations and course project should only be used for making the exercises 
    during the course and not for running your own jobs. 
    The resources allocated to the course are very limited.
-->


## Course materials

Course materials include the Q&A of each session, slides when available and notes when available.
These materials will become available as the course progresses.

Due to copyright issues some of the materials are only available to current LUMI users and have to be
downloaded from LUMI.

**Note:** Some links in the table below are dead and will remain so until after the end of the course.



<!--
## Making the exercises after the course

### HPE

The exercise material remains available in the course archive on LUMI:

-   The PDF notes in `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-Exercises_HPE.pdf`

-   The other files for the exercises in either a
    bzip2-compressed tar file `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-Exercises_HPE.tar.bz2` or
    an uncompressed tar file `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-Exercises_HPE.tar`.

To reconstruct the exercise material in your own home, project or scratch directory, all you need to do is run:

```
tar -xf /appl/local/training/4day-20241028/files/LUMI-4day-20241028-Exercises_HPE.tar.bz2
```

in the directory where you want to work on the exercises. This will create the `Exercises/HPE` subdirectory
from the training project. 

However, instead of running the `lumi_c.sh` or `lumi_g.sh` scripts that only work for the course as 
they set the course project as the active project for Slurm and also set a reservation, use the
`lumi_c_after.sh` and `lumi_g_after.sh` scripts instead, but first edit them to use one of your
projects.

### AMD 

There are [online notes about the AMD exercises](https://hackmd.io/@sfantao/H1QU6xRR3).
A [PDF print-out with less navigation features is also available](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-Exercises_AMD.pdf)
and is particularly useful should the online notes become unavailable. However, some lines are incomplete.
A [web backup](exercises_AMD_hackmd.md) is also available, but corrections to the original made after the course
are not included.

The other files for the exercises are available in 
either a bzip2-compressed tar file `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-Exercises_AMD_.tar.bz2` or
an uncompressed tar file `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-Exercises_AMD.tar` and can also be downloaded. 
( [bzip2-compressed tar download](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-Exercises_AMD.tar.bz2) or 
[uncompressed tar download](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-Exercises_AMD.tar))

To reconstruct the exercise material in your own home, project or scratch directory, all you need to do is run:

```
tar -xf /appl/local/training/4day-20241028/files/LUMI-4day-20241028-Exercises_AMD.tar.bz2
```

in the directory where you want to work on the exercises. This will create the `exercises/AMD` subdirectory
from the training project. You can do so in the same directory where you installed the HPE exercises.

!!! Warning
    The software and exercises were tested thoroughly at the time of the course. LUMI however is in
    continuous evolution and changes to the system may break exercises and software
-->

## Links to documentation

[The links to all documentation mentioned during the talks is on a separate page](A01_Documentation.md).

<!--
## External material for exercises

Some of the exercises used in the course are based on exercises or other material available in various GitHub repositories:

-   [OSU benchmark](https://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.9.tar.gz)
-   [Fortran OpenACC examples](https://github.com/RonRahaman/openacc-mpi-demos)
-   [Fortran OpenMP examples](https://github.com/ye-luo/openmp-target)
-   [Collections of examples in BabelStream](https://github.com/UoB-HPC/BabelStream)
-   [hello_jobstep example](https://code.ornl.gov/olcf/hello_jobstep)
-   [Run OpenMP example in the HPE Suport Center](https://support.hpe.com/hpesc/public/docDisplay?docId=a00114008en_us&docLocale=en_US&page=Run_an_OpenMP_Application.html)
-   [ROCm HIP examples](https://github.com/ROCm-Developer-Tools/HIP-Examples)
-->
