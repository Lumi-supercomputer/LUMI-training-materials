# AMD ROCm<sup>TM</sup> profiling tools

<em>Presenter: Samuel Antao (AMD)</em>

<!--
-   [Slides](https://462000265.lumidata.eu/profiling-20231122/files/02_intro_rocprof.pdf)

-   Recording in `/appl/local/training/profiling-20231122/recordings/02_Intro_rocprof.mp4`
-->

## Q&A

1.  Can the tool used also for profiling ML framework, Tensforflow-Horovod

    -   Yes, omnitrace-python is the driver to be used in these cases ot see the Python call stack alongside the GPU activity.

2.  In the first set of slides it was mentioned that rocmprof serialize the kernels execution. How does this affect the other tools? Is it possible to use the tools to profile a program that launches multiple kernels on different streams or even in different processes and see the overal performance?

    -   No, rocprof does not serialize kernels, what I tried to explain is that users should serialize kernels for counter readings to be meaningful.

3.  Could you check the slide about installing of omniperf? I see different path in CMAKE_INSTALL_PREFIX and "export PATH". There is dependencies: Python 3.7 but default on Lumi is Python 3.6, which module is the best for that (e.g. cray-python)?
