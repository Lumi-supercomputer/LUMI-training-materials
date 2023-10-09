# Debugging at Scale – gdb4hpc, valgrind4hpc, ATP, stat

*Presenter: Thierry Braconnier (HPE)*

<!--
Course materials will be provided during and after the course.
-->

-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-2_03_Debugging_at_Scale.pdf`
    -   `/project/project_465000644/Slides/HPE/08_debugging_at_scale.pdf` (temporary, for the lifetime of the project)
-   Recording available on LUMI as:
    `/appl/local/training/4day-20231003/recordings/2_03_Debugging_at_Scale.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A


9.  Sometimes my jobs hang for a long time at start before anything apparently happens.
    Is `cray-stat` the right tool to debug this?

    - gdb4hpc and attach to it

10. How to properly load a coredump from a Singularity container using `rocgdb`?

    - no sure how to answer to this question... I assume you have the debugging symbols of the applications, so could you open a shell and mount rocgdb in the container to open the core file?

11.  What is the difference between the sanitizer tools and the standard debugging tools offered by the CCE that we discussed yesterday (e.g. options like -h bounds , etc etc)?

     - OK, those checks at runtime are related to some special cases (like bound checking). The asan (address sanitezer) offers more checks (check the corresponding webpages, e.g. https://clang.llvm.org/docs/AddressSanitizer.html )

     - The sanizers are in all compilers nowadays, sanizers4hpc is just an aggregator of the outputs for multiple ranks. 

12. Was `CRAY_ACC_DEBUG` only for OpenMP applications?

    - correct, only CCE and OpenACC and OpenMP


