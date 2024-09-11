# Changes after the update of August-September 2024

**Please read to the bottom of this page before starting to run again on LUMI!.**

**This page will be updated as we learn about problems with the system after the
update and figure out workarounds for problems. Even though this time we had the
opportunity to do more testing then during previous updates, it was not on the 
main system and the system was also not a full copy of LUMI. Moreover, it turns out
that there are always users who use the system in a different way than we expected
and run into problems that we did not expect.**

Almost all software components on LUMI have received an update during the past system
maintenance. The user-facing updates are:

-   The operating system is now SUSE Enterprise Linux 15 SP5 on the login nodes
    (formerly SP4), and the matching version of Cray Operating System on the
    compute nodes.

-   Slurm is upgraded to version 23.02.7.

-   The libfabric CXI provider has also been upgraded to a newer version. 

-   ROCm 6.0.3 is now the default ROCm version.

    The installed driver should be able to install ROCm version 5.6 to 6.2,
    but that does not imply that all of those versions will work with all
    versions of the Cray Programming Environment. Each version of the Cray
    Programming Environment has only been tested with one or two versions of
    ROCm.


## Major changes to the programming environments

### Supported programming environments

Updating ROCm on LUMI is not as trivial as it seems. There are other components
in the system that depend on ROCm also, and the most noteworthy of these is
GPU-aware MPI. MPI is a very tricky piece of software on a supercomputer:
It has to link with the applications on the system, but also needs to work
closely together with the lower-level communication libraries on the system 
(libfabric and the CXI provider on LUMI), the GPU accelerator driver and libraries
for GPU-aware MPI (so the ROCm stack on LUMI), and with shared memory 
communication/support libraries in the kernel (HPE uses xpmem). Any change
to one of those components may require a change in the MPI library. 
So you can understand that updating a system is not as simple as it may 
appear, and the ROCm update has inevitably other consequences on the system:

-   The new 24.03 programming environment is the **only programming environment
    that is fully supported by HPE** on the new system configuration
    as it is the only programming environment on
    the system with official support for the current version of the operating
    system and ROCm 6.0.

    It is therefore also the system default version of the programming environment.

    **This implies that if you experience problems, the answer might be that you
    will have to move to 24.03 or at least try if the problems occur there too.
    The LUMI User Support Team will focus its efforts on making 24.03 available as
    soon as possible and make it as complete as possible. We only support newer
    versions of software though.**

-   The second new programming environment on the system is 23.12. This is offered
    "as is", and problems cannot be excluded, especially with GPU software, as this
    version does not officially support ROCm 6.0. This version of the CPE was designed
    by HPE for ROCm 5.7.

-   The 23.09 programming environment is also still on the system. It does
    support SUSE 15SP5, but it does not officially support ROCm 6.0. It was
    developed to be used with ROCm 5.2 or 5.5, depending on the version of the OS.

    As originally we planned to move to ROCm 5.7 instead of 6.0, it was expected
    that we would still be able to support this version of the programming environment.
    However, due to the larger than expected upgrade of the system, moving directly to
    ROCm 6.0, this is not possible. It may be better to recompile all GPU software,
    and this will be particularly troublesome with `PrgEnv-amd`/`cpeAMD` as you now
    get a much newer but also much stricter compiler based on Clang 17 rather than Clang
    14. The LUST has recompiled the central software stack for LUMI-G and had to remove
    some packages due to compatibility problems with the newer and more strict compilers.

-   Older programming environments on the system are offered "as is" as they 
    support neither the current version of the OS nor ROCm 6.

    In fact, even repairing by trying to install the user-level libraries of older 
    versions of ROCm may not be a solution, as the versions that are fully
    supported by those programming environments are not supported by the current
    ROCm driver on the system, and there can be only one driver.

    Expect problems in particular with GPU code. In most, if not all cases, the 
    proposed solution will be "upgrade to 24.03" as this is also the version for which
    we can receive upstream support.


###  Some major changes to the programming environment:

-   The `amd/6.0.3` module does not offer the complete ROCm environment as older
    versions did. So you may now have to load the `rocm/6.0.3` module also pretty
    much as was needed with the other programming environments for complete ROCm
    support.

