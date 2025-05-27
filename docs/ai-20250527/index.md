# Moving your AI training jobs to LUMI workshop - CWI, Amsterdam, May 27-28, 2025

## Course organisation

-   Location: [CWI, Science Park 123, 1098 XG Amsterdam, The Netherlands](https://maps.app.goo.gl/JxNSYntYuBYfvjGV8)


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
   
-   [Preliminary schedule](schedule.md)

<!--
-   [HedgeDoc for questions](https://md.sigma2.no/lumi-ai-workshop-may25?both)
   
    Questions with longer-term relevance will be incorporated into the pages linked below.
    This HedgeDoc document will not be monitored anymore for further questions after the course.
    The link will likely die over time.
-->
<!--
-   [Zoom link](https://cscfi.zoom.us/j/64948027353?pwd=nJ71W4e6TgT5GvewIpnfWf8uKgILp4.1) 

-   There are two Slurm reservations for the course. One for each day:

    -   First day: `AI_workshop_1` (on the `small-g` Slurm partition)
    -   Second day: `AI_workshop_2` (on the `standard-g` Slurm partition)

    Project with the compute resources: `project_465001958`.
    These resources are limited and should only be used for the exercises during
    the course and not for your own work.
-->
<!--
ReservationName=AI_workshop_1 StartTime=2025-05-27T10:00:00 EndTime=2025-05-27T18:00:00 Duration=08:00:00
   Nodes=nid[005026-005049] NodeCnt=24 CoreCnt=1536 Features=(null) PartitionName=small-g Flags=
   TRES=cpu=3072
   Users=(null) Groups=(null) Accounts=project_465001958 Licenses=(null) State=INACTIVE BurstBuffer=(null) Watts=n/a
   MaxStartDelay=(null)

ReservationName=AI_workshop_2 StartTime=2025-05-28T10:00:00 EndTime=2025-05-28T18:00:00 Duration=08:00:00
   Nodes=nid[005124-005133,005136-005143,005145-005166,005168-005173,005176-005193] NodeCnt=64 CoreCnt=4096 Features=(null) PartitionName=standard-g Flags=
   TRES=cpu=8192
   Users=(null) Groups=(null) Accounts=project_465001958 Licenses=(null) State=INACTIVE BurstBuffer=(null) Watts=n/a
   MaxStartDelay=(null)
-->


## Setting up for the exercises

### During the course

More information will follow at the start of the course.


<!--
If you have an active project on LUMI, you should be able to make the exercises in that project.
To reduce the waiting time during the workshop, use the SLURM reservations we provide (see above).

You can find all exercises on our [AI workshop GitHub page](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop)
-->


### After the termination of the course project

More information will follow after the course.

<!--
Setting up for the exercises is a bit more elaborate now.

The exercises as they were during the course are 
[available as the tag `ai-20250527` in the GitHub repository](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20250527). Whereas the repository could simply 
be cloned during the course, now you have to either:

-   Download the content of the repository as 
    a [tar file](https://462000265.lumidata.eu/ai-20250527/files/ai-20250527-Getting_Started_with_AI_workshop.tar)
    or [bzip2-compressed tar file](https://462000265.lumidata.eu/ai-20250527/files/ai-20250527-Getting_Started_with_AI_workshop.tar.bz2)
    or [from the GitHub release](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/releases/tag/ai-20250527)
    where you have a choice of formats,

-   or clone the repository and then check out the tag `ai-20250527`:

    ```
    git clone https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop.git
    cd Getting_Started_with_AI_workshop
    git checkout ai-20250527
    ```

Note also that any reference to a reservation in Slurm has to be removed.

The exercises were thoroughly tested at the time of the course. LUMI is an evolving supercomputer though,
so it is expected that some exercises may fail over time, and modules that need to be loaded, will also
change as at every update we have to drop some versions of the `LUMI` module as the programming environment
is no longer functional. Likewise it is expected that at some point the ROCm driver on the system may
become incompatible with the ROCm versions used in the containers for the course.
-->


## Course materials

**Note:** Some links in the table below will remain invalid until after the course when all
materials are uploaded.

| Presentation | Slides | recording |
|:-------------|:-------|:----------|
| [Welcome and course introduction](extra_00_Course_Introduction.md) | / | [video](extra_00_Course_Introduction.md) |
| [Introduction to LUMI](extra_01_Introduction.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-01-Lumi_intro.pdf) | [video](extra_01_Introduction.md) |
| [Using the LUMI web-interface](extra_02_Webinterface.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-02-Using_LUMI_web_UI.pdf) | [video](extra_02_Webinterface.md) |
| [Hands-on: Run a simple PyTorch example notebook](E02_Webinterface.md) | / | [video](E02_Webinterface.md) |
| [Your first AI training job on LUMI](extra_03_FirstJob.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-03-First_AI_job.pdf) | [video](extra_03_FirstJob.md) |
| [Hands-on: Run a simple single-GPU PyTorch AI training job](E03_FirstJob.md) | / | [video](E03_FirstJob.md) |
| [Understanding GPU activity & checking jobs](extra_04_CheckingGPU.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-04-Understanding_GPU_activity.pdf) | [video](extra_04_CheckingGPU.md) |
| [Hands-on: Checking GPU usage interactively using rocm-smi](E04_CheckingGPU.md) | / | [video](E04_CheckingGPU.md) |
| [Running containers on LUMI](extra_05_RunningContainers.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-05-Running_containers_on_LUMI.pdf) | [video](extra_05_RunningContainers.md) |
| [Hands-on: Pull and run a container](E05_RunningContainers.md) | / | [video](E05_RunningContainers.md) |
| [Building containers from Conda/pip environments](extra_06_BuildingContainers.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-06-Building_containers_from_conda_pip_environments.pdf) | [video](extra_06_BuildingContainers.md) |
| [Hands-on: Creating a conda environment file and building a container using cotainr](E06_BuildingContainers.md) | / | [video](E06_BuildingContainers.md) |

<!--
| [Extending containers with virtual environments for faster testing](extra_07_VirtualEnvironments.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-07-Extending_containers.pdf) | [video](extra_07_VirtualEnvironments.md) |
| [Scaling AI training to multiple GPUs](extra_08_MultipleGPUs.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-08-Scaling_multiple_GPUs.pdf) | [video](extra_08_MultipleGPUs.md) |
| [Hands-on: Converting the PyTorch single GPU AI training job to use all GPUs in a single node via DDP](E08_MultipleGPUs.md) | / | [video](E08_MultipleGPUs.md) |
| [Extreme scale AI](extra_09_ExtremeScale.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-09-Extreme_scale_AI.pdf) | [video](extra_09_ExtremeScale.md) |
| [Demo/Hands-on: Using multiple nodes](E09_ExtremeScale.md) | / | [video](E09_ExtremeScale.md) |
| [Loading training data on LUMI](extra_10_TrainingData.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-10-Training_Data_on_LUMI.pdf) | [video](extra_10_TrainingData.md) |
| [Coupling machine learning with HPC simulation](extra_11_Coupling.md) | [slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-11-Coupling_Simulation_and_AI.pdf) | [video](extra_11_Coupling.md) |
| [Hands-on: Advancing your project and general Q&A](E12_Project_and_QA.md)| / | [video](E12_Project_and_QA.md) |
-->

## Web links

-   LUMI documentation

    -   [Main documentation](https://docs.lumi-supercomputer.eu/)

    -   [Shortcut to the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)

    -   [LUMI AI guide](https://github.com/Lumi-supercomputer/LUMI-AI-Guide)

