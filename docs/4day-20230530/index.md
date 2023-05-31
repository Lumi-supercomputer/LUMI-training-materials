# Comprehensive General LUMI Training, May 30 - June 2, 2023

## Course organisation

-   Location: TalTech IT Kolledž, Raja 4c, Tallinn, Estonia, room ICO-221

    [Public transportation in Tallinn](https://visittallinn.ee/eng/visitor/plan/transport/public-transport)

-   [Schedule (PDF)](https://462000265.lumidata.eu/4day-20230530/files/2023-05_General-LUMI-Training-Agenda.pdf)

    [Dynamic schedule (adapted as the course progresses)](schedule.md)

     *The full filename for the slides and the video recording of each presentation is also mentioned in that table,
     if that file is only available on LUMI.*

-   [HedgeDoc for questions](https://md.sigma2.no/lumi-general-course?both)

-   There are two Slurm reservations for the course:

    -   CPU nodes: `training_cpu`
    -   GPU nodes: `training-gpu`


## Course materials

Course materials include the Q&A of each session, slides when available and notes when available.

Due to copyright issues some of the materials are only available to current LUMI users and have to be
downloaded from LUMI.

| Presentation | slides | notes |
|:-------------|:-------|:------|
| [Introduction](extra_1_00_Introduction.md) | / | / |
| [HPE Cray EX Architecture](extra_1_01_HPE_Cray_EX_Architecture.md) | [slides](extra_1_01_HPE_Cray_EX_Architecture.md) | / |
| [Programming Environment and Modules](extra_1_02_Programming_Environment_and_Modules.md) | [slides](extra_1_02_Programming_Environment_and_Modules.md) | / |
| [Running Applications](extra_1_03_Running_Applications.md) | [slides](extra_1_03_Running_Applications.md) | / |
| [Exercises #1](extra_1_04_Exercises_1.md) | / | / |
| [Compilers and Parallel Programming Models](extra_1_05_Compilers_and_Parallel_Programming_Models.md) | [slides](extra_1_05_Compilers_and_Parallel_Programming_Models.md) | / |
| [Exercises #2](extra_1_06_Exercises_2.md) | / | / |
| [Cray Scientific Libraries](extra_1_07_Cray_Scientific_Libraries.md) | [slides](extra_1_07_Cray_Scientific_Libraries.md) | / |
| [Exercises #3](extra_1_08_Exercises_3.md) | / | / |
| [OpenACC and OpenMP offlocad with Cray Compilation Environfment](extra_1_09_Offload_CCE.md) | [slides](extra_1_09_Offload_CCE.md) | / |
| [Debugging at Scale](extra_2_01_Debugging_at_Scale.md) | [slides](extra_2_03_Debugging_at_Scale.md) | / | 
<!--
| [Exercises #4](extra_2_02_Exercises_4.md) | / | / |
| [Advanced Application Placement](extra_2_03_Advanceed_Application_Placement.md) | [slides](extra_2_01_Advanceed_Application_Placement.md) | / |
| [Exercises #5](extra_2_04_Exercises_5.md) | / | / |
| [LUMI Software Stacks](extra_2_05_LUMI_Software_Stacks.md) | [slides](https://462000265.lumidata.eu/4day-20230530/files/LUMI-4day-20230530-2_05_software_stacks.pdf) | [notes](notes_2_05_LUMI_Software_Stacks.md) | 
| [Introduction to the AMD ROCm<sup>TM</sup> Ecosystem](extra_2_06_Introduction_to_AMD_ROCm_Ecosystem.md) | [slides](extra_2_06_Introduction_to_AMD_ROCm_Ecosystem.md) | / |
| [Exercises #6](extra_2_07_Exercises_6.md) | / | / |
| [Introduction to Perftools](extra_3_01_Introduction_to_Perftools.md) | [slides](extra_3_01_Introduction_to_Perftools.md) | / | 
| [Exercises #7](extra_3_02_Exercises_7.md) | / | / |
| [Advanced Performance Analysis](extra_3_03_Advanced_Performance_Analysis.md) | [slides](extra_3_03_Advanced_Performance_Analysis.md) | / | 
| [Exercises #8](extra_3_04_Exercises_8.md) | / | / |
| [Understanding Cray MPI on Slingshot](extra_3_05_Cray_MPI_on_Slingshot.md) | [slides](extra_3_05_Cray_MPI_on_Slingshot.md) | / |
| [Exercises #9](extra_3_06_Exercises_9.md) | / | / |
| [AMD ROCgdb Debugger](extra_3_07_AMD_ROCgdb_Debugger.md) | [slides](extra_3_07_AMD_ROCgdb_Debugger.md) | / |
| [Exercises #10](extra_3_08_Exercises_10.md) | / | / |
| [Introduction to Rocprof Profiling Tool](extra_3_09_Introduction_to_Rocprof_Profiling_Tool.md) | [slides](extra_3_09_Introduction_to_Rocprof_Profiling_Tool.md) | / |
| [Exercises #11](extra_3_10_Exercises_11.md) | / | / |
| [Introduction to Python on Cray EX](extra_4_01_Introduction_to_Python_on_Cray_EX.md) | [slides]() | / |
| [I/O Optimization - Parallel I/O](extra_4_02_IO_Optimization_Parallel_IO.md) | [slides](extra_4_02_IO_Optimization_Parallel_IO.md) | / | 
| [Exercises #12](extra_4_03_Exercises_12.md) | / | / |
| [Performance Optimization: Improving single-core](extra_4_04_Performance_Optimization_Improving_Single_Core.md) | [slides](extra_4_04_Performance_Optimization_Improving_Single_Core.md) | / | 
| [Exercises #13](extra_4_05_Exercises_13.md) | / | / |
| [AMD Omnitrace](extra_4_06_AMD_Ominitrace.md) | [slides](extra_4_06_AMD_Ominitrace.md) | / | 
| [Exercises #14](extra_4_07_Exercises_14.md) | / | / |
| [AMD Omniperf](extra_4_08_AMD_Ominiperf.md) | [slides](extra_4_08_AMD_Ominiperf.md) | / | 
| [Exercises #15](extra_4_09_Exercises_15.md) | / | / |
| [Best practices: GPU Optimization, tips & tricks / demo](extra_4_10_Best_Practices_GPU_Optimization.md) | [slides](extra_4_10_Best_Practices_GPU_Optimization.md) | / | 
| [LUMI support and LUMI documentation](extra_4_11_LUMI_Support_and_Documentation.md) | [slides](extra_4_11_LUMI_Support_and_Documentation.md) | / | 

-->


<!--

## Downloads

-   Will come as the course progresses and in the weeks after the course.


-   Slides presentation ["LUMI Software Stacks"](files/LUMI-Software-20230215.pdf) 
    (but you may prefer [reading the notes](software_stacks.md))
-   Slides AMD:
    -   [Introduction to the AMD ROCm<sup>TM</sup> Ecosystem](files/01_introduction_amd_rocm.pdf)
    -   [AMD Debugger: ROCgdb](files/02_Rocgdb_Tutorial.pdf)
    -   [Introduction to Rocporf Profiling Tool](files/03_intro_rocprof.pdf)
    -   [Introduction to OmniTools](files/04_intro_omnitools_new.pdf)
-   [Perfetto](https://perfetto.dev/), the "program" used to visualise the output of omnitrace, is not a regular application but 
    [a browser application](https://ui.perfetto.dev/). Some browsers nowadays offer the option to install it on your
    system in a way that makes it look and behave more like a regular application (Chrome, Edge among others).


## Other material only available on LUMI

The following materials are available to members of the `project_465000524` project only:


-   Slides of presentations given by HPE people are in
    <code>/project/project_465000524/slides/HPE</code> on LUMI
-   Exercises from the HPE sessions are in
    <code>/project/project_465000524/exercises/HPE</code> on LUMI

The following materials can only be found on LUMI and are only accessible to members of project_465000524:

-   Introduction to the Cray EX Hardware and Programming Environment on LUMI-G
    -   Slides: <code>/project/project_465000524/slides/HPE/01_Intro_EX_Architecture_and_PE.pdf</code>
    -   Recording: <code>/project/project_465000524/recordings/01_Intro_EX_Architecture_and_PE.mp4</code> 
-   Running Applications on LUMI-G
    -   Slides: <code>/project/project_465000524/slides/HPE/02_Running_Applications_and_Tools.pdf</code>
    -   Recording: <code>/project/project_465000524/recordings/02_Running_Applications_and_Tools.mp4</code>
-   Introduction to AMD ROCm<sup>TM</sup> Ecosystem
    -   Recording: <code>/project/project_465000524/recordings/03_Introduction_to_the_AMD_ROCmTM_ecosystem.mp4</code>
-   Exercises are in <code>/project/project_465000524/exercises</code>


## Notes

-   Notes from the HedgeDOC pages (*Published with delay*)
    -   [Day 1](hedgedoc_notes_day1.md)
    -   [Day 2](hedgedoc_notes_day2.md)
    -   [Day 3](hedgedoc_notes_day3.md)
    -   [Day 4](hedgedoc_notes_day4.md)

-   [Notes on the presentation "LUMI Software Stacks"](notes_2_05_LUMI_Software_Stacks.md)


-   [Additional notes and exercises from the AMD session](https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA) (External link!)
-->

## External material for exercises

Some of the exercises used in the course are based on exercises or other material available in various GitHub repositories:

-   [OSU benchmark](https://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.9.tar.gz)
-   [Fortran OpenACC examples](https://github.com/RonRahaman/openacc-mpi-demos)
-   [Fortran OpenMP examples](https://github.com/ye-luo/openmp-target)
-   [Collections of examples in BabelStream](https://github.com/UoB-HPC/BabelStream)
-   [hello_jobstep example](https://code.ornl.gov/olcf/hello_jobstep)
-   [Run OpenMP example in the HPE Suport Center](https://support.hpe.com/hpesc/public/docDisplay?docId=a00114008en_us&docLocale=en_US&page=Run_an_OpenMP_Application.html)
-   [ROCm HIP examples](https://github.com/ROCm-Developer-Tools/HIP-Examples)

