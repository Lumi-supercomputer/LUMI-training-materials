# LUMI Software Stacks

*Presenter: Kurt Lust (LUST)*

<video src="https://462000265.lumidata.eu/4day-20230530/recordings/2_05_LUMI_Software_Stacks.mp4" controls="controls">
</video>

-   [Notes](notes_2_05_LUMI_Software_Stacks.md)
-   [Slides (PDF)](https://462000265.lumidata.eu/4day-20230530/files/LUMI-4day-20230530-2_05_software_stacks.pdf)

The information in this talk is also covered by the following talks from the 1-day courses:

-   [Modules on LUMI](../1day-20230509/video_03_Modules_on_LUMI.md)
-   [LUMI Software Stacks](../1day-20230509/video_04_LUMI_Software_Stacks.md)


## Q&A


7. How to install a specific version of Python, e.g., 3.10, in the userspace? Is there a shortcut allowing to use EasyBuild or other wrapper?
    - Kurt will talk about this later in this talk
    - I see a ticket were such install has been requested. Are you the user who requested it? **Not on LUMI**
    - OK, so, it means we have mutliple users interested in a Python 3.10 install. Can you send a ticket? I will have a look. **sure, thanks!**
    - Take a look at [cotainr](https://cotainr.readthedocs.io/en/latest/) which allows you to easily create a Singularity/Apptainer container containing a Conda/pip environment. On LUMI you can `module load LUMI`, `module load cotainr` to get access to cotainr.

8. Would it be more preferable to install with `EasyBuild` than `Spack` in LUMI? or maybe both are the same without any differences?

    - (Peter) This is a bit like the Emacs vs Vim debate, it depends on what you are used to, and if the software that you want is available as a package/recipe. One important difference is that the install recipes for optimized and tested software by the LUMI support team and collaborators are for EasyBuild in the `LUMI-Easybuild-contrib` repository, but on the other hand, some popular software packages like Lammps, Trilinos etc from the US exascale program (for Frontier) have good Spack packages. Generally speaking, Spack tends to be popular with people who develop their own code, whereas it is easier to "just install" something with Easybuild as a user, if you only want to run the software, not develop it.
    - Thanks!

9. Some easybuild packages may be quite heavy regarding ammount of files.  i.e CDO has ~21k  after building with eb.   Thats nearly quarter of file quota of a user (100k) or ~1% project  file quota (2M). In a home system only final binary is needed to do the job.  Can the final EasyBuild/   directory be cleaned up after installation, to get only minimum ammount of files to run the aplication? Or are there any hints how to deal the file quota issue after eb installation.  

    - (Peter) Do you mean that the final installation 21k files? Or just that 21k files are needed during the build? The build files (in `/tmp`) are automatically cleaned by EasyBuild. In general, many files is problem with the parallel file systems. In some cases, you may have to use containers to work around this. We can, in some cases, increase the quotas, but there needs to be good reasons. I do not think that there is some automatic way to "strip out" files in EasyBuild, you would probably have to do it by hand. Also, when I check the Spack package for CDO, it seems to install only the binary files, so it might be possible to modify the EB install script for CDO. 
    - EasyBuild creates 20k new files, which are counted. If clean up is automatically done, then, yes, they are there.
    - It's not CDO itself, but ecCodes that is included as a dependency. (and other 2-3 aditional softs)
    - spacks seems to be the proper solution for it  if it stores only few binaries after install.
    - (Peter) the CDO module is already installed on the system, but you have to load the `spack` module to see it. If that is the only thing you need, it might be enough.
    - (Kurt) If EasyBuild installs that many file than it is usually because the default `make install` does so, so it is also a problem with the installation procedure of that software.

10. What way should I go, if I want to use PyOpenCL and mpi4py? Is there a way to install it threough EasyBuild?

    - (Peter) We do not have much experience with OpenCL+MPI through Python. Generally speaking, OpenCL is not well-supported on LUMI, it sort-of works, but is not so popular. My spontaneous thought is that this is something that I would try to install by hand, at first. The `cray-mpich` module on the system has a nice MPI4Py, it is probably a good start. Then I would try to build PyOpenCL myself using the OpenCL runtime and headers in `/opt/rocm`.
    - (Kurt) mpi4py was discussed yesterday as a component that is included in the cray-python modules because it needs to be compiled specifically for cray-mpich. We had the OpenCL discussion yesterday also: Support is unclear and it is basically a deprecated technology...

11. Could the documentation on https://docs.lumi-supercomputer.eu/development/compiling/prgenv/ please be clarified? It's not exactly straightforward which combos of modules one should use. It would prevent a lot of lost effort due to trying to get unsupported combinations to work...

    - (Peter) It is difficult for us, and not so meaningful, to try to reproduce or recreate the full documentation for the Cray Programming Environment.
    - (Alfio) Cray PE documentation is available at https://cpe.ext.hpe.com/docs/
    - The comment about "every user wants software configured the way they want" also applies to documentation. Users wish the documentation is written is such a way it describes exactly what they need. Unfortunately, it is impossible for us to describe every use cases. As a consequence, we can only provide an overview of the available PrgEnv and target modules. However, if you have any suggestion regarding the documentation please create [an issue](https://github.com/Lumi-supercomputer/lumi-userguide/issues). 
  
  

