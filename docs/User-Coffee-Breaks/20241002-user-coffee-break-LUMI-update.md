# LUMI Update Webinar (October 2, 2024)

*Presenters:* Harvey Richardson (HPE), Kurt Lust (LUST), George Markomanolis (AMD)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20241002-user-coffee-break-LUMI-update.mp4" controls="controls">
</video>

Slides of the presentations

-   HPE presentation: to come

-   [LUST presentation](https://462000265.lumidata.eu/user-coffee-breaks/files/20241002-user-coffe-break-LUMI-update-LUST.pdf)

-   [AMD presentation](https://462000265.lumidata.eu/user-coffee-breaks/files/20241002-user-coffe-break-LUMI-update-AMD.pdf)


## Q&A

[Full archive of all LUMI Coffee Break questions](https://hackmd.io/@lust/coffeearchive#). This page only shows the 
questions from the LUMI update session.


1.  Any knowledge when EasyBuild-recipes for Pytorch Containers with ROCm 6 are coming?

    -   So far Kurt Lust made those recipes. It was a personal idea of him, as the people 
        teaching the AI course preferred a different approach. But Kurt is rather busy this month 
        with the Hackathon in Brussels and the course in Amsterdam. 
        So no promises when he will have time to look into it unfortunately. 
        Good to know that these modules are actually appreciated, we will try to put some time into it.

2.  We observe about 30% slowdown in GPU MPI jobs compared to previous LUMI system. 
    Is this expected? Now we use CC, previously used hipcc but we were not able to make 
    it work after the update.
  
    -   No. Most people report equal speed to a modest increase for GPU software.
 
    -   Did you have the rocm module loaded? With the AMD compilers (amd/6.0.3 module now, amd/5.2.3 before the update) you didn't need to load the rocm module, but now you do for some ROCm functionality and GPU aware MPI. That could in fact explain why hipcc didn't work.

    -   I've observed this same behaviour and already reported it, I find a 50% slowdown with ELPA.



3.  Are you planning to build software that so far is only present as an Easybuild recipe? 
    E.g. Paraview, it is a long build, could be easier to provide "normal" prebuilt modules for that.

    -   ParaView is offered as a container in the web interface to LUMI, or at least, 
        will be again as soon as the NVIDIA visualisation nodes are operational again.

    -   We don't provide pre-built modules for software that is hard for us to test or 
        may need different configurations to please everybody. A central installation is 
        problematic to manage as you can only add to it and not remove as you don't know when 
        people are using a package. So stuff that is broken for some but works for others 
        sticks on the system forever. We follow the approach that is used in the big USA 
        centres also more and more, i.e., not much centrally installed software for more 
        flexibility in managing the stack and reparing broken installations. After all, 
        if a apckage is in a project, the members in the project only need to talk to 
        each other to find out when it can be updated.

4. Is there an estimate when ROCm 6.2 and the new profiling tools will be available on LUMI?

    -   An equivalent to the modules that we had before, is still in the testing phase.
        It will appear either as a user installable module or in LUMI/24.03 partition/G.

        Follow the [updates in the LUMI software library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/whats_new/)

    -   There is currently a very unofficial one with no guarantee that it will stay on the system:
  
        ```
        module use /pfs/lustrep2/projappl/project_462000125/samantao-public/mymodules
        module load rocm/6.2.1
        ```

5.  Will modules like singularity-filesystems etc become available by default or will we 
    keep having to use `module use /appl/local/training/modules/AI-20240529`

    -   We've already needed several specialised versions of it for users, so no. 
        There is no single "fits all" configuration of this module.

    -   Unfortunately, the central software stacks on LUMI have been designed in a way that 
        prevents us from providing these modules as part of those stacks. We are looking at 
        alterantive ways to provide something similar, but no timeline at this point unfortunately.

6.   We have recently attempted to transition training LLMs from NVIDIA-based supercomputers to LUMI-G. 
     The setup is based around Pytorch, along with some packages compiled from source using Hipify and 
     Hipcc wrapped in a Singularity container. However, we observe a slowdown of over 200%, 
     along with increased memory requirements for GPUs. Are there any tips or obvious mistakes 
     users make when managing such transitions? (A100-40GB, bfloat16)

    -   You can find training material (recordings, slides) from the last AI workshop here: 
        [2-day Getting started with AI on LUMI workshop](https://lumi-supercomputer.github.io/LUMI-training-materials/ai-20240529/)

        Most of the material is still fairly accurate, but you may have to change versions of modules.

    -   We will have another (updated) AI workshop in November, 
        maybe [that might be interesting for you](https://www.lumi-supercomputer.eu/events/lumi-ai-workshop-nov2024/)

    -   Otherwise you can also open a ticket describing your problem and we will have a look

    -   You may need to review how RCCL is initialized. Batch sizes, etc., can also have a large influence
        on performance.

6.  Is there training material for porting CUDA kernels into ROCm compatible?

    - [From a course at HLRS](https://fs.hlrs.de/projects/par/events/2024/GPU-AMD/day2/07.%20Porting%20Applications%20to%20HIP%20-%20Local.pdf#:~:text=%E2%80%A2%20Hipify-perl%20and%20hipify-clang%20can%20both)

8.  What is the method to hand over (large) (collection of) files to the LUMI support team, now that `/tmp/* is mangled?
 
    -   You can use LUMI web interface to create LUMI-O bucket and share it with us; use private buckets only!

    -   Various academic service providers also offer file sender services similar to WeTransfer. This will require
        transfering files to a system where you can run the web browser first, but then since these are usually
        rather important files you should have a backup outside of LUMI anyway.
