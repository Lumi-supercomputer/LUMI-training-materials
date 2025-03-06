# Introduction to ROC-Profiler (rocprof)

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter: Samuel Antao (AMD)*

Course materials will be provided during and after the course.

<!--
<video src="https://462000265.lumidata.eu/2p3day-20250303/recordings/406-Introduction_to_Rocprof_Profiling_Tool.mp4" controls="controls"></video>
-->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `'/project/project_465001726/Slides/AMD/session 03 - introduction to rocprof.pdf'`

Materials on the web:

-   [Slides on the web](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-406-Introduction_to_Rocprof_Profiling_Tool.pdf)

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-406-Introduction_to_Rocprof_Profiling_Tool.pdf`

<!--
-   Recording: `/appl/local/training/2p3day-20250303/recordings/406-Introduction_to_Rocprof_Profiling_Tool.mp4`
-->


!!! Note
    [Perfetto](https://perfetto.dev/), the "program" used to visualise the output of omnitrace, is not a regular application but 
    [a browser application](https://ui.perfetto.dev/). Some browsers nowadays offer the option to install it on your
    system in a way that makes it look and behave more like a regular application (Chrome, Edge among others).


## Q&A

1.  Does rocprof work with (CPU) OpenMP (launching kernels on the GPU from different OpenMP threads)? 

    -   Yes it will capture all threading in your application and the GPU activity contained in it. This is also a reminder that might be wise to reduce the ammount of threading while you profile if that is not critical for the conclusions you are trying to make. Capturing too much information clutters the visualization and can increase overhead.


2.  Does rocprof work with NVIDIA GPUs (with hip runtime installed, ofc)?

    -   No. A profiler needs hardware counters, etc., and those are different on NVIDIA hardware.


3.  Maybe I missed some sentenses: in general it is recommended to use rocprof v3, v2 or v1?

    -   I recommend using rocprof v3. If you are using an early patch version of ROCm 6.2 you might be prone to come accross some bugs, in that case switch to rocprof (v1).

4.  One question related to perf tools, it is giving node power usage, but how can I find the power available per node for lets says for LUMI-C node or LUMI-G node?? rocm-smi i think can give power related to GPU but what about CPU and memory? and can this information is used to derive efficiency of code?

    -   [Energy consumption in the LUMI docs](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/jobenergy/)

    -   Not all nodes have the same power cap. Nodes where the hardware is somewhat slower, have their power cap a bit higher. Power consumption can vary a lot between runs...

    -   Efficiency of code: Also hard. One can always lower the clock spoeed of a node which would reduce the power consumption for all operations, but your code would also be slower. So is this more efficient? Not necessarily in TCO.

