# Exercises 2: Running jobs with Slurm

## Exercises on the Slurm allocation modes

1. Run single task with a job step of `srun` using multiple cpu cores. Inspect default task allocation with `taskset` command (`taskset -cp $$` will show you cpu numbers allocated to a current process). Try with `standard-g` and `small-g` partitions. Are there any diffences? You may need to use specific reservation for `standard-g` partition to avoid long waiting. 

	??? Solution "Click to see the solution."
		
		```
		srun --partition=small-g --nodes=1 --tasks=1 --cpus-per-task=16 --time=5 --account=<project_id> bash -c 'taskset -cp $$' 
		```
		
		Note you need to replace `<project_id>` with actual project account ID in a form of `project_` plus 9 digits number.

		```
		srun --partition=standard-g --nodes=1 --tasks=1 --cpus-per-task=16 --time=5 --account=<project_id> --reservation=<res_id> bash -c 'taskset -cp $$' 
		```
		
		The command runs single process (`bash` shell with a native Linux `taskset` tool showing process's CPU affinity) on a compute node. You can use `man taskset` command to see how the tool works.

2. Try Slurm allocations with `hybrid_check` tool program from the LUMI Software Stack. The program is preinstalled on the system. 

	Use the simple job script to run parallel program with multiple tasks (MPI ranks) and threads (OpenMP). Test task/threads affinity with `sbatch` submission on the CPU partition.
	
	```
	#!/bin/bash -l
	#SBATCH --partition=small-g         # Partition name
	#SBATCH --nodes=1                   # Total number of nodes
	#SBATCH --ntasks-per-node=8         # 8 MPI ranks per node
	#SBATCH --cpus-per-task=6           # 6 threads per task
	#SBATCH --time=5                    # Run time (minutes)
	#SBATCH --account=<project_id>      # Project for billing

	module load LUMI/22.12
	module load lumi-CPEtools

	srun hybrid_check -n -r
	``` 

	Be careful with copy/paste of script body while it may brake some specific characters.

	??? Solution "Click to see the solution."
		
		Save script contents into `job.sh` file (you can use `nano` console text editor for instance), remember to use valid project account name.
		
		Submit job script using `sbatch` command. 
		
		```
		sbatch job.sh
		```
		
		The job output is saved in the `slurm-<job_id>.out` file. You can view it's contents with either `less` or `more` shell commands.
		
		Actual task/threads affinity may depend on the specific OpenMP runtime but you should see "block" thread affinity as a default behaviour.

3. Improve threads affinity with OpenMP runtime variables. Alter your script and add MPI runtime variable to see another cpu mask summary. 

	??? Solution "Click to see the solution."
		
		Export `SRUN_CPUS_PER_TASK` environment variable to follow convention from recent Slurm's versions in your script. Add this line before the `hybrid_check` call:
		
		```
		export SRUN_CPUS_PER_TASK=16 
		```
		
		Add OpenMP environment variables definition to your script:
		
		```
		export OMP_NUM_THREADS=${SRUN_CPUS_PER_TASK}
		export OMP_PROC_BIND=close
		export OMP_PLACES=cores
		```
		
		You can also add MPI runtime variable to see another cpu mask summary:
		
		```
		export MPICH_CPUMASK_DISPLAY=1
		```
		
		Note `hybrid_check` and MPICH cpu mask may not be consistent. It is found to be confusing.

4. Use `gpu_check` program tool using interactive shell on a GPU node to inspect device binding. Check on which CCD task's CPU core and GPU device are allocated (this is shown with `-l` option of the tool program).  

	??? Solution "Click to see the solution."
		
		Allocate resources for a single task with a single GPU with `salloc`:
		
		```
		salloc --partition=small-g --nodes=1 --tasks=1 --cpus-per-task=1 --gpus-per-node=1 --time=10 --account=<project_id>
		```
		
		Note that, after allocation being granted, you receive new shell but still on the compute node. You need to use `srun` to execute on the allocated node. 
		
		You need to load specific modules to access tools with GPU support. 
		
		```
		module load LUMI/22.12 partition/G
		```
		
		```
		module load lumi-CPEtools
		```

	        Run `gpu_check` interactively on a compute node:

                ```
                srun gpu_check -l
                ```       
	
		Still remember to terminate your interactive session with `exit` command.
		
		```
		exit
		``` 

## Slurm custom binding on GPU nodes

1. Allocate one GPU node with one task per GPU and bind tasks to each CCD (8-core group sharing L3 cache). Use 7 threads per task having _low noise mode_ of the GPU nodes in mind. Use `select_gpu` wrapper to map exactly one GPU per task.

	??? Solution "Click to see the solution."
		
		Begin with the example from the slides with 7 cores per task:
		
		```
		#!/bin/bash -l
		#SBATCH --partition=standard-g  # Partition (queue) name
		#SBATCH --nodes=1               # Total number of nodes
		#SBATCH --ntasks-per-node=8     # 8 MPI ranks per node
		#SBATCH --gpus-per-node=8       # Allocate one gpu per MPI rank
		#SBATCH --time=5                # Run time (minutes)
		#SBATCH --account=<project_id>  # Project for billing
		#SBATCH --hint=nomultithread

                module load LUMI/22.12
                module load partition/G
                module load lumi-CPEtools
		
		cat << EOF > select_gpu
		#!/bin/bash
		
		export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
		exec \$*
		EOF
		
		chmod +x ./select_gpu
		
		export OMP_NUM_THREADS=7
		export OMP_PROC_BIND=close
		export OMP_PLACES=cores
		
		srun --cpus-per-task=${OMP_NUM_THREADS} ./select_gpu gpu_check -l
		```
		
		You need to add explicit `--cpus-per-task` option for srun to get correct GPU mapping. If you save the script in the `job_step.sh` then simply submit it with sbatch. Inspect the job output.
		
2. Change your CPU binding leaving first (#0) and last (#7) cores unused. Run a program with 6 threads per task and inspect actual task/threads affinity.

	??? Solution "Click to see the solution."

		Now you would need to alter masks to disable 7th core of each of the group (CCD). Base mask is then `01111110` which is `0x7e` in hexadecimal notation.
		
		Try to apply new bitmask, change the corresponding variable to spawn 6 threads per task and check how new binding works.

		```
		#!/bin/bash -l
		#SBATCH --partition=standard-g  # Partition (queue) name
		#SBATCH --nodes=1               # Total number of nodes
		#SBATCH --ntasks-per-node=8     # 8 MPI ranks per node
		#SBATCH --gpus-per-node=8       # Allocate one gpu per MPI rank
		#SBATCH --time=5                # Run time (minutes)
		#SBATCH --account=<project_id>  # Project for billing
		#SBATCH --hint=nomultithread

                module load LUMI/22.12
                module load partition/G
                module load lumi-CPEtools
		
		cat << EOF > select_gpu
		#!/bin/bash
		
		export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
		exec \$*
		EOF
		
		chmod +x ./select_gpu
		
		CPU_BIND="mask_cpu:0x7e000000000000,0x7e00000000000000,"
		CPU_BIND="${CPU_BIND}0x7e0000,0x7e000000,"
		CPU_BIND="${CPU_BIND}0x7e,0x7e00,"
		CPU_BIND="${CPU_BIND}0x7e00000000,0x7e0000000000"
		
		export OMP_NUM_THREADS=6
		export OMP_PROC_BIND=close
		export OMP_PLACES=cores
		
		srun --cpu-bind=${CPU_BIND} ./select_gpu gpu_check -l
		```
