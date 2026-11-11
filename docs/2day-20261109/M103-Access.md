# Getting Access to LUMI

*Presenter: Dan Jonsson (LUST)*

We discuss the options to log on to LUMI and to transfer data.


## Materials

<!-- Materials will be made available after the lecture -->

<!--
<video src="https://462000265.lumidata.eu/2day-20261109/recordings/103-Access.mp4" controls="controls"></video>
-->
-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2day-20261109/files/LUMI-2day-20261109-103-Access.pdf)

-   [Course notes](103-Access.md)

-   [Exercises](E103-Access.md)

For users of the EuroHPC Federation Platform:

-   [Documentation](https://docs.my-eurohpc.eu/training/overview/)

-   [Recent and upcoming trainings](https://docs.my-eurohpc.eu/training/overview/)

    -   In particular, [features showcase of 19 October 2026](https://docs.my-eurohpc.eu/training/overview/#oct26-features-showcase)


## Q&A

1.  I have read that one must multiply the GPU hours (for standard-G) with 4, to get the actual time allocated. Why is that?

    -   On LUMI, we measure GPU hours historically, but based on a full MI250X, probably because when it was decided, it was not yet clear that for all practical purposes they should be considered as two GPUs. Similarly, CPU resources are measured in core-hours. But EuroHPC measures both in node-hours. So 1 GPU node-hour in EuroHPC is 4 GPU-hours on LUMI and one CPU nodehour is 128 CPU core-hours on LUMI. So LUMI tools report in GPU hours and CPU core-hours but the EFP will report node-hours and the latter need to be multiplied by 4 or 128 depending on whether they are GPU or CPU to correspond to what LUMI reports.

        But LUMI has many customers, also the 11 countries that invested in it, so it will not be changed anymore.

2.  What happens if you go over your allocated time? We currently have a group member who managed to use 4,126.9/2,443 of our CPU hours.
    
    -   When you go over your allocation your usage of LUMI will be restricted (e.g. if you go over CPU usage you cannot submit jobs to any LUMI-C partitions) and your RA will be billed for the full amount of resources used, which may make their allocation smaller for the next year.

    -   Why this happens will also be partly explained tomorrow. The billing scheme on LUMI is too complex for Slurm to handle, so the billing units are computed offline. On some systems, Slurm will take a reservation of billing units when you submit a job and will not be able to do that if the job would consume more than is left, but since Slurm doesn't know the billing units on LUMI, it cannot do that. So you can sometimes go far over your quota, especially with a small project running big jobs, before that offline script that computes the billing units, can see you're over quota and cut your access to the queues.



