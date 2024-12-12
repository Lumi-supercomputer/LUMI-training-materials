# Exercises 4: Running jobs with Slurm

## Intro

For these exercises, you'll need to take care of some settings:

-   For the CPU exercises we advise to use the `small` partition and for the 
    exercises on GPU the `standard-g` partition.

-   During the course you can use the course training project `project_465001603`
    for these exercises. A few days after the course you will need to use a different project
	on LUMI. 

-   On December 11 we have a reservation that you can use (through `#SBATCH --reservation=...`):
  
    -   For the `small` partition, the reservation name is `LUMI_Intro_small`

    -   For the `standard-g` partition, the reservation name is `LUMI_Intro_standard-g`

An alternative (during the course only) for manually specifying 
the account, the partition and the reservation, is to set
them through modules. For this, first add an additional directory to the module search path:

```
module use /appl/local/training/modules/2day-20241210
```

and then you can load either the module `exercises/small` or `exercises/standard-g`.

!!! Note "Check what these modules do..."
    Try, e.g., 

	```
	module show exercises/small
	```

	to get an idea of what these modules do. Can you see which environment variables they set?


## Exercises

<!--
Exercises will be made available during the course
-->


-   Start with the [exercises on "Slurm on LUMI"](E07-Slurm.md)
-   Proceed with the [exercises on "Process and Thread Distribution and Binding"](E08-Binding.md)


## Q&A

1.  Question related to Hybrid MPI/OpenMP: `ntasks-per-node` defines the number of cores or MPI ranks and `cpus-per-task` defines number of threads per task or per rank? You mentioned that there are two threads per core so how come 16 threads per task is possible? May be I am missing something!

    -   `ntasks-per-node` does exactly what it says: Tasks per node, so MPI ranks in most cases. It says nothing about cores available to each MPI rank (default is 1). `cpus-per-task`  then says how many cores should be reserved for each task.

2.  So in case of `nodes=1`, `ntasks-per-node = 8` and `cpus-per-task=16` how many cpu hours will be billed if this runs for 1 hour?

    -   In this case it is easy because you are filling entire nodes on LUMI-C, so the amount of memory that you consume is not a factor. It will be 128 CPU hours per hour that the job runs.

3.  For adjusting the `Makefile` for lumi, does one need to add the corresponding `CFLAGS` line in the `Makefile`?

    -   That depends. There are other ways to set environment variables that a Makefile can use. And it depends on how the rules are defined in the Makefile. Is it for one of the exercises of this course? 

    Yes it is the advanced exercise I was trying.

    -   They didn't specify an optimisation level while it is typically safer to add that, but apart from that the options are OK for the Cray compiler (`PrgEnv-cray`). For this particular program, which runs in a fraction of a second, optimisation level is of course not that important...
    
    However, to follow the exercise to make this for `lumi`, does one need to replace `-D__HIP_ARCH_GFX90A__` flag to corresponding `rocm` architecture?

    -   No, that is why I asked to compile with `make LMOD_SYSTEM_NAME="frontier"`, as that should enable the proper line in the Makefile to do that. The test on line 18 should then ensure that the code on line 19 is executed which adds the proper flags. Frontier has almost exactly the same node type as LUMI, only 3 times more...

    -   Just to be more clear, the gpu architecture on lumi is the GFX90A


