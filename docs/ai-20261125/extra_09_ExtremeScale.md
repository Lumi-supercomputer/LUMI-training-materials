# Extreme-scale AI

*Presenters:* **Samuel Antão** and Paul Bauer (AMD)

Content:

-   Model parallelism on LUMI via FSDP or DeepSpeed
-   Scaling beyond a single node 


A video recording will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20261125/recordings/LUMI-ai-20261125-09_ExtremeScale.mp4" controls="controls"></video>
-->


## Extra materials

More materials will become available during and shortly after the course

<!--
-   [Presentation slides](https://462000265.lumidata.eu/ai-20261125/files/LUMI-ai-20261125-09-Extreme_scale_AI.pdf)

-   [Demo and hands-on exercises](E09_ExtremeScale.md)


## Links from the slides

-   [Advice on RCCL tuning](https://github.com/HewlettPackard/shs-ccl-docs/blob/main/rccl/rccl_tuning_guide.md)
    which may be important for stability at very large scale (slide 11, with more information on slide 12)

-   [PyTorch blog article on Fully Sharded Data Parallel API](https://pytorch.org/blog/introducing-pytorch-fully-sharded-data-parallel-api/)
  
-   [Enabling FSDP on transformer](https://huggingface.co/docs/transformers/index)
-->


<!--
## Remark: Why is binding not easier in Slurm?

There are some reasons why the situation with the binding is not better:

-   Slurm GPU binding is broken and uses by default a technique that breaks communication with RCCL and GPU-aware MPI,
    though there is a way to restore proper behaviour in Slurm after the January 2026 update.
    Unfortunately that then breaks other improvements that were made in assigning the ideal GPU for 
    the cores assigned in `small-g`.

-   In the past, changes have been suggested by other sites that could offer some improvement, but they are
    system-wide settings and would have a large (and undesirable) impact on LUMI-C also, 
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
