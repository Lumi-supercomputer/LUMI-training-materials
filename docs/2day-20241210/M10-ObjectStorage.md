# LUMI-O Object Storage

*Presenter: Kurt Lust (LUST)*

LUMI also has an object storage system. It is useful as a staging location
to transfer data to LUMI, but some programs may also benefit from accessing the 
object storage directly.
We highlight the differences
between a parallel filesystem such as Lustre and object storage, and discuss how
LUMI-O can be accessed.


## Materials

<!--
Materials will be made available during and after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20241210/recordings/10-ObjectStorage.mp4" controls="controls"></video>

-   [Slides](https://462000265.lumidata.eu/2day-20241210/files/LUMI-2day-20241210-10-ObjectStorage.pdf)

-   [Course notes](10-ObjectStorage.md)

-   [Exercises](E10-ObjectStorage.md)

<!--
-   A video recording will follow.
-->


## Q&A

1.  Allas storage can be called and streamed directly from the code. Does LUMI-O have the same feature? I mean, python code, that actually process these data, without copying them into the project folder.

    -   You can acces LUMI-O from the compute nodes, so it is possible to access your objects from your application if that is supported.

    -   I think `boto3` would be your friend, but there are certainly other options also. Since the last system update it might even be possible to use `rclone` with FUSE (`fusermount3`) to mount it as a filesystem, but for performance that may not be the best idea.

        I have a user in Belgium who is streaming training data for their AI training from a "Zarr file" from LUMI-O to LUMI and is happy about the performance. It are questions about zarr from this and another group in my home country that made me look deeper into it for this presentation...


