# Your first training job on LUMI

*Presenters:* **Mats Sjöberg (CSC)** and Marlon Tobaben (CSC)

Content:

-   Using LUMI via the command line
-   Submitting and running AI training jobs using the batch system

<!-- A video recording will follow. -->

<video src="https://462000265.lumidata.eu/ai-20261125/recordings/LUMI-ai-20261125-03_FirstJob.mp4" controls="controls"></video>


## Extra materials

<!-- More materials will become available during and shortly after the course -->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20261125/files/LUMI-ai-20261125-03-First_AI_job.pdf)

-   [Hands-on exercises](E03_FirstJob.md)

-   [More extensive training materials on Slurm from the recent introductory "Supercomputing with LUMI" course from November 2026](../2day-20261109/index.md)

    -   A more detailed introduction to Slurm but without AI-specific examples is given in the 
        ["Slurm on LUMI" presentation](../2day-20261109/M201-Slurm.md).
        It also discusses the `sacct` command that can be used to get at least some resource use info
        from jobs.

    -   The presentation ["Process and Thread Distribution and Binding"](../2day-20261109/M202-Binding.md)
        is more oriented towards traditional HPC codes, but the discussion on a proper mapping
        of GPU dies onto CPU chiplets is also relevant for AI applications. But that is a discussion
        for the second day of this course/workshop


## Q&A


1.   What is the largest memory we can use in the mem-per-gpu ? 

    -   480 GB, but then you pay for all 8 GCDs in the node, so in practice 480/8=60 GB. See: 
        ["LUMI-G example batch scripts" in the LUMI documentation](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/lumig-job/)and ["Billing Policy" in the LUMI documentation](https://docs.lumi-supercomputer.eu/runjobs/lumi_env/billing/#gpu-nodes-lumi-g).

    -   The host memory matches roughly the GPU own memory, which is 64GB per GCD.


2.  If data preprocessing is computationally intensive, is it possible to perform the preprocessing on LUMI-C and then use the processed data for model training on LUMI-G? If so, what is the recommended workflow for managing data storage and coordinating the CPU and GPU jobs using Slurm?

    -   File system is shared across partitions (CPU and GPU) so it is possible to have pre-processing that uses the CPU partition generate data to be consumed by the GPU partition. Of course, your project needs to have CPU hours to use the CPU partition.

    -   You can always consider if there are GPU-accelerated pipelines to pre-process your data. E.g., [AMD rocAL](https://github.com/ROCm/rocAL) allows you to preprocess images in the GPU. GPUs can run other workloads other than plain training/inference.

3. If I need to train/test on a large dataset (hundreds/millions of images + txt + json files) that is local in my computer, where I can put my dataset?

    -   Ideally you would first convert to a file format that does not have millions of images like discussed  in [the file formats section of the LUMI AI guide](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/03-file-formats).

    -   Then you can [upload to LUMI-O](https://docs.lumi-supercomputer.eu/storage/lumio/).

    -   For training you can stage the data on scratch or stream from LUMI-O.

