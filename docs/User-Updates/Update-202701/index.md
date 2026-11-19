# Expected changes during the January 2027 maintenance

Significant parts of the system software will be updated in order to get a more stable and up-to-date system after the maintenance break.

-   The operating system is now SUSE Enterprise Linux 15 SP7 on the login nodes
    (formerly SP6), and the matching version of Cray Operating System on the
    compute nodes.

-   Slurm will be upgraded to a more recent version.

-   The Slingshot host software will be updated.

-   The system-installed version of ROCm(tm) will be 7.2.4 with corresponding driver.

-   The default programming environment will be 26.03, which fully supports ROCm(tm) 7.

    As the 26.03 programming environment is not fully compatible with the new generation
    flang Fortran compiler, we will build LUMI toolchains using a LUST-installed `rocm/7.0.3`
    module where it was possible to replace the new generation flang compiler with the 
    classic flang compiler.

    The Cray compilers in 25.03 are based on clang/LLVM 21. 
    GCC will remain at a 14.x version, and AOCC will be upgraded to 5.2.0.
 
As part of the update, older versions of the Programming Environment that are not fully functional anymore 
will be removed from the system. *In this update, versions 23.09 and 24.03 will be removed,* 
as will older versions of AOCC (3.2 and 4.1) and of gcc (12 and 13) as they correspond to those programming environments. 
In principle, it is possible to recover those versions via CPE containers, but their matching ROCm(tm) versions are 
unsupported and will likely not be fully functional and MPI and RCCL may also fail so 
the LUST will not be able to support you with issues.
 
Our recommendation is to now already switch to 25.03 or 25.09, or 
even consider testing with the [ccpe/26.03 container](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/c/ccpe/) 
if you are keen on testing if your code still compiles. 
 
For users of AI software, the containers that were provided in the CSC software stack or via 
`/appl/local/containers` will no longer work and users should switch to the LUMI AI Factory containers. 
Though all use compatible ROCm(tm) versions, it is not clear yet if their RCCL plugin will need to be updated.
Users are advised to move to the newer versions of the containers as they will be the ones 
that will receive an equivalent version on the updated system should communication in the 
current containers no longer function properly.
