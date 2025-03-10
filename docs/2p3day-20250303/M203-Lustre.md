# Using Lustre

*Presenter: Emanuele Vitali (LUST)*

Lustre is a parallel file system and the main file system on LUMI.
It is important to realise what the strengths and weaknesses of Lustre at the
scale of a machine as LUMI are and how to use it properly and not disturb the
work of other users.


## Materials

<!--
Materials will be made available after the lecture
-->
<video src="https://462000265.lumidata.eu/2p3day-20250303/recordings/203-Lustre.mp4" controls="controls"></video>
<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-203-Lustre.pdf)

-   [Course notes](203-Lustre.md)


## Q&A

1.  Is there some strategy to be able to figure out the ideal striping for a specific application?

    -   *See later this talk and the [advanced part of the course](M502-IO_Optimization_Parallel_IO.md). But as always, you also must know your application, and it will only deliver if you talk about files that are 10s of megabytes.*


2.  Are there some recommended options to use when doing parallel IO using parallel IO libraries?

    -   *That is the topic of a [presentation on Friday morning](M502-IO_Optimization_Parallel_IO.md)... Slides will be made available shortly after that presentation, a recording early next week. But one thing you may have to do is set proper striping parameters which is also dicussed more towards the end of this talk. The defaults on LUMI are set to values that minimize the damage that an unexperienced user can do who doesn't care about setting these values.*
