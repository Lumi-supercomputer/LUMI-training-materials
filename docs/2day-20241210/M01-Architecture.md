# LUMI Architecture

*Presenter: Emanuele Vitali*

Some insight in the hardware of LUMI is necessary to understand what
LUMI can do and what it cannot do, and to understand how an application can
be mapped upon the machine for optimal performance.


## Materials

<!--
Materials will be made available during and after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20241210/recordings/01-Architecture.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20241210/files/LUMI-2day-20241210-01-Architecture.pdf)

-   [Course notes](01-Architecture.md) (based on an earlier version of the presentation from a different presenter)


## Q&A

1.  What is a tier 0, 1, 2 supercomputer? How do I know what I am working with?

    -   Europe has a pyramid model for organising supercomputers. Tier-2 is the smaller supercomputers, often locally available, e.g., at your university. Tier-1 are then larger often national systems, built for larger jobs. Tier-0 are then the very largest computers and so expensive that except for some large countries, they have to be built and operated at an international scale.
    -   Each size of machine also has its strengths and weaknesses. Obviously you cannot run a very large job on a small machine. But on the other hand, not all properties scale nicely. E.g., the number of files that a filesystem can process per second does not grow well with the size of the cluster which is why you will hear about expected behaviour on Lustre tomorrow afternoon. LUMIs filesystems have huge bandwidth, but the number of file metadata operations: Open and close, e.g., may not be that much higher than on a much smaller cluster. So you have to work with large files and parallelism in the access of the data within the file. Which is why Emanuele said that it is important to select the right infrastructure for your job.
    -   And LUMI is clearly tier-0. There are also a number of petascale machines in the EuroHPC portfolio (currently Meluxina, Karolina, Vega, Discoverer and Deucalion) which are more Tier-1 level.

2.  How do I understand one NUMA node or 2 NUMA node with reference to the compute node?

    -   A compute node is really the unit that is running its own operating system image. Inside a compute node, all cores, can also access all data.
    -   But not every core can access all memory at the same speed. Some memory can be accessed faster than other memory, and that is called Non-Uniform Memory Access or NUMA. A NUMA domain is a group of cores that have equal access to some part of the memory, and the associated memory. The speed different is high depending on whether the memory is on the same socket or a different socket, but within a socket there is also a 20% or so access time difference between memory in the same NUMA node and the other NUMA nodes on that socket.

3.  Is multithreading is off by default because most of the used apps are limited by memory bandwith? Thank you.

    -   It is actually on a the hardware level, but off by default at the level of the scheduler, but only for job steps started with `srun`. Not all programs are memory bandwidth limited. But in fact, hyperthreading helps most for applications that are memory latency limited or have a lot of unpredictable jump instructions. They may also be useful for running a communication thread for each compute thread in the background.
    -   There is a very small penalty by turning this on in hardware, but it is negligible, and you are in full control whether you want to use it in your application or not.

