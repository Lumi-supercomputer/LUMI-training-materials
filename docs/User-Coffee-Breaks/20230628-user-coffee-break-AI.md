# Current state of running AI workloads on LUMI (June 28, 2023)

*Presenters:* Christian Schou Oxvig and René Løwe Jacobsen (LUST & DeiC)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20230628-user-coffee-break-AI.mp4" controls="controls">
</video>

-   [Slides (PDF)](https://462000265.lumidata.eu/user-coffee-breaks/files/20230628-user-coffee-break-AI.pdf)


## Q&A

[Full archive of all LUMI Coffee Break questions](https://hackmd.io/@lust/coffeearchive#2023-06-28-1300-–-1345-CEST). This page only shows the 
AI-related questions.

1.  **Q:** On this page https://github.com/Lumi-supercomputer/ml-examples/tree/main/tensorflow/hvd, options for installing Horovod are described. 
    The first one uses cray-python and tensorflow-rocm from pip. But it does not explain what module is necessary to load for Horovod to function, despite that the environment is without a running mpirun executable (GPU-aware), required by Horovod. If OpenMPI is loaded first, the horovod package will not compile with NCCL support. Knowing what other packages than cray-python (and OpenMPI?) are necessary when installing horovod with pip and not a docker, would be helpful.

    **Answer:**

    -   Please, notice that that’s not lumi’s official documentation.

    -   The idea there is to install horovod within the container. That’s why it doesn’t need any system modules loaded. 
        The image already has a horovod installation, but somehow it doesn’t work for us. We are only replacing it.

        OpenMPI is used only as a launcher while all the communication is done via rccl.

        Nevertherless, since you are having issues with those instructions, we will have a look to see if anything needs to be changed. We should probably update it to the latest image.

2.  **Q:** On the same page, [this script](https://github.com/Lumi-supercomputer/ml-examples/blob/main/tensorflow/hvd/run.sh) 
    loads many modueles and sets environment variables. But they are not explained, which makes it difficult to experiment with new dockers. Likewise, it is not explained why some areas are mapped into the Singularity image (e.g., app). Where is this information available?

    **Answer:** 
    Maybe the sections Accessing the Slingshot interconnect and OpenMPI of the README.md have the information that you need.

3.  **Q:** How can the package Accelerate from Huggingface be loaded, working with Pytorch2 and AMD infrastructure?

    **Answer:** (Christian) One option is to use cotainr to build a Singularity/Apptainer container from a conda/pip environment. On LUMI you can module load LUMI, module load cotainr to get access to cotainr. You may use this (somewhat outdated) PyTorch+ROCm example as a starting point. Modify the conda environment YAML file to your needs, i.e. include the torch 2.0 and accelerate pip packages. You probably want to use a ROCm 5.3 based version for best compatibility with LUMI, i.e. use --extra-index-url https://download.pytorch.org/whl/rocm5.3. If you try this and it doesn’t work, please submit a ticket to the LUMI user support team via https://lumi-supercomputer.eu/user-support/need-help/.

4.  **Q:** I notice that aws-ofi-rccl automatically replaces Lmod “PrgEnv-cray/8.3.3” with “cpeGNU/22.08” when I load it. 
    Could you explain this behavior, and if the GNU environment is necessary to use (also it terms of python version) when using Singuarlity dockers?

    **Answer:** This is because the module has been built with EasyBuild using the `cpeGNU/22.08` toolchain and that module may
    be needed for the AWS plugin to find the runtime libraries. You'd have to compile the plugin during the construction of the container
    with a C compiler in the container to avoid that.
