# AMD Omniperf

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter: Samuel Antao (AMD)*

<!--
Course materials will be provided during and after the course.
-->

<!--
<video src="https://462000265.lumidata.eu/4day-20241028/recordings/4_09_AMD_Omniperf.mp4" controls="controls">
</video>
-->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001362/Slides/AMD/session-5-tutorial_omniperf.pdf`

Materials on the web:

-   [Slides on the web](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-4_09_AMD_Omniperf.pdf)

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-4_09_AMD_Omniperf.pdf`

<!--
-   Recording: `/appl/local/training/4day-20241028/recordings/4_09_AMD_Omniperf.mp4`
-->


## Q&A

1.  How to query for the information about a job which has already finished?
    -   Check the many output options of `sacct`, this is the command to request information for finished jobs. See also the man page of `sacct`. The [link for the version that is currently on LUMI](https://slurm.schedmd.com/archive/slurm-23.02.7/sacct.html), is in the [Appendix with documentation that you'll find on the web site of this course](A01_Documentation.md). The `-o` or `--format` command line flag enables you to specify a lot of different fields with information about the job.
