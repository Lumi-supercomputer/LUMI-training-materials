# Introduction to Perftools

*Presenters: Thierry Braconnier  and Alfio Lazarro (HPE)*

Course materials will be provided during and after the course.

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001726/Slides/HPE/07_introduction_to_perftools.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-401-Introduction_to_Perftools.pdf`

<!--
-   Recording: `/appl/local/training/2p3day-20250303/recordings/401-Introduction_to_Perftools.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).

!!! Info
    You can find the downloads of Apprentice2 and Reveal on LUMI in
    `$CRAYPAT_ROOT/share/desktop_installers/`. This only works when the
    `perftools-base` module is loaded, but this is the case at login.


## Links

-   [Overview of the tools in the CPE documentation](https://cpe.ext.hpe.com/docs/24.03/performance-tools/index.html)


## Q&A

1.  Can these tools analyse both CPU and GPU code in an application?

    -   Yes, but for GPU code we have sessions this afternoon and tomorrow in which we also cover AMD specific profiling tools (rocprof, OmniTrace, Omniperf).

    Follow-up question/clarification. I have fortran code on CPU and call GPU fucntions via is_c_binding. I am mostrly interested in doing traces that have both CPU and GPU calls.

    -   Yes, you can use `perftools-lite-gpu`. For more specific analysis you can use the perftools (see the next talk).


2.  Do these perftools work with all PE (gnu, cray, amd, ...)?

    -   In general, yes. The one thing that is specific is the -loops functionality as it needs the compiler to generate trace points for loops, something CCE does. Even if you can't do that you can still do sampling and see which source lines are getting sample hits.


3.  Are perftools similar to NVIDIA Nsight Systems?

    -   We cannot really answer as we are not an NVIDIA site and don't have the NVIDIA tools. I'd expect the AMD tools that will be discussed tomorrow to be closer to NVIDIA tools as they focus more on GPU.


4.  In addition to MPI timing, will perf tool details about MPI bandwidth and data transfer details?? I have pure F90 and F90+HIP-C code (both MPI) that i need to profile.

    -    Yes, I suggest to use `perftools` instead of `perftools-lite` and then you can ask `-g mpi` that will give you more info on MPI (see presentation after the break or ["Use Predefined Trace Groups" in the HPE documentation](https://support.hpe.com/hpesc/public/docDisplay?docId=a00114942en_us&page=Use_Predefined_Trace_Groups.html) and [this page in the LUMI docs](https://docs.lumi-supercomputer.eu/development/profiling/perftools/).

