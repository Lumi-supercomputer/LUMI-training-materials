# Cray Scientific Libraries

*Presenter: Alfio Lazzaro (HPE)*


-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-1_07_Cray_Scientific_Libraries.pdf`
    -   `/project/project_465000524/slides/HPE/05_Libraries.pdf` (temporary, for the lifetime of the project)

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

13. Is it a good practice to run converted CUDA library by HIP in AMD GPUs? if no, any other better solution?

    **Answer** Usually it is a good starting point, especially if you know the code. But there are differences that you should take into account to optimise the code. E.g., the "warp size" is 64 instead of 32.


