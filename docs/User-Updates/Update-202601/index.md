# Changes after the update of January 2026

<!--
**See also the 
[recording of the user update webinar of February 11, 2026](../../User-Coffee-Breaks/20260211-user-coffee-break-LUMI-update.md).**
-->
<span style="color:DarkBlue">Recent changes are in dark blue.</span>

!!! Note "State of the system"
    <span style="color:DarkRed">
    **The choice was made to make LUMI available to users before all software in the 
    LUMI stacks could be checked and recompiled where possible and before the new stack
    could be installed, so that advanced users who do not depend on software preinstalled
    on the system beyond the programming environment, can start working again.**
    </span>

    <span style="color:DarkBlue">The LUMI web interface needs further debugging and remains
    unavailable until further notice.</span>
    
    <span style="color:DarkRed">
    **As the version of the `rocm` and `amd` modules has changed, we expect a lot of GPU software
    to fail if not recompiled. This is particularly true for anything using cpeAMD/24.03 as there
    even the base compilers have changed.**</span> <span style="color:DarkBlue">**We have rebuild
    cpeAMD/24.03 as the compilers for this toolchain have changed.**
    </span>
    
    <span style="color:DarkRed">
    **Experience has taught us that hard-coded paths can be hidden where you wouldn't expect them,
    e.g., because a library or application uses so-called rpath linking in its installation 
    scripts. See below for known packages of that type.**
    </span>

This page will be updated as we learn about problems with the system after the
update and figure out workarounds for problems. Even though we had the
opportunity to do more testing then during the first updates of LUMI
(though not as much as during the update in August 2024), most testing was not on the 
main system and the system was also not a full copy of LUMI. Moreover, it turns out
that there are always users who use the system in a different way than we expected
and run into problems that we did not expect.

Almost all software components on LUMI have received an update during the past system
maintenance. The user-facing updates are:

-   The operating system is now SUSE Enterprise Linux 15 SP6 on the login nodes
    (formerly SP5), and the matching version of Cray Operating System on the
    compute nodes.

