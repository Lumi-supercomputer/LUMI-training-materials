# Advanced LUMI Training, October 28-31, 2024

## Course organisation

-   Location: [SURF, Science Park 140, 1098 XG Amsterdam, The Netherlands](https://maps.app.goo.gl/GL1npKVy5Je5UFxJ7)

-   The public transportation is run by [GVB](https://www.gvb.nl/).

    -   Whatever type of ticket you have, you always need to check in and check out. 

        It is now perfectly possible to do so with your bank card, but of course you
        should use the same one to check in and check out.

        If you use your bank card, you can use their app Gappie to follow up your use.
        The app also provides routing, and you can by regular single or multi-day
        tickets in it that will then work with a QR code.

    -   [Gappie app for iOS](https://apps.apple.com/nl/app/gvb-reis-app/id1544439867) and
        [Gappie app for Android](https://play.google.com/store/apps/details?id=nl.gvb.reizigersapp)

    -   Multi-day tickets are interesting if you take public transportation a lot.
        You can buy them in the Gappie app, but 
        opening the app and scanning the QR code is a slow process compared to tapping a
        credit card on the reader. If all travel you need is from a hotel in the centre 
        to the venue and back, it isn't worth it.

-   Amsterdam is more than canals and the red light district.
    [You don't have to drink only water and milk](where_to_drink.md) and
    [there is more food than "bitterballen" from the FEBO](where_to_eat.md).
   
-   [Original schedule (PDF)](https://462000265.lumidata.eu/4day-20241028/files/2024-10_General-LUMI-Training-Agenda.pdf)

    [Dynamic schedule (adapted as the course progresses)](schedule.md)

     *The dynamic schedule also contains links to pages with information about the course materials, but 
     those links are also available below on this page.*

-   [HedgeDoc for questions](https://md.sigma2.no/lumi-general-course-oct24?both)

-   During the course, there are two Slurm reservations available:

    -   CPU nodes: `lumic_ams`
    -   GPU nodes: `lumig_ams`

    They can be used in conjunction with the training project `project_465001362`.

    Note that the reservations and course project should only be used for making the exercises 
    during the course and not for running your own jobs. 
    The resources allocated to the course are very limited.


## Course materials

Course materials include the Q&A of each session, slides when available and notes when available.

Due to copyright issues some of the materials are only available to current LUMI users and have to be
downloaded from LUMI.

**Note:** Some links in the table below are dead and will remain so until after the end of the course.

| Presentation | slides | notes | recording |
|:-------------|:-------|:------|:----------|
| [Introduction](extra_1_00_Introduction.md) | / | / | [web](extra_1_00_Introduction.md) |
| [HPE Cray EX Architecture](extra_1_01_HPE_Cray_EX_Architecture.md) | [lumi](extra_1_01_HPE_Cray_EX_Architecture.md) | / | [lumi](extra_1_01_HPE_Cray_EX_Architecture.md) |
| [Programming Environment and Modules](extra_1_02_Programming_Environment_and_Modules.md) | [lumi](extra_1_02_Programming_Environment_and_Modules.md) | / | [lumi](extra_1_02_Programming_Environment_and_Modules.md) |
| [Running Applications](extra_1_03_Running_Applications.md) | [lumi](extra_1_03_Running_Applications.md) | / | [lumi](extra_1_03_Running_Applications.md) |
| [Exercises #1](extra_1_04_Exercises_1.md) | / | / | / |
| [Compilers and Parallel Programming Models](extra_1_05_Compilers_and_Parallel_Programming_Models.md) | [lumi](extra_1_05_Compilers_and_Parallel_Programming_Models.md) | / | [lumi](extra_1_05_Compilers_and_Parallel_Programming_Models.md) |
| [Exercises #2](extra_1_06_Exercises_2.md) | / | / | / |
| [Cray Scientific Libraries](extra_1_07_Cray_Scientific_Libraries.md) | [lumi](extra_1_07_Cray_Scientific_Libraries.md) | / | [lumi](extra_1_07_Cray_Scientific_Libraries.md) |
| [Exercises #3](extra_1_08_Exercises_3.md) | / | / | / |
| [CCE Offloading Models](extra_1_09_Offload_CCE.md) | [lumi](extra_1_09_Offload_CCE.md) | / | [lumi](extra_1_09_Offload_CCE.md) |
| [Advanced Placement](extra_2_01_Advanced_Application_Placement.md) | [lumi](extra_2_05_Advanced_Application_Placement.md) | / | [lumi](extra_2_05_Advanced_Application_Placement.md) |
| [Exercises #4](extra_2_02_Exercises_4.md) | / | / | / |
| [Debugging at Scale](extra_2_03_Debugging_at_Scale.md) | [lumi](extra_2_03_Debugging_at_Scale.md) | / |  [lumi](extra_2_03_Debugging_at_Scale.md) |
| [Exercises #5](extra_2_04_Exercises_5.md) | / | / | / |
| [Introduction to the AMD ROCm Ecosystem](extra_2_05_Introduction_to_AMD_ROCm_Ecosystem.md) | [web](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-2_05_Introduction_to_AMD_ROCm_Ecosystem.pdf) | / | [web](extra_2_05_Introduction_to_AMD_ROCm_Ecosystem.md) |
| [Exercises #6](extra_2_06_Exercises_6.md) | / | / | / |
| [LUMI Software Stacks](extra_2_07_LUMI_Software_Stacks.md) | [web](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-2_07_software_stacks.pdf) | [web](notes_2_07_LUMI_Software_Stacks.md) |  [web](extra_2_07_LUMI_Software_Stacks.md) |
| [Introduction to Perftools](extra_3_01_Introduction_to_Perftools.md) | [lumi](extra_3_01_Introduction_to_Perftools.md) | / |  [lumi](extra_3_01_Introduction_to_Perftools.md) |
| [Exercises #7](extra_3_02_Exercises_7.md) | / | / | / |
| [Advanced Performance Analysis](extra_3_03_Advanced_Performance_Analysis.md) | [lumi](extra_3_03_Advanced_Performance_Analysis.md) | / |  [lumi](extra_3_03_Advanced_Performance_Analysis.md) |
| [Exercises #8](extra_3_04_Exercises_8.md) | / | / | / |
| [MPI Topics on the HPE Cray EX Supercomputer](extra_3_05_Cray_MPI_on_Slingshot.md) | [lumi](extra_3_05_Cray_MPI_on_Slingshot.md) | / | [lumi](extra_3_05_Cray_MPI_on_Slingshot.md) |
| [Exercises #9](extra_3_06_Exercises_9.md) | / | / | / |
| [AMD Debugger: ROCgdb](extra_3_07_AMD_ROCgdb_Debugger.md) | [web](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-3_07_AMD_ROCgdb_Debugger.pdf) | / | [web](extra_3_07_AMD_ROCgdb_Debugger.md) |
| [Exercises #10](extra_3_08_Exercises_10.md) | / | / | / |
| [Introduction to ROC-Profiler (rocprof)](extra_3_09_Introduction_to_Rocprof_Profiling_Tool.md) | [web](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-3_09_Introduction_to_Rocprof_Profiling_Tool.pdf) | / | [web](extra_3_09_Introduction_to_Rocprof_Profiling_Tool.md) |
| [Exercises #11](extra_3_10_Exercises_11.md) | / | / | / |
| [Introduction to Python on Cray EX](extra_4_01_Introduction_to_Python_on_Cray_EX.md) | [lumi](extra_4_01_Introduction_to_Python_on_Cray_EX.md) | / |[lumi](extra_4_01_Introduction_to_Python_on_Cray_EX.md) |
| [Performance Optimization: Improving single-core Efficiency](extra_4_02_Performance_Optimization_Improving_Single_Core.md) | [lumi](extra_4_02_Performance_Optimization_Improving_Single_Core.md) | / | [lumi](extra_4_02_Performance_Optimization_Improving_Single_Core.md) |
| [Frameworks for porting applications to GPUs](extra_4_03_Porting_to_GPU.md) | [lumi](extra_4_03_Porting_to_GPU.md) | / |[lumi](extra_4_03_Porting_to_GPU.md) |
| [Exercises #12](extra_4_04_Exercises_12.md) | / | / | / |
| [Optimizing Large Scale I/O](extra_4_05_IO_Optimization_Parallel_IO.md) | [lumi](extra_4_05_IO_Optimization_Parallel_IO.md) | / | [lumi](extra_4_05_IO_Optimization_Parallel_IO.md) |
| [Exercises #13](extra_4_06_Exercises_13.md) | / | / | / |
| [Introduction to OmniTrace](extra_4_07_AMD_Omnitrace.md) | [web](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-4_07_AMD_Omnitrace.pdf) | / |  [web](extra_4_07_AMD_Omnitrace.md) |
| [Exercises #14](extra_4_08_Exercises_14.md) | / | / | / |
| [Introduction to Omniperf](extra_4_09_AMD_Omniperf.md) | [web](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-4_09_AMD_Omniperf.pdf) | / |  [web](extra_4_09_AMD_Omniperf.md) |
| [Exercises #15](extra_4_10_Exercises_15.md) | / | / | / |
| [Tools in Action - An Example with Pytorch](extra_4_11_Best_Practices_GPU_Optimization.md) | [web](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-4_11_Best_Practices_GPU_Optimization.pdf) | / | [web](extra_4_11_Best_Practices_GPU_Optimization.md) |
| [LUMI User Support](extra_4_12_LUMI_Support_and_Documentation.md) | [web](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-4_12_LUMI_Support_and_Documentation.pdf) | [web](notes_4_12_LUMI_Support_and_Documentation.md) | [web](extra_4_12_LUMI_Support_and_Documentation.md) |
| [Appendix: Additional documentation](A01_Documentation.md) | / | [documentation](A01_Documentation.md) | / |
<!--
-->
<!-- | [Appendix: Miscellaneous questions](A02_Misc_Questions.md) | / | [questions](A02_Misc_Questions.md) | / | -->


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

There are [online notes about the AMD exercises](https://hackmd.io/@sfantao/lumi-training-ams-2024).
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


## Links to documentation

[The links to all documentation mentioned during the talks is on a separate page](A01_Documentation.md).

## External material for exercises

Some of the exercises used in the course are based on exercises or other material available in various GitHub repositories:

-   [OSU benchmark](https://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.9.tar.gz)
-   [Fortran OpenACC examples](https://github.com/RonRahaman/openacc-mpi-demos)
-   [Fortran OpenMP examples](https://github.com/ye-luo/openmp-target)
-   [Collections of examples in BabelStream](https://github.com/UoB-HPC/BabelStream)
-   [hello_jobstep example](https://code.ornl.gov/olcf/hello_jobstep)
-   [Run OpenMP example in the HPE Suport Center](https://support.hpe.com/hpesc/public/docDisplay?docId=a00114008en_us&docLocale=en_US&page=Run_an_OpenMP_Application.html)
-   [ROCm HIP examples](https://github.com/ROCm-Developer-Tools/HIP-Examples)

