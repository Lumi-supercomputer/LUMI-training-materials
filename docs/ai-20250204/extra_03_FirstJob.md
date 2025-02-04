# Your first training job on LUMI

*Presenters:* Mats Sjöberg (CSC) and Lukas Prediger (CSC)

Content:

-   Using LUMI via the command line
-   Submitting and running AI training jobs using the batch system


<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20250204/recordings/03_FirstJob.mp4" controls="controls"></video>


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250204/files/LUMI-ai-20250204-03-First_AI_job.pdf)

-   [Hands-on exercises](E03_FirstJob.md)

-   [More extensive training materials on Slurm from the recent introductory "Supercomputing with LUMI" course from December 2024](../2day-20241210/index.md)

    -   A more detailed introduction to Slurm but without AI-specific examples is given in the 
        ["Slurm on LUMI" presentation](../2day-20241210/M07-Slurm.md).
        It also discusses the `sacct` command that can be used to get at least some resource use info
        from jobs.

    -   The presentation ["Process and Thread Distribution and Binding"](../2day-20241210/M08-Binding.md)
        is more oriented towards traditional HPC codes, but the discussion on a proper mapping
        of GPU dies onto CPU chiplets is also relevant for AI applications. But that is a discussion
        for the second day of this course/workshop.


## Q&A

1.  Is the container here serves as extra packages for the jobscript? (like an additional virtual env?) 

    -   The container contains the entire software stack needed for running the exercises (or your work), so in this case PyTorch, transformers and related libraries. In fact it also bundles the ROCm libraries and additional plugins for those to run efficiently across nodes. - Lukas

    -   This afternoon there are talks about how to install additional packages in a virtual environment.


2.  If a project has GPU allocation only, how can we work with that?

    -   The GPU allocation allows you to access nodes in the GPU partitions and you can use any resources there. So if you use CPUs on the GPU partitions, they are not billed towards CPU hour budget, so you don't need a separate allocation for these. - Lukas

    Thanks, how is that specified in the #SBATCH headers?

    -   If you request resources from one of the GPU partitions (standard-g, small-g, dev-g), you are charged GPU hours and you are using the GPU nodes. As said, the CPU resources on those nodes are not billed separately. You can  specify the number of cores (which are 'cpus' in slurm terminology) in the same way as for any slurm job (so using --cpus or --cpus-per-node, etc).


3.  Do we always need to use singularity containers? What happens if we just run our job with 'srun python main.py'?

    -   As was discussed now several times already, installing your python packages directly on the filesystem is really bad for it and will likely slow it down for you and everybody else. So we recommend to use containers. We will cover an easy way of creating these containers in one of the following lectures. - Lukas

    -   And we have even additional mechanisms that are not so well suited for AI; they are discussed in our regular introductory course, e.g., [this presentation](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20241210/M11-Containers/).

    -   There is no problem with really small Python installations (10s of files) that are also not run in bulk (many jobs, or parallel jobs.) But the typical AI "main.py" will import a lot of packages that import even more themselves and so on, and that simply kills the file system.

        There are things that are easy to scale to a big machine and things that are near impossible to scale. File system capacity is easy to scale. File system bandwidth is already harder. But scaling IOPS is near impossible on a large shared and distributed infrastructure unless you have huge budgets, and even then. Unless you find someone who can change the laws of physics, this is something you have to accept. Through the eyes of a computer, the speed of light corresponds to the long side of your smartphone per clock cycle, so you can see that a computer the size of a tennis court like LUMI cannot work as a big smartphone or big PC and has other restrictions. 


4.  To make sure that I understood it correctly, in 1 node we can get at most 8 gpus and per-gpu we can get at most 7 cpus, right?

    -    Yes, you can get 8 GPUs (4 GPUs with 2 GCDs each) and 56 cores (7 per GPU) per node.

    -    There are only 8 GCDs physically in a node, so that is a hard limit. There are only 56 user-available cores in a node, so that is also a hard physical limit. And there is only 480 GB RAM available to users, so that is also a hard limit. In principle you could ask for more than 7 cores per GPU or more than 60 GB of system RAM per GPU, but you will then be billed as if you are using more GCDs. In the extreme case, if you would request 1 GCD but 56 cores or all of the memory, noone else can use the node so obviously you will be billed for the whole node. You can essentially see the node as 8 slices with 1 GCD, 7 cores and 60 GB of memory and you're billed for the number of such slices that you use. So if you'd ask 1 GPU but 16 cores and 100 GB of memory, you really need 3 slices to get to the 16 cores and will be billed for 3 GCDs or 1.5 GPU effectively.

