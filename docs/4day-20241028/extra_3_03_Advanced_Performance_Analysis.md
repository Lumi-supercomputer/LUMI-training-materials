# Advanced Performance Analysis

*Presenter: Thierry Braconnier (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001098/Slides/HPE/10_advanced_performance_analysis_merged.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-3_03_Advanced_Performance_analysis.pdf`

-   Recording: `/appl/local/training/4day-20240423/recordings/3_03_Advanced_Performance_Analysis.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  Does the tool enable profiling MPI-OpenACC Fortran ?

    -  Yes, `-g mpi,openacc` (MPI is default). 
       I suggest to use perftools-lite-gpu as a start


2.  Reveal only suggests the code for openMP?

    -   Yes It works best for Fortran codes, for C/C++ is still able to generate directives, 
        but likely it will not able to scope all variables. This is due to the aliasing that is common in C.
 
3.  Is perftools supported on Intel and NVIDIA GPUs ?

    -   The programming environment supports multiple hardware platforms, so yes. 
        But of course you need a license and cannot simply copy it from LUMI, that would be abuse. (see slide 58)
