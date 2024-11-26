# Building containers from Conda/pip environments

*Presenter*: Jørn Dietze (LUST)

Content:

-   Containers from conda/pip environments
-   Recipes for PyTorch, Tensorflow, and JAX/Flax on LUMI


<!--
<video src="https://462000265.lumidata.eu/ai-20241126/recordings/06_BuildingContainers.mp4" controls="controls"></video>
-->


## Extra materials

-   [Presentation slides](https://462000265.lumidata.eu/ai-20241126/files/LUMI-ai-20241126-06-Building_containers_from_conda_pip_environments.pdf)

-   [Hands-on exercises](E06_BuildingContainers.md)

<!--
-   ["Bonus materials" from the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-202411261/bonus_material)
    contains among other things the files used to generate the container used in the course with
    the `cotainr` tool.
-->

-   Further reading materials from the slides:

    -   [LUMI Docs containers page](https://docs.lumi-supercomputer.eu/software/containers/singularity/)

    -   [LUMI Docs installing Python packages page](https://docs.lumi-supercomputer.eu/software/installing/python/)

    -   [Cotainr conda env documentation](https://cotainr.readthedocs.io/en/latest/user_guide/conda_env.html)

    -   [Conda environment documentation](https://conda.io/projects/conda/en/latest/user-guide/tasks/manage-environments.html)

    -   [Pip requirements.txt file specification](https://pip.pypa.io/en/stable/reference/requirements-file-format/)

    -   [ROCm compatibility kernel / user space compatibility](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/reference/user-kernel-space-compat-matrix.html)

-   The [additional training materials mentioned in the "Running containers" page](extra_05_RunningContainers.md#extra-materials)
    are relevant for this presentation also.


<!--
## Remarks to things mentioned in the recording

### ROCm compatibility

The compatibility situation is actually even more complicated than explained in this presentation. The kernel driver for the GPUs depends on certain kernel versions. The kernel version depends on the version of the management interface of LUMI. So basically to do the upgrade to the 5.7 driver we need to update nearly everything on LUMI.

Furthermore, we need to ensure that MPI also works. GPU-aware MPI also depends on versions of ROCm and driver. So before updating to a new ROCm version we also need versions of the HPE Programming Environment compatible with those ROCm versions or all users of traditional HPC simulation codes would be very unhappy. That is also a factor stopping the update, as the version that supports recent enough ROCm version has also come out just a few weeks ago. And breaks a lot of currently installed software...


### Images in `/appl/local/containers/sif-images`

It is important to realise that the base images in `/appl/local/containers/sif-images` are symbolic links to the actual containers and they vary over time without warning. That may be a problem if you build on top of them, as all of a sudden things that you install on top of them may be incompatible with new packages in that container. So if you do that (topic of the next presentation) it is better to make a copy of the container and use that one.

EasyBuild actually gets its container images from `/appl/local/containers/easybuild-sif-images` which contains copies from the container images as they were when the corresponding EasyConfig was created so that an EasyConfig with a given name will always use the same module. This to improve reproducibility. E.g., some more recent containers did require changes to the module to simulate the effect of `$WITH_CONDA` by injecting environment variables in the container.

It is possible to extend an existing container with a virtual environment (topic of the next presentation) and automate that with EasyBuild, but it is complex enough that it might require help from someone with enough EasyBuild experience. An example is [this EasyConfig](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/PyTorch-2.2.0-rocm-5.6.1-python-3.10-singularity-exampleVenv-20240315/) but this is not something that an unexperienced user should try to create.


### What does the tool provided by `lumi-container-wrapper` do?

The `lumi-container-wrapper` provides a tool that enables to do some pip and conda installations in a file system friendly way. It also uses a base container but that one does not have a ROCm in it so it is of little use for AI software unless you can use the ROCm from the system. It basically does not change the base container, but installs the software in a separate SquashFS file. Furthermore, for each command it can find in the container, it will create a wrapper script outside the container that will call singularity with the right bindings to run that command in the container. It is actually rather hard to start the container "by hand" using the `singularity` command as you will also have to create the right bindmount for the SquashFS file containing the actual software installation.

The `cotainr` tool on the other hand will take the selected base image and build a new container from it that can be used the way containers are normally used.
-->


## Q&A

1.  In the LUMI stack there are python modules with e.g. numpy compiled against the Cray stack. Since when we build containers with cotainr we mainly use the `conda-forge` channel, is there a way to have the system libraries inside instead? Kind of like when we bring the system packages into a venv? Or would be the performance gain be negligible anyway?

    -   You'd have to build the Python packages that use those libraries explicitly to use the HPE Cray LibSci libraries, and then make sure that all packages that use, e.g., BLAS use that library, or you may get symbol conflicts when loading software.

        Cray LibSci isn't really superior to other good BLAS libraries. I'm not sure what conda-forge uses, but it is likely OpenBLAS and if that OpenBLAS library they use is compiled properly for multiple architectures, it is likely simply OK. -> Perfect! 
        
        For MPI, there is a high level of compatibility at the binary interface (called the ABI or Application Binary Interface) between different recent MPICH implementations, so there one can often swap out the MPI library - at least if it is MPICH-derived and not Open MPI - for the one on LUMI. There the advantage is significant as the standard libraries do not include proper support for SlingShot, though in some cases, an MPI library that supports libfabric can be told to use the libfabric from the system instead which is enough to get good performance except probably when GPU-aware MPI is required.
        
        For BLAS, the low-level linear algebra library on top of which many other libraries are built, there is no standardised binary interface and there using another library without recompiling is rarely possible. In principle, if the library that a binary uses (which will usually then be installed in the container) would be too bad, you can try to recompile a version of that library specifically for LUMI, but that would be advanced work.
        
        For GPU-accelerated programs, it is rather likely that all time critical work is done on the GPU and then it matters to get the communication right (so the RCCL plugin and/or MPI depending on what the software uses) while the linear algebra libraries come from ROCm anyway and contain a code path optimised for the MI250X.
        
    -   I have seen cases though where it would be nice if we could build on top of Cray Python and its numerical libraries, or build NumPy etc outselves, but that is then mainly if we also have to integrate other software that interfaces with Python through a shared library file rather than just an external executable that Python calls. We start seeing this with users who combine machine learning with traditional HPC. We're still exploring ways to build such containers on LUMI, as due to security reasons there are a lot of restrictions for building containers. It is definitely more advanced stuff than can be discussed in this course. There might be a market for an advanced on-line one-day course about building containers on LUMI... -> Sounds very interesting!
