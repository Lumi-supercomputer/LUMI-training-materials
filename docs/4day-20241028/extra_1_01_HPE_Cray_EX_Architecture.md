# HPE Cray EX Architecture

*Presenter: Harvey Richardson (HPE)*

<!--
Course materials will be provided during and after the course.
-->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001362/Slides/HPE/01_EX_Architecture.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-1_01_HPE_Cray_EX_Architecuture.pdf`

<!--
-   Recording: `/appl/local/training/4day-20241028/recordings/1_01_HPE_Cray_EX_Architecture.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

3.  Numa node = processors connected to the same socket ? 

    -   Not on AMD. There are 4 numa nodes in each socket as each socket is 
        logically splitted in 4 quarters with really uniform memory access, 
        but slightly longer delay to the other quarter. This is a BIOS setting though 
        that is useful for HPC, but some AMD systems will be configured with one 
        NUMA domain per socket (and a different but sligthly slower way of accessing memory)
