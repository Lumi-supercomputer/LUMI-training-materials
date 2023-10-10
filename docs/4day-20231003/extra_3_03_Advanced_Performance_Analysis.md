# Advanced Performance Analysis

*Presenter: Thierry Braconnier (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465000644/Slides/HPE/10_advanced_performance_analysis_merged.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-3_03_Advanced_Performace_analysis.pdf`

-   Recording: `/appl/local/training/4day-20231003/recordings/3_03_Advanced_Performance_Analysis.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

4.  In general, is the reliability of the profiling times (flops, percentages) equally good for directly compiled routines, cray libraries, external libraries? Are the perftools sufficient to get a reliable overview or is it always better to accompany this analysis with a direct output of the system times?

    -   The goal of any profiler tool is to provide reliable analysis of the execution. Of course it can affect the overall performance with overhead (or it can apply serialization in some parts). It really depends on the application, I don't think there is a final answer for that. For this reason perftools is always providing the non-instrumented version so that you can compare the overall execution. 

    -   But any other debug or profiling code you put in the application may also influence the application, especially if you also do immediate I/O of the numbers rather than storing them somewhere and doing all I/O outside of code that you want to time.

    -   The biggest danger is with tracing if you trace very small fast functions, perftools tries not to do this.


