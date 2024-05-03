# Exercises 4: Running jobs with Slurm

For these exercises, you'll need to take care of some settings:

-   For the CPU exercises we advise to use the `small` partition and for the 
    exercises on GPU the `standard-g` partition.

-   During the course you can use the course training project `project_465001102`
    for these exercises. A few days after the course you will need to use a different project
	on LUMI. 

-   On May 3 we have a reservation that you can use (through `#SBATCH --reservation=...`):
  
    -   For the `small` partition, the reservation name is `LUMI_Intro_SURF_small`

    -   For the `standard-g` partition, the reservation name is `LUMI_Intro_SURF_standardg`

An alternative (during the course only) for manually specifying these parameters, is to set
them through modules. For this, first add an additional directory to the module search path:

```
module use /appl/local/training/modules/2day-20240502
```

and then you can load either the module `exercises/small` or `exercises/standard-g`.

!!! Note "Check what these modules do..."
    Try, e.g., 

	```
	module show exercises/small
	```

	to get an idea of what these modules do. Can you see which environment variables they set?


## Exercises on the Slurm allocation modes

1.  In this exercise we check how cores would be assigned to a shared memory program. 
    Run a single task on the CPU partition with `srun` using 16 cpu cores. 
	Inspect the default task allocation with the `taskset` command 
	(`taskset -cp $$` will show you the cpu numbers allocated to the current process). 

	??? Solution "Click to see the solution."
		
		```
		srun --partition=small --nodes=1 --tasks=1 --cpus-per-task=16 --time=5 --account=<project_id> bash -c 'taskset -cp $$' 
		```
		
		Note that you need to replace `<project_id>` with the actual project account ID of the 
		form  `project_` plus a 9 digits number.
		
		The command runs a single process (`bash` shell with the native Linux `taskset` tool showing 
		process's CPU affinity) on a compute node. 
		You can use the `man taskset` command to see how the tool works.

2.  Next we'll try a hybrid MPI/OpenMP program.
    For this we will use the `hybrid_check` tool from the `lumi-CPEtools` module of the LUMI Software Stack. 
	This module is preinstalled on the system and has versions for all versions of the `LUMI` software stack
	and all toolchains and partitions in those stacks.

	Use the simple job script below to run a parallel program with multiple tasks (MPI ranks) and threads (OpenMP). 
	Submit with `sbatch` on the CPU partition and check task and thread affinity.
	
	```
	#!/bin/bash -l
	#SBATCH --partition=small           # Partition (queue) name
	#SBATCH --nodes=1                   # Total number of nodes
	#SBATCH --ntasks-per-node=8         # 8 MPI ranks per node
	#SBATCH --cpus-per-task=16          # 16 threads per task
	#SBATCH --time=5                    # Run time (minutes)
	#SBATCH --account=<project_id>      # Project for billing

	module load LUMI/23.09
	module load lumi-CPEtools/1.1-cpeGNU-23.09

	srun --cpus-per-task=$SLURM_CPUS_PER_TASK hybrid_check -n -r
	``` 

	Be careful with copy/paste of the script body as copy problems with special characters or a double dash may 
	occur, depending on the editor you use.

	??? Solution "Click to see the solution."
		
		Save the script contents into the file  `job.sh` (you can use the `nano` console text editor for instance). 
		Remember to use valid project account name.
		
		Submit the job script using the `sbatch` command:
		
		```
		sbatch job.sh
		```
		
		The job output is saved in the `slurm-<job_id>.out` file. 
		You can view its content with either the `less` or `more` shell commands.
		
		The actual task/threads affinity may depend on the specific OpenMP runtime 
		(if you literally use this job script it will be the GNU OpenMP runtime).

3. Improve the thread affinity with OpenMP runtime variables. 
   Alter the script from the previous exercise and ensure that each thread is bound to
   a specific core. 

	??? Solution "Click to see the solution."
		
		Add the following OpenMP environment variables definition to your script:
		
		```
		export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
		export OMP_PROC_BIND=close
		export OMP_PLACES=cores
		```
		
		You can also use an MPI runtime variable to have MPI itself report a cpu mask summary for each MPI rank:
		
		```
		export MPICH_CPUMASK_DISPLAY=1
		```
		
		Note `hybrid_check` and MPICH cpu mask may not be consistent. It is found to be confusing.

		To avoid having to use the `--cpus-per-task` flag, you can also set the environment variable `SRUN_CPUS_PER_TASK`
		instead: 
		
        ```
		export SRUN_CPUS_PER_TASK=16 
		```

		On LUMI this is not strictly necessary as the Slurm SBATCH processing has been modified to set
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

		module load LUMI/23.09
		module load lumi-CPEtools/1.1-cpeGNU-23.09

		export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

		export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
		export OMP_PROC_BIND=close
		export OMP_PLACES=cores

		export MPICH_CPUMASK_DISPLAY=1

		srun hybrid_check -n -r
		``` 

		Note that MPI returns the CPU mask per process in binary form (a long string of zeros and ones)
		where the last number is for core 0. Also, you'll see that with the OpenMP environment variables
		set, it will look like only one core can be used by each MPI task, but that is because it only
		shows the mask for the main process which becomes OpenMP thread 0. Remove the OpenMP environment
		variables and you'll see that each task now gets 16 possible cores to run on, and the same is true
		for each OpenMP thread (at least when using the GNU compilers, the Cray compilers have different
		default behaviour for OpenMP which actually makes more sense for most scientific computing codes).


4.  Build the `hello_jobstep` program tool using interactive shell on a GPU node. 
    You can pull the source code for the program from git repository 
	[`https://code.ornl.gov/olcf/hello_jobstep.git`](https://code.ornl.gov/olcf/hello_jobstep). 
	It uses a `Makefile` for building and requires Clang and HIP. 
	The `hello_jobstep` program is actually the main source of inspiration for the 
	`gpu_check` program in the `lumi-CPEtools` modules for `partition/G`.
	Try to run the program interactively. 

	??? Solution "Click to see the solution."
		
		Clone the code using `git` command:
		
		```
		git clone https://code.ornl.gov/olcf/hello_jobstep.git
		```
		
		It will create `hello_jobstep` directory consisting source code and `Makefile`.
		
		Allocate resources for a single task with a single GPU with `salloc`:
		
		```
		salloc --partition=small-g --nodes=1 --tasks=1 --cpus-per-task=1 --gpus-per-node=1 --time=10 --account=<project_id>
		```
		
		Note that, after allocation is granted, you receive new shell but are still on the compute node. 
		You need to use the `srun` command to run on the allocated node. 
		
		Start interactive session on a GPU node:
		
		```
		srun --pty bash -i
		```
		
		Note now you are on the compute node. `--pty` option for `srun` is required to interact with the remote shell.
		
		Enter the `hello_jobstep` directory and issue `make` command. 
		
		As an example we will built with the system default programming environment, `PrgEnv-cray` in `CrayEnv`. 
		Just to be sure we'll load even the programming environment module explicitly.

		The build will fail if the `rocm` module is not loaded when using `PrgEnv-cray`.
		
		```
		module load CrayEnv
		module load PrgEnv-cray
		module load rocm
		```
		
		To build the code, use

		```
		make LMOD_SYSTEM_NAME="frontier"
		```
		
		You need to add `LMOD_SYSTEM_NAME="frontier"` variable for make as the code originates from the Frontier system
		and doesn't know LUMI.
		
		(As an exercise you can try to fix the `Makefile` and enable it for LUMI :))
		
		Finally you can just execute `./hello_jobstep` binary program to see how it behaves:
		
		```
		./hello_jobstep
		```
		
		Note that executing the program with `srun` in the srun interactive session will result in a hang.
		You need to work with `--overlap` option for srun to mitigate this.
		
		Remember to terminate your interactive session with `exit` command.
		
		```
		exit
		``` 
		and then do the same for the shell created by `salloc` also.