-   Slurm is upgraded to [version 24.05.8](https://slurm.schedmd.com/archive/slurm-24.05.8/man_index.html).

-   The libfabric CXI provider has also been upgraded to a newer version. 

-   ROCm 6.3.4 is now the system-installed and default ROCm version
    and ROCm 6.0.3 is no longer on the system.

    The currently installed driver (`amdgpu` package) is version 
    6.3.60300-2084815 (and note that this is not the version returned
    by `rocm-smi` as the latter really returns the firmware version instead),
    and that driver is compatible with ROCm userland libraries from version
    6.1 till 7.0. This does not imply that all of those versions will be
    fully functional on LUMI as each version of the Cray Programming
    Environment has only been tested with one or two versions of ROCm(tm).

    E.g., none of the MPI implementations of the programming environment 
    25.09 or earlier can work with ROCm(tm) 7 to offer GPU-aware MPI.

-   Two new programming environments have been installed, see the next section.

<!-- TODO -->
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

-   The new 25.03 programming environment is the system default version after 
    the maintenance as it is the version of the PE that is fully developed for
    the current system configuration with ROCm(tm) 6.3.

    25.09 is also offered, though it has been tested more with ROCm(tm) 6.4.

    We cannot guarantee that older versions of the Programming Environment, which
    were never developed for and tested on/with SUSE 15 SP6 and ROCm(tm) 6.3, will
    work for everybody.

    **This implies that if you experience problems, the answer might be that you
    will have to move to 25.03 or at least try if the problems occur there too.
    The LUMI User Support Team will focus its efforts on making the software stack 
    for 25.03 as complete as possible as soon as we can, and a lot of it is already
    on the system. We only support relatively recent
    versions of software though. After that, we will build a stack for 25.09.**

    The CCE compilers are based on Clang/LLVM 19 (in 25.03) and Clang/LLVM 20 (25.09),
    the ROCm(tm) 6.3 compiler is based on Clang/LLVM 18,
    and the AOCC compiler (module `aocc/5.0.0`) is based on Clang/LLVM 17.
    Both the ROCm(tm) and AOCC compilers offer classic flang, not yet the new
    generation Fortran compiler.

    25.03 and 25.09 also come with two MPI implementation. The cray-mpich 8.1.x modules
    use an MPI implementation derived from MPICH 3.4, while the cray-mpich 9.0.x modules
    use an implementation derived from MPICH 4.1. In the 25.03 version of the programming
    environment, the 8.1 module is the default and is also what we will use to build the
    LUMI/25.03 software stack. In 25.09, the 9.0 module is the default and is what we
    will use for the LUMI/25.09 stack.

-   The 24.03 programming environment is still on the system. It was developed for
    use with ROCm(tm) 6.0.0 but we trick it into using the current system default
    ROCm(tm) version, 6.3.4. This is not guaranteed to work in all cases and the 
    solution is to switch to one of the newer programming environments. However, 
    it was left on the system to make the transition smoother as we expect that a
    lot of software will still work, and as some users may depend on CCE 17.

    Preliminary testing on a test system has shown that some EasyBuild recipes 
    for 24.03 do no longer build correctly. These will not be fixed unless the
    fix would be trivial and instead users should move to 25.03.

-   The 23.09 programming environment is also still on the system. It does neither
    officially support SUSE 15SP6, nor does it officially support any of the 
    ROCm(tm) 6.X versions.

    It is left on the system for users needing CCE 16 in particular, but LUST cannot
    fix and will not try to fix any issues with this compiler.

-   Older programming environments have been removed from the system as it has become
    impossible to properly support those, are often already broken in different ways
    for all but basic usage, and slow down both the module system and node reboots.

-   Note that ROCm(tm) 7.X cannot be supported at the moment with the Cray Programming
    Environments as HPE has no MPI libraries that are compatible with it yet, even though
    the GPU driver can support ROCm(tm) 7.0 (but not 7.1 or newer).


###  Some major changes to the programming environment

-   Just as after previous updates, the module system has been tuned to load
    the current ROCm module,
    `rocm/6.3.4`, when you try to load one of the previous system ROCm versions,
    including `rocm/6.0.3`. In some cases, programs will run just fine with the
    newer version, in other cases issues may appear. This is particularly true
    if you are using software that was compiled for ROCm(tm) 5. ROCm(tm) 6.0.3
    had some compatibility libraries that have been removed in later versions
    and probably wouldn't work on the current driver anyway.

    Some version of the HPE Cray PE also try to load non-existing ROCm versions and
    this is also being handled by the module environment which will offer the
    `rocm/6.3.4` and `amd/6.3.4` modules instead.

-   The changes to the `amd` modules and `gcc`/`gcc-native` modules during [the
    maintenance of August and September 2024](../Update-202409/index.md#some-major-changes-to-the-programming-environment) 
    of course are still relevant.


### Known issues with the programming environment

-   When running, software compiled with the Cray Programming Environment will by default
    use many libraries from `/opt/cray/pe/lib64` rather than from the specific version of
    the modules that are loaded.

    This is explained, among others, in the [intro course, Cray Programming Environment lecture,
    slide "Warning 1: You do not always get what you expect..."](../../2day-20251020/102-CPE.md#warning-1-you-do-not-always-get-what-you-expect).

    This is particularly relevant to the `cray-mpich` modules: The version of the shared libraries
    has not changed between Cray MPICH 8.1 and 9.0 even though the MPI libraries are very different
    as the latter are based on MPICH 4.1 while the former are based on MPICH 3.4. As a consquence,
    if you don't follow the advice on the slide mentioned in the previous paragraph, programs will
    actually use the MPI libraries from Cray MPICH 8.1.32 for 25.03, even if they are compiled with
    25.09 or with the `cray-mpich/9.0.0` module of 25.03.

    We still have to see how we will deal with this for software installed in 25.09. It is rather 
    likely that users will have to use the `lumi-CrayPath` module for that software. But it also 
    matters to every user who builds their own executables or wants to use an MPICH 4.1-derived
    Cray MPICH. 


## The LUMI software stacks

We are building new software stacks based on 25.03 and 25.09.
The recommended stable stack is `LUMI/25.03` and this one has been under
development for quite some time already with the help of a containerised version
of the PE. This also implies that the choice for versions of certain libraries was 
made before the summer of 2025. It uses Cray MPICH 8.1 which is based on the
MPICH 3.4 code base.
The stack based on `LUMI/25.09` is a bit more experimental. Several software
packages will be upgraded compared to `LUMI/25.03` and it will be based on 
Cray MPICH 9.0 which is derived from the MPICH 4.1 code base and we will also try
to support ROCm 6.4 with it.

`LUMI/25.03` should become available in the week after the update, but the development
for `LUMI/25.09` has only just started and so it may take weeks or even two months before
more than just some basic software appears on the system.

Note that the [LUMI documentation](https://docs.lumi-supercomputer.eu) 
will receive several updates in the first weeks after the maintenance. The
[LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
is mostly consistent with what can be found on the system when it comes to the
23.09. 24.03 and 25.03 versions of the LUMI stack, but you may find some EasyConfigs for
packages that claim to be pre-installed but are not yet on the system.

Since the 25.03 version of the Cray Programming Environment is the default version for
this version of the base LUMI software and since it is also the most ready version of the
software stack, `LUMI/25.03` is the default version of the LUMI stack.
In any case, we do encourage all users to **never** load the `LUMI` module without specifying
a version, as that will better protect your jobscripts from future changes on the system.

With 25.03, we also make the switch to [EasyBuild 5](https://docs.easybuild.io/). 
The relevant LUMI-specific documentation will also be updated in the coming weeks.
There are no major changes though in what you need to do to install software for which
we already have EasyBuild recipes available. If you want an overview of all dependencies
that are installed or missing, you now need to use `-Dr` instead of `-D` though.

<!--
**Note that we have put some effort in testing LUMI/24.03 and have rebuild the GPU version of
the packages in the LUMI/24.03 central stack to as much as possible remove references to ROCm libraries that
may cause problems. However, we will not invest time in solving problems with even older versions
of the LUMI stacks for which we already indicated before the maintenance
that there would be problems.**
-->

### Known issues so far with the software stacks

1.  Pre-25.03 basic software stacks using partition/G may give issues, in particular when trying to
    build software on it now.

    The only solutions are to either move to LUMI/25.03, or we have to rebuild 24.03 for 
    partition/G completely which can only be done in downtime and therefore was not done
    yet to minimise the length maintenance period. So the only practical solution is to move on
    to 25.03 if you are affected...

2.  We haven't been able to test yet on the production system, but software using the
    `libpsl` module from the older LUMI software stacks, may fail. A solution has been
    implemented in 25.03 and we are considering options for 24.03 and 23.09.


## Other software stacks

Local software stacks, with the one provided in `/appl/local/csc` as the most prominent example,
are not managed by the LUMI User Support Team. They have to be updated by the organisation who
provides them and LUST cannot tell when they will do that.

Expect that modules my not function anymore or become unavailable
for a while while updates are being made. If the package has an equivalent in the 
LUST-provided LUMI software stack and a new user-installable EasyBuild recipe is ready already
(see the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
for all available software),
you can consider switching to those.


## How to get running again?

We encourage users to be extremely careful in order to not waste lots of billing units on
jobs that hang or produce incorrect results for other reasons.

-   All GPU jobs have been put in "user hold" mode. It is up to you to release them when you
    are confident that they will work properly. We recommend to not release them all at
    once, as they may very well fail or even get stuck until the wall time expires,
    and this will lead to a lot of wasted billing units on your project that we cannot
    compensate for.

    To release the jobs again, use the 
    [`scontrol release` command](https://slurm.schedmd.com/archive/slurm-24.05.8/scontrol.html#OPT_release).
    Its argument is a comma-separated list of jobids, or alternatively you can use 
    "`jobname=`" with the job's name which would attempt to release all jobs with
    that name.

    But first continue reading the text below...

-   First check if your software still works properly. This is best done by first
    running a single smaller problem, then scaling up to your intended problem size,
    and only after a successful representative run, submit more jobs.

    You may want to [cancel jobs](https://slurm.schedmd.com/archive/slurm-24.05.8/scancel.html) 
    that are still in the queue from before the maintenance.

-   As [explained in the courses](../../2day-20251020/102-CPE.md#warning-1-you-do-not-always-get-what-you-expect), 
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

-   Something rather technical: Sometimes software installation procedures hard-code paths to
    libraries in the executable. The mechanisms that Linux uses for this are called *rpath*
    and *runpath*. Binaries compiled before the system update may now try to look for libraries
    in places where they no longer are, or may cause loading versions of libraries that are
    no longer compatible with the system while you may be thinking it will load a newer version
    through the modules that you selected or through the default libraries.

    Applications and libraries with known problems now or in the past are 
    [OpenFOAM](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/o/OpenFOAM/),
    [CDO](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/c/CDO/),
    [NCO](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/n/NCO/),
    [PETSc](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PETSc/) and
    [libdap](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/libdap/).

    These jobs will fail immediately so no billing units will be wasted.

    There is no other solution to this problem than to completely reinstall these packages,
    and likely you'll have to use the latest compiler and/or LUMI stack to be fully safe.

-   Do consider recompiling GPU software, even if it still seems to work just fine. 
    This can give you the performance benefits of a newer compiler version, but 
    several ROCm(tm) libraries have also seen huge performance increases in certain
    scenarios compared to ROCm(tm) 6.0.3.

-   Consider moving to the 25.03 programming environment, and if you are using the 
    LUMI stacks, to the LUMI/25.03 stack, as soon as possible. 
    Much work has already been done in preparing EasyBuild recipes for 
    user-installable packages also.

-   For users using containers: Depending on how you bind Cray MPICH to the container and
    which version of Cray MPICH you use for that, you may have to bind additional packages from
    the system. Note that you may also run into runtime library conflicts between the version
    of ROCm(tm) in the container and the MPI libraries which may expect a different version.
    The LUST is also still gaining experience with this.

    We will also update the AI containers in the coming weeks 
    as especially for those applications, the newer versions of ROCm(tm) 6 that we can now
    support, should already give a performance benefit.

    ROCm(tm) 7.0 is a more difficult proposition as those containers - if they can be built - will
    require the use of a less efficient mpi4py implementation. This however does not matter much to
    most AI software as most software relies primarily on RCCL for fast communication. It will not 
    work with Cray MPICH.

    ROCm(tm) 7.1 and higher cannot be supported at all at the moment. They do not only need a further
    driver update, but also a further update of the OS to a version that is not yet fully supported on
    our hardware.


## FAQ

See the 
[separate "Frequently Asked Questions" page](202601_FAQ.md)
that will be compiled from questions asked by users after the first few user coffee breaks after the update.


## Other documentation

See the 
[separate "Documentation links" page](202601_Documentation.md)
for links to the relevant documentation for Slurm and CPE components.
