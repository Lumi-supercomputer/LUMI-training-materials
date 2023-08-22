#!/bin/bash -l
#SBATCH --job-name=example-1gpt-7cpt # Job name
#SBATCH --output=%x.o%j              # Name of stdout output file
#SBATCH --error=%x.e%j               # Name of stderr error file
#SBATCH --partition=standard-g       # Partition (queue) name
#SBATCH --nodes=2                    # Total number of nodes 
#SBATCH --ntasks-per-node=8          # 8 MPI ranks per node, 16 total (2x8)
#SBATCH --gpus-per-node=8            # Allocate one gpu per MPI rank
#SBATCH --time=2:00                  # Run time (d-hh:mm:ss)

module load LUMI/22.12 partition/G lumi-CPEtools/1.1-cpeCray-22.12

cat << EOF > select_gpu_$SLURM_JOB_ID
#!/bin/bash
export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID
exec \$*
EOF
chmod +x ./select_gpu_$SLURM_JOB_ID

CPU_BIND="mask_cpu"
CPU_BIND="${CPU_BIND}:00fe000000000000,fe00000000000000" # CCD 6. 7
CPU_BIND="${CPU_BIND},0000000000fe0000,00000000fe000000" # CCD 2, 3
CPU_BIND="${CPU_BIND},00000000000000fe,000000000000fe00" # CCD 0, 1
CPU_BIND="${CPU_BIND},000000fe00000000,0000fe0000000000" # CCD 4, 5

export OMP_NUM_THREADS=7
export MPICH_GPU_SUPPORT_ENABLED=1

srun --cpu-bind=${CPU_BIND} ./select_gpu_$SLURM_JOB_ID gpu_check -l
rm -rf ./select_gpu_$SLURM_JOB_ID
