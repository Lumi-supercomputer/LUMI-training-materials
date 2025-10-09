# Scaling AI training to multiple GPUs

*Presenters:* Mats Sjöberg (CSC) and Oskar Taubert (CSC)

Content:

-   PyTorch DDP on LUMI
-   Setting up the experiment as a SLURM batch job
-   Setting the correct CPU-GPU bindings


<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20251008/recordings/08_MultipleGPUs.mp4" controls="controls"></video>


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-08-Scaling_multiple_GPUs.pdf)

-   [Hands-on exercises](E08_MultipleGPUs.md)


## Q&A

1.  How to set slicing in script ?  
 
    -   You mean slicing of the model or the resources in the machine? 
 
    I mean Slicing of GPU ex. 1/8 :
 
    -   You can request `--gpus-per-task=1` so each rank will get a GCD. In the next lecture there will 
        be other examples on how to do that.

    -   If you mean fractions of one GCD then you cannot request that in Slurm, the minimum 
        is one and only in some partitions.

32.  One GPU billing unit is 1 hour? 1 hour of a full node or a 1/8 slice?

    -   It depends on the partition you use: https://docs.lumi-supercomputer.eu/runjobs/lumi_env/billing/#gpu-billing

    -   1 hour on 1 full MI250X. So 1 GPU billing unit is 2 hours on 1 GCD (as this is 1/2 of an MI250X) 
        and a full node will cost you 4 billing units per hour.

    -   And also note that on LUMI you're not billed for what you use, but for what someone 
        else cannot use anymore because of your resource request. So if you would ask for only 
        1 GPU but half of the cores, you're still be billed for half a GPU node, 
        so 2 billing units per hour. The same holds for memory. So request at most 7 cores 
        and 60GB of memory (as only 480GB of the 512 GB is available for users, the OS and 
        file system buffers also need memory) per GCD that you request. Compared to some 
        other clusters, the amount of CPU power is low compared to the amount of GPU power, 
        as LUMI was really designed for GPU-intensive codes.

3.  I would like to ask that I am writing a conference paper and would like to write the 
    result of some experiments I am doing today and did yesterday on LUMI. Is this ok? 
    If yes, please let me know how to acknowledge the LUMI in my paper. 

    -   See https://www.lumi-supercomputer.eu/acknowledgement/

    Referring to my Q. 4, I checked the LUMI acknowledgement text - 
    "We acknowledge the EuroHPC Joint Undertaking for awarding this project access 
    to the EuroHPC supercomputer LUMI, hosted by CSC (Finland) and the LUMI consortium 
    through a EuroHPC Regular Access call." But, I am not accessing LUMI through the 
    "EuroHPC Regular Access call", 
    I got access through this workshop. Is this still okay to write the above 
    acknowledgement text in my article ? 
 
    -    Then I would rephrase it: 
         "We acknowledge LUMI TRAINING for awarding this project access to the EuroHPC 
         supercomputer LUMI, hosted by CSC (Finland) and the LUMI consortium through the 
         LUMI AI workshop, Oct. 8-9, 2025 at KTH, Stockholm, Sweden."
   
4.  In slide 10, titled "Example: 2 nodes, 2×8=16 GPUs in total", is it correct to 
    use `#SBATCH --mem=480G`. Should it be `480*2`?

    -   The `--mem` flag determines the requested memory __per node__, so `--mem=480G` is correct. 
        You can also set `--mem-per-cpu` or `--mem-per-gpu` to set it in a relative way on a per CPU 
        or GPU basis. 
        [Some more information in the sbatch manual page](https://slurm.schedmd.com/archive/slurm-23.02.7/sbatch.html#OPT_mem).

5.  7. I'm testing the lecture on my own code, it seems that after launching the experiment 
    some GPUs are not showing power consumption (4/8). It is just a DDP training on 
    California Housing dataset, could it be that the model/dataset is too small to make full 
    use of the gpus or something is off with my parallel setting?

    -   As also explained yesterday, power consumption is managed per package.
        This is also the reason why only half of the GCDs report power usage in
        the output of `rocm-smi`. 

        If it does show 500W, then you're really loading both GCDs very well.
        When using a full node it may also be slightly below 500W per GPU because 
        the power limiter for the whole node may limit the power consumption.

    -   The memory use of each GCD also gives an indication of something is going on
        that GCD.

    -   Also note that when you're using multiple nodes, logging in to one node and 
        run `rocm-smi` will still only show the power consumption for that node. 
        To get GPU information for different nodes, you'll have to connect to each 
        node and run `rocm-smi` on it. You can do this by also specifying the target 
        node you want to connect to with the `-w <target_node>` flag. 
        Have a look at Lectures 4 "Checking GPU activity" or 9 "Extreme Scale AI" for this.

6.  Is it possible to provide a dynamic name for `#SBATCH --output` and `--error` 
    files based on variables in the script?

    -   No, but you can use patterns in those filenames to insert things like jobid, jobname for example. 
        See [the 'filename pattern' section of the sbatch manpage](https://slurm.schedmd.com/archive/slurm-23.02.7/sbatch.html#SECTION_%3CB%3Efilename-pattern%3C/B%3E).

