# Cotainr on LUMI (September 27, 2023)

*Presenters:* Christian Schou Oxvig (LUST & DeiC)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20230927-user-coffee-break-cotainr.mp4" controls="controls">
</video>

Materials:

-   Cotainr: tool to build Singularity/Apptainer containers for certain use cases especially conda and pip. 
    [Tool website](https://github.com/DeiC-HPC/cotainr)

-   [`cotainr` in the LUMI docs](https://docs.lumi-supercomputer.eu/software/containers/singularity/#building-containers-using-the-cotainr-tool)

<!--
-   [Slides (PDF)](https://462000265.lumidata.eu/user-coffee-breaks/files/20230927-user-coffee-break-cotainr.pdf)
-->

## Q&A

[Full archive of all LUMI Coffee Break questions](https://hackmd.io/@lust/coffeearchive#). This page only shows the 
cotainr-related questions.


1.  **Q:** Is it recommended/possible to use multiprecision in my tensorflow models during training?

    **Answer:** That's a question to ask to a Tensorflow specialist. It requires domain knowledge to answer. We are a small team and can impossibly have expertise in all applications and how they behave on LUMI.
    
    However, the AMD GPUs are relatively strong in FP32 and very strong in FP64 but not so strong in lower precision formats so it may not pay off as much as you would expect from some other GPUs.
    
    **Comment on the answer**: it is also a question on GPU type, with NVIDIA, the command: `tf.keras.mixed_precision.set_global_policy("mixed_float16")` works transparently (and I am not specialist neither)
    
   
2.  **Q:** For containr, where is the image stored (on which quota does it go)?
  
    **Answer:** That depends on where you install it. We recommend that the image is stored in your project folder. The image will only be a single file.
    
3.  **Q:** For my conda installation on LUMI, I followed the instructions provided on the [LUMI container wrapper](https://docs.lumi-supercomputer.eu/software/installing/container-wrapper/) doc page, unlike containr build mentioned today. Seems like it did build on the file system. So should I do it again differently?
    The commands I used were:
    ```
    $ module load LUMI
    $ module load lumi-container-wrapper
    $ mkdir MyEnv
    $ conda-containerize new --prefix MyEnv env.yaml
    $ which python
    {my project path}/MyEnv/bin/python
    ```
    
    **Answer:** It does put some things on the file system like wrapper scripts but the main installation is done in a SquashFS file that will be among those files. But the container wrapper does, e.g., create wrapper scripts for everything in the bin directory in the container so that you don't need to use singularity commands to start something in the container.

    **Comment**: You can use cotainr as an alternative to the LUMI container wrapper. Please take a look at the LUMI docs page [Installing Python Packages](https://docs.lumi-supercomputer.eu/software/installing/python/) for more details about the differences.
    
5.  **Q:** Does the `--system` option installs ROCM GPU optimized BLAS/LAPACK releases when selecting lumi-g ? 

    **Answer:** The system flag defines a base image for your container. For LUMI-G it will include the full ROCm stack. You can use `--base-image`, if you want to specify your own base image. 

6. **Q:** Is there a command similar to `--post-install` for cotainr that is present in the lumi-container-wrapper? 
    - The `--post-install` command allows commands to be executed inside the container after creating the squashfs file.
    - `--post-install` is not available in containr and for best practice you should re-build the container with the python file. 

7.  **Q:** Being new to containers in general, is it possible to have my "core" image built with containr, and when running it, pip install new packages to use in the container for one certain project? Thank you.

    **Answer** Containers are read-only once created so `pip install` would do an installation outside the container in the default Python installation directories.
    
8. **Q:** I use conda env for the ML part of my code but I have also Cray compilers and tools to use with this. What are your suggestions for such mixed requirements ? 

    **Answer** I don't think there is a generic answer to that. The problem is that if you start to mix software compiled with different compilers, you can have conflicts between run-time libraries of compilers. Ideally you'd use the same compilers as those ML parts were built with, but that's something that you don't always know... Unfortunately compiling our own PyTorch and Tensorflow to ensure compatibility is outside what LUST can do given the size of the team, and is something that AMD advised us not to do as it is very difficult to get it right.

9.  **Q:** As an addition to the question about post-install: Singularity has the option to make a "sandbox" image, so that you are able to install linux packages in the shell after creation. Wouldn't this be an easy addition, that doesn't make it too complicated for the basic user? A `--sandbox` option.

    **Answer** Cotainr actually exploits sandbox to build the container. But it is not a good practice to build containers and then extend them afterwards as you may loose reproducibility as you don't have a definition file anymore that covers the whole container.

10. **Q:** Does cotainr works also with pipenv?

    **Answer** Currently only Conda is supported, but the documentation does show a way to add pip packages to the environment.

11. **Q:** I am running an R code on LUMI-C using the small partition. How can I efficiently allocate a whole node in order to cut billing units?. Are there any specific commands to adjust the minimum number of GB per core to be allocated?

    **Answer** It is possible to allocate a full node in the small partition by using the `#SBATCH --exclusive` flag in SLURM, but you might as well run in the standard partition as well, which allocated a full node by default. Same with memory: there are flags to specify the amount of memory per core, per rank, per GPU etc in SLURM (please see the sbatch man page).

12. **Q:** Is it easy to add something like "module load" in the cotainr build script, to start with a known group of packages?

    **Answer** That doesn't make much sense in the spirit of containers as containers try to offer a self-contained environment. The primary use of modules is to support multiple versions of one package which is not of use in containers.
    
    Packages also are not taken from the system, but currently from the Conda repositories and for containers in general from different software repositories.
    

13. **Q:** Does the LUMI container image include Cray compiler ? And if yes could, this container by use on our PC ?

    **Answer** The Cray compiler is NOT public domain but licensed software so you cannot use it outside of LUMI or other systems that have a license for it. There actually exists a containerised version of the PE but it is given only to users who have signed heavy legal documents in a specific project.
    
    So the Cray compiler is also not contained in the base images of cotainr and never will unless HPE would open source the PE which they will not do anytime soon as it is one of the selling points for their systems.

14. **Q:** With a singularity container built with cotainer based on a conda env, is it possible to add packages to the environment after the container is built?

    **Answer** Please see the answers above.

15. **Q:** So is there container with gnu/llvm +rocm for building fortran code for LUMI in our PC ?

    **Answer** Why not simply install the gnu compilers or ROCm + LLVM (the AMD compilers are LLVM-based) on your PC? ROCm in a container would still need an AMD GPU and driver installed in the PC if you want to test the software also and not only compile. In fact, not even all compiles would work as software installation scripts sometimes need the GPU to be present as they try to automatically check the type etc.

    **Comment** The point was to have a good starting point, that User Support have already tested .
    
    **Reply** Testing is not absolute anyway as a container still depends on the underlying hardware, OS kernel and drivers. It is a misconception that containers are fully portable. And having the software in a container can make development harder as you will always be mixing things in the container with things outside it.
    
    Moreover, we don't have the resources to test such things thoroughly. It is already not possible to thoroughly test everything that runs on the system, let alone that we can test if things would also work on other systems.

16. **Q:** Has cotainr images access to all lustre filesystems?
    
    **Answer** Yes, but you need to do the binding as explained in [our singularity documentation](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/container-jobs/#binding-network-file-systems-in-the-container).



