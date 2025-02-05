# Hands-on: Checking GPU usage interactively using rocm-smi

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20250204/04_Understanding_GPU_activity_and_checking_jobs).
<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/04_Understanding_GPU_activity_and_checking_jobs).
-->

<!--
A video recording of the discussion of the solution will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20250204/recordings/E04_CheckingGPU.mp4" controls="controls"></video>


## Q&A

1.  Step 5 from the exercises, the `srun ... rocprof --help` command never shows the options and 
    after a long time tells me "step creation temporarily disabled, retrying (Requested nodes are busy)", 
    which makes me wonder how to do this for an actual session? 

    -   That message originates from SLURM scheduling system and might have just been a temporary hiccup. 
        Maybe try again, it should work this time. - Lukas

2.  Are we allowed to tweak and change GPU configurations like power cap or clock freq in our experiments? If so can you briefly hint how? I assume ROCm sys management allow us to do this?

    -   No, you are not allowed to as that would create a mess on the system, even if you were only allowed to lower them. Some nodes on LUMI are shared (`small-g` partition among others) and you playing with such limits can influence the work of other people on the same node. Remember that the power cap is not set per GCD but per GPU package, so you using one GCD but playing with the power cap would also harm the user using the other GCD. Let alone if the clean-up after the job fails and the next user gets a GPU with lower than expected performance.

