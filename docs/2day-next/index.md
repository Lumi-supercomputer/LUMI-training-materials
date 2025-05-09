# Supercomputing with LUMI - Next version

## Course organisation

<!--
-   Location: [SURF, Science Park 140, 1098 XG, Amsterdam, The Netherlands](https://maps.app.goo.gl/11bPcfD6s93PNMZK6)
-->

-   [Schedule](schedule.md)

<!--
-   [HedgeDoc for questions](https://md.sigma2.no/lumi-intro-course-amsterdam-may24?both)
-->

<!--
-   Project for the course: `project_465001603`.

    This project provides resources for the exercises. The project should not be used for your own work!
-->

<!--
-   There are two Slurm reservations for the course:

    -   CPU nodes: `LUMI_Intro_SURF_small` (on the `small` Slurm partition)
    -   GPU nodes: `LUMI_Intro_SURF_standardg` (on the `standard-g` Slurm partition)
-->


## Setting up for the exercises

During the course, you can use the training project `project_465001603` for the exercises.
After the course, it is still possible to make almost all exercises in your own project.
They need only very little resources. The ["Object Storage" exercises](E204-ObjectStorage.md)
in [Exercise session 5](ME10-Exercises-5.md) do require data in the training project, so
these exercises should really be made while the training project is still active. For the
exercises from [Exercise session 4](ME08-Exercises-4.md) you can no longer use the reservation
if they are not made during the second course day (the reservation expires at 5pm CET/ 6pm EET that
day).

-   Create a directory in the scratch of your project, or if you want to
    keep the exercises around for a while, in a subdirectory of your project directory 
    or in your home directory (though we don't recommend the latter).
    Then go into that directory.

    E.g., in the scratch directory of your project:

    ```
    mkdir -p /scratch/project_465001726/course-20250303/exercises
    cd /scratch/project_465001726/course-20250303/exercises
    ```

    where you have to replace `project_465001726` using the number of your own project.

    If you have no other project on LUMI, you can also use the scratch of the
    course project `project_465001726`. Do use a personal subdirectory as in the
    following commands:

    ```
    mkdir -p /scratch/project_465001726/course-20250303-$USER/exercises
    cd /scratch/project_465001726/course-20250303-$USER/exercises
    ```


-   Now download the exercises and un-tar:

    ```
    wget https://462000265.lumidata.eu/2p3day-20250303/files/exercises-20250303.tar.gz
    tar -xf exercises-20250303.tar.gz
    ```

    [Link to the tar-file with the exercises](https://462000265.lumidata.eu/2p3day-20250303/files/exercises-20250303.tar.gz)

-   You're all set to go!


## Course materials

**Note:** Some links in the table below will remain invalid until after the course when all
materials are uploaded.

<!-- Note: spantable fails if there are spaces after the trailing |! -->
::spantable::

| **Presentation** | **Slides** | **Notes** | **Exercises** | **Recording** |
|:-----------------|:-----------|:----------|:--------------|:--------------|
| [Welcome and Introduction](MI101-IntroductionCourse.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-I101-IntroductionCourse.pdf) | / | / | [V](MI101-IntroductionCourse.md) |
| Introduction to the course notes | / | [N](000-Introduction.md) | / |  / |
| **Theme: Exploring LUMI from the login nodes** @span |  |  |  |  |
| [LUMI Architecture](M101-Architecture.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-101-Architecture.pdf) | [N](101-Architecture.md) | / | [V](M101-Architecture.md) |
| [HPE Cray Programming Environment](M102-CPE.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-102-CPE.pdf) | [N](102-CPE.md) | [E](E102-CPE.md) | [V](M102-CPE.md) |
| [Getting Access to LUMI](M103-Access.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-103-Access.pdf) | [N](103-Access.md) | [E](E103-Access.md) | [V](M103-Access.md) |
| [Exercises 1](ME103-Exercises-1.md) | / | / | /  | / |
| [Modules on LUMI](M104-Modules.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-104-Modules.pdf) | [N](104-Modules.md) | [E](E104-Modules.md) | [V](M104-Modules.md) |
| [Exercises 2](ME104-Exercises-2.md) | / | / | / | / |
| [LUMI Software Stacks](M105-SoftwareStacks.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-105-SoftwareStacks.pdf) | [N](105-SoftwareStacks.md) | [E](E105-SoftwareStacks.md) | [V](M105-SoftwareStacks.md) |
| [Exercises 3](ME105-Exercises-3.md) | / | / | / | / |
| [LUMI Support and Documentation](M106-Support.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-106-Support.pdf) | [N](106-Support.md) | / | [V](M106-Support.md) |
| [Wrap-Up Day 1](MI102-WrapUpDay1.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-I102-WrapUpDay1.pdf) | / | / | [V](MI102-WrapUpDay1.md) |
| **Theme: Running jobs efficiently** @span |  |  |  |  |
| [Introduction Day 2](MI201-IntroductionDay2.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-I201-IntroductionDay2.pdf) | / | / | [V](MI201-IntroductionDay2.md) |
| [Slurm on LUMI](M201-Slurm.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-201-Slurm.pdf) | [N](201-Slurm.md) | [E](E201-Slurm.md) | [V](M201-Slurm.md) |
| [Process and Thread Distribution and Binding](M202-Binding.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-202-Binding.pdf) | [N](202-Binding.md) | [E](E202-Binding.md) | [V](M202-Binding.md) |
| [Exercises 4](ME202-Exercises-4.md) | / | / | / | / |
| **Theme: Data on LUMI** @span |  |  |  |  |
| [Using Lustre](M203-Lustre.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-203-Lustre.pdf) | [N](203-Lustre.md) | / | [V](M203-Lustre.md) |
| [Object Storage](M204-ObjectStorage.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-204-ObjectStorage.pdf) | [N](204-ObjectStorage.md) | [E](E204-ObjectStorage.md) | [V](M204-ObjectStorage.md) |
| [Exercises 5](ME204-Exercises-5.md) | / | / | / | / |
| **Theme: Containers on LUMI** @span |  |  |  |  |
| [Containers on LUMI-C and LUMI-G](M205-Containers.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-205-Containers.pdf) | [N](205-Containers.md) | / | [V](M205-Containers.md) |
| [Demo 1 (optional)](Demo1.md) | / | [N](Demo1.md) | / | [V](Demo1.md#video-of-the-demo) |
| [Demo 2 (optional)](Demo2.md) | / | [N](Demo2.md) | / | [V](Demo2.md#video-of-the-demo) |
| [What Else?](MI202-WhatElse.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-I202-WhatElse.pdf) | / | / | [V](MI202-WhatElse.md) |
| **Appendices** @span |  |  |  | |
| A1 Additional documentation | / | [N](A01-Documentation.md) | / | / |

::end-spantable::


## Web links

-   [Links to additional HPE Cray documentation](A01-Documentation.md)

-   LUMI documentation

    -   [Main documentation](https://docs.lumi-supercomputer.eu/)

    -   [Shortcut to the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)

-   Other course materials

    -   [Archive of PRACE training materials](https://training.prace-ri.eu/) (no https unfortunately)


## Acknowledgement

Though a LUST course, the course borrows a lot of material from
[a similar course prepared by the Belgian local organisation](https://klust.github.io/LUMI-BE-training-materials/intro-evolving/),
which in turn was prepared in the framework of the 
[VSC](https://www.vscentrum.be/) Tier-0 support activities.
The VSC is funded by 
[FWO - Fonds Wetenschappelijk Onderzoek - Vlaanderen](https://www.fwo.be/en/)
(or Research Foundation – Flanders). 
