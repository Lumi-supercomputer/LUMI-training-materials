# Advanced Placement

*Presenter: Jean Pourroy (HPE)*


-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-2_03_Advanced_Application_Placement.pdf`
    -   `/project/project_465000524/slides/HPE/07_Advanced_Placement.pdf` (temporary, for the lifetime of the project)
-   Recording available on LUMI as:
    `/appl/local/training/4day-20230530/recordings/2_03_Advanced_Application_Placement.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

!!! Remark
    The `lumi-CPEtools` module (in the LUMI software stacks, see this afternoon) contains an alternative for `xthi` but not yet for the `hello_jobstep` tool.
    

## Q&A

4. Why is it not possible to hardcode binding on system level? Are there usecases where no binding or non-standard bindings are preffered?

    **Answer** We want to give the freedom to users as there are non-standard use cases. Sometimes it is better to have all threads in the same NUMA domain, sometimes you want to spread that.
    
    And for the GPU mapping: you'd need to ask the Slurm developers... Even getting good defaults in Slurm is hard. We'd really have to be able to always allocate in multiples of chiplets each with the matching GPU.