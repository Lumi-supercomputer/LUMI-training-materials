# Exercise session 7

-   See `/project/project_465000524/slides/HPE/Exercises.pdf` for the exercises.

-   Files are in 
    `/project/project_465000524/exercises/HPE/day3`

-   Permanent archive on LUMI:

    -   Exercise notes in `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.pdf`

    -   Exercises as bizp2-compressed tar file in
        `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.tar.bz2`

    -   Exercises as uncompressed tar file in
        `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.tar`


## Q&A


2.  I tried perfools-lite on another example and got the following message from pat-report:

    ```
    Observation:  MPI Grid Detection

        There appears to be point-to-point MPI communication in a 4 X 128
        grid pattern. The 24.6% of the total execution time spent in MPI
        functions might be reduced with a rank order that maximizes
        communication between ranks on the same node. The effect of several
        rank orders is estimated below.

        No custom rank order was found that is better than the RoundRobin
        order.

        Rank Order    On-Node    On-Node  MPICH_RANK_REORDER_METHOD
                     Bytes/PE  Bytes/PE%
                                of Total
                                Bytes/PE

        RoundRobin  1.517e+11    100.00%  0
              Fold  1.517e+11    100.00%  2
               SMP  0.000e+00      0.00%  1
    ```
    
    Normally for this code, SMP rank ordering should make sure that collective communication is all intra-node and inter-node communication is limited to point-to-point MPI calls. So I don't really get why the recommendation is to switch to RoundRobin (if I understand this remark correctly)? Is this recommendation only based on analysing point-to-point communication?

    **Answer**: Yes, you understood the remark correctly. This warning means that Cray PAT detected a suboptimal communication topology and according to the tool estimate, a round-robin rank ordering should maximize intra-node communications. There is a session about that at the beginning of the afternoon.

    **Reply**: I would be very surprised if round-robin rank ordering would be beneficial in this case. I tried to run a job with it, but this failed with:

    ```
    srun: error: task 256 launch failed: Error configuring interconnect
    ```
    and similar lines for each task.
    The job script looks as follows:

    ```
    module load LUMI/22.12 partition/C
    module load cpeCray/22.12
    module load cray-hdf5-parallel/1.12.2.1
    module load cray-fftw/3.3.10.3

    export MPICH_RANK_REORDER_METHOD=0
    srun ${executable}
    ```


