# Exercises 1: Elementary access and the HPE Cray PE

<!--
Exercises will be made available during the course
-->

-   Start with the [exercises on "Getting Access to LUMI"](E03-Access.md)

-   Continue with the [exercises on the "HPE Cray Programming environment"](E02-CPE.md)

## Q&A

1.  Do I need to load a corresponding craype for gpus then when I want to compile in login node? Because on login node it is craype-x86-rome, but I want to run my app on GPU nodes that as I understand needs to have craype-x86-milan?

    -   This process is called cross-compiling. You can compile on the login nodes for the LUMI-C nodes or for the LUMI-G nodes. For the LUMI-C nodes, all you need to do is `module load craype-x86-milan` and your code will be optimised for zen3. For the GPU nodes it is a little bit more tricky. You need to load `module load craype-x86-trento` (though not doing so wouldn't harm much), but you're likely also need to load the `rocm/6.0.3` module to get access to all the GPU-related stuff. E.g., the HIP compiler for HIP code if you are using the GNU compilers for the CPU part of the code. The Cray compiler can compile HIP code but needs the ROCm module also for tools it uses internally and I bleieve even during compilation for GPU-aware MPI. And with the AMD compilers, you'd be using `PrgEnv-aocc` on the CPU nodes but you can still use `PrgEnv-amd` to compile GPU code on the login nodes.

2.  As I understand we should always use `cc`, `CC` or `ftn` when we compile and configure them, i.e. modifying the default values of some flags. However, what is if we are using something like `cmake` or something that performs jiting (that uses CMake under the hood)? My solution was always to use `export CC=cc` but is this enough?

    -   Either this or the right CMake -DCMAKE_... variables (I don't know them by hand as I usually let EasyBuild manage them when I prepare instructions for users). But the same holds if you would not be using the wrappers as otherwise CMake would most likely be using the ancient system gcc compilers which are GCC 7.5. For a well-behaving installer this should be enough, but sometimes it may depend a bit on the program if CMake is only used under the hood. Python, e.g., may try to enforce the compilers that were used when compiling Python and try to overwrite whatever you specify.

    -   And if you don't use the wrapper, the main difficulty is finding out and specifying paths to libraries. The regular `mpicc` etc. wrappers are provided nowadays in the `cray-mpich` modules and will take care of MPI, but certainly for GNU I would double-check if they use the right compilers and not the system ones.

    -   I've had a recent case where there was an issue with the mpi cmake compiler, so keep in mind that it may also be needed to configure cmake with the -DCMAKE_MPI_C_COMPILER=cc etc.

