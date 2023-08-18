# The low-noise mode on LUMI-G

## Configuration changes

The configuration of LUMI-G has been made more symmetrical.

Previously, a low-noise mode was enabled reserving one core (core 0) for the operating
system and drivers. This was needed because benchmarking before the pilot phase showed
that the jitter cause by OS processes in the background stealing time from some cores
that were in use by applications, had a very negative impact on scalability.

This created an asymmetry as one CCD (chiplet) of the CPU had 7 cores available while
all others had 8 cores available. And this in turn almost forced users to do a fully manual
CPU binding in standard-g, and gave very bad core allocations in small-g. Some changes have
been made to the scheduler config to improve this situation.

What has changed:

-   The first core of each CCD is now reserved. As a result, only 56 cores are available to
    Slurm on each LUMI-G node. The reserved cores are 0, 8, 16, 24, 32, 40, 48 and 56.

-   The thread distribution and binding behaviour of `--cpus-per-task` has been improved. 
    Even with the old distribution rules, `--cpus-per-task=7` would now give a nice 
    distribution on the standard-g partition with effectively each task on its own CCD, 
    which in turn makes proper GPU mapping possible. However, in some cases, even with
    a lower value of `--cpus-per-task` you will still have nice mapping with tasks
    not spanning multiple CCDs (and if there are 8 tasks or less, each task on a separate
    CCD). You should experiment with this though as it is not true in all cases and as on
    small-g it is only the case if you happen to have a node that is empty.

What has **not** changed:

-   Proper binding is only possible on job-exclusive nodes, but that is the very nature
    of binding as it requires full control of all resources.

-   For those users who also work on Frontier: The configuration of the GPU nodes is now 
    more similar but still not the same. E.g., the Slurm socket is still defined as the physical
    socket and not an L3 cache domain as on Frontier, because modifying this would have had 
    implications for LUMI-C also. So don't expect that you can simply use the same strategy for
    resource requests for all cases on LUMI and Frontier.

-   `--gpu-bind=closest` still does not work as expected. On standard-g, it will not 
    give you the proper GPUs (apart from other problems with Slurm doing the binding).
    On small-g, it will not enforce an allocation with the proper CPU cores for the GPUs
    in your allocation.

-   The Slurm GPU binding is still incompatible with shared memory communication between 
    GPUs in different tasks, as is used, e.g., by GPU-aware Cray MPICH intra-node communication.
    So the trick of avoiding Slurm doing the binding and do a manual binding instead via the
    `select_gpu` script used in the LUMI documentation, is still needed.

User impact:

-   Any job script that in one way or another asks for more than 56 cores on a node of LUMI-G will
    fail.

