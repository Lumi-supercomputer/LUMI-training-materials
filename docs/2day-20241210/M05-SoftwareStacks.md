# LUMI Software Stacks

*Presenter: Kurt Lust*

In this presentation we discuss how application software is made available to
users of LUMI. For users of smaller Tier-2 clusters with large support teams compared
to the user base of the machine, the approach taken on LUMI may be a bit unusual...


## Materials

<!--
Materials will be made available during and after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20241210/recordings/05-SoftwareStacks.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20241210/files/LUMI-2day-20241210-05-SoftwareStacks.pdf)

-   [Course notes](05-SoftwareStacks.md)

-   [Exercises](E05-SoftwareStacks.md)


## Q&A

1.  That sounds rather depressing... Often I simply don't know where to get help and just drop the whole (sub)project for that reason. E.g. when I try to reproduce someone's else work from github and simply cannot install all dependencies to make it work. 

    -   You are welcome to post support request for a specific piece of software. We usually serve a set of recipes to ease installation process of custom software projects.

    -   If is a complex out-of-the-box installation it may still not be supported by LUST, but if you have an EuroHPC-JU project you can try to use the EPICURE support for that (https://epicure-hpc.eu/support-services/)

    -   But the problem with such code is often that it is also research code which has 
        been tested on just a single system and is also only important to a few users, and is old and not updated for a long time so that it doesn't work anymore with new versions of dependencies, so no support organisation can do miracles there... (I'm myself the author of such a package during my Ph.D. and only made it public with a lot of caveats, but then that one had at least documentation which is now often missing.) Some bigger research groups hire a so-called "Research Software Engineer" precisely for such work. It is the computer equivalent for a lab assistant for groups who do experimental research. But somehow the feeling in the compute community is always that it should come for free and someone else should pay the bill... When I did my Ph.D. we had a support group in the department that was about 60% the size of LUST for roughly 100 people instead of 3000.... 
       
        In LUMI one of the rules of thumb that we use when we have to select which software installations we can support and which we can't, is that if software hasn't been maintained for 2 years, we don't do it. Even very well known packages run into trouble as they age. E.g., we failed to install GROMACS 2021 versions with the newest compilers on LUMI and had to tell the user that they had to use a newer version. 

2.  Which MPI tool would you recommend using? Yes, sorry. Thanks!!

    -    Do you mean library? the cray-mpich. mpich also is compatible, but does not have access to some optimizations.

    -    And we do have a build recipe for Open MPI 4.1.6, but we cannot fully support that one. Moreover, if you use that one, you cannot use any library that is already on the system that uses MPI. It has proven useful though to get a package called ORCA to work on LUMI. But we recommend using cray-mpich whenever possible.

