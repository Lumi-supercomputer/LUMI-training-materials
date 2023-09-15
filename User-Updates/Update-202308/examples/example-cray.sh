#!/bin/bash
#SBATCH -p standard-g
#SBATCH --time=00:02:00
#SBATCH --nodes=2
#SBATCH --gres=gpu:8
#SBATCH --exclusive
#SBATCH --ntasks-per-node=8 
#SBATCH --hint=nomultithread

module load LUMI/22.12 partition/G lumi-CPEtools/1.1-cpeCray-22.12

cat << EOF > select_gpu_$SLURM_JOB_ID.sh
#!/bin/bash
GPUSID="4 5 2 3 6 7 0 1"
GPUSID=(\${GPUSID})
if [ \${#GPUSID[@]} -gt 0 -a -n "\${SLURM_NTASKS_PER_NODE}" ]; then
    if [ \${#GPUSID[@]} -gt \$SLURM_NTASKS_PER_NODE ]; then
        export ROCR_VISIBLE_DEVICES=\${GPUSID[\$((\$SLURM_LOCALID))]}
    else
        export ROCR_VISIBLE_DEVICES=\${GPUSID[\$((\$SLURM_LOCALID / (\$SLURM_NTASKS_PER_NODE / \${#GPUSID[@]})))]}
    fi 
fi
exec \$*
EOF
chmod +x ./select_gpu_$SLURM_JOB_ID.sh

export OMP_PLACES=cores
export OMP_PROC_BIND=close
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}

ASRUN="srun --cpu-bind=mask_cpu:0xfe,0xfe00,0xfe0000,0xfe000000,0xfe00000000,0xfe0000000000,0xfe000000000000,0xfe00000000000000"

${ASRUN} ./select_gpu_$SLURM_JOB_ID.sh gpu_check -l
rm -rf ./select_gpu_$SLURM_JOB_ID.sh
