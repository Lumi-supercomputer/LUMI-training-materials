# LUMI-O Object Storage

*Presenter: Dan Jonsson (LUST)*

LUMI also has an object storage system. It is useful as a staging location
to transfer data to LUMI, but some programs may also benefit from accessing the 
object storage directly.
We highlight the differences
between a parallel filesystem such as Lustre and object storage, and discuss how
LuMI-O can be accessed.


## Materials

Materials will be made available during and after the lecture

<video src="https://462000265.lumidata.eu/2day-20260422/recordings/LUMI-2day-20260422-204-ObjectStorage.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20260422/files/LUMI-2day-20260422-204-ObjectStorage.pdf)

-   [Course notes](204-ObjectStorage.md)

-   [Exercises](E204-ObjectStorage.md)


## Q&A


1.  Is the distinction between S3 and swift present in Allas relevant for LUMI-O?

    -   To be honest, we're not familiar with Allas as we have no account on that... I know part of the functionality on Allas is missing on LUMI-O and I believe that has to to do with Swift. If I understand the Allas documentation correctly (but that was a quick check): the swift tool is not supported on LUMI-O.

    -   But as both LUMI-O and Allas are completely external to either puhti/mahti/roihu and LUMI, you can use LUMI-O from puhti/mahti/roihu or use Allas from LUMI. CSC does have to [tools to access Allas from LUMI in their local software stack](https://docs.csc.fi/data/Allas/allas_lumi/) and from puhti/mahti and I guess soon roihu you can access LUMI-O simply using the rclone or s3cmd tools provided on those machines and use the configuration files generated with [auth.lumidata.eu](https://auth.lumidata.eu).

2. If `s3cmd info` doesn't show the correct URL, then is there a command that does? 
    
    - You need to configure s3cmd client first; please refere to the LUMI Docs on how to set it up properly; than try `s3cmd info s3://wheels` for instance.




