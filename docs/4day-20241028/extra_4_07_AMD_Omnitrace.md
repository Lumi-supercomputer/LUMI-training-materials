# Introduction to OmniTrace

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter: Samuel Antao (AMD)*

<!--
Course materials will be provided during and after the course.
-->

<!--
<video src="https://462000265.lumidata.eu/4day-20241028/recordings/4_07_AMD_Omnitrace.mp4" controls="controls">
</video>
-->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001362/Slides/AMD/session-4-introduction-to-omnitrace.pdf`

Materials on the web:

-   [Slides on the web](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-4_07_AMD_Omnitrace.pdf)

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-4_07_AMD_Omnitrace.pdf`

<!--
-   Recording: `/appl/local/training/4day-20241028/recordings/4_07_AMD_Omnitrace.mp4`
-->


## Q&A

1.  Where is `omnitrace`? `module spider omnitrace` or `module load omnitrace` do not show anything.

    -   They are part of the rocm stack, so available as part of the rocm module. This is for ROCm 6.2. For older versions look here https://hackmd.io/@sfantao/lumi-training-ams-2024#Omnitrace. There is a module that you can load after including a new path.
