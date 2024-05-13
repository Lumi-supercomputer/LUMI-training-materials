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

| Presentation | Slides | Notes | recording |
|:-------------|:-------|:------|:----------|
| [Welcome and Introduction](extra-00-Introduction.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-00-Introduction.pdf) | [notes](00-Introduction.md) | [video](extra-00-Introduction.md) |
| [LUMI Architecture](extra-01-Architecture.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-01-Architecture.pdf) | [notes](01-Architecture.md) | [video](extra-01-Architecture.md) |
| [HPE Cray Programming Environment](extra-02-CPE.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-02-CPE.pdf) | [notes](02-CPE.md) | [video](extra-02-CPE.md) |
| [Getting Access to LUMI](extra-03-Access.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-03-Access.pdf) | [notes](03-Access.md) | [video](extra-03-Access.md) |
| Exercises 1 | / | [notes](E03-Exercises-1.md) | / |
| [Modules on LUMI](extra-04-Modules.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-04-Modules.pdf) | [notes](04-Modules.md) | [video](extra-04-Modules.md) |
| Exercises 2 | / | [notes](E04-Exercises-2.md) | / |
| [LUMI Software Stacks](extra-05-SoftwareStacks.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-05-SoftwareStacks.pdf) | [notes](05-SoftwareStacks.md) | [video](extra-05-SoftwareStacks.md) |
| Exercises 3 | / | [notes](E05-Exercises-3.md) | / |
| [Wrap-Up Day 1](extra-06-WrapUpDay1.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-06-WrapUpDay1.pdf) | / | [video](extra-06-WrapUpDay1.md) |
| [Introduction Day 2](extra-07-IntroductionDay2.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-07-IntroductionDay2.pdf) | / | [video](extra-07-IntroductionDay2.md) |
| [Slurm on LUMI](extra-08-Slurm.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-08-Slurm.pdf) | [notes](08-Slurm.md) | [video](extra-08-Slurm.md) |
| [Process and Thread Distribution and Binding](extra-09-Binding.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-09-Binding.pdf) | [notes](09-Binding.md) | [video](extra-09-Binding.md) | 
| Exercises 4 | / | [notes](E09-Exercises-4.md) | / |
| [I/O and File Systems on LUMI](extra-10-Lustre.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-10-Lustre.pdf) | [notes](10-Lustre.md) | [video](extra-10-Lustre.md) |
| [Containers on LUMI-C and LUMI-G](extra-11-Containers.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-11-Containers.pdf) | [notes](11-Containers.md) | [video](extra-11-Containers.md) |
| [Demo 1 (optional)](Demo1.md) | / | [notes](Demo1.md) | [video](Demo1.md#video-of-the-demo) |
| [Demo 2 (optional)](Demo2.md) | / | [notes](Demo2.md) | [video](Demo2.md#video-of-the-demo) |
| [LUMI Support and Documentation](extra-12-Support.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-12-Support.pdf) | [notes](12-Support.md) | [video](extra-12-Support.md) |
| [What Else?](extra-13-WhatElse.md) | [slides](https://462000265.lumidata.eu/2day-next/files/LUMI-2day-next-13-WhatElse.pdf) | / | [video](extra-13-WhatElse.md) |
| A1 Additional documentation | / | [notes](A01-Documentation.md) | / | 


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
