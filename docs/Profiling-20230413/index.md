# HPE and AMD profiling tools (April 13, 2023)

## Course organisation

-   [Course schedule](schedule.md)

     *The full filename for the slides and the video recording of each presentation is also mentioned in that table,
     if that file is only available on LUMI.*

-   [HedgeDoc for questions (during the course only)](https://md.sigma2.no/lumi-profiling?edit)


## Downloads

-   Slides AMD:
    -   [Introduction to ROC-Profiler (rocprof)](https://462000265.lumidata.eu/profiling-20230413/files/02_intro_rocprof.pdf)
    -   [Introduction to OmniTrace](https://462000265.lumidata.eu/profiling-20230413/files/03_intro_omnitrace.pdf)
    -   [Introduction to Omniperf and Hierarchical Roofline on AMD Instinct<sup>TM</sup> MI200 GPUs](https://462000265.lumidata.eu/profiling-20230413/files/04_intro_omniperf_roofline.pdf)
-   [Perfetto](https://perfetto.dev/), the "program" used to visualise the output of omnitrace, is not a regular application but 
    [a browser application](https://ui.perfetto.dev/). Some browsers nowadays offer the option to install it on your
    system in a way that makes it look and behave more like a regular application (Chrome, Edge among others).


## Other material only available on LUMI

The following materials are available to members of the `project_465000502` project only:

-   Slides of presentations given by HPE people are in
    <code>/project/project_465000502/slides/HPE</code> on LUMI
-   Exercises from the HPE sessions are in
    <code>/project/project_465000502/exercises/HPE</code> on LUMI
-   Material for the AMD exercises is in
    <code>/project/project_465000502/exercises/AMD</code> on LUMI, 
    and there is also an [online text](https://hackmd.io/@gmarkoma/rkPbZqNMn)
    ([local copy(PDF)](https://462000265.lumidata.eu/profiling-20230413/files/LUMI-G_Pre-Hackathon-AMD.pdf))


## Notes

-   [Notes from the HedgeDoc document](hedgedoc_notes.md)


## Exercises

Some of the exercises used in the course are based on exercises or other material available in various GitHub repositories:

-   [vcopy.cpp example from the Omniperf presentation](https://raw.githubusercontent.com/AMDResearch/omniperf/main/sample/vcopy.cpp)
-   [mini-nbody from the rocporf exercise](https://github.com/ROCm-Developer-Tools/HIP-Examples/tree/master/mini-nbody)

