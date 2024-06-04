# Exercise session 9: Cray MPICH

The files for the exercises can be found in `Exercises/HPE/day3/ProgrammingModels`.
Test the Pi example with MPI or MPI/OpenMP on 4 nodes and 4 tasks.
Show where the ranks/threads are running by using the appropriate MPICH environment variable.
Use environment variables to change this order (rank-reordering).

Alternatively, continue with the previous exercises if these are more relevant for your work.


## Materials

<!--
No materials available at the moment.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   See the exercise assignments in
    `/project/project_465001098/Slides/HPE/Exercises.pdf`

-   Exercise files in `/project/project_465001098/Exercises/HPE/day3`

Temporary web-available materials:

-    Overview exercise assignments day 1+2+3 temporarily available on
     [this link](https://462000265.lumidata.eu/4day-20240423/files/LUMI-4day-20240423-3_Exercises_day3.pdf)
-->

Archived materials on LUMI:

-   Exercise assignments in `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-Exercises_HPE.pdf`

-   Exercises as bizp2-compressed tar file in
    `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-Exercises_HPE.tar.bz2`

-   Exercises as uncompressed tar file in
    `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-Exercises_HPE.tar`


## Q&A

5.  If I set --hint=nomultithread, can my task use the second thread of the cpu core, isn't it still the same core? If not, am I missing some performance here? I don't know how the hyperthread/SMT works behind the scene

    -   If you set ` --hint=nomultithread`, you'll get an affinity mask that doesn't include the second hardware thread and there is no way this can be undone later. Affinity masks are the Linux mechanism that Slurm uses at the task level in job steps. 

    I have checked the cgroup hierarchy of the task and also the cpu affinity in /proc/status, 
    in cgroup it will show the CPU id of the second thread but in the cpu affinity, it only shows the 
    first CPU id of the first thread of the core, which is quite confusing.

    -   Slurm only uses cgroups to limit access at the full job step level and job level, not at the task level, 
        as otherwise you'd have problems with shared memory computation for the same reasons that it was explained 
        you should not use, e.g., `--gpus-per-task` for the GPUs. You probably checked for a task in an 
        `srun`  that `--hint=nomultithread` (which is actually the default) and one core per task?

    Yes, it's a task in an srun. o expl, I request 2 tasks and --cpu-per-tasks=2, cgroup ill show that 
    step_0.task_0 and step_0.task_1 has access to cpus 23-26, 87-90, cpu affinity will be 23-24 for task_0 
    and 25-26 for task_1, which is a bit confusing because psutil which shows the logical core will detect 
    that thread 23,24,87,88 are working even if I don't request access to the thread 87,88.   
   
    -   I am not exactly sure what `psutil` is doing, but what you see is normal Slurm behaviour. 
        As LUMI always allocates full cores and as the cgroup is set for the whole job step, 
        your job step which uses 4 cores gets a cgroup containing virtual cores 23-26 and 87-90 
        (assuming LUMI-G), but for each task level the affinity mask will restrict you to two hardware threads, 
        on different physical cores due to the `--hint=nomultithread` . 
        I'd have to dig into what `psutil`  does exactly to understand what it reports. 
        I've never experimented with it on LUMI.   
       
    `psutil` query the data from `/proc` but thank you for explaining, 
    I have an application where I want to monitor cpu/gpu utilization so just want to make sure that our metric is correct. 
    I just thought that the cpu affinity for a task is will also use the logical core like the cgroup.

6.  I am trying to run the MPI-OpenMP (CPU) example with binding option. 
    Can you provide guidance on how to do the correct binding such that one MPI-process should 
    correspond to one NUMA node and that OMP threads spread across cpu-cores within that 
    NUMA node with correct binding. (LUMI-C)

    -   You can use:
        ```
        #!/bin/bash
        #SBATCH -p standard
        #SBATCH --nodes=2
        #SBATCH --exclusive
        #SBATCH --ntasks-per-node=8
        #SBATCH --hint=nomultithread

        export OMP_PLACES=cores
        export OMP_PROC_BIND=true
        export OMP_NUM_THREADS=6

        module load LUMI/2309
        module load partition/C
        module load lumi-CPEtools
        srun -c ${OMP_NUM_THREADS} hybrid_check
        ```
      
        The output will be:
        
        ```
        Running 16 MPI ranks with 16 threads each (total number of threads: 256).

            ++ hybrid_check: MPI rank   0/16  OpenMP thread   0/16  on cpu   0/256 of nid001001
            ++ hybrid_check: MPI rank   0/16  OpenMP thread   1/16  on cpu   1/256 of nid001001
            ++ hybrid_check: MPI rank   0/16  OpenMP thread   2/16  on cpu   2/256 of nid001001
            ++ hybrid_check: MPI rank   0/16  OpenMP thread   3/16  on cpu   3/256 of nid001001
            ++ hybrid_check: MPI rank   0/16  OpenMP thread   4/16  on cpu   4/256 of nid001001
            ++ hybrid_check: MPI rank   0/16  OpenMP thread   5/16  on cpu   5/256 of nid001001
            ++ hybrid_check: MPI rank   0/16  OpenMP thread   6/16  on cpu   6/256 of nid001001
            ++ hybrid_check: MPI rank   0/16  OpenMP thread   7/16  on cpu   7/256 of nid001001
            ++ hybrid_check: MPI rank   0/16  OpenMP thread   8/16  on cpu   8/256 of nid001001
            ++ hybrid_check: MPI rank   0/16  OpenMP thread   9/16  on cpu   9/256 of nid001001
            ++ hybrid_check: MPI rank   0/16  OpenMP thread  10/16  on cpu  10/256 of nid001001
        ```      

        Now, the problem is that there are 4 NUMAs per socket, so 16 cores per each NUMA, 
        but L3 cache is shared across 8 cores only. So the suggestion is to double the ranks-per-node a
        nd have 8 threads instead.
        But you can try and see in terms of performance.

