# Additional software on LUMI

*Presenter: Kurt Lust (LUST)*

<video src="https://462000265.lumidata.eu/peap-q-20221123/recordings/13_LUST_LUMI_Software.mp4" controls="controls">
</video>

Additional materials

-   [Slides (PDF)](https://462000265.lumidata.eu/peap-q-20221123/files/13_LUST_LUMI_Software.pdf)

    Also on LUMI in `/appl/local/training/peap-q-20221123/files/13_LUST_LUMI_Software.pdf`.

-   [Notes](notes_13_LUMI_Software_Stacks.md)


## Q&A

1.  `Error: ~/exercises/VH1-io/VH1-io/run> sbatch run_vh1-io.slurm sbatch: error: Invalid directive found in batch script: e.g` Do I need to change something in run_vh1-io.slurm before submitting?
    - Yes, you have to at least adapt the account, partition and reservation. qos has to be deleted (reservation is also optional). 
    - The readme has some quick build instructions. It worked for me :) 
    - Okay, thank you.

2.  More information about the python container wrapper can be found in the [documentation](https://docs.lumi-supercomputer.eu/software/installing/container-wrapper/).

3.  Is easybuild with AMD compilers on the roadmap for EB? 
    - The AMD AOCC compiler is already available in the Cray and LUMI software stack. Either `PrgEnv-aocc` or `cpeAOCC/22.08`. Additionally the AMD LLVM compiler is available via `PrgEnv-amd`.
    - Ok thanks! I thought one of Kurt's slides showed that EB currently only works with GNU or Intel
    - No, it works with Cray, GNU and AOCC but intel is tricky and not recommended.
    - Thanks!
    - **[Kurt]** Clarification: Standard EasyBuild has a lot of toolchains for different compilers, but only build recipes \9the EasyConfig files) for some specific toolchains, called the common toolchains. And they are based on GNU+OpenMPI+FlexiBLAS with OpenBLAS+FFTW and a few other libraries, or Intel (currently the classic compilers but that will change) with MKL and Intel MPI. This is what I pointed to with GNU and Intel in EasyBuild. For LUMI we build our own toolchain definitions which are an improved version of those used at CSCS and similar toolchains for an older version of the Cray PE included in EasyBuild.
    - **[Kurt]** It is not on the roadmap of the EasyBuilders. They have toolchains for AMD compilers but doe not build specific EasyBuild recipes and don't do much specific testing. I am trying to push them to support at least default clang, but then the Fortran mess will have to be cleaned up first. Regular clang support would at least imply that a number of clang-specific configuration problems would get solved so that changing to the AMD toolchain would be a relatively small effort (and could work with `--try-toolchain`). 
    - Ok thanks again! :D 

4. Julia (language) is installed?
    - No, not in the central software stack available for everyone. It is quite easy to just download the Julia binaries in your home directory and just run it, though. Julia uses OpenBLAS by default, which is quite OK on AMD CPUs. If you want, you can also try to somewhat "hidden" Julia module installed with Spack. `module load spack/22.08; module load julia/1.7.2-gcc-vv`. No guarantees on that one, though (unsupported/untested).
    - Another easy approach is to use existing containers. Unless GPU is used, generic container from DockerHub should work fine.
    - It is not clear though if the communication across nodes is anywhere near optimal on LUMI at the moment. The problem is that Julia comes with very incomplete installation instructions. Both the Spack and EasyBuild teams are struggling with a proper installation from sources and neither seem to have enough resources to also fully test and benchmark to see if Julia is properly tuned. 

5. Paraview is a data postprocessing software that employs a graphical user interface. Is it possible to use it with LUMI?
    Also, as explained in https://www.paraview.org/Wiki/PvPython_and_PvBatch, Paraview functions may be accessed without using the GUI and just using python scripts. Is it feasible to use pvBatch and pvPython in LUMI to postprocess data with Paraview?
    - Yes, you can use Paraview on LUMI. We have an EasyBuild recipe that is not yet present on the system but is available via the [LUMI "contrib" Github](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib/) repository. This easyconfig build the server components only and does CPU rendering via MESA. You need to run a client of the same version of the server on your local machine in order to interact with the server.
    - Actually, the Paraview recipe is still missing in the repository but we will take care of that.

