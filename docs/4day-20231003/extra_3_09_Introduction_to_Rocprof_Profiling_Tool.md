# Introduction to ROC-Profiler (rocprof)

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter:* Samuel Antão (AMD)


<!--
Course materials will be provided during and after the course.
-->

<!--
<video src="https://462000265.lumidata.eu/4day-20231003/recordings/3_09_Introduction_to_Rocprof_Profiling_Tool.mp4" controls="controls">
</video>
-->

-   [Slides on the web](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-3_09_Introduction_to_Rocprof_Profiling_Tool.pdf)

-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-3_09_Introduction_to_Rocprof_Profiling_Tool.pdf`
    -   `/project/project_465000644/Slides/AMD/session-3-introduction-to-rocprof.pdf` (temporary, for the lifetime of the project)

<!--
-   Video also available on LUMI as
    `/appl/local/training/4day-20231003/recordings/3_09_Introduction_to_Rocprof_Profiling_Tool.mp4`
-->

!!! Note
    [Perfetto](https://perfetto.dev/), the "program" used to visualise the output of omnitrace, is not a regular application but 
    [a browser application](https://ui.perfetto.dev/). Some browsers nowadays offer the option to install it on your
    system in a way that makes it look and behave more like a regular application (Chrome, Edge among others).


## Q&A

10. According to the schedule this was going to be rocprof session. Is it tomorrow then?

    - Not sure which agenda you're looking at, but the rocprof session is after this exercise round at 16:00
    - My bad, sorry! :)
    

11. Let's say my GPU bindings are bad. How would I detect this using the profiler?

    -   See the recording for the answer.

    -   Difficult to detect via a profiler. You may see some low bandwidth but you are never sure that it is caused by a wrong biding. 

    -   We have the `gpu_check` command in `lumi-CPEtools` to check the binding but that does not work for applications that do the binding themselves. 

12. Can we see the GPU memory usage in the profiler output? Or is there some other signal in the profiler to detect if we are not using the GPU memory efficiently?

    -   See the recording. You can see the allocations that you did. 

    -   AMD needs to doublecheck, but Omnitrace (discussed tomorrow) may give more information.

    -   Whether memory is used well is more difficult for a profiler to tell. You can see bandwidths and number of read and write operations, but that does not necessarily imply that memory is used well or badly.

13. Nvtop could help figuring out general memory allocation. https://github.com/Syllo/nvtop GPU agnostic


