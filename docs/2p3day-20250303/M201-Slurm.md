# Slurm on LUMI

*Presenter: Jorik van Kemenade (LUST)*

Slurm is the batch job scheduler used on LUMI. As no two Slurm configurations are
identical, even an experienced Slurm user should have a quick look at the notes of this
talk to understand the particular configuration on LUMI.


## Materials

<!--
Materials will be made available after the lecture
-->
<video src="https://462000265.lumidata.eu/2p3day-20250303/recordings/201-Slurm.mp4" controls="controls"></video>
<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-201-Slurm.pdf)

-   [Course notes](201-Slurm.md)

-   [Exercises](E201-Slurm.md)


## Q&A


1.  Is it possible to use all LUMI-G nodes (--ntasks=2000)?

    -   *Only on special request, and you can get a 6 hour time slot on a Sunday. This requires draining the system. And you don't do this with `--ntasks`, as that is not the number of nodes you request. The typical limit for the size of a job in regular queues is about one third of the size of the partition as otherwise waiting times because of draining the nodes needed for the job, becomes too high. see the [documentation on hero runs](https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/hero-runs/).*

2.  Does the priority of a job change significantly depending on the number of nodes that are requested for the job on the standard partitions?

    -   *There are changes to make sure that big jobs also start in a reasonable amount of time. But as the conditions of use forbid to try to exploit weaknesses in policies, we will not discuss this here. you should build your jobs in a reasonable way for the work you want to do as that is best for evereybody. Too many large jobs on the system also create problems as while the scheduler is gathering nodes to run a large job, these nodes remain empty unless there are enough short small jobs on the system to fill those gaps. So we need a healthy mix of different types of jobs to keep LUMI running smoothly.*

3.  Should I expect different behavior between the standard and small partitions if I have a 4-nodes job ?

    -   *Yes, and I think this is discussed in the presentation. The defaults for some Slurm parameters are different, so just using `--exclusive` on small and small-g still does not give you a 100% equivalent to standard or standard-g.*

    So if I want to run a scaling analysis with 4, 8, 16 nodes, I should submit even the small job to standard.

    -   *Not necessarily, the nodes are the same, but you need to be careful with some parameters. E.g., teh default for the amount of memory is different on both partitions. but again, this is discussed later in the presentation. If you request exclusive nodes and carefully specify the amount of memory you need, there will not be differences. But doing benchmarking on shared nodes is a bad idea.*

4.  How can we accurately estimate how much memory we need for our jobs? 

    -   *You need to know how your code runs. And at the end of the talk, you will see the commands that you can use to figure out what your job actually used, or how you can do some monitoring while the job runs. Unless you need a disproportional amount of memory, most codes are fine with a proportional amount of resources. But there are exceptions...*

5.  Is backfill more likely for short jobs?

    -   *It is only likely for relatively short jobs as it fills up the gaps that appear when the cluster is gathering nodes for a big job. For the largest regular jobs this can take a couple of hours.*

    I tend to have a lot of large but very fast jobs (< 30 mins), that seems interesting.

    -   *This is the kind of jobs that we really HATE on LUMI as it makes the machine very inefficient. Large jobs should also run for a considerable amount of time because of the high cost to others for starting such a job.. You should combine those jobs in a single longer large job. Backfill is also only for small jobs as they must fit in the growing gap that is created by more and more nodes becoming available. The larger the job in terms of number of nodes, the less likely it will be suitable as backfill. It are the large jobs that create the space to run other jobs in backfill and we don't have enough jobs that are eligible for backfill at the moment.*

    Will it work properly if I chain many srun commands in a job to get them sequentially ? (If I have say 4 commands that require the same resources)

    -   *Yes. It may help to put a 2 second sleep in between, but you can have as many job steps in a job as you want. Sometimes a srun may produce a temporary error message because the database is still blocked by finishing the previous srun, and that temporary blocking is usually avoided with a `sleep 2`. But even this is rare. That error happens more if you try to start job steps in the background to have multiple job steps running next to one another in a single job.*

    Got it, thanks. I assume there's not way to have `sacct` info for my steps separately though ?

    -   *`sacct` gives information at the job step level, so you have all the information you could get from separate jobs for each job step.*

6.  On a more general note: How interested is the LUMI Support to help users optimise resource use, as opposed to just having less optimal scripts running?

    -   *We can offer you the training to do such work so that you learn what you need to know about the system to do this work and so that you learn about tools that could be helpful, but we cannot do this for every individual user as (a) it does not only require knowledge about LUMI, but also about each individual application and the specific task that you want to do with that application, and (b) 10 FTE for 3000 users is just too few people to offer that kind of support or to have a proper understanding about a large enough range of applications.*
