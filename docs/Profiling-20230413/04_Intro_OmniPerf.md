# Introduction to Omniperf

-   [Slides](https://462000265.lumidata.eu/profiling-20230413/files/04_intro_omniperf_roofline.pdf)

-   Recording in `/appl/local/training/profiling-20230413/recordings/04_Intro_OmniPerf.mp4`


## Remarks

!!! warning
    For security reasons it is best to run `omniperf analyze` on a single user machine that 
    is protected by a firewall (which is why we do not want to install it visibly on LUMI). 
    It opens an unprotected port to a webserver so everybody with access to LUMI can easily 
    guess the port number and get access to some of your data that way.


## Q&A

16. Not related to omniperf. On `tranining/exercises/HPE/openacc-mpi-demos` after doing `sbatch job.slurm`.
    ```
    srun: error: CPU binding outside of job step allocation, allocated CPUs are: 0x01FFFFFFFFFFFFFE01FFFFFFFFFFFFFE.
    srun: error: Task launch for StepId=3372350.2 failed on node nid007281: Unable to satisfy cpu bind request
    srun: error: Application launch failed: Unable to satisfy cpu bind request
    ```
    
    **Answer**
    
    -   let me fix it, I will report here when it is done (for the record, this is due to the today's change in Slurm)... done, please check.
        -   what change in slurm happened today?
        -   LUMI admins somehow reverted a change in Slurm that came in with the update where SLURM no longer propagates cpus-per-task if set in an SBATCH job comment into the srun. The old behaviour was restored but we tested the scripts yesterday. There was a user email this morning.

17. Slide 43, the kernels performance are good or not? There is a threshold in terms of distance from boundaries?

    **Answer**
    
    Will be in the recording. The performance is not very good (and take into account the scales are logarithmic so the dots are very far from the boundary).


