# AMD debugger: ROCgdb

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter: Samuel Antao (AMD)*

Course materials will be provided during and after the course.

<!--
<video src="https://462000265.lumidata.eu/2p3day-20250303/recordings/405-AMD_ROCgdb_Debugger.mp4" controls="controls"></video>
-->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `'/project/project_465001726/Slides/AMD/session 02 - Debugging with rocgdb.pdf'`

Materials on the web:

-   [Slides on the web](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-405-AMD_ROCgdb_Debugger.pdf)

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-405-AMD_ROCgdb_Debugger.pdf`

<!--
-   Recording: `/appl/local/training/2p3day-20250303/recordings/405-AMD_ROCgdb_Debugger.mp4`
-->


## Q&A

1.  How much information can be obtained in case of out of bounds access? Is it possible to see which variable and the index when it happens?

    -   RocGDB won't tell you the problem is a out-of-bounds access. You still need to breakpoint before the problematic code and inspect addresses and indexes to see if that matches your expectation.
    
2.  Can the debuggger detect errors in the work-group like not all threads calling `__syncthreads()`?

    -   It won't tell you directly a hang comes from this. You can check while the hang is happening where the different waves are. Each thread is a wave in GDB, so you can swithch threads and inspect where you are to detect the hang cause.

3.  Does the integration with Emacs work as usual (like with GDB = gud mode)?

    -   RocGDB should integrate with Emacs or other editors as GDB does. I didn't try Emacs myself but my expectation is that ot should just work.


4.  Is it possible to use vscode integration for rocgdb on LUMI?

    -   Yes, vscode should integrate well with RocGDB. The challenge is how to have an instance of vscode-server in a login node connect to a compute node. You might have to explore gdbserver to allow remote debugging from the login nodes. I guess one might be creative and have a vscode instance run on a compute node but that would be a bit clumsy and difficult to maintain.
 