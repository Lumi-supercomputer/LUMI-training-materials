# Your first training job on LUMI

*Presenters:* Mats Sjöberg (CSC) and Oskar Taubert (CSC)

Content:

-   Using LUMI via the command line
-   Submitting and running AI training jobs using the batch system

A video recording will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250527/recordings/03_FirstJob.mp4" controls="controls"></video>
-->


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-03-First_AI_job.pdf)

-   [Hands-on exercises](E03_FirstJob.md)

-   [More extensive training materials on Slurm from the recent introductory "Supercomputing with LUMI" course from March 2025](../2p3day-20250303/index.md)

    -   A more detailed introduction to Slurm but without AI-specific examples is given in the 
        ["Slurm on LUMI" presentation](../2p3day-20250303/M201-Slurm.md).
        It also discusses the `sacct` command that can be used to get at least some resource use info
        from jobs.

    -   The presentation ["Process and Thread Distribution and Binding"](../2p3day-20250303/M202-Binding.md)
        is more oriented towards traditional HPC codes, but the discussion on a proper mapping
        of GPU dies onto CPU chiplets is also relevant for AI applications. But that is a discussion
        for the second day of this course/workshop.


## Q&A

1.  Is there way to analyze memory usage afterwards, instead of using rocm-smi?

    -   CPU memory:
    
        -   While running, there is the `top` command. `htop` is also available in the `systools` module. This would show CPU memory usage. It requires of course opening another shell on the node, see also the LUMI documentation. 

        -   After the job, information on CPU-attached RAM use can also be found via the `sacct` command. It is discussed in more detail in the Slurm session in our regular intro course (where we have 90 minutes just to explain how jobs work): https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/201-Slurm/#the-sacct-command. This will only report RAM, the GPU RAM usage is not reported in SLURM.

    -   GPU memory
  
        -   PyTorch also reports on GPU memory use, so you may find this in your job output

        -   We have an easybuild recipe to install `nvtop`, but it hasn't been updated or tested for a while. And it is for during the job.
  
        -   But there is no way to analyse GPU memory usage afterwards unless you collected that data yourself during the run and stored it somewhere. Slurm will not give that information.

2.  On NVIDIA GPU, one can use NVTX or scalene-gui to profile GPU, which could be very helpful to address OOM issue. What is the best similar way to do it on AMD GPU?

    -   We have an [extensive 4-day or 5-day training](https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/) 
        covering profiling and debugging tools for AMD GPUs as an important part of the course:. It even includes a demo of over one hour where those tools are used to analyse performance of PyTorch. Part of the materials are available online, another part just on LUMI. Not sure if Samuel will mention those tools in his talks in this course.

        There is also more information in the presentation ["Understanding GPU activity & checking jobs"](extra_04_CheckingGPU.md)
        of this course.

3.  Seems like the there's no difference between /GPT-neo-IMDB-finetuning.py and /reference-solution/GPT-neo-IMDB-finetuning.py. I'm not sure how to add the continuation from checkpoint.

    - The differences are not in the python file but in the slurm job script `run.sh`

4.  Will you please repeat how often you should have checkpointing? and is it set up in the finetuning.py document?
 
    - Every couple of hours, depending how long you run. Do more checkpointings if unstable.

