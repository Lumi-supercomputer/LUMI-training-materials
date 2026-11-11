# Modules on LUMI

*Presenter: Kurt Lust (LUST)*

LUMI uses Lmod, but as Lmod can be configured in different ways, even an experienced
Lmod user can learn from this presentation how we use modules on LUMI and how
modules can be found.


## Materials

<!-- Materials will be made available after the lecture -->

<!--
<video src="https://462000265.lumidata.eu/2day-20261109/recordings/104-Modules.mp4" controls="controls"></video>
-->
-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2day-20261109/files/LUMI-2day-20261109-104-Modules.pdf)

-   [Course notes](104-Modules.md)

-   [Exercises](E104-Modules.md)


## Q&A

1. How can I check which projects involved after login  Lumi?

    -   It's in the message-of-the-day: `lumi-workspaces`. Or just the `groups` command

2.  My main cpu programs use the following modules on HPC with the following compile modules:

    ```
    ml purge
    ml load ESMF/8.3.0-iomkl-2022a
    ml load UDUNITS/2.2.28-GCCcore-11.3.0
    ml load GSL/2.7-intel-compilers-2022.1.0
    ml load NCO/5.1.9-iomkl-2022a
    ml load Python/3.10.4-GCCcore-11.3.0
    ml load FFTW/3.3.10-GCC-11.3.0
    ````

    Do you have suggested compiler chain for the Lumi modules?
    
    -   These are regular EasyBuild toolchains, in this case with the Intel compiler and MKL. We don't really support that compiler on LUMI. But I think we have all of those libraries compile with GCC. Anyway, if you want to interface with Python through .so libraries, it is always best to use the GNU compilers.

    -   Please check https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/ for packages available or installable with easybuild on LUMI.
    
