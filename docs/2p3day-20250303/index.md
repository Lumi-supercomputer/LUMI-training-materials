# LUMI Intensive: Comprehensive Intro and Advanced Workshop, March 3-7, 2025

## Target audience

The course is an "on-site first course": We will broadcast the talks via Zoom, but there is direct
interaction only between the lecturers and the people in the physical meeting room. Several members of LUST
will be present for the whole week, and specialists from HPE and AMD will join on day 3 till 5, so 
being on-site gives you excellent opportunities to work with these people in a way that is impossible
via Zoom or email. Users taking the course on-line will be able to submit written questions. However, 
not all types of questions can be answered that way as some questions require direct interaction.
Also, experience has shown that discussions that often unwind especially in the advanced part,
are hard to follow on-line. They are not strictly moderated the way a discussion in a TV studio is,
but are natural discussions.

-   Day 1 and 2 of the course are at a more introductory level. It covers all the essentials of LUMI:
    the system architecture, programming environments, software setup, running jobs efficiently,
    various types of data storage, and using containers which are essential for Python etc.

    This part of the course is largely equivalent to the previous 2-day intro courses in
    [May 2024](../2day-20240502/index.md) and [December 2024](../2p3day-20250303/index.md).

-   Days 3-5 of the course are at a more advanced level and focus on the needs of developers of
    software for LUMI and users who want to better understand the behaviour of applications they
    are running on LUMI. There is some attention to AI also but users only interested in 
    training models and not in gaining a deeper insight of performance analysis etc., may be
    better of with the [AI trainings offered by LUST](https://lumi-supercomputer.github.io/AI-latest).

    Part of the lectures are about tools that HPE and AMD offer to analyse program behaviour, and 
    other lectures focus on a specific performance bottleneck, how to detect if it is present and how
    to deal with it.

    The materials from day 1 and 2 are an absolute prerequisite to be able to benefit from this 
    part of the course.

    It is possible though to register only for the 3 advanced days if you have the required knowledge.

Together both parts essentially cover the materials from previous 4-day advanced courses
(e.g., the [course in Amsterdam in October 2024](../4day-20241028/index.md)), but spending a bit
more time on more elementary materials and with some new material on object storage and containers
on LUMI.

See the [draft schedule](schedule.md) to get a better idea of topics that will be covered.

People registering for the whole event have priority for on-site seating on day 1 and 2.


## Course organisation

-   Location: [KTH, Lindstedtsvägen 24, 114 28Stockholm, Sweden](https://maps.app.goo.gl/NPLtyuRe97euBSnL6)

    The building is just a 5 minute walk from a metro station with excellent connections to the 
    central station (red metro line). See also the [SL web site](https://sl.se/en/in-english)
    for more information on public transportation in Stockholm.

-   [Draft schedule](schedule.md)

<!--
-   [HedgeDoc for questions](https://md.sigma2.no/lumi-general-course-mar25?both)

-   During the course, there are two Slurm reservations available:

    -   CPU nodes: `lumic_ams`
    -   GPU nodes: `lumig_ams`

    They can be used in conjunction with the training project `project_465001726`.

    Note that the reservations and course project should only be used for making the exercises 
    during the course and not for running your own jobs. 
    The resources allocated to the course are very limited.
-->

## Travel

-   **Hotel options:**
    The various hotels near the central station would be a good choice for travellers.
    The [Odenplan area](https://maps.app.goo.gl/pEFzcpTd3tmQjKkf8) 
    could be an alternative as there is a frequent bus service to the KTH campus.
    [Elite Hotel Arcadia](https://www.elite.se/hotell/stockholm/elite-hotel-arcadia-stockholm/) is
    [right on the edge of the KTH campus](https://maps.app.goo.gl/wvq4D4pMg2b6fH6n6)
    and hence also a possible choice.

-   **Travel from the airport:**
    There are [4 ways to get to central stockholm from the airport](https://www.swedavia.com/arlanda/transport/):

    -   Taxi - Expensive, go to the labeled taxi ranks in the airport. There is a fixed price to the city, which should be displayed on the taxi and will be different for different companies
    -   [Arlanda Express](https://www.arlandaexpress.com/) - Moderately expensive, very fast direct train to stockholm central station
    -   Commuter train - From sky city in Arlanda you can get the nomral trains. You need to pay 147 SEK (toll to use the tunnel under Arlanda) at the ticket barriers plus a normal SL ticket
    -   Airport bus - cheapest option, but takes longest. Central bus station is right next to central station.

-   **Using public transportation in Stockholm**

    Probably simplest if you just get the [SL (Stockholm Localtrafik) app](https://sl.se/en/fares-and-tickets/smart-phone-ticket-app) 
    on a smartphone, will give you a QR code that you can use at ticket barriers. 
    Tickets can be bought using a credit card in the app. Physical cards are also available, but cost 50 SEK for the card, 
    plus extra for the tickets you put on it.  Credit cards can also be used with contactless pay as you go to buy a single.


## Setting up for the exercises

During the course, you can use the training project `project_465001726` for the exercises.
After the course, it is still possible to make almost all exercises in your own project.
They need only very little resources. The ["Object Storage" exercises](E204-ObjectStorage.md)
in [Exercise session 5](ME204-Exercises-5.md) do require data in the training project, so
these exercises should really be made while the training project is still active. For the
exercises from [Exercise session 4](ME202-Exercises-4.md) you can no longer use the reservation
if they are not made during the second course day (the reservation expires at 5pm CET/ 6pm EET that
day).

-   Create a directory in the scratch of your project, or if you want to
    keep the exercises around for a while, in a subdirectory of your project directory 
    or in your home directory (though we don't recommend the latter).
    Then go into that directory.

    E.g., in the scratch directory of your project:

    ```
    mkdir -p /scratch/project_465001726/course-20250303-$USER/exercises
    cd /scratch/project_465001726/course-20250303-$USER/exercises
    ```

    where you have to replace `project_465001726` using the number of your own project.

    If you have no other project on LUMI, you can also use the scratch of the
    course project `project_465001726`. Do use a personal subdirectory as in the
    following commands:

    ```
    mkdir -p /scratch/project_465001726/$USER/exercises
    cd /scratch/project_465001726/$USER/exercises
    ```


-   Now download the exercises and un-tar:

    ```
    wget https://462000265.lumidata.eu/2p3day-20250303/files/exercises-20250303.tar.gz
    tar -xf exercises-20250303.tar.gz
    ```

    [Link to the tar-file with the exercises](https://462000265.lumidata.eu/2p3day-20250303/files/exercises-20250303.tar.gz)

-   You're all set to go!


## Course materials

Course materials include the Q&A of each session, slides when available and notes when available.
These materials will become available as the course progresses.

Due to copyright issues some of the materials are only available to current LUMI users and have to be
downloaded from LUMI.

**Note:** Some links in the table below are dead and will remain so until after the end of the course.

<!-- Note: spantable fails if there are spaces after the trailing |! -->
::spantable::

| Presentation | slides | notes | recording |
|:-------------|:-------|:------|:----------|
| /            | /      | /     | /         |

::end-spantable::

<!-- Note: spantable fails if there are spaces after the trailing |! -->
::spantable::

| Presentation | slides | notes | recording |
|:-------------|:-------|:------|:----------|
| **Day 1** @span |  |  |  |
| [Welcome and Introduction](MI101-IntroductionCourse.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-I101-IntroductionCourse.pdf) | / | [V](MI101-IntroductionCourse.md) |
| Introduction to the course notes | / | [N](000-Introduction.md) |  / |
| ***Theme: Exploring LUMI from the login nodes*** @span |  |  |  |
| [LUMI Architecture](M101-Architecture.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-101-Architecture.pdf) | [N](101-Architecture.md) | [V](M101-Architecture.md) |
| [HPE Cray Programming Environment](M102-CPE.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-102-CPE.pdf) | [N](102-CPE.md) | [V](M102-CPE.md) |
| [Getting Access to LUMI](M103-Access.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-103-Access.pdf) | [N](103-Access.md) | [V](M103-Access.md) |
| [Exercises 1](ME103-Exercises-1.md) | / | /  | / |
| [Modules on LUMI](M104-Modules.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-104-Modules.pdf) | [N](104-Modules.md) | [V](M104-Modules.md) |
| [Exercises 2](ME104-Exercises-2.md) | / | / | / |
| [LUMI Software Stacks](M105-SoftwareStacks.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-105-SoftwareStacks.pdf) | [N](105-SoftwareStacks.md) | [V](M105-SoftwareStacks.md) |
| [Exercises 3](ME05-Exercises-3.md) | / | / | / |
| [LUMI Support and Documentation](M106-Support.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-106-Support.pdf) | / | [V](M106-Support.md) |
| [Wrap-Up Day 1](MI102-WrapUpDay1.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-I102-WrapUpDay1.pdf) | / | [V](MI102-WrapUpDay1.md) |
| **Day 2** @span |  |  |  |
| [Introduction Day 2](MI201-IntroductionDay2.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-I201-IntroductionDay2.pdf) | / | [V](MI201-IntroductionDay2.md) |
| ***Theme: Running jobs efficiently*** @span |  |  |  |
| [Slurm on LUMI](M201-Slurm.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-201-Slurm.pdf) | [N](201-Slurm.md) || [V](M201-Slurm.md) |
| [Process and Thread Distribution and Binding](M202-Binding.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-202-Binding.pdf) | [N](202-Binding.md) | [V](M202-Binding.md) |
| [Exercises 4](ME202-Exercises-4.md) | / | / | / |
| **Theme: Data on LUMI** @span |  |  |  |
| [Using Lustre](M203-Lustre.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-203-Lustre.pdf) | [N](203-Lustre.md) | [V](M203-Lustre.md) |
| [Object Storage](M204-ObjectStorage.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-204-ObjectStorage.pdf) | [N](204-ObjectStorage.md) | [V](M204-ObjectStorage.md) |
| [Exercises 5](ME204-Exercises-5.md) | / | / | / |
| **Theme: Containers on LUMI** @span |  |  |  |
| [Containers on LUMI-C and LUMI-G](M205-Containers.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-205-Containers.pdf) | [N](205-Containers.md) | [V](M205-Containers.md) |
| [Wrap-Up Day 2](MI202-WrapUpDay2.md) | [S](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-I202-WhatElse.pdf) | / | [V](MI202-WrapUpDay2.md) |
| **Day 3** @span |  |  |  |
| [Introduction](MI301-IntroductionCourse.md) | / | / | [web](MI301-IntroductionCourse.md) |
| [HPE Cray EX Architecture](M301-HPE_Cray_EX_Architecture.md) | [lumi](M301-HPE_Cray_EX_Architecture.md) | / | [lumi](M301-HPE_Cray_EX_Architecture.md) |
| [Compilers and Parallel Programming Models](M302-Compilers_and_Parallel_Programming_Models.md) | [lumi](M302-Compilers_and_Parallel_Programming_Models.md) | / | [lumi](M302-Compilers_and_Parallel_Programming_Models.md) |
| [Exercises #6](ME302-Exercises-6.md) | / | / | / |
| [Cray Scientific Libraries](M303-Cray_Scientific_Libraries.md) | [lumi](M303-Cray_Scientific_Libraries.md) | / | [lumi](M303-Cray_Scientific_Libraries.md) |
| [Exercises #7](ME303-Exercises-7.md) | / | / | / |
| [CCE Offloading Models](M304-Offload_CCE.md) | [lumi](M304-Offload_CCE.md) | / | [lumi](M304-Offload_CCE.md) |
| [Introduction to the AMD ROCm Ecosystem](M305-Introduction_to_AMD_ROCm_Ecosystem.md) | [web](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-305-Introduction_to_AMD_ROCm_Ecosystem.pdf) | / | [web](M305-Introduction_to_AMD_ROCm_Ecosystem.md) |
| [Exercises #8](ME305-Exercises-8.md) | / | / | / |
| [Debugging at Scale](M306-Debugging_at_Scale.md) | [lumi](M306-Debugging_at_Scale.md) | / |  [lumi](M306-Debugging_at_Scale.md) |
| [Exercises #9](ME306-Exercises-9.md) | / | / | / |
| **Day 4** @span |  |  |  |
| [Introduction to Perftools](M401-Introduction_to_Perftools.md) | [lumi](M401-Introduction_to_Perftools.md) | / |  [lumi](M401-Introduction_to_Perftools.md) |
| [Exercises #10](ME401-Exercises-10.md) | / | / | / |
| [Advanced Performance Analysis](M402-Advanced_Performance_Analysis.md) | [lumi](M402-Advanced_Performance_Analysis.md) | / |  [lumi](M402-Advanced_Performance_Analysis.md) |
| [Performance Optimization: Improving single-core Efficiency](M403-Performance_Optimization_Improving_Single_Core.md) | [lumi](M403-Performance_Optimization_Improving_Single_Core.md) | / | [lumi](M403-Performance_Optimization_Improving_Single_Core.md) |
| [Exercises #11](ME403-Exercises-11.md) | / | / | / |
| [MPI Topics on the HPE Cray EX Supercomputer](M404-Cray_MPI_on_Slingshot.md) | [lumi](M404-Cray_MPI_on_Slingshot.md) | / | [lumi](M404-Cray_MPI_on_Slingshot.md) |
| [Exercises #12](ME404-Exercises-12.md) | / | / | / |
| [AMD Debugger: ROCgdb](M405-AMD_ROCgdb_Debugger.md) | [web](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-405-AMD_ROCgdb_Debugger.pdf) | / | [web](M405-AMD_ROCgdb_Debugger.md) |
| [Exercises #13](ME405-Exercises-13.md) | / | / | / |
| [Introduction to ROC-Profiler (rocprof)](M406-Introduction_to_Rocprof_Profiling_Tool.md) | [web](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-406-Introduction_to_Rocprof_Profiling_Tool.pdf) | / | [web](M406-Introduction_to_Rocprof_Profiling_Tool.md) |
| [Exercises #14](ME406-Exercises-14.md) | / | / | / |
| **Day 5** @span |  |  |  |
| [Introduction to Python on Cray EX](M501-Introduction_to_Python_on_Cray_EX.md) | [lumi](M501-Introduction_to_Python_on_Cray_EX.md) | / |[lumi](M501-Introduction_to_Python_on_Cray_EX.md) |
| [Frameworks for porting applications to GPUs](M502-Porting_to_GPU.md) | [lumi](M502-Porting_to_GPU.md) | / |[lumi](M502-Porting_to_GPU.md) |
| [Optimizing Large Scale I/O](M503-IO_Optimization_Parallel_IO.md) | [lumi](M503-IO_Optimization_Parallel_IO.md) | / | [lumi](M503-IO_Optimization_Parallel_IO.md) |
| [Exercises #15](ME503-Exercises-15.md) | / | / | / |
| [Introduction to OmniTrace](M504-AMD_Omnitrace.md) | [web](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-504-AMD_Omnitrace.pdf) | / |  [web](M504-AMD_Omnitrace.md) |
| [Exercises #16](ME504-Exercises-16.md) | / | / | / |
| [Introduction to Omniperf](M505-AMD_Omniperf.md) | [web](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-505-AMD_Omniperf.pdf) | / |  [web](M505-AMD_Omniperf.md) |
| [Exercises #17](ME505-Exercises-17.md) | / | / | / |
| [Tools in Action - An Example with Pytorch](M506-Best_Practices_GPU_Optimization.md) | [web](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-506-Best_Practices_GPU_Optimization.pdf) | / | [web](M506-Best_Practices_GPU_Optimization.md) |
| **Appendices** @span |  |  |  |
| [Additional documentation](A01-Documentation.md) | / | [web](A01-Documentation.md) | / |

::end-spantable::


<!-- | [Miscellaneous questions](A02-Misc_Questions.md) | / | [questions](A02-Misc_Questions.md) | / | -->



<!--
## Making the exercises after the course

### HPE

The exercise material remains available in the course archive on LUMI:

-   The PDF notes in `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-Exercises_HPE.pdf`

-   The other files for the exercises in either a
    bzip2-compressed tar file `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-Exercises_HPE.tar.bz2` or
    an uncompressed tar file `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-Exercises_HPE.tar`.

To reconstruct the exercise material in your own home, project or scratch directory, all you need to do is run:

```
tar -xf /appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-Exercises_HPE.tar.bz2
```

in the directory where you want to work on the exercises. This will create the `Exercises/HPE` subdirectory
from the training project. 

However, instead of running the `lumi_c.sh` or `lumi_g.sh` scripts that only work for the course as 
they set the course project as the active project for Slurm and also set a reservation, use the
`lumi_c_after.sh` and `lumi_g_after.sh` scripts instead, but first edit them to use one of your
projects.

### AMD 

There are [online notes about the AMD exercises](https://hackmd.io/@sfantao/H1QU6xRR3).
A [PDF print-out with less navigation features is also available](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-Exercises_AMD.pdf)
and is particularly useful should the online notes become unavailable. However, some lines are incomplete.
A [web backup](exercises_AMD_hackmd.md) is also available, but corrections to the original made after the course
are not included.

The other files for the exercises are available in 
either a bzip2-compressed tar file `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-Exercises_AMD_.tar.bz2` or
an uncompressed tar file `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-Exercises_AMD.tar` and can also be downloaded. 
( [bzip2-compressed tar download](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-Exercises_AMD.tar.bz2) or 
[uncompressed tar download](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-Exercises_AMD.tar))

To reconstruct the exercise material in your own home, project or scratch directory, all you need to do is run:

```
tar -xf /appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-Exercises_AMD.tar.bz2
```

in the directory where you want to work on the exercises. This will create the `exercises/AMD` subdirectory
from the training project. You can do so in the same directory where you installed the HPE exercises.

!!! Warning
    The software and exercises were tested thoroughly at the time of the course. LUMI however is in
    continuous evolution and changes to the system may break exercises and software
-->

## Links to documentation

[The links to all documentation mentioned during the talks is on a separate page](A01-Documentation.md).

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
