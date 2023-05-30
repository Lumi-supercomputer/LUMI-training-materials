# Programming Environment and Modules

*Presenter: Harvey Richardson (HPE)*

-   Slides available on LUMI as:
    -   `/project\project_465000524/slide/HPE/02_PE_and_Modules.pdf`
    -  Permanent location when available:  `/project/project_465000524/slides/HPE/1_02_Programming_Environment_and_Modules.pdf`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  What are the differences between `module` and `spack`? When should we install software using `module` and `spack`?

    **Answer** By default we install software using EasyBuild which is done via the LUMI modules. Spack is provided as an alternative without much support for those who know Spack. It is configured to use the compilers on the system, but we will not do any debugging or package development in Spack. A bit more about this in the presentation on LUMI software stacks on Wednesday afternoon (day 2). Spack can also generate module files, if you want, but it is not mandatory, and other options might be better (Spack environments or `spack load`).

2.  Regarding module load. Are `CDO command`, `NCO command`, and `ncview` modules available? If so, how can one correctly load them? Any documentation available?
    *seems that they are available via easy build  https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/*

    **Answer** See the presentation on the afternoon of day 2 about how to find software on LUMI and how we deal with software and all possible configurations, and how to install with EasyBuild.

3.  What is the difference between `PrgEnv-xxx` and `CCE`?

    **Answer** PrgEnv-... set up the whole environment: Compiler, MPI and LibSci and the compiler wrappers. CCE is just the compiler module corresponding to PrgEnv-cray, but does not yet offer MPI, LibSci or the compiler wrappers.