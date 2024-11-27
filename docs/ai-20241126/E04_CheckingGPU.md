# Hands-on: Checking GPU usage interactively using rocm-smi

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20241126/04_Understanding_GPU_activity_and_checking_jobs).

<video src="https://462000265.lumidata.eu/ai-20241126/recordings/E04_CheckingGPU.mp4" controls="controls"></video>


## Q&A

1.  So using sbatch bills compute time only as long as the scripts are running, while salloc keeps billing for as long as specified even if the scripts stopped running?

    -   **(Lukas)** Essentially yes. `salloc` essentially allocated the resources and then enters into a new shell environment from which all following (srun) commands are run on the compute node. So in a way you are in an interactive terminal on the compute node and as long as that is active you are billed for the resources. As far as I now recall, you can actually step out of it by simply typing `exit`, which will then also free the allocation.

    -   Both bill you for the time of the job, i.e., the time that the resources are set aside for you. With `sbatch` the job ends when the batch script ends and everything is cleaned up then. With `salloc`, the job ends when you leave the shell created by `salloc`, unless you reach the time limit before that, and the resources are only freed for other users when the job ends, i.e., the time limit expires or you leave the shell created by `salloc`, effectively terminating the `salloc` command. 

        As Lukas said, exit or CTRL-D takes you out of that shell, but be careful if you created subshells into that shell...

