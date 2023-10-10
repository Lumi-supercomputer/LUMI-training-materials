# Compilers and Parallel Programming Models

*Presenter: Alfio Lazzaro (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465000644/Slides/HPE/04_Compilers_and_Programming_Models.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-1_05_Compilers_and_Parallel_Programming_Models.pdf`

-   Recording: `/appl/local/training/4day-20231003/recordings/1_05_Compilers_and_Parallel_Programming_Models.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

## Q&A

19. What are your experiences with magnitude of performance increase that can be achieved using larger pagesizes?

    -   No actual experience myself but it will be very program-dependent and it is not orders of magnitude. This is about getting the last 5% or 10% of performance out of a code. It is only useful if the program also allocates its memory in sufficiently large blocks.


20. Was the -hfpN floating point optimization for Fortran only?

    -   The floating point optimization control options for C/C++ are indeed different. Options starting with `-h` are probably all Fortran-only. Clang options can be found, e.g., on [this page](https://clang.llvm.org/docs/UsersManual.html#controlling-floating-point-behavior). That page lists a lot of very fine-grained options, but also, e.g., `-ffp-model` which combines many of these options.

21. I am not sure I understand what the Default option for dynamic linking does. As far as I understand, this is supposed to link to the default Linux library. Does it mean that it does not matter what library I did load via the modules? For example, if I link to lapack, will my module loaded be replaced by some default?

    -   This is only for libraries that come with the Cray PE, not for your own 
        libraries. Dynamic linking can be used for OS libraries, Cray PE libraries, and your own libraries. When starting an application, the loader will look for those libraries in a number of standard places, some places that may be encoded in the executable (via rpath and/or runpath), and in places pointed to by the environment variable `LD_LIBRARY_PATH`. The Cray PE modules are special in that (a) the path to the shared libraries is not always added to `LD_LIBRARY_PATH` but to `CRAY_LD_LIBRARY_PATH` and (b) the wrappers inject the directory with the default versions of the libraries in the executables. So by default, since many of the Cray PE libraries are not in `LD_LIBRARY_PATH` and since the path to default versions is in the executable, the loader will use the default version.

        There are two ways to avoid that. One is to add `CRAY_LD_LIBRARY_PATH` to the front of `LD_LIBRARY_PATH` as was explained in I think an earlier talk. We also have the [lumi-CrayPath](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-CrayPath/lumi-CrayPath-0.1/) which can help you manage that. The other option is the environment variable `CRAY_ADD_RPATH` or corresponding command line argument to tell the wrappers to include the paths in the executable. 
        
        You have more reproducibility when including the specific library versions explicitly, but also a higher chance that your application stops working after a system update. We had several applications that rpathed the MPI library fail after a system update in March of this year.

22. But are the intel compilers supported by LUMI or are they shown only as a term of comparison?

    -   As Alfio said at the beginning, they are only shown for comparison. 
        We cannot support them as we get no support upstream for the compilers and we know there are problems with Intel MPI on LUMI and some MKL routines.

23. If I want a newer `rocm` is is possible to build my own?

    -   Yes and no. Some things will work, others won't. 
        First, ROCm has a driver part also that is installed in the OS kernel, and each ROCm version only works with certain versions of the driver. ROCm 5.3 and 5.4 are guaranteed to work with the driver we currently have on LUMI, newer versions are not guaranteed though one of the AMD support people has used ROCm 5.5.1 successfully on LUMI for some applications. But second, some other libraries on the system also depend on LUMI and may not be compatible with the newer version. E.g., we know that GPU aware MPI in the current Cray MPICH versions fails with ROCm 5.5. Also, the wrappers will not work with a ROCm that you install yourself so you'll have to do some more manual adding of compiler flags. Let's say there are reasons why LUST decided to provide a 5.3 version but not the newer versions as they all have some problems on LUMI which may or may not hit you.

1.  Did the `PrgEnv-cray-amd` load all the required modules for GPU compiling, such as `craype-accel-amd-gfx90a`?

    -   The target modules (like `craype-accel-amd-gfx90a`) are never loaded by the `PrgEnv` modules but always need to be loaded by hand. This is because a system can have multiple different models of GPU so the `PrgEnv` module cannot know which one to load.

2.  Sometimes it may be complicated to have mixed C/fortran linking. Among the different PEs, is there a suggested choice for this type of mixed compilation?

    -   I believe what mixed compilation is primarly considered for is AMD GPU compilers (without Fortran support) and GNU Fortran.

3.  Was the recommendation to use 32MB Hugepages?

    -   2MB but it is easy to experiment. You don't need to relink to change the size of the hugepages, just load another module at runtime.


