# The HPE Cray Programming Environment

*Presenter: Kurt Lust (LUST)*

As Linux itself is not a complete supercomputer operating system, many components
that are essential for the proper functioning of a supercomputer are separate packages
(such as the [Slurm scheduler](M201-Slurm.md) discussed later in this course) or part 
of programming environments. 
It is important to understand the consequences of this, even if all you want is to simply
run a program.


## Materials

<!-- Materials will be made available after the lecture -->

<!--
<video src="https://462000265.lumidata.eu/2day-20261109/recordings/102-CPE.mp4" controls="controls"></video>
-->
-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2day-20261109/files/LUMI-2day-20261109-102-CPE.pdf)

-   [Course notes](102-CPE.md)

-   [Exercises](E102-CPE.md)


## Q&A

1.  Why is the next system Nvidia ? is it to do with vendor lock

    -   LUMI-AI will be an AMD machine (see: https://www.eurohpc-ju.europa.eu/eurohpc-ju-signs-contract-deploy-lumi-ai-supercomputer-2026-08-31_en ).

    -   If the confusion comes from the Wave32 model: AMD currently has two architectures: CDNA version 1 till 4 (MI250X is CDNA2) have Wave64, but the some of the RDNA GPUs are also supported by ROCm and they have Wave32. For the next iteration, CDNA5, AMD is moving to a more unified architecture and also goes to Wave32 as the native format for the compute GPUs.

