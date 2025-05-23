# Intro to Supercomputing with LUMI - Hybrid course, June 2-3, 2025, on-site in Espoo and online


## Course organisation

-   Location: [CSC, Keilaranta 14, 02150 Espoo, Finland](https://maps.app.goo.gl/hqja9ar6p27nSs9Y9)
   
    Room: Dogmi.

    Upon arrival at CSC, please register in the lobby at the entrance of the C building, Life Sciences Center,
    Keilaranta 14 (round doors). It is likely you will receive a QR-code to scan at the entrance the
    day before, and that greatly speeds up the registration process.

    [Public transportation in Helsinki](https://www.hsl.fi/en). A very easy way to buy tickets is via the 
    [HSL app](https://www.hsl.fi/en/tickets-and-fares/hsl-app), 
    but it is best to set it up before you travel so that payment goes quickly.

    The venue is close to the ["Keilaniemi - Kägeludden" metro station](https://maps.app.goo.gl/22FLCZgSwSQcSAPY7),
    providing an excellent connection with the hotels downtown.

-   [Schedule](schedule.md)

-   [HedgeDoc for questions](https://siili.rahtiapp.fi/LUMI-intro-course?both#General-Information)

-   Project for the course: `project_465001965`.

    This project provides resources for the exercises. **The project should not be used for your own work!**

-   There are two Slurm reservations for the course for the exercises on the second day:

    -   CPU nodes: `LUMI_Intro_1` (on the `small` Slurm partition)
    -   GPU nodes: `LUMI_Intro_2` (on the `standard-g` Slurm partition)


## Course materials

Course materials include the Q&A of each session, slides when available and notes when available.
These materials will become available as the course progresses.

**Note:** Some links in the table below are dead and will remain so until after the end of the course.

<!-- Note: spantable fails if there are spaces after the trailing |! -->
::spantable::

| Presentation | slides | notes | recording |
|:-------------|:-------|:------|:----------|
| **Day 1** @span |  |  |  |
| [Welcome and Introduction](MI101-IntroductionCourse.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-I101-IntroductionCourse.pdf) | / | [V](MI101-IntroductionCourse.md) |
| Introduction to the course notes | / | [N](000-Introduction.md) |  / |
| ***Theme: Exploring LUMI from the login nodes*** @span |  |  |  |
| [LUMI Architecture](M101-Architecture.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-101-Architecture.pdf) | [(N)](101-Architecture.md) | [V](M101-Architecture.md) |
| [HPE Cray Programming Environment](M102-CPE.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-102-CPE.pdf) | [N](102-CPE.md) | [V](M102-CPE.md) |
| [Getting Access to LUMI](M103-Access.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-103-Access.pdf) | [N](103-Access.md) | [V](M103-Access.md) |
| [Exercises 1](ME103-Exercises-1.md) | / | /  | / |
| [Modules on LUMI](M104-Modules.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-104-Modules.pdf) | [N](104-Modules.md) | [V](M104-Modules.md) |
| [Exercises 2](ME104-Exercises-2.md) | / | / | / |
| [LUMI Software Stacks](M105-SoftwareStacks.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-105-SoftwareStacks.pdf) | [N](105-SoftwareStacks.md) | [V](M105-SoftwareStacks.md) |
| [Exercises 3](ME105-Exercises-3.md) | / | / | / |
| [LUMI Support and Documentation](M106-Support.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-106-Support.pdf) | [N](106-Support.md) | [V](M106-Support.md) |
| [Wrap-Up Day 1](MI102-WrapUpDay1.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-I102-WrapUpDay1.pdf) | / | [V](MI102-WrapUpDay1.md) |
| **Day 2** @span |  |  |  |

::end-spantable::

<!-- Note: spantable fails if there are spaces after the trailing |! -->
<!--
::spantable::

| Presentation | slides | notes | recording |
|:-------------|:-------|:------|:----------|
| **Day 1** @span |  |  |  |
| [Welcome and Introduction](MI101-IntroductionCourse.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-I101-IntroductionCourse.pdf) | / | [V](MI101-IntroductionCourse.md) |
| Introduction to the course notes | / | [N](000-Introduction.md) |  / |
| ***Theme: Exploring LUMI from the login nodes*** @span |  |  |  |
| [LUMI Architecture](M101-Architecture.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-101-Architecture.pdf) | [(N)](101-Architecture.md) | [V](M101-Architecture.md) |
| [HPE Cray Programming Environment](M102-CPE.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-102-CPE.pdf) | [N](102-CPE.md) | [V](M102-CPE.md) |
| [Getting Access to LUMI](M103-Access.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-103-Access.pdf) | [N](103-Access.md) | [V](M103-Access.md) |
| [Exercises 1](ME103-Exercises-1.md) | / | /  | / |
| [Modules on LUMI](M104-Modules.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-104-Modules.pdf) | [N](104-Modules.md) | [V](M104-Modules.md) |
| [Exercises 2](ME104-Exercises-2.md) | / | / | / |
| [LUMI Software Stacks](M105-SoftwareStacks.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-105-SoftwareStacks.pdf) | [N](105-SoftwareStacks.md) | [V](M105-SoftwareStacks.md) |
| [Exercises 3](ME105-Exercises-3.md) | / | / | / |
| [LUMI Support and Documentation](M106-Support.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-106-Support.pdf) | [N](106-Support.md) | [V](M106-Support.md) |
| [Wrap-Up Day 1](MI102-WrapUpDay1.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-I102-WrapUpDay1.pdf) | / | [V](MI102-WrapUpDay1.md) |
| **Day 2** @span |  |  |  |
| [Introduction Day 2](MI201-IntroductionDay2.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-I201-IntroductionDay2.pdf) | / | [V](MI201-IntroductionDay2.md) |
| ***Theme: Running jobs efficiently*** @span |  |  |  |
| [Slurm on LUMI](M201-Slurm.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-201-Slurm.pdf) | [(N)](201-Slurm.md) || [V](M201-Slurm.md) |
| [Process and Thread Distribution and Binding](M202-Binding.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-202-Binding.pdf) | [(N)](202-Binding.md) | [V](M202-Binding.md) |
| [Exercises 4](ME202-Exercises-4.md) | / | / | / |
| **Theme: Data on LUMI** @span |  |  |  |
| [Using Lustre](M203-Lustre.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-203-Lustre.pdf) | [(N)](203-Lustre.md) | [V](M203-Lustre.md) |
| [Object Storage](M204-ObjectStorage.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-204-ObjectStorage.pdf) | [N](204-ObjectStorage.md) | [V](M204-ObjectStorage.md) |
| [Exercises 5](ME204-Exercises-5.md) | / | / | / |
| **Theme: Containers on LUMI** @span |  |  |  |
| [Containers on LUMI-C and LUMI-G](M205-Containers.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-205-Containers.pdf) | [N](205-Containers.md) | [V](M205-Containers.md) |
| [Demo 1 (optional)](Demo1.md) | / | [N](Demo1.md) | [V](Demo1.md#video-of-the-demo) |
| [Demo 2 (optional)](Demo2.md) | / | [N](Demo2.md) | [V](Demo2.md#video-of-the-demo) |
| [Wrap-Up Day 2](MI202-WrapUpDay2.md) | [S](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-I202-WhatElse.pdf) | / | [V](MI202-WrapUpDay2.md) |

::end-spantable::
-->
<!-- | [Miscellaneous questions](A02-Misc_Questions.md) | / | [questions](A02-Misc_Questions.md) | / | -->


## Setting up for the exercises

During the course, you can use the training project `project_465001965` for the exercises.
After the course, it is still possible to make almost all exercises in your own project.
They need only very little resources, but you will need both CPU and GPU resources. 
**This project should only be used for exercises and not for your own work!**

The ["Object Storage" exercises](E204-ObjectStorage.md)
in [Exercise session 5](ME204-Exercises-5.md) do require data in the training project, so
these exercises should really be made while the training project is still active. 
There is an [alternative set of exercises](E204-ObjectStorage.md#exercises-that-can-be-made-in-your-own-project) 
missing only one element from the during-the-course 
version that can be made in your own project.
For the
exercises from [Exercise session 4](ME202-Exercises-4.md) you can no longer use the reservation
if they are not made during the second course day (the reservation expires at 5pm CET/ 6pm EET that
day).

-   Create a directory in the scratch of your project, or if you want to
    keep the exercises around for a while, in a subdirectory of your project directory 
    or in your home directory (though we don't recommend the latter).
    Then go into that directory.

    E.g., in the scratch directory of your project:

    ```
    mkdir -p /scratch/project_465001965/course-20250602-$USER/Exercises
    cd /scratch/project_465001965/course-20250602-$USER/Exercises
    ```

    where you have to replace `project_465001965` using the number of your own project.

    If you have no other project on LUMI, you can also use the scratch of the
    course project `project_465001965`. Do use a personal subdirectory as in the
    following commands:

    ```
    mkdir -p /scratch/project_465001965/$USER/Exercises
    cd /scratch/project_465001965/$USER/Exercises
    ```


-   Now download the exercises and un-tar:

    ```
    wget https://462000265.lumidata.eu/2day-20250602/files/exercises-20250602.tar.bz2
    tar -xf exercises-20250602.tar.bz2
    ```

    [Link to the tar-file with the exercises](https://462000265.lumidata.eu/2day-20250602/files/exercises-20250602.tar) and the
    [bzip2-compressed version](https://462000265.lumidata.eu/2day-20250602/files/exercises-20250602.tar.bz2).

-   You're all set to go!

<!--
## Making the exercises after the course

The ["Object Storage" exercises](E204-ObjectStorage.md)
in [Exercise session 5](ME204-Exercises-5.md) do require data in the training project but there is an 
[alternative set of exercises](E204-ObjectStorage.md#exercises-that-can-be-made-in-your-own-project) 
missing only one element from the during-the-course 
version that can be made in your own project.
For the
exercises from [Exercise session 4](ME202-Exercises-4.md) you can no longer use the reservation.

-   Create a directory in the scratch of your project, or if you want to
    keep the exercises around for a while, in a subdirectory of your project directory 
    or in your home directory (though we don't recommend the latter).
    Then go into that directory.

    E.g., in the scratch directory of your project:

    ```
    mkdir -p /scratch/project_46YXXXXXX/course-20250602-$USER/Exercises
    cd /scratch/project_46YXXXXXX/course-20250602-$USER/Exercises
    ```

    where you have to replace `project_46YXXXXXX` using the number of your own project.

-   Now install the exercise files:

    ```
    tar -xf /appl/local/training/2day-20250602/files/exercises-20250602.tar.bz2
    ```

-   You're all set to go!

!!! Warning
    The software and exercises were tested thoroughly at the time of the course. LUMI however is in
    continuous evolution and changes to the system may break exercises and software
-->


## Links to documentation

[The links to all documentation mentioned during the talks is on a separate page](A01-Documentation.md).


## Acknowledgement

Though a LUST course, the course borrows a lot of material from
[a similar course prepared by the Belgian local organisation](https://klust.github.io/LUMI-BE-training-materials/intro-evolving/),
which in turn was prepared in the framework of the 
[VSC](https://www.vscentrum.be/) Tier-0 support activities.
The VSC is funded by 
[FWO - Fonds Wetenschappelijk Onderzoek - Vlaanderen](https://www.fwo.be/en/)
(or Research Foundation – Flanders). 
