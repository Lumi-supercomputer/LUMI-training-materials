# Changes after the update of October-November 2023

**These notes are somewhat preliminary as LUST is also still exploring the
changes to the system. We have opted to make the system accessible to users
as soon as possible but that does not imply that all problems caused by the
update are solved already. These notes will be adjusted accordingly.**

**We advise to carefully test if all your software is still working properly
before submitting large batches of jobs. Expect that some jobs that are still
in the queue from before the maintenance will fail.**

The main purpose of the update in late October and early November 2023 were the
addition of 512 nodes to the LUMI-C `standard` partition and the installation of
various patches in the operating system to further improve the stability of the
system. 

The [notes of the August 2023 update](../Update-202308/index.md) are still relevant!


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
base for the Cray Compiling Environment compilers, and AOCC 4.0 for the AMD CPU-only
compilers.

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

In the coming weeks, LUST will work on a set of base libraries and additional EasyBuild
recipes for work with the 23.09 release of the Cray PE.

The 23.09 version of the Cray PE should also be fully compatible with the next LTS release
of the Cray OS and management software distribution except that at that time a newer version
of ROCm will become the basis.
