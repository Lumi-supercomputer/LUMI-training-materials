local slurm_partition =   'small'
local slurm_reservation = 'LUMI_Intro_small'
local slurm_account =     'project_465001603'

whatis( 'Description: Sets account, reservation and partition for exercises using the ' .. slurm_partition .. ' partition.' )

help( [[
Description
===========
Loading this module sets the project account, reservation and partition for
the exercises using the ]] .. slurm_partition .. [[ partition by using Slurm environment
variables.
]] )

setenv( 'SLURM_ACCOUNT',      slurm_account )
setenv( 'SLURM_PARTITION',    slurm_partition )
setenv( 'SLURM_RESERVATION',  slurm_reservation )

setenv( 'SBATCH_ACCOUNT',     slurm_account )
setenv( 'SBATCH_PARTITION',   slurm_partition )
setenv( 'SBATCH_RESERVATION', slurm_reservation )

setenv( 'SALLOC_ACCOUNT',     slurm_account )
setenv( 'SALLOC_PARTITION',   slurm_partition )
setenv( 'SALLOC_RESERVATION', slurm_reservation )
