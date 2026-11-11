# LUMI Software Stacks

*Presenter: Kurt Lust (LUST)*

In this presentation we discuss how application software is made available to
users of LUMI. For users of smaller Tier-2 clusters with large support teams compared
to the user base of the machine, the approach taken on LUMI may be a bit unusual...


## Materials

<!-- Materials will be made available after the lecture -->

<!--
<video src="https://462000265.lumidata.eu/2day-20261109/recordings/105-SoftwareStacks.mp4" controls="controls"></video>
-->
-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2day-20261109/files/LUMI-2day-20261109-105-SoftwareStacks.pdf)

-   [Course notes](105-SoftwareStacks.md)

-   [Exercises](E105-SoftwareStacks.md)


## Q&A

1.  When we are using EasyBuild will it still upset Lastre

    -   Yes if you use it in an inconsiderate manner it can still upset the lustre filesystem.

        EasyBuild itself also puts some load on the filesystem as Python software with lots of small EasyConfigs, but at least it spends most of its time compiling, etc., and we set up EasyBuild to do that on RAM disks as much as possible.


2. If we load cray python module from our project folder and execute some python app, will it still run from Login node / dev G

    -   If you execute a python script after loading the cray-python module yes it will execute on the login node. If you do an srun command it will remember what modules you have loaded and bring them into the running job. If this does not answer your question please feel free to elaborate


