# Hands-on: Advancing your own project and general Q&A

Bring your own AI code, you want to run on LUMI, and spent some time applying what 
you have learned during the workshop - with on-site support from LUST/AMD.


## Closing remarks

<video src="https://462000265.lumidata.eu/ai-20250204/recordings/E12_Conclusions.mp4" controls="controls"></video>


## Extra materials

-   [LUMI AI guide pronmoted in the closing words](https://github.com/Lumi-supercomputer/LUMI-AI-Guide)


## General Q&A

1.  Is there a prettier way to activate conda?
    Right now I am using `lumi-pytorch-rocm-6.2.3-python-3.12-pytorch-v2.5.1.sif`
    I need to activate conda to have access to the pytorch modules, so the current hack it to put this in my .sh file
    ```
    srun singularity exec $CONTAINER \
        bash -c "\$WITH_CONDA; python3 $PYTHON_FILE --max-samples=256"
    ```
    Is there a better/prettier way to activate conda so I don't have to put all arguments inside the quotes and the bash call?
    
    -   There is a trick and we use it in the EasyBuild modules that we provide for individual containers. The conda activate script just sets a number of environment variables so you can just set those from outside the container. The one tricky one, but one that is not really needed, is to adapt the prompt to show that you're in the virtual environment. 

        It has been a continuous discussion in LUST whether we should expose the container as much as possible as a container, and the singularity-AI-bindings module combined with the manual `$WITH_CONDA` is a result of that, or try to hide as much of the complexity as we can, which is what we do with the individual modules for each container. In fact, what `$WITH_CONDA` does, is not the same for all containers (if only because the name of the conda environment is not always the same), so that cannot be done in a module as generic as `singularity-AI-bindings`. 
        
        Those EasyBuild modules are not perfect and not all modules implement all functionality, basically because our time is also finite and we don't want to invest time in things that we don't know will be used. But we're always open to further develop them on request.

        With some of the newer PyTorch EasyBuild containers, your command would become 
        
        ```
        srun singularity exec $CONTAINER \
            python3 $PYTHON_FILE --max-samples=256"
        ```

2.  For my machine learning model, I need to use the mpi4py library. 
    What is the best way to install mpi4py on LUMI? 
    I tried following the instructions from the slides, but it does not seem to be working for me.
    
    -   Installing `mpi4py` requires a compilation step of C compilation, which appears to fail because it doesn't find the proper compilers in the containers. There is a base container available that already includes `mpi4py` in `/appl/local/containers/sif-images/lumi-mpi4py-rocm-6.2.0-python-3.12-mpi4py-3.1.6.sif` . Could you try extended that for your needs? If you use `cotainr build` you can replace the `--system=lumi-g` flag with `--base-image=/appl/local/containers/sif-images/lumi-mpi4py-rocm-6.2.0-python-3.12-mpi4py-3.1.6.sif`. - Lukas
    
    -   Nevermind, the mpi4py container doesn't actually work with cotainr :( - Lukas

4.  Can you provide an example command please to monitor the GPU utilization for multi-node runs?

    -   You can do the following: Check from `squeue --me` which nodes the job is running on 
        (the node ids are listed in the last column). The you can use the command 
        `srun --overlap --jobid <jobid> -w <nodeid> rocm-smi` to run `rocm-smi` on 
        any of the nodes to check utilisation. Note that this will give you only an instantaneous 
        snapshot of the `rocm-smi` output. You can use 
        `srun --overlap --jobid <jobid> -w <nodeid> --pty bash` to open a terminal on the node and use 
        `watch rocm-smi` to continuously monitor the GPU usage. Unfortunately there is no handy tool to monitor GPU utilization across all nodes at once. See also 
        [this page in the LUMI documentation](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/interactive/#using-srun-to-check-running-jobs). - Lukas

