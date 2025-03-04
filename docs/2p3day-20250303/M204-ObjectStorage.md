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
Materials will be made available during and after the lecture
-->
<!--
<video src="https://462000265.lumidata.eu/2p3day-20250303/recordings/204-ObjectStorage.mp4" controls="controls"></video>
-->
-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-204-ObjectStorage.pdf)

-   [Course notes](204-ObjectStorage.md)

-   [Exercises](E204-ObjectStorage.md)


## Q&A

1.  I might have missed this, but my normal workflow generates some data on (e.g.) the scratch which I then scp to my local cluster and then delete on LUMI. Does using LUMI-O offer any advantage with respect to this procedure?

    -   Only if you have performance constraints: scp does not offer multiple stream, but only one. if you have very large files, it may speedup your process.



