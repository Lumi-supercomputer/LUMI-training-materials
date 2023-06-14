# Advanced Performance Analysis

*Presenter: Thierry Braconnier (HPE)*

-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-3_03_Advanced_Performace_analysis.pdf`
    -   `/project/project_465000524/slides/HPE/10_advanced_performance_analysis_merged.pdf` (temporary, for the lifetime of the project)
-   Recording available on LUMI as:
    `/appl/local/training/4day-20230530/recordings/3_03_Advanced_Performance_Analysis.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

<!-- Note: Edit the sound in the recording. The first 20 minutes of this talk were accidentally recorded with the wrong mic actuvated and more silent than the remainder of the talk. -->

## Q&A

5.  Do I get it right that perftool  can actually point/suggest me the code  which will improve /benefit from GPUs?

    **Answer:** Not quite. Performance analysis is a pre-requisite for any optimization work. If the code spends a lot of time in MPI or I/O then concentrate on that. If you can identify areas of the code where computation is significant then think about taking those to the GPU.


