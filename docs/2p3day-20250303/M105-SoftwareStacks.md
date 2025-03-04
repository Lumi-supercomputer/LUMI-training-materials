# LUMI Software Stacks

*Presenter: Kurt Lust (LUST)*

In this presentation we discuss how application software is made available to
users of LUMI. For users of smaller Tier-2 clusters with large support teams compared
to the user base of the machine, the approach taken on LUMI may be a bit unusual...


## Materials

<!--
Materials will be made available after the lecture
-->
<!--
<video src="https://462000265.lumidata.eu/2p3day-20250303/recordings/105-SoftwareStacks.mp4" controls="controls"></video>
-->
-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-105-SoftwareStacks.pdf)

-   [Course notes](105-SoftwareStacks.md)

-   [Exercises](E105-SoftwareStacks.md)


## Q&A

1.  Loading LUMI/24.03 loads PrgEnv-cray module.  Would it be ok to switch to cpeCray?
    
    -    PrgEnv-cray is already loaded by default when you load LUMI/24.03. You can switch to a different PrgEnv using the `module load` command if you want.

2.  Any measurement about the toolchain providing the best BLAS ?

    -   Should be the same libsci, so same codebase. It should have similar performances but depends on compilers

3.  There is an easyconfig for OpenFOAM 10 provided by you, is it straightforward to change and reuse this for other versions?

    -   Sometimes yes, other times no. They change the building procedures and in those cases is not easy at all.


