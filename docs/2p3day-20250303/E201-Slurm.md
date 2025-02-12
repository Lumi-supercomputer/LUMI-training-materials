# Exercises: Slurm on LUMI

## Basic exercises

1.  In this exercise we check how cores would be assigned to a shared memory program. 
    Run a single task on the CPU partition with `srun` using 16 cpu cores. 
	Inspect the default task allocation with the `taskset` command 
	(`taskset -cp $$` will show you the cpu numbers allocated to the current process). 

	??? Solution "Click to see the solution."
		
		```
		srun --partition=small --nodes=1 --tasks=1 --cpus-per-task=16 --time=5 --account=<project_id> bash -c 'taskset -cp $$' 
		```
		
		Note that you need to replace `<project_id>` with the actual project account ID of the 
		form  `project_` plus a 9 digits number (and this argument can be omitted
		if you use the `exercises/small` module during the course).
		
		The command runs a single process (`bash` shell with the native Linux `taskset` tool showing 
		process's CPU affinity) on a compute node. 
		You can use the `man taskset` command to see how the tool works.

2.  Next we'll try a hybrid MPI/OpenMP program.
    For this we will use the `hybrid_check` tool from the `lumi-CPEtools` module of the LUMI Software Library. 
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

	module load LUMI/24.03
	module load lumi-CPEtools/1.2-cpeGNU-24.03

	srun --cpus-per-task=$SLURM_CPUS_PER_TASK hybrid_check -n -r
	``` 

	Be careful with copy/paste of the script body as copy problems with special characters or a double dash may 
	occur, depending on the editor you use.

	??? Solution "Click to see the solution."
		
		Save the script contents into the file  `job.sh` (you can use the `nano` console text editor for instance). 
		Remember to use valid project account name (or omit the line if you are using the `exercises/small` module).
		
		Submit the job script using the `sbatch` command:
		
		```
		sbatch job.sh
		```
		
		The job output is saved in the `slurm-<job_id>.out` file. 
		You can view its content with either the `less` or `more` shell commands.
		
		The actual task/threads affinity may depend on the specific OpenMP runtime 
		(if you literally use this job script it will be the GNU OpenMP runtime).


## Advanced exercises

These exercises combine material from several chapters of the tutorial.
This particular exercise makes most sense if you will be building software
on LUMI (but remember that this will be more of you than you may expect)!

1.  Build the `hello_jobstep` program tool using interactive shell on a GPU node. 
    You can pull the source code for the program from git repository 
	[`https://code.ornl.gov/olcf/hello_jobstep.git`](https://code.ornl.gov/olcf/hello_jobstep). 
	It uses a `Makefile` for building and requires Clang and HIP. The code also
	contains a `README.md` file with instructions, but they will need some changes.
	The `hello_jobstep` program is actually the main source of inspiration for the 
	`gpu_check` program in the `lumi-CPEtools` modules for `partition/G`.
	Try to run the program interactively. 

	The `Makefile` contains a conditional section to set proper arguments for the
	compiler. LUMI is very similar to Frontier, so when calling the `make` program
	to build the code from the Makefile, don't use simply `make` as suggested in the
	`README.md`, but use

	```
	make LMOD_SYSTEM_NAME="frontier"
	```

	*Note:* Given that the reservation is on `standard-g` where you can only get
	whole nodes, which is rather stupid for this example, it is better to try to
	get a single GPU with 7 cores and 60GB of memory on the `small-g` partition.

	??? Solution "Click to see the solution."
		
		Clone the code using `git` command:
		
		```
		git clone https://code.ornl.gov/olcf/hello_jobstep.git
		```
		
		It will create `hello_jobstep` directory consisting source code and `Makefile`.
		
		Allocate resources for a single task with a single GPU with `salloc`:
		
		```
		salloc --partition=small-g --tasks=1 --cpus-per-task=7 --gpus=1 --mem=60G --time=10 --account=<project_id>
		```
		
		Note that, after allocation is granted, you receive new shell but are still on the compute node. 
		You need to use the `srun` command to run on the allocated node. 
		
		Start interactive session on a GPU node:
		
		```
		srun --pty bash -i
		```
		
		Note now you are on the compute node. `--pty` option for `srun` is required to interact with the remote shell.
		
		Enter the `hello_jobstep` directory. There is a Makefile to build the
		code using the `make` command, but first we need to make sure that there
		is a proper programming environment loaded. 
		
		As an example we will built with the system default programming environment, `PrgEnv-cray` in `CrayEnv`. 
		Just to be sure we'll load even the programming environment module explicitly.

		The build will fail if the `rocm/6.0.3` module is not loaded when using `PrgEnv-cray`. Whereas the instructions suggest to simply use the `rocm` 
		module, we're specifying a version as at the time of the course, there 
		was a newer but not fully supported `rocm` module on the system.
		
		```
		module load CrayEnv
		module load PrgEnv-cray
		module load rocm/6.0.3
		```

		Alternatively, you can build in the `LUMI/24.03` stack using the EasyBuild toolchain instead
		of `PrgEnv-cray`:

		```
		module load LUMI/24.03 partition/G cpeCray
		```

		In this case, you do not need to load the ROCm module as it is loaded automatically by
		`cpeCray/24.03` when working in `partition/G`.
		
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


