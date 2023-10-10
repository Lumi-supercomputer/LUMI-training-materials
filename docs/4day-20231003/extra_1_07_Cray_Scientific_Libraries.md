# Cray Scientific Libraries

*Presenter: Alfio Lazzaro (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465000644/Slides/HPE/05_Libraries.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-1_07_Cray_Scientific_Libraries.pdf`

-   Recording: `/appl/local/training/4day-20231003/recordings/1_07_Cray_Scientific_Libraries.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A


27. When should we link `libsci` when compiling GPU applications?

    -   Many GPU codes will use other linear algebra libraries on the GPU but may still want to do some small computations on the CPU, and for those computations libsci may be useful. The problem with LibSci_acc is that it is HPE Cray proprietary. Nice on LUMI or to get some code using some GPU acceleration that otherwise wouldn't, but not a good starting point if you want to develop a code that you also want to use on non-HPE Cray systems.

28. When should we link `libsci_acc` when compiling GPU applications? (ie. Doesn't HIP handle it all?)

    -   If you don't want to use HIP or ROCm-specific libraries with their function names but want to use the routines that you can easily swap out for the CPU versions.