-   23.12 and 24.03 use the `gcc-native` modules. They will, as older versions of the
    programming environment are phased out, completely replace the `gcc` modules.

    Note that using the GNU compilers without wrappers is different from before
    in these modules. E.g., in `gcc-native/12.3`, the compilers are now called
    `gcc-12`, `g++-12` and `gfortran-12`.

    When using the GNU compilers with the wrappers, one should make sure that the
    right version of the wrappers is used with each type of GNU compiler module.
    If you are not using the LUMI stacks, it is best to use the proper `cpe` module
    to select a version of the programming environment and then use the default version
    of the `craype` wrapper module for that version of the CPE.


## The LUMI software stacks

We are still in the process of building and installing new software stacks based on
the 23.12 and 24.03 versions of the CPE. The `LUMI/23.12` stack will closely resemble
the `23.09` stack as when we started preparing it, it was expected that this stack too
would have been fully supported by HPE (but then we were planning an older version of
ROCm), while the `24.03` stack contains more updates to packages in the central
installation. They will appear on the system when ready. Since problems building a
software stack are unpredictable, we do not make any promises about a specific date.

Note that the [LUMI documentation](https://docs.lumi-supercomputer.eu) 
will receive several updates in the first weeks after the maintenance, and in particular the
[LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
will not be fully consistent with what can be found on the system when it comes to the
23.12 and 24.03 versions of the LUMI stack. The reason for this is that the preparations
started when it was expected that 23.12 would also be fully supported and our plan was
to make this as similar as possible to 23.09 to have a fast migration path for users while,
using 24.03 to make newer versions of software available. However, as 24.03 became the
only fully supported version due to the switch to ROCm 6.0, the LUST decided to refocus
efforts on bringing 24.03 first to the system.

Note that even though the system default version of the programming environment is
24.03, the default version of the LUMI stack will remain 23.09 until 24.03 is sufficiently
complete. We do encourage all users to **never** load the `LUMI` module without specifying
a version, as that will protect your jobscripts from future changes on the system.

Some enhancements were made to the EasyBuild configuration. Note that the name of the
`ebrepo_files` subdirectory of `$EBU_USER_PREFIX` and `/appl/lumi/mgmt` is now changed to
`ebfiles_repo` to align with the standard name used by EasyBuild on other systems.
The first time you load the `EasyBuild-user` module, it will try to adapt the name in
your installation. The new configuration now also supports custom easyblocks in all
repositories that are searched for easyconfig files. On the login nodes, the level of
parallelism for parallel build operations is restricted to 16 to not overload the login
nodes and as a higher level of parallelism rarely generates much gains.


## How to get running again?

We encourage users to be extremely careful in order to not waste lots of billing units on
jobs that hang or produce incorrect results for other reasons.

-   First check if your software still works properly. This is best done by first
    running a single smaller problem, then scaling up to your intended problem size,
    and only after a successful representative run, submit more jobs.

    You may want to cancel jobs that are still in the queue from before the maintenance.

-   Do consider recompiling GPU software. In fact, we have seen that for software that
    could be recompiled in the LUMI/23.09 stack, performance increased due to the much
    better optimisations in the much newer ROCm version.

-   Consider moving to the 24.03 programming environment, and if you are using the 
    LUMI stacks, to the LUMI/24.03 stack as soon as the latter is available and complete
    enough. Much work has already been done in preparing EasyBuild recipes for 
    user-installable packages also. Those will become available as soon as the central
    packages they depend upon, become available.

-   For users using containers: Depending on how you bind Cray MPICH to the container and
    which version of Cray MPICH you use for that, you may have to bind additional packages from
    the system. Note that you may also run into runtime library conflicts between the version
    of ROCm in the container and the MPI libraries which may expect a different version.
    The LUST is also still gaining experience with this.

    We will also update the AI containers as especially for those applications, ROCm 6 should
    have great advantages and support (versions of) software that could not be supported before.
    The initial focus for AI-oriented containers will be on providing base images for containers based on
    ROCm 5.7 up to 6.2, and containers providing recent versions of PyTorch based on those
    ROCm versions, as PyTorch is the most used AI application on LUMI.

