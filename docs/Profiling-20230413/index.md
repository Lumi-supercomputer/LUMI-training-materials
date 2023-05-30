# HPE and AMD profiling tools (April 13, 2023)

## Course organisation

-   [Course schedule](schedule.md)

     *The full filename for the slides and the video recording of each presentation is also mentioned in that table,
     if that file is only available on LUMI.*

-   [HedgeDoc for questions (during the course only)](https://md.sigma2.no/lumi-profiling?edit)


## Course materials

| Presenatation | slides | recording |
|:--------------|:-------|:----------|
| [Introduction](00_Introduction.md) | / | / |
| [Preparing an Application for Hybrid Supercomputing](01_Preparing_an_Application_for_Hybrid_Supercomputing.md) | *[slides](01_Preparing_an_Application_for_Hybrid_Supercomputing.md)* | *[recording](01_Preparing_an_Application_for_Hybrid_Supercomputing.md)* |
| [Introduction to ROC-Profiler (rocprof)](02_Intro_rocprof.md) | [slides](https://462000265.lumidata.eu/profiling-20230413/files/02_intro_rocprof.pdf) | *[recording](02_Intro_rocprof.md)* | 
| [Introduction to OmniTrace](03_Intro_OmniTrace.md) | [slides](https://462000265.lumidata.eu/profiling-20230413/files/03_intro_omnitrace.pdf) | *[recording](03_Intro_OmniTrace.md)* |
| [Introduction to Omniperf](04_Intro_OmniPerf.md) | [slides](https://462000265.lumidata.eu/profiling-20230413/files/04_intro_omniperf_roofline.pdf) | *[recording](04_Intro_OmniPerf.md)* |
| [Exercises](05_Exercises.md) | / | / |


## Extras

Extra downloads:

-   [Perfetto](https://perfetto.dev/), the "program" used to visualise the output of omnitrace, is not a regular application but 
    [a browser application](https://ui.perfetto.dev/). Some browsers nowadays offer the option to install it on your
    system in a way that makes it look and behave more like a regular application (Chrome, Edge among others).

Some of the exercises used in the course are based on exercises or other material available in various GitHub repositories:

-   [vcopy.cpp example from the Omniperf presentation](https://raw.githubusercontent.com/AMDResearch/omniperf/main/sample/vcopy.cpp)
-   [mini-nbody from the rocporf exercise](https://github.com/ROCm-Developer-Tools/HIP-Examples/tree/master/mini-nbody)

