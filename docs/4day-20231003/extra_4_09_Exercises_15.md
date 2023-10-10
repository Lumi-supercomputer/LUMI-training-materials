# Exercise session 15: Omniperf

Exercise assignments can be found in the [AMD exercise notes](https://hackmd.io/@sfantao/H1QU6xRR3),
section on [Omniperf](https://hackmd.io/@sfantao/H1QU6xRR3#Omniperf).

Exercise files can be copied from `Exercises/AMD/HPCTrainingExamples`.


## Materials

<!--
No materials available at the moment.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Exercises can be copied from `/project/project_465000644/exercises/AMD/HPCTrainingExamples`
-->

Materials on the web:

-   [AMD exercise assignments and notes](https://hackmd.io/@sfantao/H1QU6xRR3#Omniperf)

    [PDF backup](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.pdf)
    and [local web backup](exercises_AMD_hackmd.md#omniperf).

-   Exercise files: 
    [Download as .tar.bz2](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.tar.bz2)
    or [download as .tar](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.tar)

Archived materials on LUMI:

-   Exercise assignments PDF: `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.pdf`

-   Exercise files:
    `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.tar.bz2`
    or `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_AMD.tar`


## Q&A


12. When I try executing commands from the first hackmd.io link, this is what I get:

    `salloc -N 1 --ntasks=1 --partition=small-g --gpus=1 -A project_465000644 --time=00:15:00
salloc: error: Job submit/allocate failed: Requested node configuration is not available
salloc: Job allocation 4701325 has been revoked.`

    -    could you `source /project/project_465000644/Exercises/HPE/lumi_g.sh` . It could be that you run the `lumi_c.sh` script which sets some variables that could clash with the `salloc`. 

    Yes, I did source the `lumi_g.sh`
        
    -   OK. I checked the `lumi_g.sh` script and even the environment variables that it sets influence `salloc` in a way that creates conflicts with your command line. So the trick is to log in again and not source any of those scripts and then the `salloc` line will work, but you will not be working in the reservation, or to not add the `-A` and `--partition` argument as they are set by environment variables. What is actually happening is that because of the enviornment variables the reservation is activated but you're asking for nodes outside the reservation.
    
    Yes, it works when not sourcing anything. Is the `salloc` in the linked document really needed and it wouldn't be better to forgo it and just use the reservation?

