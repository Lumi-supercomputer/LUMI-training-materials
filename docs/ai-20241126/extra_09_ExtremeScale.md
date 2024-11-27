# Extreme-scale AI

*Presenters:* Samuel Antão (AMD)

Content:

-   Model parallelism on LUMI via FSDP or DeepSpeed
-   Scaling beyond a single node 


<video src="https://462000265.lumidata.eu/ai-20241126/recordings/09_ExtremeScale.mp4" controls="controls"></video>


## Extra materials

-   [Presentation slides](https://462000265.lumidata.eu/ai-20241126/files/LUMI-ai-20241126-09-Extreme_scale_AI.pdf)

-   [Demo and hands-on exercises](E09_ExtremeScale.md)


<!--
## Remark: Why is binding not easier in Slurm?

There are some reasons why the situation with the binding is not better:

-   Slurm GPU binding is broken and uses a technique that breaks communication with RCCL and GPU-aware MPI

-   One change that would offer some improvement is system-wide and would have a large impact on LUMI-C also, 
    necessitating retraining all users and probably making some use scenarios on that partition difficult.

-   It is not easy either because you can only do something with few environment variables or a pre-made script 
    if every user would nicely request 7 cores per GPU requested. On `small-g` you now basically have a lot of 
    fragmentation. I'm not sure if "CPU" could be redefined in Slurm to mean "1 CCD" but that might very well 
    be the change that sysadmins told me would also be in effect on LUMI-C where it would not be appreciated by 
    users.

-   And as we say in another course: "Slurm is not a good scheduler, but we don't have a better one yet".
    Current HPC schedulers were designed in the days that nodes had just one or 2 CPU cores and no accelerators
    and they don't sufficiently understand the hierarchy in resources and proximity between various components.

-   Preset are not easy. What may be ideal for some AI workflows may not work for others, or may not work for all
    the other users on LUMI that do simulation or other types of data processing and analysis.
-->

## Q&A

1.  Do you have experience of setting cpu affinity for Pytorch Lightning? Is it automatically taken care of?

    -   I don't have experience with Lightning in particular, but I'm pretty sure it doesn't work automatically as the specific setup differs from system to system and there's no easy way to automatically detect it.


2.  Is it possible to set CPU affinity without using `numactl`, and directly via SLURM? I had some scripts that used `datasets` and `accelerate` that were only able to use the psysical cores (0 to n/2, where n is the number of threads shown in htop), unless we would launch the script via `numactl --cpunodebind 0-3 --membind 0-3`. The same would also apply on LUMI-C with NUMA nodes 0-7.

    - Slurm has various options to set the affinity per task. Note that Linux exposes 2x the number of cpus as you have cores because each core supports two hardware threads. It is normally not advantageous to use the high numbered 'cpu's (the second thread per core). There is a talk on this topic in the 4-day LUMI comprehensive course but it is mostly written for people running MPI and MPI/OpenMP HPC applications.

    - And there is also material in [this presentation from the last 2-day course](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/extra_07_Binding/), slide 11 and following (though you may need to go to the slids before that also to understand), and recording from 22:20 on.

    - The second hyperthread on LUMI is by default unavailable to applications started with `srun` as the option `--hint=nomultithread` is set by default. If you want access to them, you need to specify `--hint=multithread`, which you can already do in an `#SBATCH` line. Slurm uses control groups at the job level, i.e., if only part of a node is allocated to a job, this will be done with a cgroup on each node, and uses CPU affinity at the task level.

