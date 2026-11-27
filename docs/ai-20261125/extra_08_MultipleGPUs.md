# Scaling AI training to multiple GPUs

*Presenters:* **Mats Sjöberg (CSC)** and Marlon Tobaben (CSC)

Content:

-   PyTorch DDP on LUMI
-   Setting up the experiment as a SLURM batch job
-   Setting the correct CPU-GPU bindings


<!-- A video recording will follow. -->

<video src="https://462000265.lumidata.eu/ai-20261125/recordings/LUMI-ai-20261125-08_MultipleGPUs.mp4" controls="controls"></video>


## Extra materials

<!-- More materials will become available during and shortly after the course -->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20261125/files/LUMI-ai-20261125-08-Scaling_multiple_GPUs.pdf)

-   [Hands-on exercises](E08_MultipleGPUs.md)


## Q&A


1.  If I want 16 GPUs, how I request that with the parameters, e.g., `--gpus-per-node=8 --nodes=2`?

    -   Yes, see [LUMI AI Guide](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/blob/3f428088712f4425fd8df8acf2c0bb722c6e5df3/05-multi-gpu-and-node/run_ddp_torchrun_4.sh#L4-L5) for examples.


2.  Do I need standard-g to run in multiple nodes, e.g., can I use also small-g with similar settings with `--gpus-per-node=8`,  `--ntasks-per-node=8`?

    -   You can also use small-g but small-g only allows up to 4 nodes, see [LUMI Documentation on partitions](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/partitions/#slurm-partitions-allocatable-by-resources).

    -   It is likely a good idea to use standard-g for full node jobs as on small-g fractions of many nodes might be already used for jobs that only use less than one node


3.  Can we use deepspeed to run the python script, e.g., `deepspeed --master_port xxxx run.py`? 

    -   Yes, any framework could work. You just need to make sure that you are respecting the assumptions of the process launching logic that each framework use. E.g., does it expect to see all GPUs of the job, or all the GPUs of a given node.

    -   See also [LUMI AI Guide examples with DeepSpeed](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/05-multi-gpu-and-node)
