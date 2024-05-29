# Building containers from Conda/pip environments

*Presenter*: Christian Schou Oxvig (LUST & DeiC)


## Extra materials

-   [Slides from the presentation](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-06-Building_containers_from_conda_pip_environments.pdf)

-   [Hands-on exercises](E06_BuildingContainers.md)

-   ["Bonus materials" from the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/bonus_material)
    contains among other things the files used to generate the container used in the course with
    the `cotainr` tool.


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


## Q&A

1.  About installing environments/packages: How about if I work in a jupyter notebook for exploration and testing of data and algorithms and need some quite specific packages? Can I also not install them in that case?

    -   (Lukas) For early testing, you can install additional packages in a virtual environment. The next session will cover this. Just keep in mind that this stresses the network filesystem, so it shouldn't become your default option for package installation.

    Alright thanks. I just need a good solution for trying out various networks, setting etc. before running a larger model. And there the notebooks are ideal!

    -   (Kurt) Actually there is a way to ensure that the virtual environment does not stress the file system (by then packing it in a SquashFS file and bindmounting that in the container) and some of the more recent EasyConfigs for PyTorch already install some scripts to make organising that easier as it is rather technical.

2.  Can you use SingularityCE definition files to build containers on LUMI? As explained here https://docs.sylabs.io/guides/latest/user-guide/build_a_container.html

    -   (Lukas): As far as I know, this often might not work, namely when the definition file performs any kind of installation step that would require superuser privileges on a normal system (e.g., installing software via one of the linux software/package managers), due to limitations in permissions/fakeroot on the system. It is usually easier to build these containers on your own system and then copy them to LUMI.

    -   (Kurt) Some things might actually work with the ["unprivileged `proot` build process"](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/bonus_material) of SingularityCE 3.11, but the documentation is very unclear what works and what doesn't. We have already used it to extend an existing container with additional SUSE packages using the `zypper` command. See [Demo 1 from the Amsterdam course earlier this month](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/Demo1/). But it is certainly not a solution that always works.

        We now have the `proot` command in the [`systools/23.09` module (LUMI Software Library page)](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/s/systools/) in the `CrayEnv` and `LUMI/23.09` stacks.

3.  Where will be the conda env files located inside the container when we're making it from environment.yml? I suppose it cannot  be `~/.conda` as the home directory by default is bind inside the container. 

    -   (Lukas): When using cotainr, the environment is installed to `/opt/conda/envs/conda_container_env/` inside the container.

4.  When I try to build my container in a LUMI-C node, I'm getting an error, which I surmise arises from a previous `salloc` command. Is there a way to avoid this, besides logging in/out?:

    ```
    srun: error: Unable to confirm allocation for job 7241252: Invalid job id specified
    srun: Check SLURM_JOB_ID environment variable. Expired or invalid job 7241252
    ```

    -   `salloc` actually starts a new shell session with the SLURM environmental paramters set. Just write `exit` to exit that one and you should be back in your original one. You can check whether `$SLURM_JOB_ID` is still set.

    `exit` worked, however the job had already expired, so i wouldn't have found a job id anyway. Thanks!

    -   That's exactly the problem the variable is not unset/deleted even though it is not valid any longer.

    -   The problem is partly also because Slurm commands communicate with one another via environment variables that can take precedence over command line options. So starting a new Slurm job in an existing one can transfer those environment variables to the new job and result in very strange error messages.


