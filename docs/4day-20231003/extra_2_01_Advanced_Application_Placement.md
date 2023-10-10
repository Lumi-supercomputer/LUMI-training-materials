# Advanced Placement

*Presenter: Jean Pourroy (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465000644/Slides/HPE/07_Advanced_Placement.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-2_01_Advanced_Application_Placement.pdf`

-   Recording: `/appl/local/training/4day-20231003/recordings/2_01_Advanced_Application_Placement.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

!!! Remark
    The [`lumi-CPEtools` module](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-CPEtools/) 
    (in the LUMI software stacks, see this afternoon) contains alternatives for `xthi` and the `hello_jobstep` tool.

    This module also contains the `gpu_check` command which was mentioned in the presentation.
    

## Q&A

1.  Can you explain NUMA domain shortly?

    -   NUMA stands for _Non-Uniform Memory Access_, at a high level it means that when you do a memory operation some memory is "closer" to a processor than other menory.
    -   It was in the first presentation yesterday, so you can check back the recordings once they are available. Basically some memory is closer to some chiplets of the AMD processor than to others. On any machine, each socket is a NUMA domain as the communication between two sockets is bandwidth limited and adds a lot of latency to the memory access (x3.2). But on AMD internally one socket can also be subdivided in 4 NUMA domains, but there the latency difference is only 20%. 


2.  How do I see from command line in which NUMA domain my GPUs are?

    -    Future slides will cover this
    -   `lstopo` is a command that can give such information. But it may be easier to work with the tables in the documentation, and once you start running we have a program in the the [`lumi-CPEtools`](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-CPEtools/) module that shows you information about the binding of each MPI task. It is a very similar program to one that will be mentioned later in this lecture. You really have to look at the PCIe address as both the ROCm runtime and so-called Linux control groups can cause renumbering of the GPUs.
    -   `rocm-smi` command also has option (`--showtopo`) to show which NUMA domain GPU is attached to.


3.  Where is the `gpu_check` tool? In perftools?

    -   It is in [lumi-CPEtools](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-CPEtools/)


4.  So, if we check SLURM_LOCALID in our application and assign the GPU based on that (using the given mapping), we should have good binding?

    -   Yes. But only if you use exclusive nodes (so nodes in `standard-g` or full nodes in `small-g` with `--exclusive`) as doing binding requires full control over all resources in the node. So if your application is very sensitive to communication between CPU and GPU you have to use full nodes and if your application cannot use all GPUS, try to start with srun multiple copies of your application with different input on the same node.











1. So, just to confirm: was using `--gpu-bind` ok or not?

    -    Not OK if you want the tasks that `srun` starts to communicate with each other. It causes GPU-aware MPI to fail as it can no longer do GPU memory to GPU memory copy for intra-node communication between tasks.

2. Can we take advantage of GPU binding if using one GPU only?

    -   Only if you allocate a whole node and then start 8 of those tasks by playing a bit with `srun` and some scripts to start your application (e.g., use one srun to start 8 of those tasks via a script that does not only set `ROCR_VISIBLE_DEVICES` but also directs the copy of the application to the right input files). It is also possible to play with multiple `srun` commands running in the background but at several times in the past we have had problems with that on LUMI. We cannot always guarantee a good mapping on `small-g` between the cores that you get allocated and the GPU that you get allocated. So if you have a lot of CPU-to-GPU communication going on you may notice large variations in performance between jobs on `small-g`. 


