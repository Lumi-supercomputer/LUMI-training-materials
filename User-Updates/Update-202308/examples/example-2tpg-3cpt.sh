#!/bin/bash -l
#SBATCH --job-name=examplejob   # Job name
#SBATCH --output=examplejob.o%j # Name of stdout output file
#SBATCH --error=examplejob.e%j  # Name of stderr error file
#SBATCH --partition=standard-g  # Partition (queue) name
#SBATCH --nodes=2               # Total number of nodes 
#SBATCH --ntasks-per-node=16    # 16 MPI ranks per node, 32 total (2x16)
#SBATCH --gpus-per-node=8       # Allocate all eight GPUS in a node
#SBATCH --time=1-12:00:00       # Run time (d-hh:mm:ss)

module load LUMI/22.12 partition/G lumi-CPEtools/1.1-cpeCray-22.12

cat << EOF > select_gpu_$SLURM_JOB_ID
#!/bin/bash
export ROCR_VISIBLE_DEVICES=\$((SLURM_LOCALID/2))
exec \$*
EOF
chmod +x ./select_gpu_$SLURM_JOB_ID

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

srun --cpu-bind=${CPU_BIND} ./select_gpu_$SLURM_JOB_ID gpu_check -l
rm -rf ./select_gpu_$SLURM_JOB_ID