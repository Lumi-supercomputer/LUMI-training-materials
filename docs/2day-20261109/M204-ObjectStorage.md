# LUMI-O Object Storage

*Presenter: Dan Jonsson (LUST)*

LUMI also has an object storage system. It is useful as a staging location
to transfer data to LUMI, but some programs may also benefit from accessing the 
object storage directly.
We highlight the differences
between a parallel filesystem such as Lustre and object storage, and discuss how
LuMI-O can be accessed.


## Materials

<!-- Materials will be made available during and after the lecture -->

<!--
<video src="https://462000265.lumidata.eu/2day-20261109/recordings/204-ObjectStorage.mp4" controls="controls"></video>
-->
-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2day-20261109/files/LUMI-2day-2day-20261109-204-ObjectStorage.pdf)

-   [Course notes](204-ObjectStorage.md)

-   [Exercises](E204-ObjectStorage.md)


## Q&A

1.  What is the benefit of a flat structure for the object storage system?

    -   That is just a basic property of object storage. Internally it is implemented in a totally different way from classical filesystems (and actually uses database technology for the metadata). It is also developed with totally different applications in mind from classical filesystems and is really made for, e.g., replicating data across sites.

2.  Does LUMI also provide a long-term archival system, like on tapes?

    -   No. That is the task of other organisations, and typically national supercomputer centres that get permanent structural funding rather than one-off projects such as LUMI that get funding without guarantee for a successor. LUMI only offers work storage. In fact, data should be copied from LUMI as soon as it is generated as there is also no backup of any volume.

    -   Research Data Management has totally different requirements than what LUMI can provide and is organised in different projects. And often at the national or even university level, organisations that are also likely to persist for the duration that the data has to persist.

3.  In the context of EU digital sovereignty, will the next generation LUMI system consider migerate away from S3 bucket to something EU based providers for object storage?

    -   Nothing is stored in S3. It uses the S3 protocols but no storage from Amazon. Your data is in Kajaani on hardware owned by EuroHPC JU and operated by CSC.


