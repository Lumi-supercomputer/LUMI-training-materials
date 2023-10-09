# Tools in Action - An Example with Pytorch

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter:* Samuel Antão (AMD)

Course materials will be provided during and after the course.

<video src="https://462000265.lumidata.eu/4day-20231003/recordings/4_10_Best_Practices_GPU_Optimization.mp4" controls="controls">
</video>

-   [Slides on the web](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-4_10_Best_Practices_GPU_Optimization.pdf)

-   Downloadable scripts as
    [bzip2-compressed tar archive](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-4_10_scripts.tar.bz2) and 
    [uncompressed tar archive](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-4_10_scripts.tar)

-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-4_10_Best_Practices_GPU_Optimization.pdf`
    -   `/project/project_465000644/Slides/AMD/session-6-ToolsInActionPytorchExample-LUMI.pdf` (temporary, for the lifetime of the project)

-   Scripts archived on lumi as
    bzip2-compressed tar archive in `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-4_10_scripts.tar.bz2` and
    uncompressed tar archive in `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-4_10_scripts.tar`.

-   Video also available on LUMI as
    `/appl/local/training/4day-20231003/recordings/4_10_Best_Practices_GPU_Optimization.mp4`


## Q&A


13. If PyTorch does not use MPI, what does it use?

    -   RCCL, the ROCm version of the NVIDIA NCCL library. It needs a plugin to communicate across nodes but I guess that will also be shown in the talk.

14. Why we don't need `libsci` for BLAS, LAPACK, etc?

    -   He is using a different one here because it doesn't really matter if you may a Pytorch for GPU. BLAS operations will run on the GPU with ROCm libraries.

    Why not EasyBuild then?

    -   The build process is not very compatible with EasyBuild. It is possible but adapting the EasyConfigs that exist for Pytorch to LUMI is too time-consuming for us at the moment. And in the end we want to end up in a container which comes later in the talk...

15. I thought conda and python packages should be installed in containers?

    -   Preferably, especially if they become large in number of files. It is also comming up in the talk... Running outside a container can be useful though if you need to go in the code with debuggers and profilers.

        An in between solution, especially if you work on exclusive nodes, could be to install in `/tmp` which would be very good for performance also. You could then store a tar archive and uncompress that in the job to do the installation, and still be able to use debuggers etc. easily.

16. How does Singularity enable more recent ROCm versions?

    -   Because you can put dependencies in there also that are not on the system. E.g., recent ROCm versions are build with a newer version of gcc than is the default on LUMI, and with a container you can put the right compiler runtime libraries where ROCm can also find them.

        One of the major reasons to use containers is to provide libraries that are not on the system or that are required in a different version than on the system without creating conflicts.

17. What does MIOpen do?

    -   It is the ROCm equivalent of cuDNN and is the BLAS of machine learning applications: It contains optimised implementations of common operations in machine learning applications. Each vendor tries to make its optimised implementation of those routines. Intel also has an mklDNN for its CPUs and now GPU also. Pytorch and Tensorflow both use it.

18. Do we have access to these scripts?

    -   They are in the `Exercises/AMD/Pytorch` subdirectory, and archived via [this page](http://localhost:8000/LUMI-training-materials/4day-20231003/extra_4_10_Best_Practices_GPU_Optimization/).

19. Meta question: Are we allowed to share/show

    -   AMD and LUST slides and recordings: Yes, they can be shared at will, just acknowleding they come from a LUMI course. However, for LUST material, if you want to use the material in your own trainings or more formal presentations, you should make it very clear that LUST did not check modifications or if they are still up-to-date and hence cannot be responsible for errors. To re-use AMD material in more formal events it is best to contact them. (Notice, e.g., that AMD people presenting have to show a disclaimer at the end so they will likely require something similar if you copy from their slides.)
        
    -   HPE slides and recordings: Only to people with a userid on LUMI.

    -   Basically if we make them directly available via web links they can be shared informally, just mentioning where they come from, and if they are only available on the system in the training project or `/appl/local/training` but not via a direct web link, then access is restricted to people with a userid.
    
    -   You can always share this link to [our training material webpage](https://lumi-supercomputer.github.io/LUMI-training-materials/4day-20231003/)

20. Is there offline version of perfetto.dev? Because one should have local version if looking in long time perspective. Remote things tend to make changes which break everything or make it for payment.

    -   According to AMD, no, perfetto is only available in online version.

        The [code is available in a GitHub repository](https://github.com/google/perfetto)
        though so it should be possible to set up a web server yourself running perfetto.
        
        I do notice there are downloads in that repository also but I do not know if they contain a complete web server etc., or need to be installed on top of one already existing. I cannot check as my Mac detects the files as suspicious and refuses to download.

    Thank you very much. Well, just cloning that repo may fix it.

