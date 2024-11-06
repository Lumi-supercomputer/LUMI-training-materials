# Compilers and Parallel Programming Models

*Presenters: Harvey Richardson and Alfio Lazzaro (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001362/Slides/HPE/04_Compilers_and_Programming_Models.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-1_05_Compilers_and_Parallel_Programming_Models.pdf`

-   Recording: `/appl/local/training/4day-20241028/recordings/1_05_Compilers_and_Parallel_Programming_Models.mp4`

<!--
-   Could add references from the last slide?
-->

These materials can only be distributed to actual users of LUMI (active user account).

!!! Note "Alternative for modifying `LD_LIBRARY_PATH`"
    Instead of using
    ```LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH```,
    you can also use the module [lumi-CrayPath](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-CrayPath/). 
    Loading it essentially does that setting for `LD_LIBRARY_PATH`, unloading tries to restore the old situation, 
    and reloading while the module is already loaded, will adapt to a possibly modified `$CRAY_LD_LIBRARY_PATH`. 
    (So basically use it after loading all other modules that you need.)


## Q&A

1.  Together with Kokkos, Raja there is Alpaka as a portability library. Thank you for mentioning :)

    -   Some of the slides probably come from the USA as HPE is an american company and they tend to 
        not know Alpaka unfortunately ;-)
