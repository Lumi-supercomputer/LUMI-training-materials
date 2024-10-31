# Introduction to Python on Cray EX

*Presenter: Jean Pourroy (HPE)*

<!--
Course materials will be provided during and after the course.
-->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001362/Slides/HPE/12_1_Python_Frameworks.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-4_01_Introduction_to_Python_on_Cray_EX.pdf`

<!--
-   Recording: `/appl/local/training/4day-20241028/recordings/4_01_Introduction_to_Python_on_Cray_EX.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  Why is it recommended to run Python codes not using multi-threading/multi-processing still with `srun`?

    -   not sure I understand the question, `srun` allows to run on the compute nodes (otherwise you will run on the login nodes if you use `salloc`)

    -   Note also that in a batch job, there is a difference between calling a program with and without srun. Without srun, it runs in the context of the batch job step, which includes, e.g., all hyperthreads on all cores of the first node of the job available to the job, while with `srun`, the LUMI-default `--hint=nomultithread` would apply.

