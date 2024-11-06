# MPI Topics on the HPE Cray EX Supercomputer

*Presenter: Harvey Richardson (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001362/Slides/HPE/11_cray_mpi_MPMD_medium.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-3_05_Cray_MPI_on_Slingshot.pdf`

-   Recording: `/appl/local/training/4day-20241028/recordings/3_05_Cray_MPI_on_Slingshot.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  For the 2D neighbour exchange example on the slides, isn't it easier to let `MPI_Cart_create()` deal with the reordering and just use whatever it returns? And then ask the MPI_Cart_shift() for neighbours?
   
    -   Cart may not create an optimal solution. It may not be aware about things like node-layout and NUMA domains.
