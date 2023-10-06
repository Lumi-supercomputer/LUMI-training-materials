# I/O Optimization - Parallel I/O

*Presenter: Harvey Richardson (HPE)*

<!--
Course materials will be provided during and after the course.
-->

-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-4_04_IO_Optimization_Parallel_IO.pdf`
    -   `/project/project_465000644/Slides/HPE/14_IO_medium_LUMI.pdf` (temporary, for the lifetime of the project)
<!--
-   Recording available on LUMI as:
    `/appl/local/training/4day-20231003/recordings/4_04_IO_Optimization_Parallel_IO.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).


## Links

-   The [ExaIO project](https://www.exascaleproject.org/research-project/exaio/) paper
    ["Transparent Asynchronous Parallel I/O Using Background Threads"](https://doi.org/10.1109/TPDS.2021.3090322).


## Q&A

4.  Rules of thumb for setting the stripe size?

    -   See slide 23

    -   HPE sometimes says 1 MB but it turns out to depend on how your program does I/O. I remember a ticket of a project reporting that they had to set it much, much higher for optimal bandwidth but then they got close to one quarter of the quoted peak bandwidth of the file system for reads which was very, very good considering that many users where also using the file system at that moment.

    - If you can write large chunks of data or are using a library that buffers (fortran I/O, C file I/O operations) then experiment with larger stripe sizes.

5. Let's say I have gigabytes of training data (in 1 or 2 files). I put them on /flash/PROJECT. Does the striping apply there also?

    -    Yes, sometimes, depending on how you do I/O in your code. If the I/O operations are of a type that scales (large parallel I/O from multiple nodes), it will help. And on LUMI-G maybe even from one node if the I/O would be properly using all NICs. With a single NIC, the bandwidth that NIC can deliver may already close to what you can get from one OST if that one has a low load at that time. And with small I/O operations, striping will not give you anything, neither on disk nor on flash, and you'll be limited by latency of a network file system.
      
         But the whole idea is also that having optimal I/O enables you to use cheaper storage and get the same results as on expensive faster storage. The flash file system is billed at ten times the rage as the hard disk file system for a reason. It was also that much more expensive when purchased.



