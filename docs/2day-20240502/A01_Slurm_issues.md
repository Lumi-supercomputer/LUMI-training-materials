# Slurm issues on LUMI

Note: Use `sbatch --version` to check the version of Slurm.

## Wrong allocations on small-g when requesting 1 CPU per task

*Observed on Slurm 22.05.8.*

When requesting a GPU allocation requesting only 1 CPU per task with `--cpus-per-task=1`
and requesting GPUs with `--gpus-per-task`, we get invalid allocations at least when 
the job has to span multiple nodes. The problems disappear as soon as a value larger
than 1 is used for `--cpus-per-task`.

??? Note "Sample job script showing the bug"
    <!-- map-smallg-1gpt-error.slurm -->
    ```
    #! /bin/bash
    #SBATCH --job-name=map-smallg-1gpt-error
    #SBATCH --output %x-%j.txt
    #SBATCH --partition=small-g
    #SBATCH --ntasks=12
    #SBATCH --cpus-per-task=1
    #SBATCH --gpus-per-task=1
    #SBATCH --hint=nomultithread
    #SBATCH --time=5:00

    module load LUMI/22.12 partition/G lumi-CPEtools/1.1-cpeCray-22.12

    echo "Requested resources as reported through SLURM_ variables:"
    echo "- SLURM_NTASKS: $SLURM_NTASKS"
    echo "- SLURM_CPUS_PER_TASK: $SLURM_CPUS_PER_TASK"
    echo "- SLURM_GPUS_PER_TASK: $SLURM_GPUS_PER_TASK"
    echo "Distribution based on SLURM_ variables:"
    echo "- SLURM_JOB_NUM_NODES: $SLURM_JOB_NUM_NODES"
    echo "- SLURM_JOB_NODELIST: $SLURM_JOB_NODELIST"
    echo "- SLURM_TASKS_PER_NODE: $SLURM_TASKS_PER_NODE"
    echo "- SLURM_JOB_CPUS_PER_NODE: $SLURM_JOB_CPUS_PER_NODE"
    echo
    echo "Control: All SLURM_ and SRUN_ variables:"
    env | egrep ^SLURM_
    env | egrep ^SRUN_
    echo
    echo -e "Control: Job script\n\n======================================================"
    cat $0
    echo -e "======================================================\n"

    set -x
    srun -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK --gpus-per-task=$SLURM_GPUS_PER_TASK gpu_check -l
    set +x

    /bin/rm -f select_gpu_$SLURM_JOB_ID echo_dev_$SLURM_JOB_ID
    ```

**Workaround:** Use a value larger than 1 for `--cpus-per-task`. A pure MPI application will not use
the additional CPU cores, but since in an ideal case a CCD should not be used by more than 1 task unless
the GPU is also shared by multiple tasks.


