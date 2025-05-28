# Hands-on: Advancing your own project and general Q&A

Bring your own AI code, you want to run on LUMI, and spent some time applying what 
you have learned during the workshop - with on-site support from LUST/AMD.

## Closing remarks

<video src="https://462000265.lumidata.eu/ai-20250527/recordings/E12_Conclusions.mp4" controls="controls"></video>


## Extra materials

-   [LUMI AI guide promoted in the closing words](https://github.com/Lumi-supercomputer/LUMI-AI-Guide)

## General Q&A

1.  I'd need to install **conda install -c conda-forge opencv**, but I get permission error: *EnvironmentNotWritableError: The current user does not have write permissions to the target environment.* I'm inside *singularity shell lumi-pytorch-rocm-6.1.3-python-3.12-pytorch-v2.4.1.sif*, and I've run *$WITH_CONDA*. Then I try running *conda install -c conda-forge opencv* and get the error.

    -   If you use the virtual environment approach, you cannot install packages with conda but only with pip. If you want to use conda install, I would try first to install it via cotainr by adding the package to the environment file used for building the container.

    The package I'm looking for is not available via pip. I could use apt install -y libgl1, but there's no apt.

    -   On LUMI you need to use `zypper` and install SUSE packages. However, a container is read-only so you need to go through a container build process. This is demonstrated in one of the demos made for another course: https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/Demo1/ and in the talk for which it is a demo: https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/M205-Containers/ . Our AI containers are based on an OpenSUSE 15SP5 package to be as close as possible to the OS on LUMI to minimise the chance of having compatibility problems between kernel and drivers on the system and the container userland. `apt` is a debian/Ubuntu command and the tool to install packages on SUSE is `zypper`.  Names of packages are not universal though. If you want to install OpenGL-related packages: Be aware of what was said this morning. MI250X is not a rendering GPU so you'll have to use a software OpenGL emulation. There is no support for hardware-accelerated OpenGL on the compute nodes.

2.  I'm so close to succeeding in getting my training gear running! I managed to transfer squashfs file to LUMI and mount it inside sif. But I need to train with ultralytics/YOLO, and I get this error. **ImportError: libGL.so.1: cannot open shared object file: No such file or directory**. This library is not found via pip :(

    -   You probably have to do a proot build based on one of the base containers where you install libGL via zypper. And then with this new container you can use cotainr to install your libraries. If you need help with this we can help you further tomorrow. Actually you can see the comment above for a much more in-depth comment.

    -   See the same remarks as I made for the previous question: You'll have to use software-based OpenGL (MESA) and that is exactly what is done in the demo I refer to in that section. It's not a Python package but a system library, so indeed not possible via `pip`. Conda may or may not deliver it if you build a container from scratch, but you may get a version that does not work on LUMI.

    HEY, I think I got this working by installing **pip install opencv-python-headless**. Thank you for the answer.

3.  Do we have Alphafold on LUMI (container ?) 

    -   We had but it hasn't been updated for a while due to lack of demand. With all the small files that it tends to use, LUMI may not be the best performing solution for it. The last one we had was based on ROCm 5.5 so will likely not work anymore.

    -   If you would need, please open a ticket and we can see whether we can create a newer version.
    -   