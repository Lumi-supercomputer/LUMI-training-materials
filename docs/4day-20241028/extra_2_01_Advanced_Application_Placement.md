# Advanced Placement

*Presenter: Jean-Yves Vet (HPE)*

<!--
Course materials will be provided during and after the course.
-->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001362/Slides/HPE/08_Advanced_Placement.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-2_01_Advanced_Application_Placement.pdf`

<!--
-   Recording: `/appl/local/training/4day-20241028/recordings/2_01_Advanced_Application_Placement.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).

!!! Remark
    The [`lumi-CPEtools` module](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-CPEtools/) 
    contains several tools mentioned in the presentation.

    Note that these commands also have various command line options that
    were not mentioned and show more information about the actual binding.


## Q&A

1.  In the slide with the `lscpu | grep -Ei "CPU\ "` we saw this distribution of NUMA nodes CPUs. What do the 4 last rows refer to? e.g. "NUMA node0 CPU(s): 0-15, 64-79"

    -    (alfio) these are the core ids, so node0 has cores with ids 0 to 15 and then 64 to 79 (hyperthread cores)
        
    Ah okay, so it does not have to do with the distance of those nodes between each other, right?

    -    No, the "relative" distance is the command `numactl -H`
`

2.  Does `--exclusive` flag make the available memory on each node be distributed equally among CPUs defined by `--cpus-per-node`? Or do we still need to set it via `--mem-per-cpu` or something like that?
    
    -   (alfio) exclusive is only to get the entire node, without sharing with other users.
 
    -   (Kurt) Defaults set by the sysadmins still apply, so you may want to use, e.g., '--mem=0' to get all CPU memory on the node, or even better, `--mem=224G` or `--mem=480G` for regular LUMI-C and LUMI-G nodes respectively as that would protect you from getting nodes where a system memory leak may have reduced the amount of memory available to a user.

        Memory is always a pool per node and not limited per task. This is in fact essential to make communication through shared memory possible and is also why `--gpu-bind` in Slurm does not work: It currently creates a so-called cgroup per GPU which makes memory-to-memory communication impossible.

3.  Why is `gpu_check` reporting Bus_ID dc? That's a PCI bridge, not a GPU (the GPU is de). Is it just a output issue in the `gpu_check` binary?

    -   (Kurt) I'd have to check the code to see how the Bus_id is determined. It is basically the code of the ORNL hello_jobstep program a bit reworked with some extra output (but the determination of the ID is taken from the hello_jobstep code if I remember correclty). This will be something to look into after the course. It is strange that it is only for this GPU, the other ones correspond to what I see in `lstopo`.

        Bug located, just a constant in the code with the wrong value. It will be fixed next week or the week after, at the next update of the software stack.
