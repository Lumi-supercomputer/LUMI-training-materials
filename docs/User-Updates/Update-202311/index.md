# Changes after the update of October-November 2023

**Last update of this document: November 17, 2023.**

**We advise to carefully test if all your software is still working properly
before submitting large batches of jobs. Expect that some jobs that worked 
before the maintenance will fail now.**

The main purpose of the update in late October and early November 2023 were the
addition of 512 nodes to the LUMI-C `standard` partition and the installation of
various patches in the operating system to further improve the stability of the
system. 

The [notes of the August 2023 update](../Update-202308/index.md) are still relevant!


## Known broken features (workaround available)

The `cray-mpich/8.1.18`, `cray-mpich/8.1.23` and `cray-mpich/8.1.25` modules for
the CCE compiler are currently broken on LUMI. This manifests itself in several
ways:

*   The modules are invisible when one of the `cce` compiler modules is loaded.

*   Loading software for `cpeCray/22.08`, `cpeCray/22.12` or `cpeCray/23.03` in the
    LUMI software stacks produces errors.

*   Changing the default version of the PE to 22.08, 22.12 or 23.03 by loading the
    matching `cpe` module will fail if `PrgEnv-cray` is loaded. Likewise, switching
    to `PrgEnv-cray` with one of these `cpe` modules loaded, will fail. 

*   The same hold when you try to load one of the `cce` modules by hand with one of
    the `cray-mpich` modules mentioned above loaded for a different compiler.

The root cause of the problems is that HPE Cray now makes libraries available for 
the LLVM ABI version 14.0. All packages on the system, also those for older versions of the
Cray PE, were properly upgraded in the process except the MPICH packages for 
22.08, 22.12 or 23.03.

<!--
We are trying to figure out if this can be repaired or if workarounds will be needed,
and if so, which workarounds are acceptable as some workarounds have side effects for
other compilers also.
-->

<!--
Note that using `cray-mpich/8.1.27` should be fine, also when using any compiler
version from 22.08, 22.12, 23.03 (for CCE this would be `cce/14.0.2`, `cce/15.0.0` 
or `cce/15.0.1`). In fact, as this is the default version, unless you enforce a
particular version of Cray MPICH by prepending `LD_LIBRARY_PATH` with 
`CRAY_LD_LIBRARY_PATH` or using rpath-linking, you'll be running with libraries
from this module anyway. So with software compiled in the login environment or
in `CrayEnv`, you can always force-load specific versions of compiler modules
and other modules and use `cray-mpich/8.1.27` as the version for Cray MPICH.
-->

### Update Monday November 13, 2023: Workaround

Changes have been made to the module system to automatically replace any attempt 
to load `cray-mpich/8.1.18`, `cray-mpich/8.1.23` or `cray-mpich/8.1.25` with a 
load operation of `cray-mpich/8.1.27`. As it is not possible to do this selectively
only for the Cray MPICH modules for the Cray Compilation Environment, the switch 
is done **for all compilers**. 

The confusing bit is that you will still see these modules in the list of available
modules, dependent on whether you have the LUMI stacks loaded or one of the other ones,
on which cpe* module you have loaded in the LUMI stacks, or which compiler module
you have loaded. You can however no longer load these modules, they will be replaced
automatically by the `cray-mpich/8.1.27` as this rule has precedence in Lmod.

Note that using `cray-mpich/8.1.27` should be fine, also when using any compiler
version from 22.08, 22.12, 23.03 (for CCE this would be `cce/14.0.2`, `cce/15.0.0` 
or `cce/15.0.1`). In fact, as this is the default version, unless you enforce a
particular version of Cray MPICH by prepending `LD_LIBRARY_PATH` with 
`CRAY_LD_LIBRARY_PATH` or using rpath-linking, you'll be running with libraries
from this module anyway. Hence we expect a minimal impact on software already
on the system, and certainly far less impact than the underlying problem has.



## OS patches

Several patches have been applied to the SUSE OS on the login nodes and Cray OS on
the compute nodes (as both are in sync with the latter based on SUSE but with some
features disabled that harm scalability). This version of the Cray operating system
distribution is still based on the AMD GPU driver from ROCm 5.2.3. As a consequence of this,
ROCm 5.2.3 is still the official version of ROCm on LUMI, whereas AMD also promises
compatibility with versions 5.0 till 5.4. Many features of 5.5 and 5.6 work just
fine if you install those versions in a container. Version 5.5 should also be 
compatible with the MPI libraries of the Cray PE version 23.09.

On LUMI we use the LTS (long-term service) releases of the HPE Cray operating system
and management software stack. Support for a newer ROCm driver should be part of the
next update of that stack expected to appear later this year, but after past 
bad experiences with bugs in the installation procedure slowing down the update process
we do not want to be the first site installing this update.


## 23.09 programming environment

The major novelty of this release of the Cray PE is the move to Clang/LLVM 16 as the
base for the Cray Compiling Environment compilers. After a future update of the 
Cray OS it should also be possible to use the updated AOCC 4.0 compilers and 
ROCm 5.5 will also be fully supported. However, for this to happen we are waiting
on a new Long-Term Service release of the HPE Cray system software stack for Cray EX
systems.

Not all features of 23.09 are supported on the version of the OS on LUMI. In particular,
though the newest versions of the Cray performance monitoring tools are installed on the
system, they are not fully operational. Users should use the versions of Perftools
and PAPI included with the 23.03 or earlier programming environments.

To make the modules of an older release of the Cray PE the default, load the matching
`cpe` module twice in separate `module load` statements and ignore the warnings. E.g., to
make the modules from the CPE 22.12 the default (and marked with a `D` in the output of
`module avail`), run

```
module load cpe/22.12
module load cpe/22.12
```

As it may be impossible to support programming environments older than 23.09 after the
next system update, we encourage users to transfer to 23.09 when possible.


### Update November 13, 2023: This now also works again for `PrgEnv-cray`.

In the coming weeks, LUST will work on a set of base libraries and additional EasyBuild
recipes for work with the 23.09 release of the Cray PE. However, as Clang 16, on which
the new version of the Cray compilers is based, is a lot more strict about language compliance,
rebuilding the software stack is not a smooth process.

The 23.09 version of the Cray PE should also be fully compatible with the next LTS release
of the Cray OS and management software distribution except that at that time a newer version
of ROCm will become the basis.


### Update November 17, 2023: Software stacks

A lot of base libraries have been pre-installed on the system in the `LUMI/23.09` software
stacks. At the moment, the cpeCray-23.09 version in particular is less extensive than usual.
The reasons are twofold:

-   Boost currently fails to compile with `cpeCray/23.09`. It is currently unclear if this is
    caused to errors in the Boost configuration process or to a bug in the compiler returning
    a wrong value during configuration.

-   Some packages fail to compile due to sloppy code violating C or C++ language rules that
    have been in place for 20 or more years. Clang 16, the basis for the Cray Compilation Environment
    16, is more strict imposing those language standards than previous compilers. In some cases
    we were able to disable the errors and the package compiled, but some software using 
    Gnome GLib so far fails to compile.

Those packages may be added to the software stack at a later date if we find solutions to the
problems, but there is no guarantee that these problems can be solved with the current versions
of those packages and CPE.

We've also started the process of porting user-installable EasyBuild recipes. Some are already
available on the system, others will follow, possibly on request.