-   Any job script that uses `--cpu-bind=map_cpu:` and that has one of the now unavailable cores in the 
    map will fail. 

    **The ["MPI-based job" in the GPU examples](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/lumig-job/#mpi-based-job)
    in the LUMI documentation before the August 2023 update does no longer work. Also, the `--cpu-bind=map_cpu:` line
    that was shown on the ["Distribtion and binding"](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/distribution-binding/#gpu-binding)
    page does no longer work after the update. The documentation has been corrected.**

-   Any job script that uses `--cpu-bind=mask_gpu:` and that includes a now unavailable core in the mask
    will fail. 

    The 
    ["Hybrid MPI+OpenMP job" example in "GPU examples](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/lumig-job/#hybrid-mpiopenmp-job)
    already took this into account and is still correct.
    **The example mask on the 
    ["Distribution and binding" page](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/distribution-binding/#gpu-binding)
    is wrong and all occurrences of `ff` need to be modified to `fe`. The documentation has been corrected.** 

All training materials in the ["LUMI training materials" archive web site](https://klust.github.io/LUMI-training-materials/)
reflect the state of LUMI at the time that the course was given. These materials are not updated after the course, so some job
scripts for LUMI-G contained in those courses will be incorrect. As courses are lectured again, a new version of the course
materials will be made available on this site and LUMI (as some materials cannot be published on the web).

In particular,

-   The [latest materials for the 4-day comprehensive LUMI training](https://klust.github.io/LUMI-training-materials/comprehensive-latest)
    are currently those of the May 30 - June 2 course in Tallinn, but a new version will become available some days after the training in 
    Warsaw, October 3-6.

-   The [latest materials of the 1-day introductory LUMI training](https://klust.github.io/LUMI-training-materials/intro-latest)
    are currently those of the course in early May 2023. A new edition has not yet been planned but is expected in the fall of 2023.


## MPI-based job example

The [example from the "MPI-based job" section on the "GPU examples documentation page](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/lumig-job/#mpi-based-job)
needs only an almost trivial modification on line 23:

```bash linenums="1"
#!/bin/bash -l
#SBATCH --job-name=examplejob   # Job name
#SBATCH --output=examplejob.o%j # Name of stdout output file
#SBATCH --error=examplejob.e%j  # Name of stderr error file
#SBATCH --partition=standard-g  # Partition (queue) name
#SBATCH --nodes=2               # Total number of nodes 
#SBATCH --ntasks-per-node=8     # 8 MPI ranks per node, 16 total (2x8)
#SBATCH --gpus-per-node=8       # Allocate one gpu per MPI rank
#SBATCH --time=1-12:00:00       # Run time (d-hh:mm:ss)
#SBATCH --mail-type=all         # Send email at begin and end of job
#SBATCH --account=project_<id>  # Project for billing
#SBATCH --mail-user=username@domain.com

cat << EOF > select_gpu
#!/bin/bash

export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
exec \$*
EOF

chmod +x ./select_gpu

CPU_BIND="map_cpu:49,57,17,25,1,9,33,41"

export MPICH_GPU_SUPPORT_ENABLED=1

srun --cpu-bind=${CPU_BIND} ./select_gpu <executable> <args>
rm -rf ./select_gpu
```

??? example "Download runnable example"

    Example: [example-mpi.sh](examples/example-mpi.sh)

    Run with:

    ```
    sbatch -A project_46YXXXXXX example-mpi.sh
    ```

    Future updates of LUMI may invalidate this script.


## Hybrid MPI+OpenMP job

The mask in the [example from the "Hybrid MPI+OpenMP job" section on the "GPU examples documentation page](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/lumig-job/#hybrid-mpiopenmp-job)
is still correct:

```bash linenums="1"
#!/bin/bash -l
#SBATCH --job-name=examplejob   # Job name
#SBATCH --output=examplejob.o%j # Name of stdout output file
#SBATCH --error=examplejob.e%j  # Name of stderr error file
#SBATCH --partition=standard-g  # Partition (queue) name
#SBATCH --nodes=2               # Total number of nodes 
#SBATCH --ntasks-per-node=8     # 8 MPI ranks per node, 16 total (2x8)
#SBATCH --gpus-per-node=8       # Allocate one gpu per MPI rank
#SBATCH --time=1-12:00:00       # Run time (d-hh:mm:ss)
#SBATCH --mail-type=all         # Send email at begin and end of job
#SBATCH --account=project_<id>  # Project for billing
#SBATCH --mail-user=username@domain.com

cat << EOF > select_gpu
#!/bin/bash

export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
exec \$*
EOF

chmod +x ./select_gpu

CPU_BIND="mask_cpu:7e000000000000,7e00000000000000"
CPU_BIND="${CPU_BIND},7e0000,7e000000"
CPU_BIND="${CPU_BIND},7e,7e00"
CPU_BIND="${CPU_BIND},7e00000000,7e0000000000"

export OMP_NUM_THREADS=6
export MPICH_GPU_SUPPORT_ENABLED=1

srun --cpu-bind=${CPU_BIND} ./select_gpu <executable> <args>
rm -rf ./select_gpu
```

The mask here is built up of `7e` blocks which use cores 1 till 6 of each CCD, but do not use the reserved
core 0 nor the available core 7.
In general, any mask element with a 1, 3, 5, 7, 9, B, D or F in position 1, 3, 5, 7, 9, 11, 13 or 15 
(counting from the right and starting with 1) is wrong as it would have a 1-bit on the position of core 0
of one of the CCDs. Or in other words, the odd positions (counting from the right and starting from 1)
of each mask element should be an even hexadecimal number (including 0).

??? example "Download runnable example"

    Example: [example-hybrid.sh](examples/example-hybrid.sh)

    Run with:

    ```
    sbatch -A project_46YXXXXXX example-hybrid.sh
    ```

    Future updates of LUMI may invalidate this script.


## Comprehensive training "Advanced Placement" lecture

Many of the slides of the GPU-related slides of the 
["Advanced Placement" lecture of the comprehensive LUMI course of May-June 2023](https://klust.github.io/LUMI-training-materials/4day-20230530/extra_2_03_Advanced_Application_Placement/) 
need changes.

Note that numbers refer to the page numbers on the slides themselves. Some slides are left out of the bundle.

-   The example on slide 61 which did not work (as explained on slide 62 and 63) will now actually work

    ```bash
    #!/bin/bash
    #SBATCH -p <partition>
    #SBATCH -A <your_project>
    #SBATCH --time=00:02:00
    #SBATCH --nodes=2
    #SBATCH --gres=gpu:8 
    #SBATCH --exclusive
    #SBATCH --ntasks-per-node=8 
    #SBATCH --cpus-per-task=7 
    #SBATCH --hint=nomultithread

    export OMP_PLACES=cores
    export OMP_PROC_BIND=close
    export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

    srun ./xthi | sort -n -k 4 -k 6
    ```

    The mask shown on slide 63 is still correct though and that approach also works.

    The Python script on slide 64 to generate masks is also correct 
    as is the job script on slide 65 that uses that mask:

    ```bash
    #!/bin/bash
    #SBATCH -p <partition> 
    #SBATCH -A <your_project> 
    #SBATCH --time=00:02:00 
    #SBATCH --nodes=1
    #SBATCH --gres=gpu:8 
    #SBATCH --exclusive
    #SBATCH --ntasks-per-node=8 
    #SBATCH --hint=nomultithread

    export OMP_PLACES=cores
    export OMP_PROC_BIND=close
    export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

    ASRUN="srun --cpu-bind=mask_cpu:0xfe,0xfe00,0xfe0000,0xfe000000,0xfe00000000,0xfe0000000000,0xfe000000000000,0xfe00000000000000"

    ${ASRUN} ./xthi | sort -n -k 4 -k 6
    ```
    
    (but the `--cpus-per-task`` line on that slide is wrong and was wrong before.)

-   The script on slide 72:
   
    ```bash
    #!/bin/bash
    #SBATCH -p <partition>
    #SBATCH -A <your_project>
    #SBATCH --time=00:02:00
    #SBATCH --nodes=2
    #SBATCH --gres=gpu:8
    #SBATCH --exclusive
    #SBATCH --ntasks-per-node=8 
    #SBATCH --hint=nomultithread

    export OMP_PLACES=cores
    export OMP_PROC_BIND=close
    export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

    ASRUN="srun --cpu-bind=mask_cpu:0xfe,0xfe00,0xfe0000,0xfe000000,0xfe00000000,0xfe0000000000,0xfe000000000000,0xfe00000000000000"

    ${ASRUN} ./select_gpu.sh <my_app>
    ```

    with `select_gpu.sh`: 

    ```bash
    #!/bin/bash

    export ROCR_VISIBLE_DEVICES=$SLURM_LOCALID

    exec $*
    ```

    (and with the `--cpus-per-task` line removed)

    will still give a correct CPU binding and the GPU binding is still too naive.
    It is corrected by the `select_gpu.sh` script on slide 74 which does not require any modifications either:

    ```bash
    #!/bin/bash
    GPUSID="4 5 2 3 6 7 0 1"
    GPUSID=(${GPUSID})
    if [ ${#GPUSID[@]} -gt 0 -a -n "${SLURM_NTASKS_PER_NODE}" ]; then
        if [ ${#GPUSID[@]} -gt $SLURM_NTASKS_PER_NODE ]; then
            export ROCR_VISIBLE_DEVICES=${GPUSID[$(($SLURM_LOCALID))]}
        else
            export ROCR_VISIBLE_DEVICES=${GPUSID[$(($SLURM_LOCALID / ($SLURM_NTASKS_PER_NODE / ${#GPUSID[@]})))]}
        fi 
    fi
    exec $*
    ```

    (Note that this script however assumes that the number of tasks per node is a multiple of the number of GPUs in the 
    list.)

??? example "Download runnable example based on the script of slide 72-74"

    Example: [example-cray.sh](examples/example-cray.sh)

    Run with:

    ```
    sbatch -A project_46YXXXXXX example-cray.sh
    ```

    Future updates of LUMI may invalidate this script.




## Some other examples

### Mask for 1 GPU per task, 7 cores per task:

```bash linenums="1"
#!/bin/bash -l
#SBATCH --job-name=examplejob   # Job name
#SBATCH --output=examplejob.o%j # Name of stdout output file
#SBATCH --error=examplejob.e%j  # Name of stderr error file
#SBATCH --partition=standard-g  # Partition (queue) name
#SBATCH --nodes=2               # Total number of nodes 
#SBATCH --ntasks-per-node=8     # 8 MPI ranks per node, 16 total (2x8)
#SBATCH --gpus-per-node=8       # Allocate one gpu per MPI rank
#SBATCH --time=1-12:00:00       # Run time (d-hh:mm:ss)
#SBATCH --mail-type=all         # Send email at begin and end of job
#SBATCH --account=project_<id>  # Project for billing
#SBATCH --mail-user=username@domain.com

cat << EOF > select_gpu
#!/bin/bash
export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
exec \$*
EOF
chmod +x ./select_gpu

CPU_BIND="mask_cpu"
CPU_BIND="${CPU_BIND}:00fe000000000000,fe00000000000000" # CCD 6. 7
CPU_BIND="${CPU_BIND},0000000000fe0000,00000000fe000000" # CCD 2, 3
CPU_BIND="${CPU_BIND},00000000000000fe,000000000000fe00" # CCD 0, 1
CPU_BIND="${CPU_BIND},000000fe00000000,0000fe0000000000" # CCD 4, 5

export OMP_NUM_THREADS=7
export MPICH_GPU_SUPPORT_ENABLED=1

srun --cpu-bind=${CPU_BIND} ./select_gpu <executable> <args>
rm -rf ./select_gpu
```

This mask makes the first HWT on all 7 cores available. 
For OpenMP applications, use can then be restricted again by setting
`OMP_NUM_THREADS` to a lower value.

??? example "Download runnable example"

    Example: [example-1gpt-7cpt.sh](examples/example-1gpt-7cpt.sh)

    Run with:

    ```
    sbatch -A project_46YXXXXXX example-1gpt-7cpt.sh
    ```

    Future updates of LUMI may invalidate this script.


### Mask for 2 tasks per GPU, 3 cores per task

```bash linenums="1"
#!/bin/bash -l
#SBATCH --job-name=examplejob   # Job name
#SBATCH --output=examplejob.o%j # Name of stdout output file
#SBATCH --error=examplejob.e%j  # Name of stderr error file
#SBATCH --partition=standard-g  # Partition (queue) name
#SBATCH --nodes=2               # Total number of nodes 
#SBATCH --ntasks-per-node=16    # 16 MPI ranks per node, 32 total (2x16)
#SBATCH --gpus-per-node=8       # Allocate all eight GPUS in a node
#SBATCH --time=1-12:00:00       # Run time (d-hh:mm:ss)
#SBATCH --mail-type=all         # Send email at begin and end of job
#SBATCH --account=project_<id>  # Project for billing
#SBATCH --mail-user=username@domain.com

cat << EOF > select_gpu
#!/bin/bash
export ROCR_VISIBLE_DEVICES=\$((SLURM_LOCALID/2))
exec \$*
EOF
chmod +x ./select_gpu

CPU_BIND="mask_cpu"  #7766554433221100,7766554433221100
CPU_BIND="${CPU_BIND}:000E000000000000,00E0000000000000" # CCD 6
CPU_BIND="${CPU_BIND},0E00000000000000,E000000000000000" # CCD 7
CPU_BIND="${CPU_BIND},00000000000E0000,0000000000E00000" # CCD 2
CPU_BIND="${CPU_BIND},000000000E000000,00000000E0000000" # CCD 3
CPU_BIND="${CPU_BIND},000000000000000E,00000000000000E0" # CCD 0
CPU_BIND="${CPU_BIND},0000000000000E00,000000000000E000" # CCD 1
CPU_BIND="${CPU_BIND},0000000E00000000,000000E000000000" # CCD 4
CPU_BIND="${CPU_BIND},00000E0000000000,0000E00000000000" # CCD 5
#                     7766554433221100,7766554433221100

export OMP_NUM_THREADS=3
export MPICH_GPU_SUPPORT_ENABLED=1

srun --cpu-bind=${CPU_BIND} ./select_gpu <executable> <args>
rm -rf ./select_gpu
```

This mask will use cores 1-3 and 5-7 of each CCD to place tasks.

??? example "Download runnable example"

    Example: [example-2tpg-3cpt.sh](examples/example-2tpg-3cpt.sh)

    Run with:

    ```
    sbatch -A project_46YXXXXXX example-2tpg-3cpt.sh
    ```

    Future updates of LUMI may invalidate this script.

