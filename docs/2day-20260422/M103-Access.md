# Getting Access to LUMI

*Presenter: Dan Jonsson (LUST)*

We discuss the options to log on to LUMI and to transfer data.


## Materials

<!--
Materials will be made available after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20260422/recordings/LUMI-2day-20260422-103-Access.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20260422/files/LUMI-2day-20260422-103-Access.pdf)

-   [Course notes](103-Access.md)

-   [Exercises](E103-Access.md)


## Q&A


1.  What's the preferable way access/sync files and directories (e.g. from LUMI home directory) on a local computer? I've used 'rclone mount' so far, is it OK?

    -   `rclone mount`? That is for accessing object storage?
    
        There is more later in the presentation. For small transfers you're OK with `rsync` over ssh or `sftp`. I personally use `rsync` but only on selected subdirectories.
    
        For large transfers I would recommend to transfer from LUMI to object storage and then from object storage to your home machine. The difference is that those use multistream protocols that can get a much higher combined bandwidth than you can with a single stream tool such as `rsync` or `sftp`.
        
    Thanks for the answer. I was referring to my user home directory, which mostly contains just some source code or software config files. So I used rclone (which is built on rsync but preferred by my university) to simply mount that directory on my local computer, which is apparently fine.


