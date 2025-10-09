# Your first training job on LUMI

*Presenters:* Mats Sjöberg (CSC) and Oskar Taubert (CSC)

Content:

-   Using LUMI via the command line
-   Submitting and running AI training jobs using the batch system

<!--
A video recording will follow.
-->

<!--
<video src="https://462000265.lumidata.eu/ai-20251008/recordings/03_FirstJob.mp4" controls="controls"></video>
-->


## Extra materials

<!--
More materials will become available during and shortly after the course
-->


-   [Presentation slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-03-First_AI_job.pdf)

-   [Hands-on exercises](E03_FirstJob.md)

<!--
-   [More extensive training materials on Slurm from the recent introductory "Supercomputing with LUMI" course from March 2025](../2p3day-20250303/index.md)

    -   A more detailed introduction to Slurm but without AI-specific examples is given in the 
        ["Slurm on LUMI" presentation](../2p3day-20250303/M201-Slurm.md).
        It also discusses the `sacct` command that can be used to get at least some resource use info
        from jobs.

    -   The presentation ["Process and Thread Distribution and Binding"](../2p3day-20250303/M202-Binding.md)
        is more oriented towards traditional HPC codes, but the discussion on a proper mapping
        of GPU dies onto CPU chiplets is also relevant for AI applications. But that is a discussion
        for the second day of this course/workshop.
-->


## Q&A

1.  Question from the audience about dynamic job size

    -   No, this cannot be done. And it is normal also, as there is no guarantee that the resources 
        would be immediately available, so your job would be stuck while still keeping the nodes 
        that it already has, which is very expensive.

        You can write dependent jobs, where you specify that one job should only start when another 
        job has finished. So you could have a second job with more resources that can get scheduled 
        as soon as the first job with fewer resources ends. 
        See [this part of the sbatch manual](https://slurm.schedmd.com/archive/slurm-23.02.7/sbatch.html#OPT_dependency)

    -   Running an inference service on a HPC system with inelastic job scheduling is not an ideal fit, 
        but increasingly asked for and there are "overlay" solutions that try to provide a bridge 
        at the cost of some efficiency.

    -   An HPC system has advantages over cloud infrastructure (it can be cheaper), but then it also 
        comes with restrictions that a cloud infrastructure does not have...
     
2.  What does the flag `--overlap` do in `srun`?

    -   It allows multiple job steps in Slurm to overlap resources such as CPU cores and GPUs. 
    -   But this is a very brief introduction to Slurm. In the regular intro courses, we have 
    -   [a 2 hour lecture](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20250602/M201-Slurm/) 
    -   and even that is not enough to explain all that in detail...

3.  ***Info*** [Link to the HyperQueue presentation mentioned after a question in the room]( https://lumi-supercomputer.github.io/LUMI-training-materials/User-Coffee-Breaks/20240131-user-coffee-break-HyperQueue/)

4.  I'm attempting to view the training stats on TensorBoard using the path to runs but it displays empty loss curves. 
    Is this expected at this stage of the tutorial? EDIT: (**It started showing some data**)

    -   Tensorboard is not the fastest.

    -   Also: it should write the tensorboard logs to scratch, not projappl (unless you change that).

    -   When you launch tensorboard you need to add the path `/scratch/project_465002178/USERNAME/runs/` 
        to the TensorBoard log directory (replace `USERNAME` with your actual username)

6.  Got this error: 
    ```
    + srun singularity exec /appl/local/containers/sif-images/lumi-pytorch-rocm-6.2.4-python-3.12-pytorch-v2.6.0.sif /users/sharmavi/test.py --output-path /scratch/project_465002178/sharmavi/data/ --logging-path /scratch/project_465002178/sharmavi/runs/
    **FATAL:   permission denied **
    ```

    -   This will try to run the script `test.py`. So 
       
         1.  This has to be an executable script, and
         2.  It has to start with the correct shebang line to tell Linux to use Python
             (and which Python), i.e., that line that starts with `#!`.

    -   Or you just forgot the `python` after the sif-file.

