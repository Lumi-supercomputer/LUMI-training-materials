# Running containers on LUMI

*Presenter*: Gregor Decristoforo (LUST)

Content:

-   What is a container and what can it do
-   How do you use containers
-   Mounting filesystem into containers
-   Official LUMI (FakeCPE) containers


A video recording will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250204/recordings/05_RunningContainers.mp4" controls="controls"></video>
-->


## Extra materials

More materials will become available during and shortly after the course

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250204/files/LUMI-ai-20250204-05-Running_containers_on_LUMI.pdf)

-   [Hands-on exercises](E05_RunningContainers.md)

-   Documentation:

    -   [LUMI docs "Container jobs" page](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/container-jobs/)

    -   [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/) for information about
        the available EasyConfigs for containers

-   [Training materials from the most recent LUMI introductory training in December 2024](../2day-20241210/index.md)

    -   The ["LUMI Software Stacks" talk](../2day-20241210/M05-SoftwareStacks.md)
        discusses using EasyBuild among other things.

    -   The ["Containers on LUMI-C and LUMI-G" talk](../2day-20241210/M11-Containers.md)
        also covers the AI containers towards the end of the presentation.

-   And some demos from the [LUMI introductory training in May 2024](../2day-20240502/index.md)

    -   ["Demo 1: Fooocus"](../2day-20240502/Demo1.md) 
        extends a container installed with EasyBuild with additional packages and is based on the demo given
        the EuroHPC master students at the most recent EuroHPC Summit Week.

    -   ["Demo 2: A short walk-through for distributed learning"](../2day-20240502/Demo2.md)
        demonstrates a procedure also covered in the documentation to do distributed learning using the
        container with the module installed by EasyBuild.

## Q&A

1.  What ai-modules does?

    -   The singularity-AI-bindings module shown in the slides sets up the directory mounts of /scratch/, /project/, /flash/, etc from the LUMI filesystem into your container. It also binds some essential system libraries into the container. - Lukas

    -   To see what the module does, you can also do `module show singularity-AI-bindings` (after the `module use` on the slide)


2.  Can the existing (pre-built) containers be used to avoid the Python venv file issues that were mentioned earlier? 

    -   Kind of. In the [last presentation today](extra_07_VirtualEnvironments.md), 
        you'll see how you can pack the virtual environment that you created on top of the container in a way that is 100% OK for the file system. Or the EasyBuild-installed modules that were mentioned, also help. For now we only have the virtual environment management support in the newer 
        [PyTorch containers with EasyBuild](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/) 
        but we can in principle implement the same mechanism in another container also.


