# Using Lustre

*Presenter: Emanuele Vitali (LUST)*

Lustre is a parallel file system and the main file system on LUMI.
It is important to realise what the strengths and weaknesses of Lustre at the
scale of a machine as LUMI are and how to use it properly and not disturb the
work of other users.


## Materials

<!-- Materials will be made available after the lecture -->

<!--
<video src="https://462000265.lumidata.eu/2day-20261109/recordings/203-Lustre.mp4" controls="controls"></video>
-->
-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2day-20261109/files/LUMI-2day-20261109-203-Lustre.pdf)

-   [Course notes](203-Lustre.md)


## Q&A

1.  What are the best practices for developing a tool best suited for the HPC architectures?

    -   This is a very generic question to answer... But the keywords are parallelism, exploiting hierarchies (like the memory hierarchy) and streaming rather than random access. The latter holds for both RAM memory (where you want predictability) and for file storage (where ideally you also want operations that work on a large block of data at a time).
    -   Also keep in mind that you have a very fast network connecting the nodes that is faster than anything else. So don't read the same file from every node or process separately but read it once and send the contents to other nodes. Don't use the file system for communication (unless probably a RAM disk, but then you're bound to the node).
    -   But good programming is really a big course by itself... Some elements of this are touched upon in the Program Analysis and Optimization Workshops that we organise (like the one the next three days).