## Slurm custom binding on GPU nodes

1.  Allocate one GPU node with one task per GPU and bind tasks to each CCD (8-core group sharing L3 cache) 
    leaving the first (#0) and last (#7) cores unused. 
	Run a program with 6 threads per task and inspect the actual task/threads affinity
	using either the `hello_jobstep` executable generated in the previous exercise, or the
	`gpu_check` command from tne `lumi-CPEtools` module.

	??? Solution "Click to see the solution."
		
		We can chose between different approaches. In the example below,
		we follow the 
		["GPU binding: Linear GCD, match cores"](07_Binding.md#linear-assignment-of-gcd-then-match-the-cores) 
		slides and we only need to adapt the CPU mask:
		
		```
		#!/bin/bash -l
		#SBATCH --partition=standard-g  # Partition (queue) name
		#SBATCH --nodes=1               # Total number of nodes
		#SBATCH --ntasks-per-node=8     # 8 MPI ranks per node
		#SBATCH --gpus-per-node=8       # Allocate one gpu per MPI rank
		#SBATCH --time=5                # Run time (minutes)
		#SBATCH --account=<project_id>  # Project for billing
		#SBATCH --hint=nomultithread
		
		cat << EOF > select_gpu_$SLURM_JOB_ID
		#!/bin/bash
		export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
		exec \$*
		EOF
		chmod +x ./select_gpu_$SLURM_JOB_ID
		
		CPU_BIND="mask_cpu:0xfe000000000000,0xfe00000000000000,"
		CPU_BIND="${CPU_BIND}0xfe0000,0xfe000000,"
		CPU_BIND="${CPU_BIND}0xfe,0xfe00,"
		CPU_BIND="${CPU_BIND}0xfe00000000,0xfe0000000000"
		
		export OMP_NUM_THREADS=6
		export OMP_PROC_BIND=close
		export OMP_PLACES=cores
		
		srun --cpu-bind=${CPU_BIND} ./select_gpu_$SLURM_JOB_ID ./hello_jobstep
		```

		The base mask we need for this exercise, with each first and last core of a chiplet disabled,
		is `01111110` which is `0x7e` in hexadecimal notation.

		Save the job script as `job_step.sh` then simply submit it with sbatch from the directory
		that contains the `hello_jobstep` executable. Inspect the job output.
		
		Note that in fact as this program was compiled with the Cray compiler in the previous exercise,
		you don't even need to use the `OMP_*` environment variables above as the threads are 
		automatically pinned to a single core and as the correct number of threads is derived from
		the affinity mask for each task.

		Or using `gpu_check` instead (and we'll use the `cpeGNU` version again):

		```
		#!/bin/bash -l
		#SBATCH --partition=standard-g  # Partition (queue) name
		#SBATCH --nodes=1               # Total number of nodes
		#SBATCH --ntasks-per-node=8     # 8 MPI ranks per node
		#SBATCH --gpus-per-node=8       # Allocate one gpu per MPI rank
		#SBATCH --time=5                # Run time (minutes)
		#SBATCH --account=<project_id>  # Project for billing
		#SBATCH --hint=nomultithread

		module load LUMI/23.09
		module load lumi-CPEtools/1.1-cpeGNU-23.09
		
		cat << EOF > select_gpu_$SLURM_JOB_ID
		#!/bin/bash
		export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
		exec \$*
		EOF
		chmod +x ./select_gpu_$SLURM_JOB_ID
		
		CPU_BIND="mask_cpu:0xfe000000000000,0xfe00000000000000,"
		CPU_BIND="${CPU_BIND}0xfe0000,0xfe000000,"
		CPU_BIND="${CPU_BIND}0xfe,0xfe00,"
		CPU_BIND="${CPU_BIND}0xfe00000000,0xfe0000000000"
		
		export OMP_NUM_THREADS=6
		export OMP_PROC_BIND=close
		export OMP_PLACES=cores
		
		srun --cpu-bind=${CPU_BIND} ./select_gpu_$SLURM_JOB_ID gpu_check -l
		```
