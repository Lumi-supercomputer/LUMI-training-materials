# Your first training job on LUMI

*Presenters:* **Mats Sjöberg (CSC)** and Marlon Tobaben (CSC)

Content:

-   Using LUMI via the command line
-   Submitting and running AI training jobs using the batch system

<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20260611/recordings/03_FirstJob.mp4" controls="controls"></video>


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-03-First_AI_job.pdf)

-   [Hands-on exercises](E03_FirstJob.md)

-   [More extensive training materials on Slurm from the recent introductory "Supercomputing with LUMI" course from April 2026](../2day-20260422/index.md)

    -   A more detailed introduction to Slurm but without AI-specific examples is given in the 
        ["Slurm on LUMI" presentation](../2day-20260422/M201-Slurm.md).
        It also discusses the `sacct` command that can be used to get at least some resource use info
        from jobs.

    -   The presentation ["Process and Thread Distribution and Binding"](../2day-20260422/M202-Binding.md)
        is more oriented towards traditional HPC codes, but the discussion on a proper mapping
        of GPU dies onto CPU chiplets is also relevant for AI applications. But that is a discussion
        for the second day of this course/workshop


## Q&A

1.  Is the `--mem-per-gpu` parameter required for the SLURM batch script? If you do not specify this, do you get all available memory for one gpu? 

    -   What you get depends on the partition. You should always specify how much RAM you need just to be safe. On `standard-g` you get all the memory, but on `small-g` you do not and may get much less than you expect. It is a fixed quantity independent of the amount of GPUs you ask. Another reason for a proper memory request is that it can protect you from getting a node where memory is taken by, e.g., a memory leak. We had that in the early years of LUMI.

2.  How to add log files parameters to the bash file ?

    - You can redirect output to a file by adding in your slurm script:

        - To redirect stdout: `#SBATCH  -o <name of output file>`

        - To redirect stderr: `#SBATCH -e <name of error output file>`


