# AMD ROCm<sup>TM</sup> profiling tools

<em>Presenter: Samuel Antao (AMD)</em>

-   Slides:

    -   [Part 1: rocprof (PDF, 3.2M)](https://462000265.lumidata.eu/profiling-20231122/files/02a_AMD_ROCm_profiling_tools_rocprof.pdf)

    -   [Part 2: OmniTrace (PDF, 9.7M)](https://462000265.lumidata.eu/profiling-20231122/files/02b_AMD_ROCm_profiling_tools_omnitrace.pdf)

    -   [Part 3: OmniPerf and the roofline model (PDF, 6.5M)](https://462000265.lumidata.eu/profiling-20231122/files/02c_AMD_ROCm_profiling_tools_omniperf_and_roofline.pdf)

    The slide files are also available on LUMI in
    `/appl/local/training/profiling-20231122/files`.

<!--
-   Recording in `/appl/local/training/profiling-20231122/recordings/02_Intro_rocprof.mp4`
-->


=== "Part 1: rocprof"
    <video src="https://462000265.lumidata.eu/profiling-20231122/recordings/02a_AMD_tools__rocprof.mp4" controls="controls"></video>

=== "Part 2: OmniTrace"
    <video src="https://462000265.lumidata.eu/profiling-20231122/recordings/02b_AMD_tools__OmniTrace.mp4" controls="controls"></video>

=== "Part 3: OmniPerf"
    <video src="https://462000265.lumidata.eu/profiling-20231122/recordings/02c_AMD_tools__OmniPerf.mp4" controls="controls"></video>

The recordings are also available on LUMI in
`/appl/local/training/profiling-20231122/recordings`.


## Q&A

1.  Can the tool used also for profiling ML framework, Tensforflow-Horovod

    -   Yes, omnitrace-python is the driver to be used in these cases ot see the Python call stack alongside the GPU activity.

2.  In the first set of slides it was mentioned that rocmprof serialize the kernels execution. How does this affect the other tools? Is it possible to use the tools to profile a program that launches multiple kernels on different streams or even in different processes and see the overal performance?

    -   No, rocprof does not serialize kernels, what I tried to explain is that users should serialize kernels for counter readings to be meaningful.

3.  Could you check the slide about installing of omniperf? I see different path in CMAKE_INSTALL_PREFIX and "export PATH". There is dependencies: Python 3.7 but default on Lumi is Python 3.6, which module is the best for that (e.g. cray-python)?


    -   Cray-python should be fine. The exported PATH is a typo, it should be: `export PATH=$INSTALL_DIR/1.0.10/bin:$PATH`. For the exercises we use the following to provide omniperf for ROCm 5.4.3:

        ```
        module use /pfs/lustrep2/projappl/project_462000125/samantao-public/mymodules
        module load rocm/5.4.3 omniperf/1.0.10-rocm-5.4.x

        source /pfs/lustrep2/projappl/project_462000125/samantao-public/omnitools/venv/bin/activate
        ```

