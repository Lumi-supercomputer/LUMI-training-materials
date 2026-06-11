# Hands-on: Checking GPU usage interactively using rocm-smi

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20251009/04_Understanding_GPU_activity_and_checking_jobs).
-->

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/04_Understanding_GPU_activity_and_checking_jobs).

<!--
A video recording of the discussion of the solution will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20260611/recordings/E04_CheckingGPU.mp4" controls="controls"></video>


## Q&A

1.  Why is `srun` needed? What happens if I forget using it (while still being sure I am on a compute node?)
    I know that one has to use it for multi-node jobs (since the script actually runs only on the first node of the allocation),
    but what does it do in a single node job?

    -   In order for you to be on a compute node you must have used srun at some point. The way to get to the compute nodes is `srun your_command` or `srun --overlap --jobid ### --pty bash`. The latter starts a bash session and then you can 

    -   If you forget `srun` with salloc, you will be running on the login node. If you forget `srun` in a batch script, you will be running on the first node in the allocation only.
    
    Doesn't `salloc` *without arguments* already brings me to a compute node? Just checked: no (on other HPC systems it does, sorry)

    -   This can be configured differently in SLURM - on LUMI salloc doesn't start a session on the compute nodes. This just reserves the nodes for subsequent srun invocations.

    -   Actually, LUMI uses the standard behaviour of Slurm. Those systems that do give you a shell on the compute node have modified the Slurm configuration. Often this is because those sites were running another resource manager and scheduler before that launched a shell on the compute node by default with the equivalent command to `salloc` (e.g., Torque/MAUI or Torque/MOAB). 

2.  There was a question if rocm-smi can show memory usage in absolute numbers instead of a percentage. This can be done with:

    - For rocm-smi: `rocm-smi --showmeminfo vram`

    - With the newer amd-smi (available in the containers) you can use: `amd-smi metric -m`
