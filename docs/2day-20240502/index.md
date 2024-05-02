# Supercomputing with LUMI - Amsterdam, May 2-3, 2024

## Course organisation

-   Location: [SURF, Science Park 140, 1098 XG, Amsterdam, The Netherlands](https://maps.app.goo.gl/11bPcfD6s93PNMZK6)

-   [Schedule](schedule.md)

-   [HedgeDoc for questions](https://md.sigma2.no/lumi-intro-course-may24?both)

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
    wget https://462000265.lumidata.eu/2day-20240502/files/exercises-20240502.tar.gz
    tar -xf exercises-20240502.tar.gz
    ```

    [Link to the tar-file with the exercises](https://462000265.lumidata.eu/2day-20240502/files/exercises-20240502.tar.gz)

-   You're all set to go!


## Course materials

**Note:** Some links in the table below will remain invalid until after the course when all
materials are uploaded.

| Presentation | Slides | Notes | recording |
|:-------------|:-------|:------|:----------|
| [Welcome and Introduction](extra_00_Introduction.md) | [slides](https://462000265.lumidata.eu/2day-20240502/files/LUMI-2day-20240502-00-Introduction.pdf) | [notes](00_Introduction.md) | [video](extra_00_Introduction.md) |
| [LUMI Architecture](extra_01_Architecture.md) | [slides](https://462000265.lumidata.eu/2day-20240502/files/LUMI-2day-20240502-01-architecture.pdf) | [notes](01_Architecture.md) | [video](extra_01_Architecture.md) |
| [HPE Cray Programming Environment](extra_02_CPE.md) | [slides](https://462000265.lumidata.eu/2day-20240502/files/LUMI-2day-20240502-02-CPE.pdf) | [notes](02_CPE.md) | [video](extra_02_CPE.md) |
| [Getting Access to LUMI](extra_03_LUMI_access.md) | [slides](https://462000265.lumidata.eu/2day-20240502/files/LUMI-2day-20240502-03-access.pdf) | [notes](03_LUMI_access.md) | [video](extra_03_LUMI_access.md) |
| Exercises 1 | / | [notes](E03_Exercises_1.md) | / |
| [Modules on LUMI](extra_04_Modules.md) | [slides](https://462000265.lumidata.eu/2day-20240502/files/LUMI-2day-20240502-04-modules.pdf) | [notes](04_Modules.md) | [video](extra_04_Modules.md) |
| Exercises 2 | / | [notes](E04_Exercises_2.md) | / |
| [LUMI Software Stacks](extra_05_Software_stacks.md) | [slides](https://462000265.lumidata.eu/2day-20240502/files/LUMI-2day-20240502-05-software.pdf) | [notes](05_Software_stacks.md) | [video](extra_05_Software_stacks.md) |
| Exercises 3 | / | [notes](E05_Exercises_3.md) | / |
| A1 Additional documentation | / | [notes](A01_Documentation.md) | / | 


## Web links

-   [Links to additional HPE Cray documentation](A01_Documentation.md)

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
