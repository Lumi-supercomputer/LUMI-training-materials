# Extreme-scale AI

*Presenters:* Samuel Antão (AMD)

Content:

-   Model parallelism on LUMI via FSDP or DeepSpeed
-   Scaling beyond a single node 


A video recording will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250204/recordings/09_ExtremeScale.mp4" controls="controls"></video>
-->


## Extra materials

More materials will become available during and shortly after the course

<!--
-   [Presentation slides](https://462000265.lumidata.eu/ai-20250204/files/LUMI-ai-20250204-09-Extreme_scale_AI.pdf)

-   [Demo and hands-on exercises](E09_ExtremeScale.md)
-->


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

/
