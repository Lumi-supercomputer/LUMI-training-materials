# I/O Optimization - Parallel I/O

*Presenter: Harvey Richardson (HPE)*

<!--
Course materials will be provided during and after the course.
-->

-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-4_04_IO_Optimization_Parallel_IO.pdf`
    -   `/project/project_465000644/Slides/HPE/14_IO_medium_LUMI.pdf` (temporary, for the lifetime of the project)
-   Recording available on LUMI as:
    `/appl/local/training/4day-20231003/recordings/4_04_IO_Optimization_Parallel_IO.mp4`

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

7. Thank you very much for very interesting topic - MPI-IO. I'm totaly new to it. Which resources can you advice me? You mentioned The ExaIO project, as a development over HDF5. I intend to start from much more primitive things and then if necessary to go upper level. I have found an article https://phillipmdickens.github.io/pubs/paper1.pdf but it is 13 years old. This question, as for me, deserves the whole day. Which resources can you advice me to learn about MPI-IO/or non-mpi hacks like asynchronous I/O?

    -   I have no time to check now, I have too much processing of the course materials to do at the moment, but maybe some of the following links can put you on the way:

        -   [Slides from an Archer course](http://www.archer.ac.uk/training/course-material/2017/09/advMPI-soton/Slides/L05-MPI-IO.pdf) which was for an older Cray machine. The may have an update somewhere for Archer2 which is even closer to LUMI.

        -   [Slides from CSCS](https://www.cscs.ch/fileadmin/user_upload/contents_publications/tutorials/fast_parallel_IO/MPI-IO_NS.pdf), also a Cray site

        -   [A video from PRACE](https://materials.prace-ri.eu/295/). It may be worth to go their training materials of their past trainings. It may contain interesting stuff.

        -   [Material from a training from Argonne National Lab](https://extremecomputingtraining.anl.gov/wp-content/uploads/sites/96/2022/11/ATPESC-2022-Track-3-Talk-7-Latham-mpiio.pdf). That group created MPICH, the basis for Cray MPICH, and their MPI I/O code is actually used by other MPI implementatons also.

        Basically, googling for "MPI I/O training materials" does seem to return a lot of useable materials.

8.  A question a bit close to I/O. I intend to write MPI/OpenMP program. Let's assume that we have several compute nodes, consisting of 4 NUMA nodes,  with NIC(s) connected to single NUMA node. I need processing messages like a pipeline, namely receive message, process it then send it keeping their order. I suppose using 4 MPI processes running many OpenMP threads each because I am not sure that I can divide tasks more. How should I organize this avoiding nonnecessary memory copying and keeping memory locality for each OpenMP thread? Can you advice any literature how to write something similar in C/C++ or where to look about it? Are there any articles or books about such "pipeline pattern"?

    - I don't think we can answer this today, if you could summarise your exact scenario further and submit a LUMI ticket asking it be sent to the CoE then we can have a look and hopefully come back with some advice.
   
    Ok thank you. I am at very early stage. I think I need to rethink it and possibly write some primitive prototype in order to ask more detailed questions.
   
    -   It may be worth to search for PRACE training archives. They used to have good courses about intra-node optimization which is what matters here. E.g., there used to be excellent courses given by Georg Hager and Gerhard Wellein of FAU Erlangen. Some of that material might be online in the PRACE archives.


