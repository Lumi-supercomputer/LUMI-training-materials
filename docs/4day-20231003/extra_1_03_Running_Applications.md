# Running Applications

*Presenter: Alfio Lazzaro (HPE), replacing Harvey Richardson (HPE)*

Course materials will be provided during and after the course.

<!--
-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-1_03_Running_Applications.pdf`
    -   `/project/project_465000644/slides/HPE/03_Running_Applications_Slurm.pdf` (temporary, for the lifetime of the project)
-   Recording available on LUMI as:
    `/appl/local/training/4day-20231003/recordings/1_03_Running_Applications.mp4`

These materials can only be distributed to actual users of LUMI (active user account).
-->

## Q&A


12. Are other launchers except `srun` (`mpiexec`, `mpirun`) supported?

    -   No. Only srun works.
  
    What about software precompiled and delivered with own `mpiexec` - we need to wrapper it?
  
    -   This is usually anyway a problem of precompiled software as these are usually build with OpenMPI which is currently not supported on LUMI (only MPICH and ABI compatible ones)

    Have you tried some wrappers for Open MPI, eg [wi4mpi](https://github.com/cea-hpc/wi4mpi)?

    -   No, we haven't and are too small a team to do that. We only support such software for which we can get support elsewhere ourselves. 

    -   Software that hardcodes the name of the MPI process starter is badly written software. That software should be corrected. The MPI standard only tells that there should be a process starter but does not enforce that it should be called `mpirun` or `mpiexec`.

13. If I run a serial exec via sbatch without srun, where is the process running? on the login (UAN) node?

    - It will run on a compute node 

14. So if 'Idle' in the output of `sinfo -s` does not mean available nodes, how can we see the amount of available nodes?
    -   Not sure, if I understand correctly. Why should it notshow the avialable nodes under "idle"?
    -   I guess the question here is how to see nodes that are immediately allocatable, which as far as I know is not possible. "Idle" here would just stand for `not doing anything right now`, not `free to do anything`.
    -   It's quite difficult to know. Because there may be a job in the queue that's going to use the idle nodes. But for the moment, it's still in the queue, waiting its turn. That's why it's difficult/impossible to know which node is immediately available.
    -   You cannot see the truly available nodes because nodes may be available to some jobs but not to others. E.g., if the scheduler expects that it will take another hour to gather enough nodes for the large job that is highest in priority, it may still decide that it is safe to start a smaller half hour job using the nodes that it is reserving for the big job. That process is called "backfill". It is not a good idea to try to manipulate the scheduler and it doesn't make sense either since you are not the only user. By the time you would have read the information about available nodes, they may not be available anymore.

15. In my experience, I never observed a speed-up when using multi-thread (tasks-per-node between 128 and 256) for well-coded MPI applications. Can you make an example of when this would be an advantage? Is it really possible? Does it maybe depend on the PEs?

    -   As the performance of most HPC applications is limited by the performance of the memory bus, it is rare to see an improvement in performance by enabling or disabling hyperthreading. The best thing to do is try it, and hope for a pleasant surprise, but I agree with you that this rarely happens.

    -   Hyperthreading seems to work best with bad code that has lots of unpredictable branches on which a processor can get stuck. It works very well, e.g., on server systems used to run databases.

16. Is there a difference in using srun or salloc to run jobs directly on computing nodes?

    -   Yes. I would advise you not to use `srun` by default to start jobs directly but always use either `sbatch` for batch jobs or `salloc` if you want to run interactively, unless you are aware that using `srun` outside an `salloc` or `sbatch` environment has some options that will work in a different way and can live with that.

    -   `salloc` does not start a job. It only creates an allocation and will give you a shell on the node where you executed `salloc` (typically a login node), and only when you use `srun` to create a so-called job step you will get onto the compute node.

    -   `sbatch` creates an allocation and then executes a script on the first node of that allocation.

    -   The primary function of `srun` is to create a job step inside an existing allocation. However, if it is not run into an allocation, it will also create an allocation. Some options have sligthly diffent meaning when creating a job step and when creating an allocation and this is why `srun` may act differently when run outside an allocation.

