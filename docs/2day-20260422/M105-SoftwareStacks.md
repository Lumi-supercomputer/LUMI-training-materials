# LUMI Software Stacks

*Presenter: Kurt Lust (LUST)*

In this presentation we discuss how application software is made available to
users of LUMI. For users of smaller Tier-2 clusters with large support teams compared
to the user base of the machine, the approach taken on LUMI may be a bit unusual...


## Materials

<!--
Materials will be made available after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20260422/recordings/LUMI-2day-20260422-105-SoftwareStacks.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20260422/files/LUMI-2day-20260422-105-SoftwareStacks.pdf)

-   [Course notes](105-SoftwareStacks.md)

-   [Exercises](E105-SoftwareStacks.md)


## Q&A

1.  Are `Local-CSC` modules well aligned with LUMI hardware?

    -   Yes. That software is also mostly compiled specifically for LUMI. The few packages that come as binaries are
        an exception, but CSC did check if they run as intended.

2.  Why static linking is important when installing the toolchains 

    -   You mean in installing software. One advantage of static linking is that you can have no library conflicts when running the software as no shared libraries are used where code may pick up the wrong one. Though rpath or runpath linking do that to. The other advantage is that parallel applications will load a lot faster as you are only loading a single larger file rather than several smaller files. But the Cray PE cannot link everything statically. Shared libraries help if multiple users are running different packages that use the same libraries as these libraries are then loaded only once. So they are very useful on a typical workstation or server. But if you run a scientific code on an exclusive node, you're basically at most running the same binary in multiple processes (each MPI rank) so there is no benefit in terms of memory use to shared libraries.


