# Your first training job on LUMI

*Presenters:* Mats Sjöberg (CSC) and Lukas Prediger (CSC)


## Extra materials

-   [Presentation slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-03-First_AI_job.pdf)

-   [Hands-on exercises](E03_FirstJob.md)

-   [More extensive training materials on Slurm from the recent introdctory "Supercomputing with LUMI" course from May 2024](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/)

    -   A more detailed introduction to Slurm but without AI-specific exemples is given in the 
        ["Slurm on LUMI" presentation](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/extra_06_Slurm/).
        It also discusses the `sacct` command that can be used to get at least some resource use info
        from jobs.

    -   The presentation ["Process and Thread Distribution and Binding"](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/extra_07_Binding/)
        is more oriented towards traditional HPC codes, but the discussion on a proper mapping
        of GPU dies onto CPU chiplets is also relevant for AI applications. But that is a discussion
        for the second day of this course/workshop.


## Q&A

1.  Why in --mem-per-gpu=60G it is 60 GB, not 64?

    -   Because the nodes have only 480 GB available per user of the 512 GB, so 1/8th of that is a fair use per GPU. Which gives 60 GB. Note that this is CPU memory and not GPU memory!

        It was actually explained later in the presentation, after this question was asked. 
   

2.  Does AMD have some alternative to nvidia ngc? Premade singularity images?

    -   AMD has a [ROCm dockerHub project](https://hub.docker.com/u/rocm) where the latests containers go, e.g. Pytorch.

    -   There is also [InfinityHub](https://www.amd.com/en/developer/resources/infinity-hub.html) but this contains possibly more datated versions, so I recommend using DockerHub for AI-related images.

    -   The other part of the equation here is that the publicly available containers do not (they can't because of license issues) the network related bits, so they are not ready to run efficiently accross nodes. For that, we recommend using the LUMI provided containers under `/appl/local/containers/sif-images`. The containers suggested for this training event are based on those. More details will be given in a later session today.

3.  When I use this command from the slides, it gives error & I am not sure which form should the compute_node take: 

    ```
    $ srun --overlap --pty --jobid=7240318 bash 
    @compute_node$ rocm-smi
    ``` 

    Gives `/usr/bin/bash: @compute_node$: No such file or directory.` Should the "@compute_node$" be 1, or @1$, or @1, or small-g, or @small-g$ etc.?

    -   If something ends on a `$` at the start of a line it is meant to refer to the command line prompt. And in this case this notation was used to denote a compute node command line prompt, showing the number of the compute node.

    -   So you should use `srun --overlap --pty --jobid=7240318 bash` to open a terminal on the same node that your job is running on, then use the `rocm-smi` command in that new terminal.
