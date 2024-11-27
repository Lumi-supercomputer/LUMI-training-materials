# Hands-on: Converting the PyTorch single GPU AI training job to use all GPUs in a single node via DDP

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-202411261/08_Scaling_to_multiple_GPUs).
-->
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/08_Scaling_to_multiple_GPUs).

<!--
<video src="https://462000265.lumidata.eu/ai-20241126/recordings/E08_MultipleGPUs.mp4" controls="controls"></video>
-->


## Q&A

1.  I'm not sure if this is the right section. I'm getting often following error when running job on small-g 4 out of 8 GPUs. 
    ```
    torch.distributed.DistBackendError: NCCL error in: 
      ../torch/csrc/distributed/c10d/ProcessGroupNCCL.cpp:1691, internal error, 
      NCCL version 2.16.5
    ncclInternalError: Internal check failed.
    Last error:
    Failed to find reverse path from remNode 0/c1000 nlinks 4 to node 0/d9000
    ``` 
    Any idea why? It happens randomly. Yes.. we use `export CUDA_VISIBLE_DEVICES=$ROCR_VISIBLE_DEVICES`

    -   How are you setting device visibility? If using ROCR_VISIBLE_DEVICES, try use HIP_VISIBLE_DEVICES instead.

    -   We have seen this error before but are not sure what's the reason for it. It is indeed not predictable and it only seems to happen on small-g and dev-g when reserving multiple GPUs but not the full node exclusively. We were suspecting it has to do with assumptions on CPU-GPU binding in PyTorch/NCCL that do not work well when partial nodes are reserved. But I guess the "good" thing about it's randomness is that you can re-run your job and then it probably works... -Lukas

