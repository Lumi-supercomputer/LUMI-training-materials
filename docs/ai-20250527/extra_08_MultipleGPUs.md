# Scaling AI training to multiple GPUs

*Presenters:* Mats Sjöberg (CSC) and Oskar Taubert (CSC)

Content:

-   PyTorch DDP on LUMI
-   Setting up the experiment as a SLURM batch job
-   Setting the correct CPU-GPU bindings


A video recording will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250527/recordings/08_MultipleGPUs.mp4" controls="controls"></video>
-->


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-08-Scaling_multiple_GPUs.pdf)

-   [Hands-on exercises](E08_MultipleGPUs.md)

## Remarks from the audience

1.  Also, for DDP, if you are calculating some local variables (e.g. loss, KPIs, etc.) you may need to remember 
    that they are local to a rank and if you want to see the aggregate value across all ranks, 
    you need to gather these values at the end of a run/epoch to see the expected value. See the
    [PyTorch forum](https://discuss.pytorch.org/t/torch-ddp-multi-gpu-gives-low-accuracy-metric/189430/11). 


## Q&A

1.  What's the average utilization efficiency of LUMI-G? I.e. not how many nodes are booked, but how much (how efficiently by a user's program) an allocated GPU is utilized during a job.

    -   We cannot say this. We cannot break in user's jobs to check the efficiency. In fact, only profiling can tell you if a job is used efficiently, so only the user can check. And even then: You can have a very inefficient algorithm that uses the GPU very well, but that is still inefficient use of the machine. Also, what do you do with bandwidth-limited codes. Do you call them efficient? They will use all the memory bandwidth but not all compute power. (And it seems AI inference is a nice example of this if you look at the performance gains NVIDIA got between H100 and H200 where the only change was memory capacity and bandwidth.)

        Efficiency on LUMI is the responsibility of each user. And hopefully the finite allocations help to push users to pay attention to that. Resource Allocators should also check projects and amounts of resources requested to see if the user is capable of working efficiently. But on a machine the size of LUMI, with the broad audience of LUMI, and with industrial use also, you cannot have a support team baby-sitting all users to see if they are doing a good job. We can only offer the trainings so that users can at least get the necessary pieces of the puzzle to work efficiently. But we cannot offer a Research Software Engineer that would take you by the hand for every step of your work. We'd need 200 people for that rather than the 10 we have.


2.  Yesterday we spoke about the default ethernet link that a job can fallback to if you don't specify a right configuration. 
    I assume when using torchrun, you should also specify (seem to recall from the docs the ability to select the network interface) 
    the type interface to use (i.e. Infiniband).

    -   This is actually discussed in the next presentation, ["Extreme scale AI"](extra_09_ExtremeScale.md)].

    -   It was not well explained because you're not falling back to Ethernet but to regular TCP/IP communication protocols. 
        Later today you will see some environment variables that you need to set up the network. But it is really 
        just telling which network cards to use; PyTorch will use RCCL by default. On most ROCm versions you also 
        need to tell RCCL which protocol to use, but from ROCm 6.2 on the default is OK. And what was said yesterday, 
        is that RCCL needs to be able to find the plugin to talk to the libfabric library which provides the most 
        efficient communication. If that plugin is not found, TCP/IP will be used. 
        That is set up properly in all containers that we provide (both the ones made by AMD in 
        `/appl/local/containers/sif-mages` as the ones provided by CSC (after using `module load Local-CSC` or `module use /appl/local/csc/modulefiles`))

        The most interesting environment variables are:
        
        ```
        export NCCL_SOCKET_IFNAME=hsn0,hsn1,hsn2,hsn3
        export NCCL_NET_GDR_LEVEL=3
        ```
        
        The first one can be abbreviated to
        
        ```
        export NCCL_SOCKET_IFNAME=hsn
        ```
        
        on current versions of ROCm. The second one is not needed in the most recent versions of ROCm 
        (I believe from ROCm 6.2 on), but it does not harm to specify.
        
        In the CSC modules they are set by default, and we've started doing that also in the most recent 
        PyTorch modules (the 2.6 ones) that we provide via EasyBuild to align with the CSC-provided setups.
        
        By the way, you would also need to do set up the network interface also if LUMI would have had 
        NVIDIA GPUs but the Slingshot network.

 

3.  I tried to monitor the GPU activity with **rocm-smi**, but I got 

    ```
    cat: /sys/module/amdgpu/initstate: No such file or directory
    ERROR:root:Driver not initialized (amdgpu not found in modules)
    ```
    
    But it seems I got the job working correctly cause log did show 

    ```
    ...
    Rank 3 of 8 (local: 3) sees 8 devices
    Using GPU, device name: AMD Instinct MI250X
    Loading model and tokenizer
    Rank 7 of 8 (local: 7) sees 8 devices
    Using GPU, device name: AMD Instinct MI250X
    Loading model and tokenizer
    ...
    ```

    -   You were probably running `rocm-smi` on the login node instead of on the compute node instead of in an interactive shell on the compute nod.
        You need to open an interactive shell on the compute node that is running the job. 
        See, e.g., [the LUMI documentation](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/interactive/#using-srun-to-check-running-jobs) but even then it is tricky to get access to the GPUs.

        This was also discussed a bit in the 
        [presentation "Understanding GPU activity and checking jobs"](extra_04_CheckingGPU.md) and in the 
        next presentation, ["Extreme scale AI"](extra_09_ExtremeScale.md) (slide 14 in the latter).

