# Exercise session 15

<!--
No materials available at the moment.
-->

-   [On-line exercise notes](https://hackmd.io/@sfantao/H1QU6xRR3#Omniperf).

<!--
-   [On-line exercise notes](https://hackmd.io/@sfantao/H1QU6xRR3#Omniperf).

    [PDF backup](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.pdf)

-   Exercises can be copied from `/project/project_465000644/exercises/AMD/HPCTrainingExamples`

-   Exercises are archived as compressed and uncompressed tar files:
 
    -   [Web download .tar.bz2](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.tar.bz2)
        or [web download .tar](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.tar)

    -   On LUMI:
        -   `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.tar.bz2`
        -   `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.tar`

-   The necessary version of Omniperf is installed in the software installation in 
    `/project/project_465000644/software`.

    The installation can be recovered from the archive (bzip2-compressed tar file) on LUMI: 
    `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Software_AMD.tar.bz2`

    This installation was tested for the course but will fail at some point due to changes to the system.

    Note that Omniperf poses security risks as it is based on an unprotected web server running on a predicable
    port number.
-->


## Q&A


12. When I try executing commands from the first hackmd.io link, this is what I get:

    `salloc -N 1 --ntasks=1 --partition=small-g --gpus=1 -A project_465000644 --time=00:15:00
salloc: error: Job submit/allocate failed: Requested node configuration is not available
salloc: Job allocation 4701325 has been revoked.`

    -    could you `source /project/project_465000644/Exercises/HPE/lumi_g.sh` . It could be that you run the `lumi_c.sh` script which sets some variables that could clash with the `salloc`. 

    Yes, I did source the `lumi_g.sh`
        
    -   OK. I checked the `lumi_g.sh` script and even the environment variables that it sets influence `salloc` in a way that creates conflicts with your command line. So the trick is to log in again and not source any of those scripts and then the `salloc` line will work, but you will not be working in the reservation, or to not add the `-A` and `--partition` argument as they are set by environment variables. What is actually happening is that because of the enviornment variables the reservation is activated but you're asking for nodes outside the reservation.
    
    Yes, it works when not sourcing anything. Is the `salloc` in the linked document really needed and it wouldn't be better to forgo it and just use the reservation?

