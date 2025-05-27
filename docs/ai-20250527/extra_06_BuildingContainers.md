# Building containers from Conda/pip environments

*Presenter*: Julius Roeder (DeIC)

Content:

-   Containers from conda/pip environments
-   Recipes for PyTorch, Tensorflow, and JAX/Flax on LUMI


A video recording will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250527/recordings/06_BuildingContainers.mp4" controls="controls"></video>
-->


## Extra materials

More materials will become available during and shortly after the course.

<!--
-   [Presentation slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-06-Building_containers_from_conda_pip_environments.pdf)

-   [Hands-on exercises](E06_BuildingContainers.md)

-   ["Bonus materials" from the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-202505271/bonus_material)
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
-->


<!--
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
-->


## Q&A

/
