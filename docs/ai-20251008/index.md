# Moving your AI training jobs to LUMI workshop - KTH, Stockholm, October 8-9, 2025

<!--
!!! Note
    If you are looking for course materials, check the pages of the 
    [previous edition in May 2025](../ai-20250527/index.md).
-->

## Course organisation

-   Location: [KTH, Lindstedtsvägen 24, 114 28 Stockholm, Sweden](https://maps.app.goo.gl/NPLtyuRe97euBSnL6),
    [room 522 "Fantum"](https://www.kth.se/places/room/id/c9ec01ab-b536-4be6-b82a-0d52ddadb2e6?l=en).

    The building is just a 5 minute walk from a metro station with excellent connections to the 
    central station (red metro line). See also the [SL web site](https://sl.se/en/in-english)
    for more information on public transportation in Stockholm.

-   Hotel suggestions for participants from outside Stockholm:

    -   [Elite Hotel Arcadia](https://maps.app.goo.gl/CQSC4S78xREbGrTE9) is close to the 
        entrance of the KTH campus and the metro station serving KTH.

    -   Hotels in the neighbourhood of the central station are also a good choice as there is 
        a fast and high frequency metro connection to the KTH campus from there and as it is a
        good place to find restaurants or head into old town at night.

        The [Scandic Continental Hotel](https://maps.app.goo.gl/CQSC4S78xREbGrTE9) even sits
        right on top of the main metro station where you can jump on any line.

-   [Schedule](schedule.md)

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

    -   [Arlanda Express](https://www.arlandaexpress.com/) - Moderately expensive, very fast direct train to stockholm central station.
        There are two train stations for the Arlanda Express at the airport, one for terminal 2, 3 and 4 (Arlanda Sodra) and
        one for terminal 5 (Arlanda Norra). 

    -   Commuter train - From Sky City in Arlanda you can get the normal trains. You need to pay 147 SEK (toll to use the tunnel under Arlanda) at the ticket barriers plus a normal SL ticket. This is a different train station as those for the Arlanda Express!

    -   Airport bus - cheapest option, but takes longest. Central bus station is right next to central station.

-   **Using public transportation in Stockholm**

    Probably simplest if you just get the [SL (Stockholm Localtrafik) app](https://sl.se/en/fares-and-tickets/smart-phone-ticket-app) 
    on a smartphone, will give you a QR code that you can use at ticket barriers. 
    Tickets can be bought using a credit card in the app. Physical cards are also available, but cost 50 SEK for the card, 
    plus extra for the tickets you put on it.  
    [Credit cards can also be used with contactless pay as you go to buy a single](https://sl.se/en/fares-and-tickets/contactless-pay-as-you-go/how-to-pay-as-you-go).

    Single tickets are fairly expensive. If you plan to use public transportation not only to come and go to the venue,
    but also at night to travel in Stockholm, a [travelcard](https://sl.se/en/fares-and-tickets/visitor-tickets/travelcards),
    which you can get in the app, may be a better option.

    Be careful when using the route planner in the app to travel to the course venue.
    If you search for KTH, several options will be offered to you, some of those in
    entirely different parts of the city. Search for 
    ["Tekniska högskolan"](https://maps.app.goo.gl/xoaz6KgaTKF3enL76), the metro station, or 
    "Lindstedtsvägen (Stockholm)". But **do NOT take 
    ["KTH - Royal Intitute of Technology (Södertälje)"](https://maps.app.goo.gl/NJJMRYPxdW3YgZ5E6)**
    as this will take you to a different place, even outside Stockholm

-   [Something for the night](something_for_the_night.md)


## Setting up for the exercises

### During the course

<!--
More information will follow at the start of the course.
-->


If you have an active project on LUMI, you should be able to make the exercises in that project
(i.e., store the files in your own project, but use the course project for running).
That way you're guaranteed access to your work for the duration of your project.
To reduce the waiting time during the workshop, use the SLURM reservations we provide (see above)
and the course project for running.

You can find all exercises on our [AI workshop GitHub page](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop)


### After the termination of the course project

<!--
More information will follow after the course.
-->

Setting up for the exercises is a bit more elaborate now.

The exercises as they were during the course are 
[available as the tag `ai-20251009` in the GitHub repository](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20251009). Whereas the repository could simply 
be cloned during the course, now you have to either:

-   Download the content of the repository as 
    a [tar file](https://462000265.lumidata.eu/ai-20251008/files/ai-20251008-Getting_Started_with_AI_workshop.tar)
    or [bzip2-compressed tar file](https://462000265.lumidata.eu/ai-20251008/files/ai-20251008-Getting_Started_with_AI_workshop.tar.bz2)
    or [from the GitHub release](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/releases/tag/ai-20251009)
    where you have a choice of formats,

-   or clone the repository and then check out the tag `ai-20251009`:

    ```
    git clone https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop.git
    cd Getting_Started_with_AI_workshop
    git checkout ai-20251009
    ```

Note also that any reference to a reservation in Slurm has to be removed.

The exercises were thoroughly tested at the time of the course. LUMI is an evolving supercomputer though,
so it is expected that some exercises may fail over time, and modules that need to be loaded, will also
change as at every update we have to drop some versions of the `LUMI` module as the programming environment
is no longer functional. Likewise it is expected that at some point the ROCm driver on the system may
become incompatible with the ROCm versions used in the containers for the course.

## Course materials

<!--
Course materials will be made available during the course.
-->

**Note:** Some links in the table below will remain invalid until after the course when all
materials are uploaded.

| Presentation | Slides | recording |
|:-------------|:-------|:----------|
| [Welcome and course introduction](extra_00_Course_Introduction.md) | / | [video](extra_00_Course_Introduction.md) |
| [Introduction to LUMI](extra_01_Introduction.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-01-Lumi_intro.pdf) | [video](extra_01_Introduction.md) |
| [Using the LUMI web-interface](extra_02_Webinterface.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-02-Using_LUMI_web_UI.pdf) | [video](extra_02_Webinterface.md) |
| [Hands-on: Run a simple PyTorch example notebook](E02_Webinterface.md) | / | [video](E02_Webinterface.md) |
| [Your first AI training job on LUMI](extra_03_FirstJob.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-03-First_AI_job.pdf) | [video](extra_03_FirstJob.md) |
| [Hands-on: Run a simple single-GPU PyTorch AI training job](E03_FirstJob.md) | / | [video](E03_FirstJob.md) |
| [Understanding GPU activity & checking jobs](extra_04_CheckingGPU.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-04-Understanding_GPU_activity.pdf) | [video](extra_04_CheckingGPU.md) |
| [Hands-on: Checking GPU usage interactively using rocm-smi](E04_CheckingGPU.md) | / | [video](E04_CheckingGPU.md) |
| [Running containers on LUMI](extra_05_RunningContainers.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-05-Running_containers_on_LUMI.pdf) | [video](extra_05_RunningContainers.md) |
| [Hands-on: Pull and run a container](E05_RunningContainers.md) | / | [video](E05_RunningContainers.md) |
| [Building containers from Conda/pip environments](extra_06_BuildingContainers.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-06-Building_containers_from_conda_pip_environments.pdf) | [video](extra_06_BuildingContainers.md) |
| [Hands-on: Creating a conda environment file and building a container using cotainr](E06_BuildingContainers.md) | / | [video](E06_BuildingContainers.md) |
| [Extending containers with virtual environments for faster testing](extra_07_VirtualEnvironments.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-07-Extending_containers.pdf) | [video](extra_07_VirtualEnvironments.md) |
| [Scaling AI training to multiple GPUs](extra_08_MultipleGPUs.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-08-Scaling_multiple_GPUs.pdf) | [video](extra_08_MultipleGPUs.md) |
| [Hands-on: Converting the PyTorch single GPU AI training job to use all GPUs in a single node via DDP](E08_MultipleGPUs.md) | / | [video](E08_MultipleGPUs.md) |
| [Extreme scale AI](extra_09_ExtremeScale.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-09-Extreme_scale_AI.pdf) | [video](extra_09_ExtremeScale.md) |
| [Demo/Hands-on: Using multiple nodes](E09_ExtremeScale.md) | / | [video](E09_ExtremeScale.md) |
| [Loading training data on LUMI](extra_10_TrainingData.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-10-Training_Data_on_LUMI.pdf) | [video](extra_10_TrainingData.md) |
| [Coupling machine learning with HPC simulation](extra_11_Coupling.md) | [slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-11-Coupling_Simulation_and_AI.pdf) | [video](extra_11_Coupling.md) |
| [Hands-on: Advancing your project and general Q&A](E12_Project_and_QA.md)| / | [video](E12_Project_and_QA.md) |
<!--
-->


## Web links

-   LUMI documentation

    -   [Main documentation](https://docs.lumi-supercomputer.eu/)

    -   [Shortcut to the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)

    -   [LUMI AI guide](https://github.com/Lumi-supercomputer/LUMI-AI-Guide)

