# Slurm on LUMI

*Presenter: Jorik van Kemenade*

Slurm is the batch job scheduler used on LUMI. As no two Slurm configurations are
identical, even an experienced Slurm user should have a quick look at the notes of this
talk to understand the particular configuration on LUMI.


## Materials

<!--
Materials will be made available during and after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20241210/recordings/07-Slurm.mp4" controls="controls"></video>

-   [Slides](https://462000265.lumidata.eu/2day-20241210/files/LUMI-2day-20241210-07-Slurm.pdf)

-   [Course notes](07-Slurm.md)  (based on an earlier version of the presentation and not thoroughly tested again)

-   [Exercises](E07-Slurm.md)

<!--
-   A video recording will follow.
-->


## Q&A

1.  In my `bashrc` I load a lot of module, is there a nice way (beside defining an environment variable) to supres the processing of the `bashrc`?

    -    as far as i know, `!#/bin/bash` is not processing the bashrc. to launch a new shell that will process the bashrc you need to use `!#/bin/bash -l` . Note that the new shell that you start, even with `!#/bin/bash`, will inherit the environment from the parent (that is why it seems that you run the bashrc there). My personal suggestion is to keep `bashrc` clean, and have a different bash function to load all the modules or by creating an environment file that you can source after login. (Kurt) This also what I use as I have different environments and each even has some aliases defined to quickly go to the directories of the corresponding project.


2.  Why is it possible to submit only 2 dev jobs? And why limit amount of submitted jobs at the first place, can they all just sit in the queue?

    -   2 is already a lot. The dev partition is meant for actively debugging and profiling. I can't see how a single user can be actively debugging more than one application at a time. It is really for interactive work and if we allow users to use it as any other partition, it doesn't make sense to have a `dev-g`  partition. If we note abuse for running things which are really autonomous "production" runs to bypass queues, it is considerd breaking the conditions of use of LUMI. 

    -   And a limit on the number of jobs submitted: There is a limit to the number of jobs that Slurm can handle. Even if they are just in the queue, because Slurm is continuously re-evaluating permissions. Too many jobs in the queue and (a) it becomes for admins impossible to get an overview of the queue and (b) Slurm would slow down a lot. So the more users a system has, the lower the number of jobs that will be allowed per user. This is just another example of what was said yesterday: Use the right size of system for your work.

    -   Moreover, Slurm is meant to schedule significant fractions of a cluster. If you need very fine-grained scheduler, you really need to use a "scheduler-within-the-scheduler": A subscheduler in your job to manage your small work. 

3.  I have been granted with resources only on standard and standard-g, can I use dev-g for interactive profiling?

    -    Yes. You receive CPU hours or GPU hours, and you can spend them on all different partitions (standard, small, dev)


4.  Is this slide the most recent or the website: https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/partitions/ (the dev-g numbers are different)?

    -   Looks like the slide was not adapted. The number in the docs is currently the correct one. But these numbers do change over time. 

    -   You can control the actual values using `scontrol show part dev-g`

5.  Does this mean that if you run lots of jobs, your next job will be "lower priority"? (Or did I misunderstand this? :)

    -    Ideally, yes. slurm tends to share resources between projects and users. And this is one of the reasons why your job in the queue may be overtaken by one that is more recently submitted.


6.  How can I find the tasks in LUMI that have been finished/calculated and ran in the past two days/24h? Can you give me some tips and guidance?

    -   The `sacct` command is your friend and was discussed at the end of the presentation.


7.  Where can I find more about scheduling policy of SLURM that prioritize the job? Is it covered in the documentation somewhere?

    -   No, and it is also not important. It may change without notice to keep the ocupation of the system optimal. Moreover, the conditions of use of LUMI forbid trying to exploit weaknesses in the system for your own advantage, and specifically overengineering jobs for that purpose is one example of this. If you want a job to start quickly, basically be reasonable. Don't ask for more nodes than you need because big jobs tend to increase the waiting time for everybody. Don't ask for more walltime than needed as then your job so that it becomes a better candidate for backfill. 


8.  For my understanding of `salloc` and `srun`; If I run `salloc` I will end up on a node, where I have a potentially access on the full node (if I am on a shared node), for the sake of argument assume the node has 10 cores and I requested 5, so when i run an MPI program with 10 ranks, then it would associate each rank with one core. However, if I would go through `srun` then two ranks would go to one core. Is this correct or do I miss something?

    -   No, `salloc` does not run any job. it just creates the allocation. you will still be on the login node after that. You need to combine `salloc` and `srun` to run on the compute node. `salloc` -> create allocation `srun` -> start the mpi job on the created allocation.

    Q: So when I run `salloc` on the login node, then I will be send back to the login node, but not a shell on the compute node. When I then run `srun` on the login node, it would run the command - remotely - on the compute node, where I got my allocation?

    -   You are not really sent to compute node with salloc. so technically no going back. salloc command sends a request to scheduler "hey, i need this resources, please do reserve them". when the scheduler makes those resources available, the command ends. And you are still in the same place where you executed that command. To login interactively there are different techniques. Note that is possible to go on those allocated node, but via a srun command (e.g. launching a shell script on one of the allocated nodes). 

9.  How I can debug my batch job if slurm refuses to start it due to some mess in parameters? It just says smth like "resources cannot be allocated" but does not explain if I asked for too much memory or too many jobs or what's the problem.

    -   Too many jobs is a different error message. And if Slurm complains about the number of resources you asked, there is no other way than to check your script by hand and look into the documentation. For memory there is a rule that is valid on all of LUMI: The amount of physical RAM - 32GB is available to users. Slurm error messages are not very precise, but that is also due to the many different ways in which resources can be requested, and parameters can also conflict with one another.

10. Is it possible in lumi to `ssh` to a running node to monitor resources ? like running `htop`?

    -    Not with `ssh`, but yes. 

    -    The reason for not allowing `ssh` is that everything you start this way, is not under the control of the resource manager. Even though there is an extension to Slurm to ensure that you can only log on to nodes on which you have jobs and that will take care of (trying to) kill all processes you start that way when your last job on a node ends, this is still not safe when multiple users are allowed on the node. The work you start in that `ssh` session is not subject to all your resource limits for your jobs, so you can eat into the resources that were meant for another user and cause trouble for that user. 

11.  Maybe a bit offtopic, but can I monitor GPUs load when I run the job? Like you have shown us running htop on CPU example. I mean some analog of `nvtop` but for AMD and for 8 GPUs.

    -   For simple metrics on your GPU usage you can use rocm-smi. For more information you can use profiling tools like rocprof. In the LUMI training materials archive you can find more information. For example, in the AI course we have a session on understanding GPU usage: https://lumi-supercomputer.github.io/LUMI-training-materials/ai-20241126/extra_04_CheckingGPU/. An extensive introduction to rocprof can be found here: https://lumi-supercomputer.github.io/LUMI-training-materials/4day-20241028/extra_3_09_Introduction_to_Rocprof_Profiling_Tool/. If you look at the sessions of the rest of the 4 day course, you can also find OmniTrace and Omniperf to get even more information on your application performance and GPU usage.

    -   When using `rocm-smi`, check not only that the load is high (close to 100%) but also that the power consumption is around 300W (if only one GCD of a MI250X is used) or around 500W if using both GCDs per GPU. This is important as a GPU can be busy but in reality it just waits for a data or synchronization without actually doing anything.

     -   And there is actually a port of `nvtop` for AMD GPUs and we 
         [do have a user-installable EasyConfig for it](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/n/nvtop/).




