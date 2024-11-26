# Running containers on LUMI

*Presenter*: Jan Vicherek (LUST)

Content:

-   What is a container and what can it do
-   How do you use containers
-   Mounting filesystem into containers
-   Official LUMI (FakeCPE) containers


<!--
<video src="https://462000265.lumidata.eu/ai-20241126/recordings/05_RunningContainers.mp4" controls="controls"></video>
-->


## Extra materials

-   [Presentation slides](https://462000265.lumidata.eu/ai-20241126/files/LUMI-ai-20241126-05-Running_containers_on_LUMI.pdf)

-   [Hands-on exercises](E05_RunningContainers.md)

-   Documentation:

    -   [LUMI docs "Container jobs" page](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/container-jobs/)

    -   [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/) for information about
        the available EasyConfigs for containers

-   [Training materials from the most recent LUMI introductory training in May 2024](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/)

    -   The ["LUMI Software Stacks" talk](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/extra_05_Software_stacks/)
        discusses using EasyBuild among other things.

    -   The ["Containers on LUMI-C and LUMI-G" talk](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/extra_09_Containers/)
        also covers the AI containers towards the end of the presentation.

    -   ["Demo 1: Fooocus"](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/Demo1/) 
        extends a container installed with EasyBuild with additional packages and is based on the demo given
        the EuroHPC master students at the most recent EuroHPC Summit Week.

    -   ["Demo 2: A short walk-through for distributed learning"](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/Demo2/)
        demonstrates a procedure also covered in the documentation to do distributed learning using the
        container with the module installed by EasyBuild.

## Q&A

1.  Without 'module use /project/project_465001363/modules/AI-20241126', which is dependent to today's workshop, how should one be able to go for 'module load singularity-userfilesystems'? Or maybe I am wrong...

    -   You can use "module use /appl/local/training/modules/AI-20241126"  as the packages in this directory (cotainr, singularity-bindings, singularity-CPEbits, singularity-userfilesystems) will remain available even after the training.

    -   The precise bindings that are needed depends on what is on the system and what is in the container. Both change (the system during system updates, e.g., the libjanson.so.4 binding was not needed two system upgrades ago). 

    -   [`singularity-bindings`](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/s/singularity-bindings/) can also be installed via our EasyBuild build procedure. The precise content of the module may need to be adapted to what is in your container. It is not a universal solution which is why it is not a default on the system.

    -   And there are use cases where we know that CPEbits also is insufficient, even for the current containers, and more mounts from the system are needed.

    -   And [`cotainr`](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/c/cotainr/) is part of the regular software stacks on LUMI (but just before the course a bug was discovered in the then most recent version that could not be repaired in time).

2.  Building on the previous question, how would I know what is needed and what not for each use case? Since in most cases I would get a performance penalty and not an outright failure. Would modules like CPEbits be available on a 'standard' path?

    -   Actually it looks like the cases where you would get a serious performance penalty are well covered by `CPEbits` and you'd probably get an error if it doesn't work. Most of the problems we've seen are actually cases where system libraries that are bound to the container then try to load other libraries that are not bound and not in the container.

        The main problem with AI software is that it needs to find the right network libraries to get good performance on SlingShot 11. So RCCL needs a plugin which is actually pre-installed in the AI containers that we offer, and everything that uses MPI should use the Cray MPI from the system to ensure that the interconnect is properly used. There are a few other solutions for MPI, but even then you'll still have to import the lower-level communication library for libfabric from the system. HPE is open-sourcing their version, but there are still problems with it.
        
        Apart from that you need properly optimised linear algebra libraries, but that is not a problem that can be solved by binding system libraries, unless you specifically build the software in the container to use those libraries. But that is beyond the scope of this course.

    -   CPEbits is not available on the standard path precisely because we cannot guarantee it works with each container. For some containers we provide container-specific modules as then we can adapt them more easily for the specific content of the container, but they may still fail after a system update. This is whey, e.g., we offer users the option to install [PyTorch modules](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/) for some of the PyTorch containers that we offer. -> Support for the "important" containers like torch and tf is already very good, thank!

    -   Moreover, due to the large user base of LUMI, all with different requirements, the difficulties to maintain things in the central stack as we cannot remove anything because you're never sure people are using it at that time (something may turn out to be broken for some users but not for others) and because the module system would become too slow with those 1000s of modules on the system, we make most of the modules user-installable so that each project can create the software stack that is ideal for them.


