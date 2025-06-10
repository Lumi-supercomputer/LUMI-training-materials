# LUMI Software Stacks

*Presenter: Kurt Lust (LUST)*

In this presentation we discuss how application software is made available to
users of LUMI. For users of smaller Tier-2 clusters with large support teams compared
to the user base of the machine, the approach taken on LUMI may be a bit unusual...


## Materials

Materials will be made available after the lecture

<video src="https://462000265.lumidata.eu/2day-20250602/recordings/105-SoftwareStacks.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-105-SoftwareStacks.pdf)

-   [Course notes](105-SoftwareStacks.md)

-   [Exercises](E105-SoftwareStacks.md)

Archived materials on LUMI:

-   Slides: `/appl/local/training/2day-20250602/files/LUMI-2day-20250602-105-SoftwareStacks.pdf`

-   Recording: `/appl/local/training/2day-20250602/recordings/105-SoftwareStacks.mp4`


## Q&A

1.  What is your opinion on using spack?

    -   There is Spack environment available on LUMI. It is usable but provided as it is, meaning we do not serve custom, optimized Spack packages. Spack is very useful, for development environments in particular.

    -   Spack is very good at creating your own personal environment and our new spack setup will be more oriented towards that kind of use. It is in some sense "Conda but better" for installing properly system-optimised scientific software.

    -   EasyBuild on the other hand is more rigid, and full instructions for one specific version are contained in a file. It is also much easier to customise the content of a module file for one specific combination.

    -   In all, I personally prefer EasyBuild for a very central approach and central stack where specific options are offered, while I prefer Spack if maximum flexibility is required, building a custom environment for a specific project.
