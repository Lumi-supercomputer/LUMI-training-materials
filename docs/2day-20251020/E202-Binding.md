# Exercises: Process and Thread Distribution and Binding

## Exercises on the Slurm allocation modes


1.  We return to the hybrid MPI/OpenMP example from the
    [Slurm exercises](E201-Slurm.md). 
   
   	```
	#!/bin/bash -l
	#SBATCH --partition=small           # Partition (queue) name
	#SBATCH --nodes=1                   # Total number of nodes
	#SBATCH --ntasks-per-node=8         # 8 MPI ranks per node
	#SBATCH --cpus-per-task=16          # 16 threads per task
	#SBATCH --time=5                    # Run time (minutes)
	#SBATCH --account=<project_id>      # Project for billing

	module load LUMI/24.03
	module load lumi-CPEtools/1.2a-cpeGNU-24.03

	srun --cpus-per-task=$SLURM_CPUS_PER_TASK hybrid_check -n -r
	``` 

    Improve the thread affinity with OpenMP runtime variables. 
    Alter the above script and ensure that each thread is bound to
    a specific core. 

	??? Solution "Click to see the solution."
		
		Add the following OpenMP environment variables definition to your script:
		
		```
		export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
		export OMP_PLACES=cores
		export OMP_PROC_BIND=close
		```
		
		To avoid having to use the `--cpus-per-task` flag, you can also set the environment variable `SRUN_CPUS_PER_TASK`
		instead: 
		
        ```
		export SRUN_CPUS_PER_TASK=16 
		```

		On LUMI this is not strictly necessary as the Slurm `sbatch` processing has been modified to set
		this environment variable, but that was a clunky patch to reconstruct some old behaviour of Slurm
		and we have already seen cases where the patch did not work (but that were more complex cases that
		required different environment variables for a similar function).

		The list of environment variables that the `srun` command can use as input, is actually confusing, as
		some start with `SLURM_` but a few start with `SRUN_` while the `SLURM_` equivalent is ignored.

		So we end up with the following script:

		```
		#!/bin/bash -l
		#SBATCH --partition=small           # Partition (queue) name
		#SBATCH --nodes=1                   # Total number of nodes
		#SBATCH --ntasks-per-node=8         # 8 MPI ranks per node
		#SBATCH --cpus-per-task=16          # 16 threads per task
		#SBATCH --time=5                    # Run time (minutes)
		#SBATCH --account=<project_id>      # Project for billing

		module load LUMI/24.03
		module load lumi-CPEtools/1.2a-cpeGNU-24.03

		export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

		export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
		export OMP_PROC_BIND=close
		export OMP_PLACES=cores

		srun hybrid_check -n -r
		``` 


    ??? Note "Using `MPICH_CPUMASK_DISPLAY`"
        Cray MPICH can also return information about the CPU mask per process in binary form (a long string of zeros and ones)
		where the last number is for core 0. For this, you need to set

		```
		export MPICH_CPUMASK_DISPLAY=1
		```

		You'll see that with the OpenMP environment variables set as in the example,
		it will look like only one core can be used by each MPI task, but that is because it only
		shows the mask for the main process which becomes OpenMP thread 0. Remove the OpenMP environment
		variables and you'll see that each task now gets 16 possible cores to run on, and the same is true
		for each OpenMP thread (at least when using the GNU compilers, the Cray compilers have different
		default behaviour for OpenMP which actually makes more sense for most scientific computing codes).

		The format in which the mask is reported, is different from that used by `hybrid_check`, where
		the first digit corresponds to core 0. The `MPICH_CPUMASK_DISPLAY` style of reporting corresponds
		to the way Slurm CPU masks for `--cpu-bind` are constructed.

2.  **Binding on GPU nodes:**
    Allocate one GPU node with one task per GPU and bind tasks to each CCD (8-core group sharing L3 cache) 
    leaving the first (#0) and last (#7) cores unused. 
	Run a program with 6 threads per task and inspect the actual task/threads affinity
	using the 	`gpu_check` command from the `lumi-CPEtools` module.

	??? Solution "Click to see the solution."
		
		We can chose between different approaches. In the example below,
		we follow the 
		"GPU binding: Linear GCD, match cores" 
		slides and we only need to adapt the CPU mask:
		
		```
		#!/bin/bash -l
		#SBATCH --partition=standard-g      # Partition (queue) name
		#SBATCH --nodes=1                   # Total number of nodes
		#SBATCH --ntasks-per-node=8         # 8 MPI ranks per node
		#SBATCH --gpus-per-node=8           # Allocate one gpu per MPI rank
		#SBATCH --time=5                    # Run time (minutes)
		#SBATCH --account=<project_id>      # Project for billing
		#SBATCH --hint=nomultithread
		
		module load LUMI/24.03 partition/G
		module load lumi-CPEtools/1.2a-cpeGNU-24.03

		cat << EOF > select_gpu_$SLURM_JOB_ID
		#!/bin/bash
		export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
		exec \$*
		EOF
		chmod +x ./select_gpu_$SLURM_JOB_ID
		
		CPU_BIND="mask_cpu:0x7e000000000000,0x7e00000000000000,"
		CPU_BIND="${CPU_BIND}0x7e0000,0x7e000000,"
		CPU_BIND="${CPU_BIND}0x7e,0x7e00,"
		CPU_BIND="${CPU_BIND}0x7e00000000,0x7e0000000000"
		
		export OMP_NUM_THREADS=6
		export OMP_PROC_BIND=close
		export OMP_PLACES=cores
		
		srun --cpu-bind=${CPU_BIND} ./select_gpu_$SLURM_JOB_ID gpu_check -l
		```

		The base mask we need for this exercise, with each first and last core of a chiplet disabled,
		is `01111110` which is `0x7e` in hexadecimal notation (though using `0xfe`
		as the building block would also have worked as we already limit the number
		of threads to 6 through `OMP_NUM_THREADS` and use other binding variables
		that will bind all threads as close as possible to the core with relative
		number 1 of each chiplet).

		Save the job script as `job_step.sh` then simply submit it with sbatch. Inspect the job output.
		
		Note that in fact, if you had used the `cpeCray` version of the
		`lumi-CPEtools` module, 
		you don't even need to use the `OMP_*` environment variables above as the threads are 
		automatically pinned to a single core and as the correct number of threads is derived from
		the affinity mask for each task.
