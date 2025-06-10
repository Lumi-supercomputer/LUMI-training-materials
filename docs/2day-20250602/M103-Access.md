# Getting Access to LUMI

*Presenter: Kurt Lust (LUST)*

We discuss the options to log on to LUMI and to transfer data.


## Materials

Materials will be made available after the lecture

<video src="https://462000265.lumidata.eu/2day-20250602/recordings/103-Access.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-103-Access.pdf)

-   [Course notes](103-Access.md)

-   [Exercises](E103-Access.md)

Archived materials on LUMI:

-   Slides: `/appl/local/training/2day-20250602/files/LUMI-2day-20250602-103-Access.pdf`

-   Recording: `/appl/local/training/2day-20250602/recordings/103-Access.mp4`


## Related lectures in this course

-   ["Using Lustre"](M203-Lustre.md) on day 2

-   ["LUMI-O Object Storage](M204-ObjectStorage.md) on day 2

-   ["Optimizing Large-Scale I/O](../2p3day-20250303/M503-IO_Optimization_Parallel_IO.md) in our 
    intensive 4- or 5-day courses


## Q&A

1.  I was using the LUMI GUI yesterday to upload some small files to my home directory, and found the process failed sometimes. But then it succeeded sometimes. Do you know if this is a bug?

    -   I suspect it may be related to loss of connection. 

    -   In my experience, you need to have a stable connection until all the files are uploaded, then they'll show up all at once. If you lose connection when only some files are shown to be uploaded, none of them will, in my experience, make it on LUMI. I think it was covered a bit in the section about how the GUI/OpenOnDemand environment works.

    -   Web servers are not a robust environment to upload or download lots of files. The protocols are simply
        not designed for that. So failures from time to time are to be expected. 
