# Understanding GPU activity & checking jobs

*Presenter:* Marius Kurz, Samuel Antão (AMD)

Content:

-   Checking jobs with rocm-smi
-   Setting environment variables for ROCm/AMD debug info
-   Simple profiling using rocprof


<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20251008/recordings/04_CheckingGPU.mp4" controls="controls"></video>


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-04-Understanding_GPU_activity.pdf)

-   [Hands-on exercises](E04_CheckingGPU.md)


## Q&A

1.  There is a mistake on slide 3? I think the bandwidth per link is 50 GB/s per direction 
    (but 25 GT/s but these transactions are 2 bytes wide), which indeed results in 400 GB/s bidirectional bandwidth.

    -    Yes, it should be 25 GT/s (transactions). We will fix it.

2.  Does either activating logs, or using one of these profilers add a substantial overhead?

    -   Profilers and logging always add a bit of overhead. It is hard to quantify the overhead but 
        that is connected with the amount of activity you want to capture. Also, the system and I/O load matters.

    -   Typically, profiling overhead should be in the order of a few percent - say 2-5% - and 
        hopefully won't preclude drawing conclusions out of your profile. 

4.  A tool to sample driver information - including power - is AMDSMI: https://github.com/ROCm/amdsmi

    -   It does have a python interface and is typically installed with pytorch. That is part of the LUMI containers already.

    -   I (Mats, CSC) also made a [simple program that samples the energy counters](https://docs.csc.fi/support/tutorials/gpu-ml/#gpu-energy-tool-lumi)
        (via that same AMDSMI API), meant to be ran at start and end of job, 
        as an alternative way of getting the same info...

5.  The sample command `srun singularity ...` don't work now, since it tries to download the model in the project folder. I get this warning and it exits:
    ```
    Loading model and tokenizer
    /opt/miniconda3/envs/pytorch/lib/python3.12/site-packages/huggingface_hub/file_download.py:752: UserWarning: Not enough free disk space to download the file. The expected file size is: 0.80 MB. The target location /workdir/hf-cache/hub/models--EleutherAI--gpt-neo-1.3B/blobs only has 0.00 MB free disk space.
    ...

    ```

    -   Looks like you haven't set `HF_HOME` environment variable as it tries to write to `/workdir` 
        rather than `/scratch`. (`/workdir` I think is a path inside the container which is read-only, 
        and thus cannot be written to)
    
    That was what the [official instructions](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20251009/04_Understanding_GPU_activity_and_checking_jobs#2-spin-training-work) said. 
    Now I changed it to `HF_HOME=/flash/project_465002178/hf-cache` and it seems to go ahead. Thanks.
    
    -   Actually I was mistaken, `/workdir` should work as well, but you need to bind it to some appropriate 
        place with `-B .:/workdir` ... but changing it to `/flash` or `/scratch` like you did works as well 
    
       That `-B` flag makes a path on LUMI show up as being under `/workdir` _inside the container_.

