# Scaling AI training to multiple GPUs

*Presenters:* Mats Sjöberg (CSC) and Lukas Prediger (CSC)

Content:

-   PyTorch DDP on LUMI
-   Setting up the experiment as a SLURM batch job
-   Setting the correct CPU-GPU bindings


<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20250204/recordings/08_MultipleGPUs.mp4" controls="controls"></video>


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250204/files/LUMI-ai-20250204-08-Scaling_multiple_GPUs.pdf)

-   [Hands-on exercises](E08_MultipleGPUs.md)


## Q&A

1.  If I ask for one complete node and use “ddp”, how many maximum num_workers should I use ? should it still be num_workers == cpus-per-task=7

    -   I assume you mean the number of workers for the dataloaders. 
        These are "orthogonal" to the processes for the GPU. For each GPU, you will have one "main" process on the CPU, and torchrun will take care of running these for you. Each of those will then spawn the number of dataloader worker processes that you set up. These just handle preprocessing of data to be ready to be send to the GPU. Since the throughput of data at each GPU shouldn't change (much) compare to running with a single GPU, if you needed 7 dataloader processes (num_workers), it makes sense to keep it the same when running with multiple GPUs. However, in general, if you really want to find out just how many you need, you should try different values and see how that affects performance or profile you run. - Lukas

2.  Is there a 'cpus-per-gpu' variable?
    
    -   There is, but as I recall there was some issue with that in the SLURM setup on LUMI which results 
        in the GPUs not being able to communicate with each other when using `cpus-per-gpu`. So you don't want to use that. - Lukas
    
    -   This communication problem is actually explained in our 
        [regular introductory courses](https://lumi-supercomputer.github.io/intro-latest) in - I think - the Slurm or the binding presentation. The version of Slurm that we have on LUMI, tries to bind GPUs to tasks via a mechanism known as "control groups". Unfortunately, these control groups break the more efficient ways of communication between GPUs. There are several ways around it, but the way presented in the talk may be the better choice.
    
    -   In general, Slurm has a lot of parameters that don't always work completely the way you expect. 
        When reading the manual pages of `sbatch` and `srun`, really each word is important. Another common cause of the system refusing jobs is actually overspecifying resources and in that way, introducing conflicts. E.g., several parameters that try to bind CPUs and/or GPUs to tasks.

3.  Which container has lightning module? lightning handle this ddp automatically I guess. Can I install this in existing containers?

    -   You can check what is in a container with `pip list`, e.g., 
        ```
        singularity exec lumi-pytorch-rocm-5.7.3-python-3.12-pytorch-v2.2.2.sif bash -c '$WITH_CONDA; pip list'
        ```
        or even
        ```
        singularity exec lumi-pytorch-rocm-5.7.3-python-3.12-pytorch-v2.2.2.sif bash -c '$WITH_CONDA; pip list' | grep lightning
        ```
        And a nice one-liner:
        ```
        for siffile in $(/bin/ls /appl/local/containers/sif-images/lumi-pytorch-rocm-*.sif); \
            do echo -e "\n$siffile\n" ; \
            singularity exec $siffile bash -c '$WITH_CONDA; pip list' | grep lightning ; \
            done
        ```
        that will show you that almost all containers have it.

    -   And you can use the mechanism from the [last talk of yesterday (the virtual environment)](extra_07_VirtualEnvironments.md) 
        to add the package if it is missing in your otherwise favourite container. 

4.  What could cause this -> using DDP and multiple GPUs, increasing batch_size slows down the process?
    
    -   This should be expected, as the batch size represents the amount of data to process at each iteration. 
        Increasing the batch size results into more data to process, thus more time to finish one iteration.     

    -   But with multiple GPUs there likely is a sweet-spot for batch size. 
        If the batch is too small, then each GPU will spend most of the time waiting on 
        communication with other GPUs, so then you want to increase it a bit and can process 
        more data in the same time. But if the batch (per device) is too large, then you would 
        indeed expect to see that each iteration will take longer.

5.  How to set module paths in Jupyter notebooks? e.g. to test quickly something with the installed packages in a container in Jupyter notebook.

    -   I guess you cannot use Jupyter in LUMI web UI with a custom container, unless you make some kind of wrapper script. 
        If you have a virtual env or some Python packages installed on disk you can probably make them visible to Jupyter 
        by setting the right environment variables using the Advanced -> Custom init: Text option when launching Jupyter.

