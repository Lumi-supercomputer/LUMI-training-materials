# MPI Topics on the HPE Cray EX Supercomputer

*Presenter: Harvey Richardson (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465000644/Slides/HPE/11_cray_mpi_MPMD_medium.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-3_05_Cray_MPI_on_Slingshot.pdf`

-   Recording: `/appl/local/training/4day-20231003/recordings/3_05_Cray_MPI_on_Slingshot.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

5.  If you use GPU-aware MPI with larger eager messages, is there no risk of running out of memory even quicker? (Well, this would also be the case for CPU, but somehow on LUMI memory errors on the GPU for big MPI jobs are more common)

    -   There is a limit to how much you can increase the maximum size for eager messages. But yes, we do think that it also increases the amount of memory that MPI will use for buffering.
 
6. How does the `aws-ofi-rccl` fit together with all this?

    -   RCCL is not MPI, it is a different distributed memory communication protocol. And the `aws-ofi-rccl` plugin is a plugin for RCCL that enables it to communicate via the OFI communication library on LUMI which then uses the Cassini provider to work with SlingShot 11. Otherwise it would use a standard Linux protocol that is much slower.

