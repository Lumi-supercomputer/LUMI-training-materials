# Slurm on LUMI

A video recording will follow.

<!--
Materials will be made available after the lecture
-->

Extra materials

-   [Slides](https://462000265.lumidata.eu/2day-20240502/files/LUMI-2day-20240502-06-slurm.pdf)

-   [Course notes](06_Slurm.md)


## Q&A

8.  Can we get energy consumption from `sacct` on LUMI ?

    -   No, but you can read them from `/sys/cray/pm_counters/`.     
        You need to read those counters before and after the job (meaning before and 
        after the `srun` command), then do the math and you can have the energy consumption. 
        There are several of them, cpu, gpu and memory. 
        They are only available on compute nodes.

        Note though that it only makes sense when using whole nodes for the job, and that
        there are also shared elements in a cluster whose power consumption cannot be
        measured or assigned to individual jobs, e.g., storage and the interconnect.



