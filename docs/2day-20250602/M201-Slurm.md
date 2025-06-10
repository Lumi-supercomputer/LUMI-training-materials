# Slurm on LUMI

*Presenter: Jorik van Kemenade (LUST)*

Slurm is the batch job scheduler used on LUMI. As no two Slurm configurations are
identical, even an experienced Slurm user should have a quick look at the notes of this
talk to understand the particular configuration on LUMI.


## Materials

Materials will be made available after the lecture

<video src="https://462000265.lumidata.eu/2day-20250602/recordings/201-Slurm.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-201-Slurm.pdf)

-   [Course notes](201-Slurm.md)

-   [Exercises](E201-Slurm.md)

Archived materials on LUMI:

-   Slides: `/appl/local/training/2day-20250602/files/LUMI-2day-20250602-201-Slurm.pdf`

-   Recording: `/appl/local/training/2day-20250602/recordings/201-Slurm.mp4`


## Q&A

1.  Can you explain what `srun` does exactly in comparison to just putting a command in a batch script (e.g. `srun python ....` vs. `python ....`)?
 
    -   `srun` launches parallel processes on allocated cpus (across allocated compute nodes), 
        in other words `srun python` creates `N` instances of the python interpreter where `N` is a number of Slurm tasks, 
        it also inherits threading policy from the Slurm environment; in contrast issuing plain `python` command in the 
        job script creates a single python process. 

2.  Is there any prioritisation on certain type of jobs on slurm? For example are small jobs prefered?

    -   Actually is the opposite: large jobs are slightly favoured. 
        Also, the account is important as slurm tries to be fair and let all user run their jobs, 
        so if many user submit from the same project that may lead to that project losing priority. 
        This is explained in the talk on the slides about fairness.

    -   Anyway, it is always best to be honest in your requests. In fact, the terms of use in LUMI forbid to exploit weaknesses in the system. 
        The scheduler is set up with policies that try to guarantee that everybody gets served in a fair way. 
        The one thing we need a bit more is jobs that are short enough that they would be selected for backfill which harms nobody. 
        Backfill is a mechanism where the scheduler decides to start a lower-priority job to fill an empty hole 
        in the machine why it is gathering nodes for a big job, as long as that is not expected to hold up the big job.

3.  In our project, we have substantial number of similar,small jobs which are going to do similar work 
    and use a similar amount time, do you have any recommendations as to how to best use slurm?

    -   As in the previous answer was said: be honest in your need. don't ask for 6 hours if you only need 2, 
        don't ask for 10 nodes if you only use 5. The scheduler will do his job best if he knows all correct job predicted resource consumption correctly.

    -   But if these jobs are very small, you may want to run multiple of them inside a single job one after another 
        as Slurm is not made to schedule lots of small jobs. The larger the cluster, the smaller the number of jobs 
        a user can submit at a time as Slurm scheduling does not scale across nodes and actually even has trouble 
        using a high core number server as the critical sections in the code (sections that can only run serially) 
        are rather large. Or use subschedulers such as HyperQueue (see also the LUMI Software Library for 
        pointers to that package).

    -   And if you want full control of resources you may want to ask for entire nodes and run multiple of these small 
        jobs next to one another. There are different tricks, either with multiple sruns with resources for a single job each, 
        and putting them in the background (but there are cases where Slurm fails) or a single srun that would start a 
        parallel job where each component of that parallel job would be a single job. This can be useful, e.g., 
        if each of your small jobs would be a shared memory job that runs best inside a single chiplet, or a GPU job 
        that needs a single GPU and you want to ensure optimal communication between the CPU part and the GPU part. 

    -   So there is no easy answer to your question. 
        The best strategy depends a lot on the properties and needs of each of your small jobs...

5.  How can I ssh in the nodes where my job is running so that I can monitor CPU and GPU usage? 
    I'm trying to verify that the job is utilizing the CPUs and GPUs correctly?

    -    You cannot ssh onto the compute nodes is disabled for security reasons. 
         The LUMI documentation shows strategies how to do this with `srun` from the command line [here](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/interactive/). 
         And there is the slide on inspecting a running job in this talk and the notes.


4.  SLURM jobs are automatically logging or you need to do something yourself?

    -   I'm not sure what you mean exactly with logging. All output from all ranks to stdout and stderr is stored 
        in a file in the directory from which you launched the jobs, but the names etc can be influenced with `--output` and `--error`. 
        There was a slide "Redirecting output" about that

    -   Slurm also saves a little bit of other information per job and jobstep in a database and that is what `sacct` is for. 
        It requests information from the database. That includes things like amount of memory used, walltime and cpu time, exit code, ...

