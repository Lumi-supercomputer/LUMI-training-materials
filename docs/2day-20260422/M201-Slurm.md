# Slurm on LUMI

*Presenter: Tuomas Lunttila (LUST)*

Slurm is the batch job scheduler used on LUMI. As no two Slurm configurations are
identical, even an experienced Slurm user should have a quick look at the notes of this
talk to understand the particular configuration on LUMI.


## Materials

<!--
Materials will be made available after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20260422/recordings/LUMI-2day-20260422-201-Slurm.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20260422/files/LUMI-2day-20260422-201-Slurm.pdf)

-   [Course notes](201-Slurm.md)

-   [Exercises](E201-Slurm.md)


## Q&A


1.  Do we have to take into account the full machine runs when booking for normal jobs? If the system is drained of jobs for the last Sunday of the month.

    -   You don't book time on a supercomputer. You submit jobs and the scheduler decides when they will run. You don't know in advance then they will run. And everything is re-evaluated every few minutes based on the priorities of each of the jobs that are in the queue. It is also not "first come, first served". See the slide on "Queueing and fairness". This is also why a large supercomputer is not good for interactive work. But batch jobs guarantee that the resources can be optimally used and that the machine can be kept as busy as possible, also during the night and during the weekend.

2.  Does `salloc` reserves a part of login node, or part of some interactive node?

    -   It reserves resources in the partition where you request resources. But you're running ahead of the presentation. Once you have your allocation, you start job steps in the allocation where the work is done. So with `salloc` you still have to start actual work with `srun`. There are examples coming later in the lecture.

3.  With allocations per node, do we still need to specify the memory that we want to use, or is it enough to just specify the number of nodes we need and is it then automatically assigned?

    -   You don't need to do on standard and standard-g, but if you would request an exclusive node on small or small-g and don't use `--mem`, you don't get all the memory as there is a default per task set for these partitions that is less.

    -   It is also a "safety measure", as Tuomas said before. if you ask for the "right amount" of memory you are guaranteed a healthy node with that amount, if you don't and something went wrong with the node cleaning procedure that node can be given to you, and you may get an unexpected out-of-memory error. This should not happen nowadays, but it happened in the past.

4. If there is only one task, is there a difference between `--mem` and `--mem-per-cpu`?

    -   `-mem` is memory per node. The value you specify there will be different from what you specify for `--mem-per-cpu` unless you task also has only one CPU. But frankly, LUMI is not really made to run single core jobs... Also, but that is still coming, you're not just billed for the amount of cores you use, but also for the amount of memory (and number of GPUs). If you would be using only one core but ask half of the memory of the node, you will still be billed for half the node.
    
    Thanks. I'm thinking about a case, e.g. 
    `--nodes=1 --ntasks=1 --cpus-per-task=<all> --mem=<all_node_mem>`
    vs
    `--nodes=1 --ntasks=1 --cpus-per-task=<all> --mem-per-cpu=<if_multiplied_by_cpus-per-task_equals_to_all_node_mem>`
    Any difference here?

    -   No, but the first is a lot easier to write...


5.  Would you recommend using 'module purge' in batch job scripts on Lumi?

    -   I personally would, and explicitly load the correct LUMI and partition module (or CrayEnv module) to ensure that your job script runs in the intended environment. Launching a job script from a different environment than intended can lead to issues that are impossible to debug.




