# LUMI Architecture

*Presenter: Emanuele Vitali (LUST)*

Some insight in the hardware of LUMI is necessary to understand what
LUMI can do and what it cannot do, and to understand how an application can
be mapped upon the machine for optimal performance.


## Materials

<!-- Materials will be made available after the lecture -->

<!--
<video src="https://462000265.lumidata.eu/2day-20261109/recordings/101-Architecture.mp4" controls="controls"></video>
-->
-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2day-20261109/files/LUMI-2day-20261109-101-Architecture.pdf)

-   [Course notes](101-Architecture.md)


## Q&A

1.  Is it possible to submit jobs from LUMI-K. E.g. use a virtual machine as a submit host.

    -   It is Kubernetes and a container platform, not a virtual machine platform.

    -   Technically, yes, but the terms of use indirectly forbid it. The issue is that there are no users on LUMI-K, only projects. So everybody in your project can see everything in that project. To submit a job, you need credentials. So technically you are sharing your credentials which is forbidden. At the moment, you would have to pull from LUMI-K, and I don't see that change during the lifetime of LUMI. 

    -   It is more meant, e.g., to run a database that is then used by your jobs. That database can run permanently, and also has access to filesystems that are much better suited for running databases than the Lustre filesystem.

    -   And there are also security issues if you let the Kubernetes container access LUMI. If that container offers services to the outside world (which is allowed), an intruder who manages to break into your service could then also access LUMI. 

2.  Isn't it that usually threads are disabled on HPC systems, when you ask for tasks you get only physical cores?

    -   It's a little bit more complicated. At the BIOS/UEFI level, they are enabled on LUMI. So, e.g., the second set of registers is always there. At the level of running a job, the default on LUMI but only for a job step started with `srun` is to not use the second hardware thread. But the batch job step will use them all. So it is not the same as turning off the hardware threads at the BIOS/UEFI level as then the second set of registers is not even there and more space is available for the internal register renumbering.


3.  Are all NUMA regions connected all 4 GPUs ?

    -   No, but that is the next slide. It is even more a connection between CPU chiplet and GPU chiplet and that will be an important part of the second talk of tomorrow morning.


