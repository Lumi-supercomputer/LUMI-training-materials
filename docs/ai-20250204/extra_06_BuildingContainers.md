# Building containers from Conda/pip environments

*Presenter*: Jørn Dietze (LUST)

Content:

-   Containers from conda/pip environments
-   Recipes for PyTorch, Tensorflow, and JAX/Flax on LUMI


A video recording will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250204/recordings/06_BuildingContainers.mp4" controls="controls"></video>
-->


## Extra materials

More materials will become available during and shortly after the course

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250204/files/LUMI-ai-20250204-06-Building_containers_from_conda_pip_environments.pdf)

-   [Hands-on exercises](E06_BuildingContainers.md)

-   ["Bonus materials" from the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-202502041/bonus_material)
    contains among other things the files used to generate the container used in the course with
    the `cotainr` tool.

-   Further reading materials from the slides:

    -   [LUMI Docs containers page](https://docs.lumi-supercomputer.eu/software/containers/singularity/)

    -   [LUMI Docs installing Python packages page](https://docs.lumi-supercomputer.eu/software/installing/python/)

    -   [Cotainr conda env documentation](https://cotainr.readthedocs.io/en/latest/user_guide/conda_env.html)

    -   [Conda environment documentation](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)

    -   [Pip requirements.txt file specification](https://pip.pypa.io/en/stable/reference/requirements-file-format/)

    -   [ROCm compatibility kernel / user space compatibility](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/reference/user-kernel-space-compat-matrix.html)

-   The [additional training materials mentioned in the "Running containers" page](extra_05_RunningContainers.md#extra-materials)
    are relevant for this presentation also.


## Remarks to things mentioned in the recording

### ROCm compatibility

The compatibility situation is actually even more complicated than explained in this presentation. The kernel driver for the GPUs depends on certain kernel versions. The kernel version depends on the version of the management interface of LUMI. So basically to do the upgrade to the 5.7 driver we need to update nearly everything on LUMI.

Furthermore, we need to ensure that MPI also works. GPU-aware MPI also depends on versions of ROCm and driver. So before updating to a new ROCm version we also need versions of the HPE Programming Environment compatible with those ROCm versions or all users of traditional HPC simulation codes would be very unhappy. That is also a factor stopping the update, as the version that supports recent enough ROCm version has also come out just a few weeks ago. And breaks a lot of currently installed software...


### Images in `/appl/local/containers/sif-images`

It is important to realise that the base images in `/appl/local/containers/sif-images` are symbolic links to the actual containers and they vary over time without warning. That may be a problem if you build on top of them, as all of a sudden things that you install on top of them may be incompatible with new packages in that container. So if you do that (topic of the next presentation) it is better to make a copy of the container and use that one.

EasyBuild actually gets its container images from `/appl/local/containers/easybuild-sif-images` which contains copies from the container images as they were when the corresponding EasyConfig was created so that an EasyConfig with a given name will always use the same module. This to improve reproducibility. E.g., some more recent containers did require changes to the module to simulate the effect of `$WITH_CONDA` by injecting environment variables in the container.

It is possible to extend an existing container with a virtual environment (topic of the next presentation) and automate that with EasyBuild, but it is complex enough that it might require help from someone with enough EasyBuild experience. An example is [this EasyConfig](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/PyTorch-2.3.1-rocm-6.0.3-python-3.12-singularity-exampleVenv-20240923/) but this is not something that an unexperienced user should try to create.


### What does the tool provided by `lumi-container-wrapper` do?

The `lumi-container-wrapper` provides a tool that enables to do some pip and conda installations in a file system friendly way. It also uses a base container but that one does not have a ROCm in it so it is of little use for AI software unless you can use the ROCm from the system. It basically does not change the base container, but installs the software in a separate SquashFS file. Furthermore, for each command it can find in the container, it will create a wrapper script outside the container that will call singularity with the right bindings to run that command in the container. It is actually rather hard to start the container "by hand" using the `singularity` command as you will also have to create the right bindmount for the SquashFS file containing the actual software installation.

The `cotainr` tool on the other hand will take the selected base image and build a new container from it that can be used the way containers are normally used.


## Q&A

1.  When building pytorch with cotainr, how to include RCCL for multiple gpus?

    -   If you use the GPU system image as a base (so `cotainr --system=lumi-g ... `), ROCm with RCCL and the plugin that is needed for good performance, is in there.
    -   This answer is not clear - could someone clarify!!
        -   I edited the above, is it now clearer? - Lukas
        -   Do you need to bound it the rccl lib ?
        -   No. ROCm and RCCL are contained completely in the container, but some system libraries need to be bound for optimal performance. For that you can use the `singularity-AI-bindings` module that was shown in the previous lecture (or set up the same bindings as that does). So you can use that module also with your own cotainr-built containers. - Lukas
        -   In particular, RCCL interfaces via a plugin with the libfabric network library whiich in turn needs the "CXI" plugin and that component is crucial to get the full performance of the LUMI interconnect, but is still proprietary. So that is taken from the system.

2.  I am not use python (using julia, available also a docker image that singularity can use). I guess I can use self build containers which works well so far. But I am wondering what additional libraries need to be bind-mounted to make the best use of the available hardware. On some point there was the note that there is software not builded inside the container for license restriction. Can you also expand on this? (yes, julia can use the system MPI library)

    -   If you take a container that is not specifically prepared for LUMI, there is no guarantee you can even get it to run at optimal performance. For Julia, if it support MPICH then you should definitely bind the Cray MPICH libraries, but I don't know which version would be best as Julia is probably LLVM-compiled (as its own just-in-time compiler is LLVM-based). But it is impossible to give a precise list of libraries as that is different for different containers. E.g., the Cray MPICH libraries also need some other libraries. IF they are in the container in sufficiently recent versions, you don't need to bind them, otherwise you need to bind them to a system version. 

3.  Can the Cray MPICH copy data from one GPU directly to other GPUs? Is it "rocm-aware" ?

    -   Very much, but you have to be careful when linking I believe and certainly when running, and you need to enable it through an environment variable. Then there is another issue, one with Slurm, that can break the GPU-to-GPU communication. This is discussed in some detail in the regular intro course that Jorn mentioned, and in more detail in the advanced version. Instructions to enable GPU-aware MPI are also in the docs. See [this page in the docs](https://docs.lumi-supercomputer.eu/development/compiling/prgenv/#gpu-aware-mpi) and [this slide in the regular intro course](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20241210/02-CPE/#gpu-aware-mpi).

4.  Is Cotainr Lumi specific?

    -   No, it is developed by our Danish partner DeIC and open source. See [this site on readthedocs](https://cotainr.readthedocs.io/en/latest/) for the documentation.

5.  What would the difference between pytorch container built with cotainr and the singularity one?

    -   Possibly the place where the binaries come from, but I'd have to check the whole built process of our singularity container. The difference is more in some additional packages that are hand-compiled to interface well with the system libraries of LUMI rather than picked from Conda. This holds in particular for `mpi4py`. Not sure if you can even have one from Conda that would allow to replace the MPI library with the one from HPE Cray with proper network support. 

        For most AI software, this probably doesn't matter too much as it seems that MPI is not heavily used (and probably more used to initialise stuff and then switching to RCCL). But if you combine AI with simulation, this may matter as the simulation part will rely heavily on MPI use.
        
    - There are some packages that have troubles when installed via pip/conda, especially if they need to compile some binaries. E.g., flash-attention is one that has been problematic in the past, I believe, and hence container creation via cotainr might fail for these. Some of these are included in the manually build pytorch container. - Lukas
    
    - Also keep in mind that both are actually singularity containers, so to run them you use singularity. The difference is just in the tool used to build them. - Lukas

