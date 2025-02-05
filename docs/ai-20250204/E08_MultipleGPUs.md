# Hands-on: Converting the PyTorch single GPU AI training job to use all GPUs in a single node via DDP

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20250204/08_Scaling_to_multiple_GPUs).
-->
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/08_Scaling_to_multiple_GPUs).

A video recording of the discussion of the solution will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250204/recordings/E08_MultipleGPUs.mp4" controls="controls"></video>
-->

## Q&A

1.  In a slurm script what would be the difference between 'torchrun script.py' and 'srun python script.py' (in terms of performance) ?

    -   Even though the behavior may vary slightly from case to case, in all the tests I've run, there was no appreciable difference in terms of performance.

    -   There is an important difference when not using torchrun: srun will take care of running `ntasks-per-node` many processes of the command that follows. So if you drop `srun` in that line, it will run only one `python ..` process, even if you set the `#SBATCH` number of tasks to a higher number.

2.  For exercice 8, I checked the GPU utilization from watch rocm-smi and GPU% was 100% for every GPU except GPU 0. Also PwrCap was 500W for only 4 of the 8 GPUs. I would like to check if I understood correctly, for this case, shouldn't it be 500W for all of them, since I was using all? Does this means that it is not using all the GPUs properly? It was running for 5 minutes only

    -   The powercap part of the question: PwrCap is a parameter that is set by the sysadmins. 
        It may not be exactly the same on all GPUs for performance reasons. Some GPUs can run faster at a given power than others, that is normal variability in semiconductor production. Sysadmins did experiment a bit with powercaps to get an equal speed from all GPUs (important to ease load distribution) while not exceeding power limits per rack, so yo may have bumped in some better ones that require less power for a given speed. The power usage parameter is the one to look at, but even that doesn't really tell you if you are using the resource efficiently. It only tells that you are using it to some degree but not how good that use is. E.g., you may be spending a lot of power on moving data rather than on doing computations with the data, and that is something only advanced profiling can show you (with a tool like Omniperf).

    I see. So, to check the quality of the GPU usage, do you recommend to perform advanced profiling?

3.  Does this 'TOKENIZERS_PARALLELISM=false' mean that the user has to handel the parallism themself explicitly? 
    If this is the case, could you point us to the python lines in the exercice where this is done - thanks? 

    -   The transformers package sometimes uses tokenizers written in some other language than Python (e.g. C). 
        These are typically (much) faster than the equivalent Python implementation and some of these do additional parallelism on top of the number of dataloader processes we instruct the script to use. Since we already use multiple processes for data-loading, we set `TOKENIZERS_PARALLELISM=false`. - Lukas

