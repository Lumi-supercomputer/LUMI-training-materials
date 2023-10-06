# Introduction to OmniTrace

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter:* Samuel Antão (AMD)

Course materials will be provided during and after the course.

<!--
<video src="https://462000265.lumidata.eu/4day-20231003/recordings/4_06_AMD_Omnitrace.mp4" controls="controls">
</video>
-->

-   [Slides on the web](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-4_06_AMD_Omnitrace.pdf)

-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-4_06_AMD_Omnitrace.pdf`
    -   `/project/project_465000644/Slides/AMD/session-4-introduction-to-omnitrace.pdf` (temporary, for the lifetime of the project)

<!--
-   Video also available on LUMI as
    `/appl/local/training/4day-20231003/recordings/4_06_AMD_Ominitrace.mp4`
-->

## Q&A

9.  Where do we get rocm 5.4.3? I thought that the latest on LUMI is 5.3.3 (and even that is not supported).

    -   LUST does not support anything newer than 5.3.3 because newer versions are not 100% compatible with the PE we have. However, the [exercises for this talk](https://hackmd.io/@sfantao/H1QU6xRR3#Omnitrace) point to an unofficial one. But don't complain if it does not work for what you want to do (e.g., problems with gcc or MPI hangs may occur, and the installaton plays not nice with the Cray PE wrappers).

        There is hope that after the next system update later this fall ROCM 5.5 will be available, but sysadmins are still testing everything involved with that update so it is not yet 100% certain it will be ready for the next maintenance window.
        
    -   5.3.3 is not supported in the sense that if there turn out to be problem with it in combination with the PE, we cannot upstream problems to get a solution from the vendor, and also it is not compatible with the way `PrgEnv-amd` works. However, it has been successfully used on LUMI by several users.
