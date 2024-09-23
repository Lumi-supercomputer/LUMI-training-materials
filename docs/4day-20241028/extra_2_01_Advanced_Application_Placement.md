# Advanced Placement

*Presenter: Jean-Yves Vet (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001098/Slides/HPE/08_Advanced_Placement.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-2_05_Advanced_Application_Placement.pdf`

-   Recording: `/appl/local/training/4day-20240423/recordings/2_05_Advanced_Application_Placement.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

!!! Remark
    The [`lumi-CPEtools` module](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-CPEtools/) 
    contains several tools mentioned in the presentation.

    Note that these commands also have various command line options that
    were not mentioned and show more information about the actual binding.


## Q&A

1.  Is the gpu direct RDMA supported on LUMI-G? And how to enable it?

    -   ` MPICH_GPU_SUPPORT_ENABLED=1` 

    -   It is also different than on NVIDIA platforms. On LUMI there is no equivalent to NVIDIA GPUdirect 
        needed as the GPUs are connected to the CPUs via InfinityFabric/xGMI, which is much more powerful than PCIe.

2.  What is the difference between `MPICH_GPU_SUPPORT_ENABLED` and `MPICH_GPU_SUPPORT`?

    -   This is a typo on the slide, both should mention `MPICH_GPU_SUPPORT_ENABLED`, this will be fixed.

3.  Is it possible to see that GPU-aware MPI is enabled from profiling?

    -   Yes, but note that LUMI design by default implies copies from GPU memory to the network. 
