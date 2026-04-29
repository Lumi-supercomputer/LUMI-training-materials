# Moving your AI training jobs to LUMI workshop - UiT, Tromsø, June 11-12, 2026

!!! Note
    If you are looking for course materials, check the pages of the 
    [previous edition in October 2025](../ai-20251008/index.md).
    The previous course was still based on the LUST/AMD containers and CSC modules,
    while this edition is fully based on the 
    [LUMI AI Factory containers](https://docs.lumi-supercomputer.eu/laif/software/ai-environment/).


## Course organisation

-   Location: UiT - The Artic University of Norway, Tromsø.
    [University library room UB 244 (2nd floor)](https://use.mazemap.com/#v=1&config=uit&campusid=5&zlevel=1&center=18.973518,69.680798&zoom=18&sharepoitype=poi&sharepoi=174057&search=244)

-   Schedule: TBA
<!--
-   [Very preliminary schedule](schedule.md)
-->

<!--
-   [HedgeDoc for questions](https://siili.rahtiapp.fi/lumi-ai-workshop-oct25?both)
   
    Questions with longer-term relevance will be incorporated into the pages linked below.
    This HedgeDoc document will not be monitored anymore for further questions after the course.
    The link will likely die over time.

-   [Zoom link](https://cscfi.zoom.us/j/65207108811?pwd=Mm8wZGUyNW1DQzdwL0hSY1VIMDBLQT09) 

-   There are two Slurm reservations for the course. One for each day:

    -   First day: `AI_workshop_Day1` (on the `small-g` Slurm partition)
    -   Second day: `AI_workshop_Day2` (on the `standard-g` Slurm partition)

    Project with the compute resources: `project_465002178`.
    These resources are limited and should only be used for the exercises during
    the course and not for your own work.
-->

<!--
ReservationName=AI_workshop_Day1 StartTime=2025-10-08T10:00:00 EndTime=2025-10-08T20:00:00 Duration=10:00:00
   Nodes=nid[005026-005041] NodeCnt=16 CoreCnt=1024 Features=(null) PartitionName=small-g Flags=
   TRES=cpu=2048
   Users=(null) Groups=(null) Accounts=project_465002178 Licenses=(null) State=INACTIVE BurstBuffer=(null) Watts=n/a
   MaxStartDelay=(null)

ReservationName=AI_workshop_Day2 StartTime=2025-10-09T10:00:00 EndTime=2025-10-09T20:00:00 Duration=10:00:00
   Nodes=nid[005124-005139] NodeCnt=16 CoreCnt=1024 Features=(null) PartitionName=standard-g Flags=
   TRES=cpu=2048
   Users=(null) Groups=(null) Accounts=project_465002178 Licenses=(null) State=INACTIVE BurstBuffer=(null) Watts=n/a
   MaxStartDelay=(null)
-->

## Setting up for the exercises

### During the course

More information will follow at the start of the course.

<!--
If you have an active project on LUMI, you should be able to make the exercises in that project
(i.e., store the files in your own project, but use the course project for running).
That way you're guaranteed access to your work for the duration of your project.
To reduce the waiting time during the workshop, use the SLURM reservations we provide (see above)
and the course project for running.

You can find all exercises on our [AI workshop GitHub page](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop)
-->

### After the termination of the course project

More information will follow after the course.

<!--
Setting up for the exercises is a bit more elaborate now.

The exercises as they were during the course are 
[available as the tag `ai-20260611` in the GitHub repository](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20260611). Whereas the repository could simply 
be cloned during the course, now you have to either:

-   Download the content of the repository as 
    a [tar file](https://462000265.lumidata.eu/ai-20260611/files/ai-20260611-Getting_Started_with_AI_workshop.tar)
    or [bzip2-compressed tar file](https://462000265.lumidata.eu/ai-20260611/files/ai-20260611-Getting_Started_with_AI_workshop.tar.bz2)
    or [from the GitHub release](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/releases/tag/ai-20260611)
    where you have a choice of formats,

-   or clone the repository and then check out the tag `ai-20260611`:

    ```
    git clone https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop.git
    cd Getting_Started_with_AI_workshop
    git checkout ai-20260611
    ```

Note also that any reference to a reservation in Slurm has to be removed.

The exercises were thoroughly tested at the time of the course. LUMI is an evolving supercomputer though,
so it is expected that some exercises may fail over time, and modules that need to be loaded, will also
change as at every update we have to drop some versions of the `LUMI` module as the programming environment
is no longer functional. Likewise it is expected that at some point the ROCm driver on the system may
become incompatible with the ROCm versions used in the containers for the course.
-->

## Course materials

Course materials will be made available during the course.

<!--
**Note:** Some links in the table below will remain invalid until after the course when all
materials are uploaded.

| Presentation | Slides | recording |
|:-------------|:-------|:----------|
| [Welcome and course introduction](extra_00_Course_Introduction.md) | / | [video](extra_00_Course_Introduction.md) |
| [Introduction to LUMI](extra_01_Introduction.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-01-Lumi_intro.pdf) | [video](extra_01_Introduction.md) |
| [Using the LUMI web-interface](extra_02_Webinterface.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-02-Using_LUMI_web_UI.pdf) | [video](extra_02_Webinterface.md) |
| [Hands-on: Run a simple PyTorch example notebook](E02_Webinterface.md) | / | [video](E02_Webinterface.md) |
| [Your first AI training job on LUMI](extra_03_FirstJob.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-03-First_AI_job.pdf) | [video](extra_03_FirstJob.md) |
| [Hands-on: Run a simple single-GPU PyTorch AI training job](E03_FirstJob.md) | / | [video](E03_FirstJob.md) |
| [Understanding GPU activity & checking jobs](extra_04_CheckingGPU.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-04-Understanding_GPU_activity.pdf) | [video](extra_04_CheckingGPU.md) |
| [Hands-on: Checking GPU usage interactively using rocm-smi](E04_CheckingGPU.md) | / | [video](E04_CheckingGPU.md) |
| [Running containers on LUMI](extra_05_RunningContainers.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-05-Running_containers_on_LUMI.pdf) | [video](extra_05_RunningContainers.md) |
| [Hands-on: Pull and run a container](E05_RunningContainers.md) | / | [video](E05_RunningContainers.md) |
| [Building containers from Conda/pip environments](extra_06_BuildingContainers.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-06-Building_containers_from_conda_pip_environments.pdf) | [video](extra_06_BuildingContainers.md) |
| [Hands-on: Creating a conda environment file and building a container using cotainr](E06_BuildingContainers.md) | / | [video](E06_BuildingContainers.md) |
| [Extending containers with virtual environments for faster testing](extra_07_VirtualEnvironments.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-07-Extending_containers.pdf) | [video](extra_07_VirtualEnvironments.md) |
| [Scaling AI training to multiple GPUs](extra_08_MultipleGPUs.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-08-Scaling_multiple_GPUs.pdf) | [video](extra_08_MultipleGPUs.md) |
| [Hands-on: Converting the PyTorch single GPU AI training job to use all GPUs in a single node via DDP](E08_MultipleGPUs.md) | / | [video](E08_MultipleGPUs.md) |
| [Extreme scale AI](extra_09_ExtremeScale.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-09-Extreme_scale_AI.pdf) | [video](extra_09_ExtremeScale.md) |
| [Demo/Hands-on: Using multiple nodes](E09_ExtremeScale.md) | / | [video](E09_ExtremeScale.md) |
| [Loading training data on LUMI](extra_10_TrainingData.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-10-Training_Data_on_LUMI.pdf) | [video](extra_10_TrainingData.md) |
| [Coupling machine learning with HPC simulation](extra_11_Coupling.md) | [slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-11-Coupling_Simulation_and_AI.pdf) | [video](extra_11_Coupling.md) |
| [Hands-on: Advancing your project and general Q&A](E12_Project_and_QA.md)| / | [video](E12_Project_and_QA.md) |
-->
<!--
-->


## Web links

-   LUMI documentation

    -   [Main documentation](https://docs.lumi-supercomputer.eu/)

    -   [Shortcut to the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)

    -   [LUMI AI guide](https://github.com/Lumi-supercomputer/LUMI-AI-Guide)

