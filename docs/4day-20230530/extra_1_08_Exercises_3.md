# Exercise session 3

-   See `/project/project_465000524/slides/HPE/Exercises.pdf`.
    The files for the exercises are in
    `/project/project_465000524/exercises/HPE/day1/libsci_acc`.

    Test with LibSci_ACC, check the different interfaces and environment variables.

-   Permanent archive on LUMI:

    -   Exercise notes in `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.pdf`

    -   Exercises as bizp2-compressed tar file in
        `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.tar.bz2`

    -   Exercises as uncompressed tar file in
        `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.tar`



## Q&A

14. Do we still need to modify the job script? I logged in (to get a fresh shell), did `source lumi_g.sh` and submitted the script. 
The LibSci_ACC automatic interface runs terminates with:
    ```
    srun: error: nid007242: task 3: Bus error
    srun: launch/slurm: _step_signal: Terminating StepId=3606826.1
    slurmstepd: error: *** STEP 3606826.1 ON nid007242 CANCELLED AT 2023-05-30T15:48:22 ***
    srun: error: nid007242: tasks 0,2: Terminated
    srun: error: nid007242: task 1: Bus error (core dumped)
    ```
    Similar problem for the third run (Adding avoiding heuristics on input data).

    The run titled "Adding MPI G2G enabled" runs fine again, and with 8s seems faster than what was shown in the presentation.

    **Update**
    
    The `job.slurm` file for this exercise has been updated compared to this morning, after making the following changes
    ```
    25,26c25
    < module load cray-libsci_acc/22.08.1.1
    < export LD_LIBRARY_PATH=${CRAY_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}
    ---
    > module load cray-libsci_acc
    ```
    the problem that was mentiond above goes away.


