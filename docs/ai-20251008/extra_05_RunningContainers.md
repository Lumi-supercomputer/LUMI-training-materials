# Running containers on LUMI

*Presenter*: Julius Roeder (DeiC)

Content:

-   What is a container and what can it do
-   How do you use containers
-   Mounting filesystem into containers
-   Official LUMI (FakeCPE) containers


<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20251008/recordings/05_RunningContainers.mp4" controls="controls"></video>


## Extra materials

More materials will become available during and shortly after the course

-   [Presentation slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-05-Running_containers_on_LUMI.pdf)

-   [Hands-on exercises](E05_RunningContainers.md)

-   Documentation:

    -   [LUMI docs "Container jobs" page](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/container-jobs/)

    -   [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/) for information about
        the available EasyConfigs for containers

-   [Training materials from the most recent LUMI introductory training in June 2025](../2day-20250602/index.md)

    -   The ["LUMI Software Stacks" talk](../2day-20250602/M105-SoftwareStacks.md)
        discusses using EasyBuild among other things.

    -   The ["Containers on LUMI-C and LUMI-G" talk](../2day-20250602/M205-Containers.md)
        also covers the AI containers towards the end of the presentation.

-   And some demos from the [LUMI introductory training in March 2025](../2day-20250602/index.md)

    -   ["Demo 1: Fooocus"](../2day-20250602/Demo1.md) 
        extends a container installed with EasyBuild with additional packages and is based on the demo given
        the EuroHPC master students at the most recent EuroHPC Summit Week. It uses among other things also
        the "proot unprivileged build" approach mentioned in the presentation.

    -   ["Demo 2: A short walk-through for distributed learning"](../2day-20250602/Demo2.md)
        demonstrates a procedure also covered in the documentation to do distributed learning using the
        container with the module installed by EasyBuild. The approach is slightly different from the one 
        used in this course though.


## Q&A

1.  How can we extend the prebuilt containers with more libraries (after copying them to some of our own folders)?

    -   Yes, that will be discussed in the comming sessions. Options includes create a sandbox 
        out of the container to install your own software or use virtual environments.

    -   And in the training materials for this lecture, you will also soon find a link to 
        an older demo where we use some approaches to extend the container (the FOOOCUS demo).

2.  Is there a way to create a sigularity container from a requirements.txt or poetry files in a direct way?

    -   Yes. ["lumi-container-wrapper"](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-container-wrapper/) 
        (or [this doc page](https://docs.lumi-supercomputer.eu/software/installing/container-wrapper/)) is your tool. 
        But you can't build a proper PyTorch container that way. For that, 
        [`cotainr`](https://docs.lumi-supercomputer.eu/software/containers/singularity/#building-containers-using-the-cotainr-tool) 
        which will be treated in the next presentation is your tool of choice. 
        There is more needed than what pip etc. can do to make a working PyTorch container. 
        But you can always extend an existing container with additional packages specified in a 
        requirements.txt file, e.g., via a virtual environment, which is the last presentation of today.

3.  In the provided pytorch container, there is no ffmpeg library, however, it is in 
    the [module FFmpeg]( https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/f/FFmpeg/). 
    How do I use the ffmpeg inside my pytorch container? 
    No official package available for [openSUSE Leap 15.5](https://software.opensuse.org/package/ffmpeg), 
    any instructions on how to install ffmpeg from source to my container? 

    -   You cannot use that version from the module in the container. 
        You will have to extend the container with the FFmpeg package. 
        If there is a SUSE package for that, and if so, you can use the "proot unprivileged build" proces for that. 
        We have a demo, the Fooocus demo discussed above.. 
   
        And if there is no package, you'll need to install it by hand. 
        The ffmpeg package on the system cannot be trivially imported in the container as it 
        has a lot of dependencies that would also need to be imported, 
        and as the compiler version used for these packages, may not be compatible either. 
        Unfortunately, the number of dependencies of FFmpeg is huge so this is a far from trivial undertaking...

        I don't know by heart how to use the SUSE `zypper` tool to install community packages, 
        but that might be the easiest solution if it can then still find all dependencies.
        
        I did also experiment a little with extending a Conda installation with conda 
        by running the commands in a `%post` section in a proot build process. 
        It did not work completely - the output of `conda list` did not correspond 
        to what was installed - but it did seem to install the packages I wanted, 
        so that may be another way.
        
    -   There is a conda package for ffmpeg. That might work.
        You can try `pytorch::ffmpeg`
        Or building from source. There should be instructions in the ffmpeg docs.

4.  I've exceeded disk quota when pulling a container from docker to singularity:
    ```
    singularity pull my_container.sif            docker://rocm/pytorch:rocm6.4.4_ubuntu
    24.04_py3.12_pytorch_release_2.7.1

    FATAL:   While making image from oci registry: error fetching image to cache: while building SIF from layers: conveyor failed to get: error writing layer: write /users/masmagre/.singularity/cache/blob/blobs/sha256/c1974c40f700d776376f6394d8016636ef10037d2291ddd533015ec9b556414d455257573: disk quota exceeded
    ```
    
    -   This is an issue the lecturer unfortunately forgot to warn for (or I must have overlooked it). 
        The default cache location is in the home directory, which is too small. 
        The solution is to set another cache directory on /scratch or so using the environment variable 
        `SINGULARITY_CACHEDIR`. (Or link the cache subdirectory of `˜/.singularity` to such a directory)

    -   I tend to do that kind of thing in a job on a single compute node and set the cache to `/tmp`.

        Which works also if you allocate enough memory to the job. Building larger containers may require 
        just taking an exclusive node, e.g., by using the `standard` partition if you have 
        CPU billing units left or on `standard-g`.
    
    -   Some more information about this can be found in the 
        [LUMI documentation](https://docs.lumi-supercomputer.eu/software/containers/singularity/#pulling-container-images-from-a-registry)
