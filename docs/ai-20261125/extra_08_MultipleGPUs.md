# Scaling AI training to multiple GPUs

*Presenters:* **Mats Sjöberg (CSC)** and Marlon Tobaben (CSC)

Content:

-   PyTorch DDP on LUMI
-   Setting up the experiment as a SLURM batch job
-   Setting the correct CPU-GPU bindings


<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20260611/recordings/08_MultipleGPUs.mp4" controls="controls"></video>


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-08-Scaling_multiple_GPUs.pdf)

-   [Hands-on exercises](E08_MultipleGPUs.md)


## Q&A

1.  Should I always use the minimal number of nodes or is it better to spread my processes across multiple nodes

    -   Always use the minimal number of nodes, and if your job is suitable to fill an entire number of nodes, use standard-g and exclusive nodes. Splitting on small-g over more nodes

        -   Makes it impossible to do proper binding which is important for performance and will follow in the training

        -   As the nodes than become a shared resource with other users, what they do can influence your job and performance that you observe. E.g., even though you're not sharing a GPU, you're sharing CPU memory bandwidth and sharing the connections to the GPU and between the GPUs, so transfers between CPU and GPU or between GPUs if you use multiple GPUs, become less predictable.


2.  Does `SLURM_LOCALID` always start from 0?

    -   Yes, it does. This is a numbering per node and always starts from 0 by definition, independent of which cores or which GPUs you get. It is not even configurable.

        `SLURM_PROCID` also always starts from 0 but is a global numbering.
        
        This course only gives a brief introduction to Slurm and to bindings. In the [regular LUMI intro course](https://lumi-supercomputer.github.io/intro-latest) a half day is spent on Slurm and using parallelism (but the latter part is more HPC-oriented).
        
    -   With `srun` you can influence which GPU and which CPU cores each task gets, but again this is discussed more extensively in the [regular LUMI intro course](https://lumi-supercomputer.github.io/intro-latest). In AI software you often have to use other mechanisms and do parts of that assignment in the Python code but that comes later in this course.


3.  Hi, I have a question about PyTorch DDP on LUMI.

    Is it correct that PyTorch DDP itself is usually not the main compatibility problem, provided that we use the official LUMI/ROCm-compatible PyTorch containers, but that the main risk comes from extra CUDA/NVIDIA-specific dependencies?

    For example, in graph-learning projects using packages such as PyTorch Geometric, torch-scatter, torch-sparse, or other custom kernel libraries, what is the recommended way to check whether these dependencies are compatible with LUMI’s AMD GPU/ROCm environment?

    Should we start from the official LUMI ROCm PyTorch containers and then only add packages with confirmed ROCm/HIP support, or is there a recommended workflow/container strategy for building safe environments for multi-GPU DDP training with graph-learning dependencies?
    
    -   PyTorch DDP works perfectly fine on LUMI, the main problems would indeed be additional packages not 100% supporting AMD GPUs. The approach you suggest, starting with the official LUMI PyTorch and adding things on top of that is indeed the recommended way.
 
    -   As for PyTorch geometric in particular, I think AMD support is a bit lacking or unclear, but my colleagues can fill in here.
 
    -   I can find a community repo stating that PyG is working in ROCm 7: https://github.com/Looong01/pyg-rocm-build/tree/main/pytorch_geometric-2.7.0. ROCm 7 is compatible with the current LUMI driver - this pages has a compatibility matrix: https://rocm.docs.amd.com/en/latest/compatibility/compatibility-matrix.html. Having said that, I've come accross project leveraging ROCm 7.2 - so this may work but not part of the official support matrix.

    -   Separate from packages not supporting ROCm and being only available for LUMI, the other compatibility problem is the network. ROCm RCCL needs a specific plugin to talk to the Slingshot interconnect. If that plugin is not present, then it will fall back to a much slower communication mode. This is not an issue with the Cray EX architecture alone, but also happens with some other network cards, and the plugin that is needed for RCCL was actually originally developed by AWS for their network cards in their cloud infrastructure. This is why you cannot simply download a container from AMD and use it on LUMI and why we've always had containers specific for LUMI. This is also one of the reasons why in the cotainr presentation, the presenter started from LAIF containers as they contain that plugin. In case you would be using something that requires MPI (which is less common in AI), you also need an MPI implementation that works via a library called libfabric, and that library should be configured with the CXI (or somtimes called Cassini) plugin to talk to the Slingshot network at optimal speeds. And if it is done with mpi4py, you need an mpi4py wheel that can actually talk to the proper MPI library with proper Slingshot network support, again something that is done in the mpi4py module in some of the LAIF containers (but there is no Python support yet in the `-mpich-` containers).

    -   To add something here: Happy to hear suggestions for packages to [the LAIF container recipes](https://github.com/lumi-ai-factory/laifs-container-recipes) or via a normal LUMI User Support ticket that can be then redirected to the LUMI AI Factory colleagues.

