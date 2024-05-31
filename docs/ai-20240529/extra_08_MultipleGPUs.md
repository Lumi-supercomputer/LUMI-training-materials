# Scaling to multiple GPUs

*Presenters:* Mats Sjöberg (CSC) and Lukas Prediger (CSC)

<video src="https://462000265.lumidata.eu/ai-20240529/recordings/08_MultipleGPUs.mp4" controls="controls">
</video>


## Extra materials

-   [Presentation slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-08-Scaling_multiple_GPUs.pdf)

-   [Hands-on exercises](E08_MultipleGPUs.md)


## Q&A

1. If I reserve one GCD and 14 CPU cores, will I only be billed for one GCD?

    -   No, you will be billed for 2 GCDs since your share of requested CPU cores corresponds to 14/56 = 1/4 of the node (2 CCDs out of 8). The same principle applies if you request more han 1/8 of the memory for a single GCD. More details on the [LUMI Docs billing policy page](https://docs.lumi-supercomputer.eu/runjobs/lumi_env/billing/#gpu-billing). 

        Basically the policy is that you get billed for everything that another user cannot use in a normal way because of the way you use the machine. So if you take a larger share of a particular resource (GCDs, CPU cores and CPU memory), that will be the basis on which you are billed as you can no longer fill up the node with other users who only ask a fair share of each resource.

2. If I use PyTorch DistributedDataParallel on LUMI, do I still need to specify NCCL and not RCCL as backend? (The slide says `torch.distributed.init_process_group(backend='nccl')`)
    - Yes, PyTorch uses the Nvidia terminology independently of whether you use AMD or Nvidia GPUs. If your PyTorch has been built against ROCm instead of CUDA, setting `torch.distributed.init_process_group(backend='nccl')` results in RCCL being used for communication.

    - The underlying reason is that AMD could not exactly copy CUDA because that is proprietary and protected technology. However, they could legally make a set of libraries where function calls have a different name but the same functionality. This is how HIP came to be. It mimics a large part of the CUDA functionality with functions that map one-to-one on CUDA functions to the extent that you can still compile your HIP code for NVIDIA GPUs by just adding a header file that converts those function names back to the CUDA ones. Similary, several libraries in the ROCm ecosystem just mimic NVIDIA libraries, and this is why PyTorch treats them the same.

3. In checking that we use all GPUs, do we primarily check the power oscillating around that recommended value ( 300-500 W) or psutil? Maybe I mix things...

    - I think the first step is to check the GPU utilization, the GPU% part. It should be higher than 0, and also the GPU memory allocated should be higher than zero. Then if those things are OK, check the power as well, as that's a better indication of it doing something useful as well.
