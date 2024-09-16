# Changes after the update of August-September 2024

**Please read to the bottom of this page before starting to run again on LUMI!.
The instructions for getting to run again are deliberately towards the bottom
of this text!**

<span style="color:DarkBlue">Recent changes are in dark blue.</span>

This page will be updated as we learn about problems with the system after the
update and figure out workarounds for problems. Even though this time we had the
opportunity to do more testing then during previous updates, most testing was not on the 
main system and the system was also not a full copy of LUMI. Moreover, it turns out
that there are always users who use the system in a different way than we expected
and run into problems that we did not expect.

Almost all software components on LUMI have received an update during the past system
maintenance. The user-facing updates are:

-   The operating system is now SUSE Enterprise Linux 15 SP5 on the login nodes
    (formerly SP4), and the matching version of Cray Operating System on the
    compute nodes.

-   Slurm is upgraded to [version 23.02.7](https://slurm.schedmd.com/archive/slurm-23.02.7/man_index.html).

-   The libfabric CXI provider has also been upgraded to a newer version. 

-   ROCm 6.0.3 is now the system-installed and default ROCm version
    and ROCm 5.2.3 is no longer on the system.

    The installed driver should be able to install ROCm version 5.6 to 6.2,
    but that does not imply that all of those versions will work with all
    versions of the Cray Programming Environment. Each version of the Cray
    Programming Environment has only been tested with one or two versions of
    ROCm.

-   Two new programming environments have been installed, see the next section.

**As after previous maintenance periods, the visualisation nodes in the `lumid`
partition are not yet available as they require a slightly different setup.**


## Major changes to the programming environments

### (Un)supported programming environments

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
    as it is the **only programming environment on
    the system with official support for both the current version of the operating
    system and ROCm 6.0.**

    It is therefore also the system default version of the programming environment.

    **This implies that if you experience problems, the answer might be that you
    will have to move to 24.03 or at least try if the problems occur there too.
    The LUMI User Support Team will focus its efforts on making the software stack 
    for 24.03 as complete as possible as soon as we can, and a lot of it is already
    on the system. We only support relatively recent
    versions of software though.**

    The CCE and ROCm compilers in this programming environment are both based on 
    Clang/LLVM 17 while the AOCC compiler (module `aocc/4.1.0`) is based on
    Clang/LLVM 16.

-   The second new programming environment on the system is 23.12. This is offered
    "as is", and problems cannot be excluded, especially with GPU software, as this
    version does not officially support ROCm 6.0. This version of the CPE was designed
    by HPE for ROCm 5.7.

-   The 23.09 programming environment is also still on the system. It does
    support SUSE 15SP5, but it does not officially support ROCm 6.0. It was
    developed to be used with ROCm 5.2 or 5.5, depending on the version of the OS.

    As originally we planned to move to ROCm 5.7 instead of 6.0, it was expected
    that we would still be able to support this version of the programming environment
    as the ROCm versions are close enough (this had worked in the past).
    However, due to the larger than expected upgrade of the system, moving directly to
    ROCm 6.0, this is not possible. It may be better to recompile all GPU software,
    and this will be particularly troublesome with `PrgEnv-amd`/`cpeAMD` as you now
    get a much newer but also much stricter compiler based on Clang 17 rather than Clang
    14.  The LUST has recompiled the central software stack for LUMI-G and had to remove
    some packages due to compatibility problems with the newer and more strict compilers.
    These packages return in newer versions in the 24.03 stack.

-   Older programming environments on the system are offered "as is" as they 
    support neither the current version of the OS nor ROCm 6.

    In fact, even repairing by trying to install the user-level libraries of older 
    versions of ROCm may not be a solution, as the ROCm versions that are fully
    supported by those programming environments are not supported by the current
    ROCm driver on the system, and there can be only one driver.

    Expect problems in particular with GPU code. In most, if not all cases, the 
    proposed solution will be "upgrade to 24.03" as this is also the version for which
    we can receive upstream support. However, we even cannot guarantee the proper working
    of all CPU code, and recompiling may not be enough to solve problems. (In fact, we have
    had problems with some software on 22.08 already for over one year.)


###  Some major changes to the programming environment

-   Just as after previous updates, the module system has been tuned to load
    the current ROCm module,
    `rocm/6.0.3`, when you try to load one of the previous system ROCm versions,
    including `rocm/5.2.3`. In some cases, programs will run just fine with the
    newer version, in other cases issues may appear.

    Some version of the HPE Cray PE also try to load non-existing ROCm versions and
    this is also being handled by the module environment which will offer the
    `rocm/6.0.3` and `amd/6.0.3` modules instead.

-   The `amd/6.0.3` module does not offer the complete ROCm environment as older
    versions did. So you may now have to load the `rocm/6.0.3` module also 
    as was already needed with the other programming environments for complete ROCm
    support.

-   23.12 and 24.03 use the `gcc-native` modules. They will, as older versions of the
    programming environment are phased out, completely replace the `gcc` modules.
    
    The former `gcc` modules provided a version of the GNU compilers packaged by HPE
    and hence installed in `/opt/cray`. The new `gcc-native` modules provide the GNU 
    compilers from development packages in the SUSE Linux distribution. Hence
    executables and runtime libraries have moved to the standard SUSE locations.

    Note that using the GNU compilers without wrappers is therefore different from before
    in these modules. E.g., in `gcc-native/12.3`, the compilers are now called
    `gcc-12`, `g++-12` and `gfortran-12`.

    When using the GNU compilers with the wrappers, one should make sure that the
    right version of the wrappers is used with each type of GNU compiler module.
    If you are not using the LUMI stacks, it is best to use the proper `cpe` module
    to select a version of the programming environment and then use the default version
    of the `craype` wrapper module for that version of the CPE.

    You will have to be extra careful when installing software and double check if the
    right compilers are used. Unless you tell the configuration process exactly which
    compilers to use, it may pick up the system gcc instead which is rather old and just
    there to ensure that there is a level of compatibility between system libraries for
    all SUSE 15 versions.


### Known issues with the programming stack

-   The `intro_mpi` manual page for the latest version of Cray MPICH (8.1.29) was missing.
    Instead, the one from version 8.1.28 is shown which does lack some new information.

    The [web version of the manual page offered by HPE](https://cpe.ext.hpe.com/docs/latest/mpt/mpich/intro_mpi.html)
    is currently the one from version 8.1.29 though and very interesting reading.


## The LUMI software stacks

We are building new software stacks based on 
the 23.12 and 24.03 versions of the CPE. The `LUMI/23.12` stack closely resembles
the `23.09` stack as when we started preparing it, it was expected that this stack too
would have been fully supported by HPE (but then we were planning an older version of
ROCm), while the `24.03` stack contains more updates to packages in the central
installation. Much of `24.03` and `23.12` was ready when the system was released again
to users.

Note that the [LUMI documentation](https://docs.lumi-supercomputer.eu) 
will receive several updates in the first weeks after the maintenance. The
[LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
is mostly consistent with what can be found on the system when it comes to the
23.12 and 24.03 versions of the LUMI stack, but you may find some EasyConfigs for
packages that claim to be pre-installed but are not yet on the system.

Since the `LUMI/24.03` software stack is sufficiently ready and since it is the only stack
we can truly support, it is also the default software stack so that it also aligns with the
system default version of the programming environment.
In any case, we do encourage all users to **never** load the `LUMI` module without specifying
a version, as that will better protect your jobscripts from future changes on the system.

Some enhancements were made to the EasyBuild configuration. Note that the name of the
`ebrepo_files` subdirectory of `$EBU_USER_PREFIX` and `/appl/lumi/mgmt` is now changed to
`ebfiles_repo` to align with the standard name used by EasyBuild on other systems.
The first time you load the `EasyBuild-user` module, it will try to adapt the name in
your installation. The new configuration now also supports custom easyblocks in all
repositories that are searched for easyconfig files. On the login nodes, the level of
parallelism for parallel build operations is restricted to 16 to not overload the login
nodes and as a higher level of parallelism rarely generates much gains.

**Note that we have put some effort in testing LUMI/23.09 and have rebuild the GPU version of
the packages in the LUMI/23.09 central stack to as much as possible remove references to ROCm libraries that
may cause problems. However, we will not invest time in solving problems with even older versions
of the LUMI stacks for which we already indicated before the maintenance
that there would be problems.**


## <span style="color:DarkBlue">Other software stacks</span>

<span style="color:DarkBlue">Local software stacks, with the one provided in `/appl/local/csc` as the most prominent example,
are not managed by the LUMI User Support Team. They have to be updated by the organisation who
provides them and LUST cannot tell when they will do that.</span>

<span style="color:DarkBlue">Expect that modules my not function anymore or become unavailable
for a while while updates are being made. If the package has an equivalent in the 
LUST-provided LUMI software stack and a new user-installable EasyBuild recipe is ready already
(see the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
for all available software),
you can consider switching to those.</span>


## How to get running again?

We encourage users to be extremely careful in order to not waste lots of billing units on
jobs that hang or produce incorrect results for other reasons.

-   All GPU jobs have been put in "user hold" mode. It is up to you to release them when you
    are confident that they will work properly. We recommend to not release them all at
    once, as they may very well fail or even get stuck until the wall time expires,
    and this will lead to a lot of wasted billing units on your project that we cannot
    compensate for.

    To release the jobs again, use the 
    [`scontrol release` command](https://slurm.schedmd.com/archive/slurm-23.02.7/scontrol.html#OPT_release).
    It argument is a comma-separated list of jobids, or alternatively you can use 
    "`jobname=`" with the job's name which would attempt to release all jobs with
    that name.

    But first continue reading the text below...

-   First check if your software still works properly. This is best done by first
    running a single smaller problem, then scaling up to your intended problem size,
    and only after a successful representative run, submit more jobs.

    You may want to [cancel jobs](https://slurm.schedmd.com/archive/slurm-23.02.7/scancel.html) 
    that are still in the queue from before the maintenance.

-   As [explained in the courses](http://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/02_CPE/#warning-1-you-do-not-always-get-what-you-expect), 
    by default the HPE Cray PE will use
    system default versions of MPI etc., which are those of the 24.03 PE, even if older
    modules are loaded. The idea behind this is that in most cases the latest one is the
    most bug-free one and best adapted to the current OS and drivers on the system.

    If that causes problems, you can try running using the exact versions of the libraries
    that you actually selected. 

    For this, you either prepend `LD_LIBRARY_PATH` with `CRAY_LD_LIBRARY_PATH`:

    ```bash
    export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH
    ```

    or, even simpler, load the module `lumi-CrayPath` after loading all modules and 
    reload this module after every module change.

    We expect mostly problems for GPU applications that have not been recompiled with 24.03
    and ROCm 6 as there you might be mixing ROCm 5 libraries and ROCm 6 libraries as the
    latter are used by the default MPI libraries.

-   Something rather technical: Sometimes software installation procedures hard-code paths to
    libraries in the executable. The mechanisms that Linux uses for this are called rpath
    and runpath. Binaries compiled before the system update may now try to look for libraries
    in places where they no longer are, or may cause loading versions of libraries that are
    no longer compatible with the system while you may be thinking it will load a newer version
    through the modules that you selected or through the default libraries.

    Applications and libraries with known problems now or in the past are 
    [OpenFOAM](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/o/OpenFOAM/),
    [CDO](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/c/CDO/),
    [NCO](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/n/NCO/),
    [PETSc](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PETSc/) and
    [libdap](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/libdap/).

    This jobs will fail immediately so no billing units will be wasted.

    There is no other solution to this problem than to completely reinstall these packages,
    and likely you'll have to use the latest compiler and/or LUMI stack to be fully safe.

-   Do consider recompiling GPU software, even if it still seems to work just fine. 
    In fact, we have seen that for software that
    could be recompiled in the LUMI/23.09 stack, performance increased due to the much
    better optimisations in the much newer ROCm version.

-   Consider moving to the 24.03 programming environment, and if you are using the 
    LUMI stacks, to the LUMI/24.03 stack, as soon as possible. 
    Much work has already been done in preparing EasyBuild recipes for 
    user-installable packages also.

-   For users using containers: Depending on how you bind Cray MPICH to the container and
    which version of Cray MPICH you use for that, you may have to bind additional packages from
    the system. Note that you may also run into runtime library conflicts between the version
    of ROCm in the container and the MPI libraries which may expect a different version.
    The LUST is also still gaining experience with this.

    We will also update the AI containers in the coming weeks 
    as especially for those applications, ROCm 6 should
    have great advantages and support (versions of) software that could not be supported before.
    The initial focus for AI-oriented containers will be on providing base images for containers based on
    ROCm 5.7 up to 6.2, and containers providing recent versions of PyTorch based on those
    ROCm versions, as PyTorch is the most used AI application on LUMI.

