# Hands-on: Run a simple single-GPU PyTorch AI training job

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20241126/03_Your_first_AI_training_job_on_LUMI).

<video src="https://462000265.lumidata.eu/ai-20241126/recordings/E03_FirstJob.mp4" controls="controls"></video>


## Q&A

1.  I get this:
    ```
    srun: fatal: SLURM_MEM_PER_CPU, SLURM_MEM_PER_GPU, and SLURM_MEM_PER_NODE are mutually exclusive.
    ```
    
    -   It is exactly what this said: You cannot combine different ways of requesting memory in a single job. You should make a choice between `--mem-per-cpu`, `--mem-per-gpu` or `--mem`. 
    
    I follow exactly the solution which is --mem-per-gpu.
    
    -   Are you launching the job from a Login node shell? If you launch from a Compute node shell it might already have some Slurm settings activated.
    -   I'm running from vscode terminal.

2.  Would `--cpus-per-gpu=7` also work when allocating on LUMI-G, instead of `--cpus-per-task=7 * ngpus`?

    -   If you mean as an alternative to `--cpus-per-task`, then probably, although I haven't tested it.
    
    -   The `srun` manual is a bit confusing, I'd avoid it as it implies another option which is only for job steps. Or at least check carefully t  first time you use it with techniques we will see later today that you don't get more GPUs in your job allocation than you expected.
        
        Slurm can sometimes show very unexpected behaviour with some options. They may also conflict with standard options set for some partitions.

3.  If we used `sbatch run.sh`, why do we use srun within it? Is there any advantage of it?

    -   `sbatch` only creates a job allocation. Work in Slurm is usually done in `job steps`, and they are created with `srun`. Some options that you specify with `sbatch` only take effect in regular job steps created with `srun`. 

        Well, I am oversimplifying, as `sbatch` does create a special job step, called the "batch job step". But that one only has resources on the first node. It basically gets all resources requested on the first node of the job. Settings like `--hint=nomultithread` (which is actually a default on LUMI) also have no effect in the batch job step.
        
        In a single-node job `srun` may not seem useful, but it actually is if you start a multi-process job. Moreover, `srun` is the only way to get access to other nodes of the job apart from the one on which the batch job step runs. You will see examples later in this course.
        
