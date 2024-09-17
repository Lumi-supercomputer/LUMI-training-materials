# HPE Cray EX Architecture

*Presenter: Harvey Richardson (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001098/Slides/HPE/01_EX_Architecture.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-1_01_HPE_Cray_EX_Architecuture.pdf`

-   Recording: `/appl/local/training/4day-20240423/recordings/1_01_HPE_Cray_EX_Architecture.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

## Q&A

1.  Can an AMD GPU in LUMI be used to run typical Nvidia GPU platforms, such as pytorch or tensorflow? 
    If I run my python script, do I have to import specific libraries to enable AMD gpus? 
    Or it's pretty much quite similar to Nvidia?

    -   It cannot run binaries for NVIDIA GPUs, but much software has been ported, including PyTorch and Tensorflow. 
        It is like with CPUs: an ARM CPU cannot run x86 binaries and vice-versa. 
        As we will see in the HIP talk tomorrow, many libraries for NVIDIA have an equivalent for AMD. 
        But NVIDIA is proprietary technology (to protect their own market and be able to charge more), 
        so it is not always really one-to-one as even function names in the NVIDIA ecosystem are sometimes protected. 
        But, e.g., when you install Python packages you may have to tell pip to use the right binaries for the AMD ecosystem.
   
    -   See also [tomorrow afternoon in the software stack talk](extra_2_07_LUMI_Software_Stacks.md) 
        to learn how you can find out what we have.

    -   For most AI frameworks, if you install them correctly then you don't need to change anything in your code to make it work. 

2.  Is speculative execution on epyc enable by default?

    -   Yes, it would be very slow without. It is not something you can enable or disable on a CPU, 
        it sits too deep in the architecture.

