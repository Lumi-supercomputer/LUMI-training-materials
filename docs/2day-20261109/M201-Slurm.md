# Slurm on LUMI

*Presenter: Tuomas Lunttila (LUST)*

Slurm is the batch job scheduler used on LUMI. As no two Slurm configurations are
identical, even an experienced Slurm user should have a quick look at the notes of this
talk to understand the particular configuration on LUMI.


## Materials

<!-- Materials will be made available after the lecture -->

<!--
<video src="https://462000265.lumidata.eu/2day-20261109/recordings/201-Slurm.mp4" controls="controls"></video>
-->
-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2day-20261109/files/LUMI-2day-20261109-201-Slurm.pdf)

-   [Course notes](201-Slurm.md)

-   [Exercises](E201-Slurm.md)


## Q&A

1.  Is it necessary to clean the modules that may have been loaded or the job would clean that for you when it starts 

    -   Slurm does not start with a clean sheet by default but with the setup you had when you launched the job. So it may be a good idea to even do a `module purge`, but ensuring that you have all modules loaded that you need in the job script already goes a long way.


2.  If I install Flux as a module in my private space and use would that cause issues for the system or others ?

    -   We have no experience with Flux and cannot answer that question.

        But as far as I can see from the documentation is should be possible to run Flux inside a Slurm batch job as a subscheduler. But this will limit Flux to the resources of that particular job and hence also the end time of that job. 
           - Thank you

3.  Are you billed based on the amount of time a job has run or how much was allocated. E.g. if a 24 hour job crashed 2 hours in, do you then "pay" for all 24 hours?

    -   You are only billed for the actual runtime, not the time requested for the allocation. It is still important to not overestimate your runtime too much, especially if it would be a relatively short job, as that increases the chances to run in backfill.

        But that requires that it crashed in a way that the job script actualle ends of course. If it simply hangs and the job script only gets killed because of a time-out, you will be billed for the whole time the script "ran". So be particularly careful with depending on things that are external to LUMI, like getting data from outside in a running job, as then external sources may also cause programs to hang on LUMI.


4.  Little more explanation on the difference between `srun` and `sbatch` if you have time, specially when to use it, would be nice. With Intel MPI I used to use srun(with ranks equals to cores directly specified) for some reason admins adviced and for python programs sbatch.

    -   `sbatch` start a job and the so-called batch job step in that job. The batch job step has all resources on the first node of the allocation.

        A job in Slurm is just a bunch of resources and does no work. All work is done in job steps.
        
    -   `srun` then starts a job step. It is preferably run inside an existing job created with `sbatch` or `salloc`. If there is no job, then `srun` will start a job also to run the jobstep, but that can have side effects as some options work subtly differently in `sbatch` and in `srun`. So although I realise that many users also abuse `srun` to create the job, this is not a good idea and it also makes debugging the job a lot harder if things go wrong. It is better to start MPI programs also inside a job that you already created with `sbatch` or `salloc`.

    -   The confusing thing - and some sysadmins don't realise because that distinction did not exist in some older resource managers like Torque - is that there is a distinction between a job and a job step and you need to realise the difference between them. A job is just a collection of resources, work is done in job steps that run inside that collection of resources, or even just a subset of those.

5.  If I have 10 tasks that each require 10 nodes, is there a difference whether I request 100 nodes and distribute the tasks between nodes inside the batch script, or submit 10 different smaller jobs?

    -   You jobs will start a lot faster when they are split over 10 10-node jobs. After all, for a 100 node job, Slurm first needs to find 100 empty nodes, so it takes time to collect those, and during that time they can only be used for backfill. So 10 10-node jobs rather than 1 100-node job is better for the length of the queues. Also, if those 10 10-node jobs don't take the same amount of time, you will pay more for the single 100-node job as that will only end when all 10-node subjobs have ended.

        Subscheduling inside a job only makes sense for short jobs or jobs that are smaller than 1 node as they create a lot of scheduling overhead (and you can run in the limit of number of jobs you have in the queue). After all, before and after every job Slurm does a lot clean-up and some tests on the proper working of the nodes, and that also eats resources (that you are currently not billed for on LUMI, but I know systems where they also charge a small fixed amount per job start). For jobs smaller than 1 node, it makes sense because you have more control over what happens on the node. Because even though jobs get their own cores, they still share L3 caches and memory bandwidth with the other jobs on a node, so jobs from other users on a node may influence the performance of your job. As the speaker said, if you take a full node and distribute yourself over that node, than only you are to blame for erroneous performance.


6.  Would `sbatch --dependency=` better option than heterogenous jobs?

    -   No. Heterogenous jobs have a totally different purpose. The components have to run together as if they are a single job and in a single `MPI_COMM_WORLD`. `--dependency` is for jobs that depend on one another but do not need to run together. It is, e.g., a way to split up a 4-day job in two 2-day jobs while submitting them together: You make sure that the first job makes a checkpoint in time before the job ends and then the second step starts from that checkpoint. GROMACS, e.g., has the option to make a checkpoint after a certain time and then end. More HPC codes should implement that feature...
