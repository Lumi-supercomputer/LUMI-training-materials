# LUMI-O Object Storage

*Presenter: Kurt Lust (LUST)*

LUMI also has an object storage system. It is useful as a staging location
to transfer data to LUMI, but some programs may also benefit from accessing the 
object storage directly.
We highlight the differences
between a parallel filesystem such as Lustre and object storage, and discuss how
LuMI-O can be accessed.


## Materials

<!--
Materials will be made available after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20250602/recordings/204-ObjectStorage.mp4" controls="controls"></video>
<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-204-ObjectStorage.pdf)

-   [Course notes](204-ObjectStorage.md)

-   [Exercises](E204-ObjectStorage.md)

Archived materials on LUMI:

-   Slides: `/appl/local/training/2day-20250602/files/LUMI-2day-20250602-204-ObjectStorage.pdf`

-   Recording: `/appl/local/training/2day-20250602/recordings/204-ObjectStorage.mp4`


## Q&A

3.  Is there a REST API for accessing LUMI-O?

    -   Yes, you can use [RAW HTTP calls](https://docs.lumi-supercomputer.eu/storage/lumio/#raw-http-request). 
        But this is not recommended, why do you want to do this? 

    We want to automate data transfer and make it available for proccesing

    -   In that case we would recommend using libraries that support object storage. For example, Python has great support for object storage for example.
