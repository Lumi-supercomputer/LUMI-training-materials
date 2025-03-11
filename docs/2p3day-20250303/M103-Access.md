# Getting Access to LUMI

*Presenter: Kurt Lust (LUST)*

We discuss the options to log on to LUMI and to transfer data.


## Materials

<!--
Materials will be made available after the lecture
-->
<video src="https://462000265.lumidata.eu/2p3day-20250303/recordings/103-Access.mp4" controls="controls"></video>
<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-103-Access.pdf)

-   [Course notes](103-Access.md)

-   [Exercises](E103-Access.md)

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-103-Access.pdf`

-   Recording: `/appl/local/training/2p3day-20250303/recordings/103-Access.mp4`


## Related lectures in this course

-   ["Using Lustre"](M203-Lustre.md) on day 2

-   ["LUMI-O Object Storage](M204-ObjectStorage.md) on day 2

-   ["Optimizing Large-Scale I/O](M503-IO_Optimization_Parallel_IO.md) on day 5


## Q&A


1.  Are there some recommendations or even allocated resources for testing to not waste resources and budget? 

    -   *There are no free resource for testing. Usually you can ask for a small project (e.g. the EuroHPC benchmark projects) to test your code on the machine, and only after that you can ask for a large allocation. And use common sense, you should know your application and you should know "how small" you can test, and the test is (still) significant. Then when you are satisfied, you can scale up.*

2.  If my job runs faster than the allocated time, will I get billed the actual time ?

    -   *We cover the billing policy in more detail during the SLURM talk tomorrow. But you are billed for the resources that you use (or others can't use to be more precise), so if your job runs faster than the allocated time you will be charged for the time it took not the time you allocated.*
 
3.  If my software fits on my home, is it wrong to put it there instead of in the project folder?

    -   *It depends, if you are the only person using the software it may make sense. But for most projects on LUMI there are multiple collaborators that share software. In that case we don't want the software to be duplicated accross multiple home folders but in one shared project folder.*

4.  Is there a way to see your quota for flash or project storage?

    -   *Yes, you can use several commands to get information about this (see also [this page](https://docs.lumi-supercomputer.eu/runjobs/lumi_env/dailymanagement/) of our documentation):*
        -   *`lumi-workspaces`: Live quota data, state of billing units with some delay. It combines `lumi-quota` and `lumi-allocations`.*
        -   *`lumi-ldap-userinfo`: Quota data is not live but with a 1-2 hour delay*
        -   *`lumi-ldap-projectinfo`: Quota data is not live but with a 1-2 hour delay*

5.  Typically I have one large input file (a mesh) per MPI process. Is that an effective file size?

    -   *It depends, how large is the file and what is your typical job size?*

    Scaling up is WIP, but typical size is 1000 to 10000 ranks (with 1-2 OpenMP threads), and each rank would load around 10 MB. It could be a super large file instead (like 100 GB) but I'm not sure if it's better.

    -   *You would need to test this, but 1000-10000 files is a lot. It is probably better to work with 1 large file (using hdf5) and play around with the chunk size. We will cover strategies like this in the LUSTRE talks.*
 
    It's a home-made format and we read it line by line, would it be effective to have everyone reading the same file at once?
 
    -   *That is why i mentioned hdf5: if you wrap that format into an hdf5 structure, where every process has it's own space, then yes. Otherwise, probably not.*

    So the idea is to use the fact that the HDF5 libs are optimized for parallel reads?

    -   *Exactly, we will talk about this topic tomorrow in lustre, and you will understand why.*

    -   *Also, if reading line by line means that the data is in text and not binary format, this is a really bad idea. Reading text data is incredibly slow compared to reading binary data.*

6.  There is no backup. Do you have any specific recommendations about preferred way to backup the data regularly?

    -   *We don't have backup software on LUMI. The best strategy would be to regularly make a copy of your data to a local cluster or have a copy of your data in LUMI-O. Tools like `rclone` can be helpfull to optimise this process.*
    
    `rclone` indeed works, but it may not be optimal for regular backups. I was thinking about utilizing `restic` or similar dedup systems, but not sure if it is a good idea

    -   *I am not sure if it is possible to install and configure backup software on LUMI. You also need to think about how to invoke the software. You are not allowed to run long-running processes on the login nodes. But you are free to try and if you run into specific problems you can always submit a ticket.*

    -   *[`restic`](https://restic.readthedocs.io/en/latest/manual_rest.html) is 
        actually a tool meant to backup to object storage and is installed on LUMI, but I have no 
        actual experience with it. Also keep in mind that this is not a good backup as it is a backup 
        to a system in the same data centre. It protects you against failures of Lustre, but not against 
        a disaster striking the data centre.*


