# Getting Access to LUMI

*Presenter: Kurt Lust*

We discuss the options to log on to LUMI and to transfer data.


## Materials

<!--
Materials will be made available during and after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20241210/recordings/03-Access.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20241210/files/LUMI-2day-20241210-03-Access.pdf)

-   [Course notes](03-Access.md)

-   [Exercises](E03-Access.md)


## Q&A

1.  Why do project numbers change every 6 months? This is not convenient

    -   It depends on your resource allocator. 6 months is short. But the rules of LUMI are that project have a maximum lifetime of 12 months. There are a couple of reasons for this decision, one being that unused data is removed frequently which also so far has let to the scratch not being actively cleared. Another one (I think) is that resources are consumed in the allocated time but this could also be done on the slurm level without closing projects. Maybe Kurt knows more about that.

    -   You also have to realise that you are playing with a lot of money. So each project allocator also wants to be able to reconsider decisions: You may have one of the best projects today but next year someone else may have a more brilliant project that deserves the compute time more. LUMI projects can represent a lot of money. I know of EuroHPC Extreme Scale projects that are worth over 2M EURO...

    -   And we can also not say precisely how much compute time we will have available in two years. As everybody involved in operatin LUMI learns over time and as use evolves, so does the amount of compute time that can be allocated. Each large supercomputer starts from the assumption that not all users will consume all their compute time so there is often more allocated than available, but how much changes over time as when people get more familiar with a computer, they tend to use a larger fraction of their allocation. In the first year of LUMI operations, we used a large so-called overallocation as too much compute time remained unused, but this has been lowered gradually to keep the lengths of the queue a bit under control.

2.  Why is it impossible to prolong projects or ask for extra resources? It is possible in other CSC servers

    -   As mentioned in the question above, it was decided to limit project lifetimes to 12 months. It is possible to add extra resources to a project, whether CSC does that or not is their decision (but I'm quite sure they do that if there are good reasons). Of course, CSC can't hand out more allocations than its share of LUMI.

3.  I don't fully understand the difference between quota and storage billing units, since quota can be handled by LUST, but storage billing units not. Thanks!

    -    The idea is that quota is a hard constraint, you cannot go over that. billing units are used to measure continuous usage. so you can "save" billing units by deleting unused files. The idea is that you won't get "max quota * project length" billing units, it is usually less. And you have to manage it (e.g. you can load data, do simulation, copy back output and delete everything to keep billing units low). Is a compromise to force users to do some cleanup and don't leave useless data on the machine, but at the same time allow large "bursts" of data when running the actual simulations.

    -    A project may have a high use but only for a short term. If we would work with quota only, we have to be careful not to distribute too much quota as we never know how much people will use. By also billing actual use, we can use more liberal volume quota and rest assured that people will clean up anyway. In fact, it works so well that we don't need the automatic cleanup of scratch and flash at the moment.

    -    Storage billing units are also distributed among the partners proportional to their participation in LUMI and for industrial customers can correspond to actual money. It is not up to LUST to spend the "money" of, e.g., EuroHPC, if one of their users wants more storage billing units.


4.  Then do you suggest to use LUMI-O as a staging place to transfer large files temporarily and then transfer to other LUMI file systems?

    -   Yes, that is often a good approach. Either to store large datasets or to transfer data in and out of LUMI.

5.  When you use 1 GPU for 1 hour, do you consume half GPU core core (due to 2 GPU chip) and plus you also are billed for CPU hours attached to GPU chip or not?

    -   No, you are not billed for the CPU usage on the GPU nodes. One GCD (in most instances that shows as one GPU), will be billed as 1/2 GPU hour as there are 2 GCDs on each AMD MI250X GPU card.

6.  Is there some documentation/guidance somewhere on explicitly using the entirely of the gpu - i.e. both chiplets?

    -   The GCDs communicate using MPI or RCCL (but with higher bandwidth than between GPU cards), so usign 2 GCDs is basically the same approach as scaling up to multiple GPUs on one node (or even acroos nodes). It is not possible to use both GCDs as if they are truly one GPU; the bandwidth of the connection is way to slow (total of 200 GB/s per direction compared to 1.6 TB/s peak for the memory of one GCD, and let alone the bandwidth in the caches...)

