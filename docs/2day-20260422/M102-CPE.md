# The HPE Cray Programming Environment

*Presenter: Kurt Lust (LUST)*

As Linux itself is not a complete supercomputer operating system, many components
that are essential for the proper functioning of a supercomputer are separate packages
(such as the [Slurm scheduler](M201-Slurm.md) discussed later in this course) or part 
of programming environments. 
It is important to understand the consequences of this, even if all you want is to simply
run a program.


## Materials

<!--
Materials will be made available after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20260422/recordings/LUMI-2day-20260422-102-CPE.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20260422/files/LUMI-2day-20260422-102-CPE.pdf)

-   [Course notes](102-CPE.md)

-   [Exercises](E102-CPE.md)


## Q&A


1.  I use LUMI for Machine Learning frameworks. I use a CESingularity container to load Torch etc. 
    Do I still need to load this PrgEnv to make everything work well with Cray? 

    -   Not really, you may need some modules for bindings (I am thinking about the AIF container), or you need to manually take care of the binding yourself if you want/need to use some of those libraries (so no easy shortcut with modules, manual work is needed)

    I specify the bindings in the Python code when setting up the distributed environment with PyTorch. So that should probably be okay then? 

    -   I'm not totally sure, binding need to be specified in the singularity run command. if the python "encloses" that, then you're right, else not. I don't know your code so I cannot say :D

    Okay, thank you! I will check this.

    -   Oh, and sorry i may have misunderstood. With bindings here i meant binding of libraries from outside to inside the container, not binding the process to the cpu/gpu. That is definitely doable with python only. Usually issue with CS to have same word for different things.

    Ah okay :D I build the container with the other containers but maybe I best check if that binding is done correctly. But then I probably don't neet the PrgEnv module. Thank you for the information.

    -   **Kurt** Be careful when using your own containers for machine learning and not the containers that we provide. ROCm RCCL needs a special plugin for good performance on LUMI and that is typically missing if you use a container from elsewhere. Loading any Prgenv module (which is impossible in a container anyway unless you build the container specifically for using that programming environment) will not fix that.

        My personal advice - but some people in LUST will disagree - would be to not even consider `cotainr` which was heavily promoted in past editions of the AI training but to simply build on top of the [LUMI AI factory containers](https://docs.lumi-supercomputer.eu/laif/software/ai-environment/) as they can then offer you support and as they have put a lot of effort in assuring that those containers run well. (`cotainr` would install from Conda and, e.g., give you a less-than-optimal `mpi4py` which may not matter much for most AI workflows, but may also re-install ROCm libraries in a way that they do no longer detect the plugin needed for good commnication performance).

        One property of containers is that they offer you isolation. So whatever module you load outside the container will likely have no effect in the container unless that module is specifically written to inject things in the container using special environment variables for that purpose.

2.  What about the PrgEnv-gnu-amd? Does it make sense to use it? I have to use gcc compilers to compiler my software.

    -   That module will load clang for c/c++ and gnu for fortran. AFAIK there is no specific optimizations 
        (compared to PrgEnv-gnu and PrgEnv-amd).



