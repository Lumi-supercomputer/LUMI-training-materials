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
-   There are two Slurm reservations for the course:

    -   CPU nodes: `LUMI_Intro_SURF_small` (on the `small` Slurm partition)
    -   GPU nodes: `LUMI_Intro_SURF_standardg` (on the `standard-g` Slurm partition)
-->


## Setting up for the exercises

If you have an active project on LUMI, you should be able to make the exercises in that project.
You will only need an very minimum of CPU and GPU billing units for this.

-   Create a directory in the scratch of your project, or if you want to
    keep the exercises around for a while, in a subdirectory of your project directory 
    or in your home directory (though we don't recommend the latter).
    Then go into that directory.

    E.g., in the scratch directory of your project:

    ```
    mkdir -p /scratch/project_465001102/$USER/exercises
    cd /scratch/project_465001102/$USER/exercises
    ```

    where you have to replace `project_465001102` using the number of your own project.

-   Now download the exercises and un-tar:

    ```
    wget https://462000265.lumidata.eu/2day-next/files/exercises-20240502.tar.gz
    tar -xf exercises-20240502.tar.gz
    ```

    [Link to the tar-file with the exercises](https://462000265.lumidata.eu/2day-next/files/exercises-20240502.tar.gz)

-   You're all set to go!


## Course materials

**Note:** Some links in the table below will remain invalid until after the course when all
materials are uploaded.

| Presentation | Slides | Notes | Exercises | Recording |
|:-------------|:-------|:------|:----------|:----------|
| [Welcome and Introduction](MI01-IntroductionCourse.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-I01-IntroductionCourse.pdf) | / | / | [V](MI01-IntroductionCourse.md) |
| Introduction to the course notes | / | [N](00-Introduction.md) | / |  / | 
| [LUMI Architecture](M01-Architecture.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-01-Architecture.pdf) | [N](01-Architecture.md) | / | [V](M01-Architecture.md) |
| [HPE Cray Programming Environment](M02-CPE.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-02-CPE.pdf) | [N](02-CPE.md) | [E](E02-CPE.md) | [V](M02-CPE.md) |
| [Getting Access to LUMI](M03-Access.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-03-Access.pdf) | [N](03-Access.md) | [E](E03-Access.md) | [V](M03-Access.md) |
| [Exercises 1](ME03-Exercises-1.md) | / | / | /  | / |
| [Modules on LUMI](M04-Modules.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-04-Modules.pdf) | [N](04-Modules.md) | [E](E04-Modules.md) | [V](M04-Modules.md) |
| [Exercises 2](ME04-Exercises-2.md) | / | / | / | / |
| [LUMI Software Stacks](M05-SoftwareStacks.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-05-SoftwareStacks.pdf) | [N](05-SoftwareStacks.md) | [E](E05-SoftwareStacks.md) | [V](M05-SoftwareStacks.md) |
| [Exercises 3](ME05-Exercises-3.md) | / | / | / | / |
| [Wrap-Up Day 1](MI02-WrapUpDay1.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-I02-WrapUpDay1.pdf) | / | / | [V](MI02-WrapUpDay1.md) |
| [Introduction Day 2](MI03-IntroductionDay2.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-I03-IntroductionDay2.pdf) | / | / | [V](MI03-IntroductionDay2.md) |
| [Slurm on LUMI](M06-Slurm.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-06-Slurm.pdf) | [N](06-Slurm.md) | [E](E06-Slurm.md) | [V](M06-Slurm.md) |
| [Process and Thread Distribution and Binding](M07-Binding.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-07-Binding.pdf) | [N](07-Binding.md) | [E](E07-Binding.md) | [V](M07-Binding.md) | 
| [Exercises 4](ME07-Exercises-4.md) | / | / | / | / |
| [Using Lustre](M08-Lustre.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-08-Lustre.pdf) | [N](08-Lustre.md) | / | [V](M08-Lustre.md) |
| [Containers on LUMI-C and LUMI-G](M09-Containers.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-09-Containers.pdf) | [N](09-Containers.md) | / | [V](M09-Containers.md) |
| [Demo 1 (optional)](Demo1.md) | / | [N](Demo1.md) | / | [V](Demo1.md#video-of-the-demo) |
| [Demo 2 (optional)](Demo2.md) | / | [N](Demo2.md) | / | [V](Demo2.md#video-of-the-demo) |
| [LUMI Support and Documentation](M10-Support.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-10-Support.pdf) | [N](10-Support.md) | / | [V](M10-Support.md) |
| [What Else?](MI04-WhatElse.md) | [S](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-I04-WhatElse.pdf) | / | / | [V](MI04-WhatElse.md) |
| A1 Additional documentation | / | [N](A01-Documentation.md) | / | / | 


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
