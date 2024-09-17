# Running Applications

*Presenter: Harvey Richardson (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001098/Slides/HPE/03_Running_Applications_Slurm.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-1_03_Running_Applications.pdf`

-   Recording: `/appl/local/training/4day-20240423/recordings/1_03_Running_Applications.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

## Q&A

1.  Can you clarify the differences between: `ntasks-per-core` vs `ntasks-per-node` and `ntasks` in SLURM terminology?

    -   `-ntasks` is the total number of MPI ranks, `-ntasks-per-node` is the number of MPI ranks per each node, 
        e.g. I want to run 128 MPI ranks with 4 ranks per each node (i.e. 32 nodes), 
        so I can use: `--ntasks=128 --ntasks-per-node=4`. 
        The `-ntasks-per-core` is only relevant if you want to use hyperthreads. You can find more info with `man srun`.


2.  What does `$SBATCH --exclusive` do? is it quite mandatory to include it in my bash script when executing sbatch job? 

    -    `exclusive` is set for some queues, so you will get the entire node even if you are asking for less resources 
         (you can use `scontrol show partition standard`, where `standard` is the queue, and check for the "EXCLUSIVE"). 
         And you can use it in the other partitions (e.g., `small` and `small-g`) to get exclusive access to that node 
         (and of course be billed for exclusive acces). But a node in `small` or `small-g` will still not be fully 
         equivalent to a node in `standard` or `standard-g`, as some defaults, e.g., for memory, are set differently.


