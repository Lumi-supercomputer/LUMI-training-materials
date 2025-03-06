# MPI Topics on the HPE Cray EX Supercomputer

*Presenter: Harvey Richardson (HPE)*

Course materials will be provided during and after the course.

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001726/Slides/HPE/10_cray_mpi_short.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-404-Cray_MPI_on_Slingshot.pdf`

<!--
-   Recording: `/appl/local/training/2p3day-20250303/recordings/404-Cray_MPI_on_Slingshot.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

7.  Based on the slide  (28 maybe) should we expect very similar perfomrance having 1 GPU per MPI vs 2 GPUs per MPI comunicating with each other when the GPUS are in the same ? Since both cases use P2P

    -   Could you make an example? 
    
    Sorry. For later. Assuming GPU-GPU communication. There are two cases 1 GPU per MPI, using MPI for excahnging data or 1MPI process with 2 GPUs using direct peer to peer access
            
    -   OK, so MPI uses P2P for that case (IPC) but there are corner cases (small message size for instance), so performance can be different. There is a range of env variables that you can use to tune P2P (check `man mpi` and grep for IPC). (sorry for the initial confusion, I thought P2P to be Point-to-Point MPI communications...)

