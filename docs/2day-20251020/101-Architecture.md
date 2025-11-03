# The LUMI Architecture

In this presentation, we will build up LUMI part by part, stressing those
aspects that are important to know to run on LUMI efficiently and define
jobs that can scale.

## Why do I kneed to know this?

<figure markdown style="border: 1px solid #000">
  ![Slide Why know...](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/WhyKnow.png){ loading=lazy }
</figure>

You may wonder why you need to know about system architecture if all you want to do is to run 
some programs.

A supercomputer is **not simply a scaled-up smartphone or PC** that will offer good performance
automatically. 
It is a shared infrastructure and you don't get the whole machine to yourself.
Instead you have to request a suitable fraction of the computer for the work you want to do.
But it is also a very expensive infrastructure, with an investment of 160M EURO for LUMI
and an estimated total cost (including operations) of 250M EURO. So it is important to use the computer
efficiently. 

LUMI, as other large supercomputers, is built for running large parallel applications efficiently.
But that efficiency does not for free. Scaling from a small problem size on a small computer 
does not come for free, not in hardware and neither in software. For example, it is not true that
increasing the amount of cores your application will run faster. You need to connect them, and to pass 
data between them, and we will see in this lecture that it is not that easy. Another example (this time on software): 
communication has a cost, and parts of programs are serial. if the dominant part of a program is the serial one,
increasing the parallelism will have a negligible or even negative impact.
Modern supercomputers are usually heterogeneous machines, with CPU and accelerators (usually GPU) that collaborate to perform the computation.
But to collaborate, there is a need to move data from one device to the other, and this has a cost, which sometimes
overshadows the gain of a faster processing of the data on the accelerator.

For all these reasons, it is important to properly map an application on the available resources to run efficiently.
The way an application is developed is important for this, but it is not the only factor. Every application needs some user help 
to run in the most efficient way, and that requires that the user who is launching the application has an understanding of:

1.  The **hardware architecture** of the supercomputer, which is something that we discuss in this
    section.

2.  The **middleware**: the layers of software that sit between the application on one hand and the
    hardware and operating system on the other hand. LUMI runs a sligthly modified version of Linux.
    But Linux is not a supercomputer operating system. Missing functionality in Linux is offered
    by other software layers instead that on supercomputers often come as part of the programming
    environment.
    This is a topic of discussion in several sessions of this course.

3.  The **application**. This is very domain-specific and application-specific and hence cannot be the
    topic of a general course like this one. In fact, there are so many different applications and
    often considerable domain knowledge is required so that a small support team like the one of 
    LUMI cannot provide that information. 

4.  Moreover, the way an application should be used may even depend on **the particular problem that you
    are trying to solve**. Bigger problems, bigger computers, and different settings may be needed in
    the application.

    It is up to scientific communities to organise trainings that teach you individual applications and
    how to use them for different problem types,
    and then up to users to combine the knowledge of an application obtained from such a course with the
    knowledge about the computer you want to use and its middleware obtained from courses such as this one
    or our more advanced courses.

Some users expect that a support team can give answers to all those questions, even to the third and fourth
bullet of the above list. If a support team could do that, it would basically imply that they could simply
do all the research that users do and much faster as they are assumed to have the answer ready in hours...


## LUMI is ...

<figure markdown style="border: 1px solid #000">
  ![Slide LUMI is...](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/LUMIIs.png){ loading=lazy }
</figure>

LUMI is a pre-exascale supercomputer, and not a superfast PC nor a compute cloud architecture.

Each of these architectures have their own strengths and weaknesses and offer different 
compromises and it is key to chose the right infrastructure for the job and use the right 
tools for each infrastructure.

Just some examples of using the wrong tools or infrastructure:

-   **The single thread performance of the CPU is lower than on a high-end PC.** 
    We've had users who were disappointed about the speed of a single core and were expecting
    that this would be much faster than their PCs. Supercomputers however are optimised for 
    performance per Watt and get their performance from using lots of cores through well-designed
    software. If you want the fastest core possible, you'll need a gaming PC.

    *E.g., the AMD 5800X was a popular CPU for high end gaming PCs using the same core architecture 
    as the CPUs in LUMI. It runs at a
    base clock of 3.8 GHz and a boost clock of 4.7 GHz if only one core is used and the system has
    proper cooling. The 7763 used in the compute nodes of LUMI-C runs at a base clock of 2.45 GHz
    and a boost clock of 3.5 GHz. If you have only one single core job to run on your PC, you'll
    be able to reach that boost clock while on LUMI you'd probably need to have a large part of
    the node for yourself, and even then the performance for jobs that are not memory bandwidth
    limited will be lower than that of the gaming PC.*

-   **For some data formats the GPU performance may be slower also than on a high end gaming PC.**
    This is even more so because
    an MI250X should be treated as two GPUs for most practical purposes. The better double precision
    floating point operations and matrix operations, also at full precision, require transistors 
    that on some other GPUs are used for rendering hardware or for single precision compute units.

    *E.g., a single GPU die of the MI250X (half a GPU) has a peak FP32 performance at the boost clock
    of almost 24 TFlops or 48 TFlops
    in the packed format which is actually hard for a compiler to exploit, while the high-end AMD
    graphics GPU RX 7900 XTX claims 61 TFlops at the boost clock. But the FP64 performance of one MI250X 
    die is also close to 24 TFlops in vector math, while the RX 7900 XTX does less than 2 TFlops
    in that data format which is important for a lot of scientific computing applications.*

-   **Compute GPUs and rendering GPUs are different beasts these days.**
    We had a user who wanted to use the ray tracing units to do rendering. The MI250X does not
    have texture units or ray tracing units though. It is not a real graphics processor anymore.

-   **The environment is different also. It is not that because it runs some Linux it handles are your
    Linux software.**
    A user complained that they did not succeed in getting their nice remote development environment to
    work on LUMI. The original author of these notes took a test license and downloaded a trial version.
    It was a very nice environment but really made for local development and remote development in a 
    cloud environment with virtual machines individually protected by personal firewalls and was 
    not only hard to get working on a supercomputer but also insecure.

<!-- GENERAL version -->
-   **And supercomputer need proper software that exploits the strengths and works around the weaknesses
    of their architecture.**  
    Supercomputers are optimised to run very scalable applications cost-efficiently, but that
    requires well parallelised software and data storage in a proper way so that data can be 
    streamed in and out of the machine efficiently from big shared filesystems that are also 
    optimised more for bandwidth than small individual operations. 
<!-- END GENERAL version -->

<!-- BELGIUM Belgian version due to CERN censorship. 
-   **And supercomputer need proper software that exploits the strengths and works around the weaknesses
    of their architecture.**  
    Supercomputers are optimised to run very scalable applications cost-efficiently, but that
    requires well parallelised software and data storage in a proper way so that data can be 
    streamed in and out of the machine efficiently from big shared filesystems that are also 
    optimised more for bandwidth than small individual operations. 

    A nice illustration of this is the 
    [case study: Bringing CERN LHC computations to an HPC infrastructure](https://klust.github.io/SupercomputersForStarters/C05_Summary1/C05_S06_Software_not_hardware/#case-study-bringing-cern-lhc-computations-to-an-hpc-infrastructure)
    in the course notes of the [UAntwerpen "Supercomputers for Starters" course](https://klust.github.io/SupercomputersForStarters/)
    which is part of the VSC introductory courses offered in Antwerp.
END BELGIUM -->

True supercomputers, and LUMI in particular, are built for scalable parallel applications and features that
are found on smaller clusters or on workstations that pose a threat to scalability are removed from the system.
It is also a shared infrastructure but with a much more lightweight management layer than a cloud infrastructure
and far less isolation between users, meaning that abuse by one user can have more of a negative impact on 
other users than in a cloud infrastructure (e.g. an user running memory intensive postprocessing scripts on the
login node will damage all other users that are working on that login node because it will use all the memory 
available on the node itself. Measures are taken to avoid this, but sometimes not abuse but misuse can create
problems for other issues. For that reason it is important to know what to do and what NOT to do on a supercomputer).
Supercomputers since the mid to late '80s are also built according
to the principle of trying to reduce the hardware cost by using cleverly designed software both at the system
and application level. They perform best when streaming data through the machine at all levels of the 
memory hierarchy and are not built at all for random access to small bits of data (where the definition of
"small" depends on the level in the memory hierarchy).

At several points in this course you will see how this impacts what you can do with a supercomputer and
how you work with a supercomputer.

And LUMI is not just a supercomputer, it is a pre-exascale supercomputer. This implies that it is using
new and leading edge technology and pushing the limits of current technology. But this also means that
it will have some features that many observe as problems that smaller clusters using more conventional
technology will not have. Stability is definitely less, bigger networks definitely come with more 
problems (and are an important cause of those stability problems), not everything scales as you would
hope (think of the scheduler and file system IOPS discussed later in this course), ...


## LUMI spec sheet: A modular system

<figure markdown style="border: 1px solid #000">
  ![Slide LUMI is...](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/LUMISpecs.png){ loading=lazy }
</figure>

So we've already seen that LUMI is in the first place a EuroHPC pre-exascale machine.
LUMI is built to prepare for the exascale era and to fit in the EuroHPC ecosystem. 
But it does not even mean
that it has to cater to all pre-exascale compute needs. The EuroHPC JU tries to
build systems that have some flexibility, but also does not try to cover 
all needs with a single machine. They built 3 pre-exascale systems
with different architecture to explore multiple architectures and to cater
to a more diverse audience. LUMI is an AMD GPU-based supercomputer, 
Leonardo uses NVIDIA A100 GPUS, and MareNostrum5 has a very large CPU section besides an
NVIDIA Hopper GPU section.

LUMI is also a very modular machine designed according to the principles explored
in a series of European projects, and in particular
[DEEP and its successors](https://www.deep-projects.eu/)) that explored
the cluster-booster concept. E.g., in a complicated multiphysics simulation 
you could be using regular CPU nodes for the physics that cannot be GPU-accelerated
communicating with compute GPU nodes for the physics that can be GPU-accelerated,
then add a number of CPU nodes to do the I/O and a specialised render GPU node for
in-situ visualisation.

LUMI is in the first place a huge **GPGPU supercomputer**. The GPU partition of
LUMI, called **LUMI-G**, contains 2978 nodes with a single 64-core AMD EPYC 7A53 CPU (codename Trento)
and 4 AMD MI250X GPUs. Each node has 512 GB of RAM attached to the CPU (the maximum the CPU can handle
without compromising bandwidth) and 128 GB of HBM2e memory per GPU. Each GPU node
has a theoretical peak performance of nearly 200 TFlops in single (FP32) or double (FP64)
precision vector arithmetic (and twice that with the packed FP32 format, but that 
is not well supported so this number is not often quoted). The matrix units are
capable of about 400 TFlops in FP32 or FP64. However, compared to the NVIDIA GPUs,
the performance for lower precision formats used in some AI applications is not that
stellar.

LUMI also has a **large CPU-only partition**, called **LUMI-C**, for jobs that do not run well on GPUs,
but also integrated enough with the GPU partition that it is possible to have
applications that combine both node types.
LUMI-C consists of 2048 nodes with 2 64-core AMD EPYC 7763 CPUs (codename Milan). 32 of those nodes
have 1TB of RAM (with some of these nodes actually reserved for special purposes
such as connecting to a Quantum computer), 128 have 512 GB and 1888 have
256 GB of RAM.

LUMI also has two smaller groups of nodes for **interactive data analytics**. 
8 of those nodes have two 
64-core Zen2/Rome CPUs with 4 TB of RAM per node, while 8 others have dual 64-core
Zen2/Rome CPUs and 8 NVIDIA A40 GPUs for visualisation. Together these are known as
**LUMI-D**. But this is a bit misleading, as from the scheduler perspective, those are two different partitions.
The first one (the partition with the 4TB RAM nodes) is called **largemem**, while the second (the partition
with the A40) is called **lumid** by the Slurm scheduler.
There is also an **Open OnDemand based service (web interface)** to make some fo those facilities
available. Note though that these nodes are meant for a very specific use,
so it is not that we will also be offering, e.g., GPU compute facilities
on NVIDIA hardware, and that these are shared resources that should not be
monopolised by a single user (so no hope to run an MPI job on 8 4TB nodes).

LUMI also has three solutions for storing data: the first two are traditional **Lustre parallel
file systems** while the last one is an **object based file system**.

The first one is a **8 PB flash based file system** running the **Lustre parallel file system**.
This system is often denoted as **LUMI-F**. The bandwidth of that system is over 2 TB/s. 
Note however that this is still a remote file system with a parallel file system on it,
so do not expect that it will behave as the local SSD in your laptop. 
But that is also the topic of another session in this course.

The main work storage is provided by **4 20 PB hard disk based Lustre file systems**
with a bandwidth of 240 GB/s each. That section of the machine is often denoted 
as **LUMI-P**. 

Big parallel file systems need to be used in the proper way to be able to offer the
performance that one would expect from their specifications. This is important enough that 
we have a separate session about that in this course.

There is also a 30 PB **object based file system** 
similar to the Allas service of CSC that some
of the Finnish users may be familiar with is also being worked on. At the 
moment the interface to that system is still rather primitive.
This part of LUMI is also known as **LUMI-O**.

Currently LUMI has **4 login nodes** for ssh access, called user access nodes (uan) in the HPE Cray
world. They each have 2 64-core AMD EPYC 7742 processors (codename Rome) and 1 TB of RAM.
Note that  whereas the GPU and CPU compute nodes have the Zen3 architecture
code-named "Milan", the processors on the login nodes are Zen2 processors,
code-named "Rome". Zen3 adds some new instructions so if a compiler generates
them, that code would not run on the login nodes. These instructions are basically
used in cryptography though. However, many instructions have very different latency,
so a compiler that optimises specifically for Zen3 may chose another ordering of
instructions then when optimising for Zen2 so it may still make sense to compile
specifically for the compute nodes on LUMI. There are also an additional
login nodes for access via the web-based Open OnDemand interface, plus others that are used for
system administration at different level (and with different permissions!)
Together these are sometimes called **LUMI-L**.

All compute nodes, login nodes and storage are linked together through a 
**high-performance interconnect**. LUMI uses the **Slingshot 11** interconnect which
is developed by HPE Cray, so **not the Mellanox/NVIDIA InfiniBand** that you may
be familiar with from many smaller clusters, and as we shall discuss later
this also influences how you work on LUMI.

Early on a small partition for containerised micro-services managed with
Kubernetes was also planned, but that may never materialize due to lack of 
people to set it up and manage it.

In this section of the course we will now build up LUMI step by step.


## Building LUMI: The CPU AMD 7xx3 (Milan/Zen3) CPU

<figure markdown style="border: 1px solid #000">
  ![Slide The AMD EPYC 7xx3 (Milan/Zen3) CPU](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/AMDMilanCCD.png){ loading=lazy }
</figure>

The LUMI-C and LUMI-G compute nodes use third generation AMD EPYC CPUs.
Whereas Intel CPUs launched in the same period were built out of a single large
monolithic piece of silicon (that only changed recently with some variants
of the Sapphire Rapids CPU launched in early 2023), AMD CPUs are made up
of multiple so-called chiplets. This is a clever trick to save money when 
creating the chip itself. When there are defects in the silicon, the only 
thing that can be done is to throw away the defective chip. In this way, by not 
having monolithic chips, it is possible to throw away a smaller component and waste
less resources!

The basic building block of Zen3 CPUs is the **Core Complex Die (CCD)**.
Each CCD contains 8 cores, and each core has 32 kB of L1 instruction 
and 32 kB of L1 data cache, and 512 kB of L2 cache. The L3 cache is shared
across all cores on a chiplet and has a total size of 32 MB on LUMI (there are some
variants of the processor where this is 96MB).
At the user level, the **instruction set is basically equivalent to that of the
Intel Broadwell generation**. AVX2 vector instructions and the FMA instruction are
fully supported, but there is **no support for any of the AVX-512** versions that can
be found on Intel Skylake server processors and later generations. Hence the number
of floating point operations that a core can in theory do each clock cycle is 16 (in 
double precision) rather than the 32 some Intel processors are capable of. 

<figure markdown style="border: 1px solid #000">
  ![Slide The AMD EPYC 7xx3 (Milan/Zen3) CPU (2)](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/AMDMilanCPU.png){ loading=lazy }
</figure>

The full processor package for the AMD EPYC processors used in LUMI have
8 such Core Complex Dies for a total of 64 cores. The **caches are not
shared between different CCDs**, so it also implies that the processor has
8 so-called L3 cache regions or domains. (Some cheaper variants have only 4 CCDs,
and some have CCDs with only 6 or fewer cores enabled but the same 32 MB of L3
cache per CCD).

Each CCD connects to the memory/IO die through an Infinity Fabric link
(also called GMI link which stands for Global Memory Interface). The connection
is asymmetric on Milan with 51.2 GB/s bandwidth from memory/IO die to CCD (read operations) 
and 25.6 GB/s bandwidth from CCD to memory/io die (write operations, 32 bytes and 16 byte wide connections
running at the memory clock with is 1.6 GHz for DDR4 3200).
The memory/IO die contains the memory controllers,
connections to connect two CPU packages together, PCIe lanes to connect to external
hardware, and some additional hardware, e.g., for managing the processor. 
The memory/IO die supports 4 dual channel DDR4 memory controllers providing 
a total of 8 64-bit wide memory channels. Each memory channel has a theoretical peak
bandwidth of 25.6 GB/s.
From a logical point of view the memory/IO-die is split in 4 quadrants,
with each quadrant having a dual channel memory controller and 2 CCDs. They basically act
as **4 NUMA domains**. For a core it is slightly faster to access memory in its own
quadrant than memory attached to another quadrant, though for the 4 quadrants within
the same socket the difference is small. (In fact, the BIOS can be set to show only
two or one NUMA domain which is advantageous in some cases, like the typical load
pattern of login nodes where it is impossible to nicely spread processes and
their memory across the 4 NUMA domains).

The theoretical memory bandwidth of a complete package is around 200 GB/s. However,
that bandwidth is not available to a single core but **can only be used if enough 
cores spread over all CCDs are used**.

<!-- BELGIUM
!!! lumi-be "Clusters in Belgium"

    The CPUs used in the LUMI-C compute nodes are identical to those used in 
    the Cenaero/CÉCI cluster lucia or the Milan partition of the VSC cluster 
    hortense. The UGent VSC cluster gallade uses a very similar processor also
    but with more cache per CCD. Some other cluster, e.g., accelgor and doduo+ 
    at UGent or the Milan partition of vaughan in at UAntwerpen, also use CPUs
    of this generation but with only 4 CCDs per processor and/or 6 active cores 
    per CCD. But many topics that we cover in this course also applies to those
    clusters.

    Some other clusters, e.g., the older Rome partition of the VSC cluster hortense,
    the CÉCI cluster NIC5 at ULiège or the older main
    partition of the VSC cluster vaughan at UAntwerpen, use the older Zen2/Rome
    CPUs which are also used on the login nodes of LUMI. These have two groups
    of 4 cores each with their own separated L3 cache per CCD and 4 or 8 CCDs per 
    socket. 
-->

## Building LUMI: a LUMI-C node

<figure markdown style="border: 1px solid #000">
  ![Slide LUMI-C node](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/AMDMilanNode.png){ loading=lazy }
</figure>

A compute node is then built out of two such processor packages, connected 
through 4 16-bit wide Infinity Fabric connections with a total theoretical
bandwidth of 144 GB/s in each direction. So note that the bandwidth in
each direction is less than the memory bandwidth of a socket. Again, **it is
not really possible to use the full memory bandwidth of a node using just cores
on a single socket**. Only one of the two sockets has a direct connection to the
high performance Slingshot interconnect though.


### A strong hierarchy in the node

<figure markdown style="border: 1px solid #000">
  ![Slide Strong hierarchy](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/AMDMilanHierarchy.png){ loading=lazy }
</figure>

As can be seen from the node architecture in the previous slide, the CPU compute
nodes have a very hierarchical architecture. When mapping an application onto 
one or more compute nodes, it is key for performance to take that hierarchy
into account. This is also the reason why we will pay so much attention to
thread and process pinning in this tutorial course.

At the coarsest level, each core supports two hardware threads (what Intel calls
hyperthreads). Those hardware threads share all the resources of a core, including the 
L1 data and instruction caches and the L2 cache, execution units and space for
register renaming. 
One can think that it is optimal to map 2 threads on the same core by using hyperthreading, as the communication
between those will be optimal. And this is true, but they will be using the same unit (i.e. contending the resources!).
This is something that cannot be known apriori. Indeed, in many supercomputer applications the bottleneck is the 
resource usage, so usually, the hyperthreading is disabled by default.
In LUMI it is possible to activate it with a Slurm command (that will be shown in the Slurm lecture).
However, keep in mind that this is something that **you** have to test and evaluate, as it changes
from application to application!

The next level is the Core Complex Die. It contains (up to) 8 cores. These cores share
the L3 cache and the link to the memory/IO die. 
Next, as configured on the LUMI compute nodes, there are 2 Core Complex Dies in a
NUMA node. These two CCDs share the DRAM channels of that NUMA node.
At the fourth level in our hierarchy 4 NUMA nodes are grouped in a socket. Those 4 
nodes share an inter-socket link (a ring between the 4 quadrants of the memory/IO chiplet).
At the fifth and last level in our shared memory hierarchy there are two sockets
in a node. On LUMI, they share a single Slingshot inter-node link.

The finer the level (the lower the number), the shorter the distance and hence the data delay
is between threads that need to communicate with each other through the memory hierarchy, and
the higher the bandwidth.

This table tells us a lot about how one should map jobs, processes and threads
onto a node. E.g., if a process has fewer then 8 processing threads running
concurrently, these should be mapped to cores on a single CCD so that they can share 
the L3 cache, unless they are sufficiently independent of one another or memory bound, but even in the
latter case the additional cores on those CCDs should not be used by other processes as
they may push your data out of the cache or saturate the link to the memory/IO die and hence
slow down some threads of your process. In some cases the optimal solution is to distribute 1 rank per ccd
and leave the other cores idle, if that single core is able to use ALL the bandwidth of the memory controller,
and having other cores contending for it would only create slowdowns! (memory bound applications).
Similarly, on a 256 GB compute node each NUMA node has
32 GB of RAM (or actually a bit less as the OS also needs memory, etc.), so if you have a job
that uses 50 GB of memory but only, say, 12 threads, you should really have two NUMA nodes reserved
for that job as otherwise other threads or processes running on cores in those NUMA nodes could saturate
some resources needed by your job. It might also be preferential to spread those 12 threads over the 4 
CCDs in those 2 NUMA domains unless communication through the L3 threads would be the bottleneck in your
application.


### Hierarchy: delays in numbers

<figure markdown style="border: 1px solid #000">
  ![Slide Delays in numbers](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/AMDMilanDelays.png){ loading=lazy }
</figure>

This slide shows the Advanced Configuration and Power Interface
System Locality distance Information Table (ACPI SLIT)
as returned by, e.g., `numactl -H` which gives relative distances to
memory from a core. E.g., a value of 32 means that access takes 3.2x times the 
time it would take to access memory attached to the same NUMA node. 
We can see from this table that the penalty for accessing memory in 
another NUMA domain in the same socket is still relatively minor (20% 
extra time), but accessing memory attached to the other socket is a lot 
more expensive. If a process running on one socket would only access memory
attached to the other socket, it would run a lot slower which is why Linux
has mechanisms to try to avoid that, but this cannot be done in all scenarios
which is why on some clusters you will be allocated cores in proportion to
the amount of memory you require, even if that is more cores than you
really need (and you will be billed for them).


## Building LUMI: Concept LUMI-G node

<figure markdown style="border: 1px solid #000">
  ![Slide Concept LUMI-G node](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/GPUnodeConcept.png){ loading=lazy }
</figure>

This slide shows a conceptual view of a LUMI-G compute node. This node is
unlike any Intel-architecture-CPU-with-NVIDIA-GPU compute node you may have 
seen before, and rather mimics the architecture of the USA pre-exascale
machines Summit and Sierra which have IBM POWER9 CPUs paired with 
NVIDIA V100 GPUs.

Each GPU node consists of one 64-core AMD EPYC CPU and 4 AMD MI250X GPUs. 
So far nothing special. However, two elements make this compute node very
special. First, the GPUs are not connected to the CPU though a PCIe bus. Instead
they are connected through the same links that AMD uses to link the GPUs together,
or to link the two sockets in the LUMI-C compute nodes, known as xGMI or
Infinity Fabric. This enables unified memory across CPU and GPUs and 
provides partial cache coherency across the system. The CPUs coherently
cache the CPU DDR and GPU HBM memory, but each GPU only coherently caches 
its own local memory.
The second remarkable element is that the Slingshot interface cards
connect directly to the GPUs (through a PCIe interface on the GPU) rather
than to the CPU. The GPUs have a shorter path to the communication 
network than the CPU in this design. 

This makes the LUMI-G compute node really a "GPU first" system. The architecture
looks more like a GPU system with a CPU as the accelerator for tasks that a GPU is
not good at such as some scalar processing or running an OS, rather than a CPU node
with GPU accelerator.

It is also a good fit with the cluster-booster design explored in the DEEP project
series. In that design, parts of your application that cannot be
properly accelerated would run on CPU nodes, while booster GPU nodes would be used for those parts 
that can (at least if those two could execute concurrently with each other).
Different node types are mixed and matched as needed for each specific application, 
rather than building clusters with massive and expensive nodes
that few applications can fully exploit. As the cost per transistor does not decrease
anymore, one has to look for ways to use each transistor as efficiently as possible...

It is also important to realise that even though we call the partition "LUMI-G", the MI250X
is not a GPU in the true sense of the word. It is not a rendering GPU, which for AMD is 
currently the RDNA architecture which is at version 4, but a compute accelerator with
an architecture that evolved from a GPU architecture, in this case the VEGA architecture
from AMD. The architecture of the MI200 series is also known as CDNA2, with the MI100 series
being just CDNA, the first version. Much of the hardware that does not serve compute purposes
has been removed from the design to have more transistors available for compute. 
Rendering is possible, but it will be software-based 
rendering with some GPU acceleration for certain parts of the pipeline, but not full hardware
rendering. 
<!--
The video units are still present though, likely for AI applications that process video.
-->

This is not an evolution at AMD only. The same is happening with NVIDIA GPUs and there is a reason
why the latest generation is called "Hopper" for compute and "Ada Lovelace" for rendering GPUs. 
Several of the functional blocks in the Ada Lovelace architecture are missing in the Hopper 
architecture to make room for more compute power and double precision compute units. E.g.,
Hopper does not contain the ray tracing units of Ada Lovelace.
The Intel Data Center GPU Max code named "Ponte Vecchio" is the only current GPU for 
HPC that still offers full hardware rendering support (and even ray tracing), but that line
looks increasingly like a dead end.

Graphics on one hand and HPC and AI on the other hand are becoming separate workloads for which
manufacturers make different, specialised cards, and if you have applications that need both,
you'll have to rework them to work in two phases, or to use two types of nodes and communicate
between them over the interconnect, and look for supercomputers that support both workloads.
And nowadays we're even starting to see a split between chips that really target AI and
chips that target a more traditional HPC workload, with the latter threatened as there
is currently much more money to make in the AI market. And within AI we're starting to 
see specialised accelerators for inference (e.g., the NVIDIA Rubin CPX).

But so far for the sales presentation, let's get back to reality...


## Building LUMI: What a LUMI-G node really looks like

<figure markdown style="border: 1px solid #000">
  ![Slide Real LUMI-G node](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/GPUnodeReal.png){ loading=lazy }
</figure>

Or the cleaner picture:


<figure>
  <img 
    src="https://462000265.lumidata.eu/2day-20251020/img/lumig-node-architecture-rings.svg" 
    width="842"
    alt="LUMI-G compute nodes overview"
  >
</figure>

The LUMI-G node uses the 64-core AMD 7A53 EPYC processor, known under the code name "Trento".
This is basically a Zen3 processor but with a customised memory/IO die, designed specifically 
for HPE Cray (and in fact Cray itself, before the merger) for the USA Coral-project to build the
Frontier supercomputer, the fastest system in the world at the end of 2022 according to at least
the Top500 list. Just as the CPUs in the LUMI-C nodes, it is a design with 8 CCDs and a memory/IO
die.

The MI250X GPU is also not a single massive die, but contains two compute dies besides the 8 stacks of
HBM2e memory, 4 stacks or 64 GB per compute die. The two compute dies in a package are linked together 
through 4 16-bit Infinity Fabric links. These links run at a higher speed than the links
between two CPU sockets in a LUMI-C node, but per link the bandwidth is still only
50 GB/s per direction, creating a total bandwidth of 200 GB/s per direction between
the two compute dies in an MI250X GPU. That amount of bandwidth is very low compared to
even the memory bandwidth, which is roughly 1.6 TB/s peak per die, let alone compared
to whatever bandwidth caches on the compute dies would have or the bandwidth of the internal structures that 
connect all compute engines on the compute die. Hence the two dies in a single package cannot
function efficiently as as single GPU which is one reason why each MI250X GPU on LUMI
is actually seen as two GPUs. 

Each compute die uses a further 2 or 3 of those Infinity Fabric (or xGNI) links to connect
to some compute dies in other MI250X packages. In total, each MI250X package is connected through
5 such links to other MI250X packages. These links run at the same 25 GT/s speed as the 
links between two compute dies in a package, but even then the bandwidth is only a meager 
250 GB/s per direction, less than an NVIDIA A100 GPU which offers 300 GB/s per direction
or the NVIDIA H100 GPU which offers 450 GB/s per direction. Each Infinity Fabric link may be
twice as fast as each NVLINK 3 or 4 link (NVIDIA Ampere and Hopper respectively),
offering 50 GB/s per direction rather than 25 GB/s per direction for NVLINK, 
but each Ampere GPU has 12 such links and each Hopper GPU 18 (and in fact a further 18 similar ones to
link to a Grace CPU), while each MI250X package has only 5 such links available to link to other GPUs
(and the three that we still need to discuss).

Note also that even though the connection between MI250X packages is all-to-all, the connection
between GPU dies is all but all-to-all. as each GPU die connects to only 3 other GPU dies.
There are basically two bidirectional rings that don't need to share links in the topology, and then some extra
connections. The rings are:

-   Green ring: 1 - 0 - 6 - 7 - 5 - 4 - 2 - 3 - 1
-   Red ring: 1 - 0 - 2 - 3 - 7 - 6 - 4 - 5 - 1
<!--
    Note the bit flip pattern in the latter: 001 - 000 - 010 - 011 - 111 - 110 - 100 - 101 - 001
-->

These rings play a role in the inter-GPU communication in AI applications using RCCL.

Each compute die is also connected to one CPU Core Complex Die (or as documentation of the
node sometimes says, L3 cache region). This connection only runs at the same speed as the links
between CPUs on the LUMI-C CPU nodes, i.e., 36 GB/s per direction (which is still enough for 
all 8 GPU compute dies together to saturate the memory bandwidth of the CPU). 
This implies that each of the 8 GPU dies has a preferred CPU die to work with, and this should
definitely be taken into account when mapping processes and threads on a LUMI-G node. 

The figure also shows another problem with the LUMI-G node: The mapping between CPU cores/dies
and GPU dies is all but logical:

| GPU die | CCD | hardware threads  | NUMA node |
|---------|-----|-------------------|-----------|
| 0       | 6   | 48-55, 112-119    | 3         |
| 1       | 7   | 56-63, 120-127    | 3         |
| 2       | 2   | 16-23, 80-87      | 1         |
| 3       | 3   | 24-31, 88-95      | 1         |
| 4       | 0   | 0-7, 64-71        | 0         |
| 5       | 1   | 8-15, 72-79       | 0         |
| 6       | 4   | 32-39, 96-103     | 2         |
| 7       | 5   | 40-47, 104, 11    | 2         |

and as we shall see later in the course, exploiting this is a bit tricky at the moment.

<!--
!!! Note
    It is not clear if the GPU compute dies are actually directly connected to the CPU compute
    dies or via the memory/IO die. The former would imply that each CPU CCD would have two 
    Infinity Fabric ports. As far as we are aware, this has never been show in AMD documentation,
    but then it is known that the Zen4 8-core CCD has two such ports that are actually also
    used in those EPYC 7004 SKUs that have only 4 CCDs.
-->

### The next Gen: El Capitan

<figure markdown style="border: 1px solid #000">
  ![Slide The next gen: El Capitan](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/GPUnodeFuture.png){ loading=lazy }
</figure>

Some users may be annoyed by the "small" amount of memory on each node. Others
may be annoyed by the limited CPU capacity on a node compared to some systems 
with NVIDIA GPUs. It is however very much in line with the cluster-booster
philosophy already mentioned a few times, and it does seem to be the future
according to AMD (with Intel also working into that direction). 
In fact, it looks like with respect to memory 
capacity things may even get worse.

We saw the first little steps of bringing GPU and CPU closer together and 
integrating both memory spaces in the USA pre-exascale systems Summit and Sierra.
The LUMI-G node which was really designed for one of the first USA exascale systems
continues on this philosophy, albeit with a CPU and GPU from a different manufacturer.
Given that manufacturing large dies becomes prohibitively expensive in newer semiconductor
processes and that the transistor density on a die is also not increasing at the same
rate anymore with process shrinks, manufacturers are starting to look at other ways
of increasing the number of transistors per "chip" or should we say package.
So multi-die designs are here to stay, and as is already the case in the AMD CPUs,
different dies may be manufactured with different processes for economical reasons.

Moreover, a closer integration of CPU and GPU would not only make programming easier
as memory management becomes easier, it would also enable some codes to run on GPU 
accelerators that are currently bottlenecked by memory transfers between GPU and CPU.

Such a chip is exactly what AMD launched in December 2023 with the MI300A version of 
the MI300 series. 
It employs 13 chiplets in two layers, linked to (still only) 8 
memory stacks (albeit of a much faster type than on the MI250X). 
The 4 chiplets on the
bottom layer are the memory controllers and inter-GPU links (an they can be at the
bottom as they produce less heat). Furthermore each package features 6 GPU dies
(now called XCD or Accelerated Compute Die as they really can't do graphics) and
3 Zen4 "Genoa" CPU dies. In the MI300A the memory is still limited to 8 16 GB stacks, 
providing a total of 128 GB of RAM. The MI300X,  which is the regular version 
without built-in CPU, already uses 24 GB stacks for a total of 192 GB of memory,
but presumably those were not yet available when the design of MI300A was tested
for the launch customer, the [El Capitan supercomputer](https://asc.llnl.gov/exascale/el-capitan)
which became the number 1 in the [TOP500 list of November 2024](https://top500.org/lists/top500/2024/11/).
[HLRS is building the Hunter cluster based on AMD MI300A](https://www.hlrs.de/news/detail/exascale-supercomputing-is-coming-to-stuttgart) 
as a transitional system
to their first exascale-class system Herder that will become operational by 2027.
The fact that the chip has recently been selected for the Hunter development system
also indicates that even if no successor using the same techniques to combine GPU and
CPU compute dies and memory would be made, there should at least be a successor that
towards software behaves very similarly.

Intel at some point has shown only very conceptual drawings of its Falcon Shores chip 
which it calls an XPU, but those drawings suggest that that chip will also support some low-bandwidth
but higher capacity external memory, similar to the approach taken in some Sapphire 
Rapids Xeon processors that combine HBM memory on-package with DDR5 memory outside 
the package. Falcon Shores was meant to be the next generation of Intel GPUs for HPC, after 
Ponte Vecchio which is used in the Aurora supercomputer. However, it then first reverted
to a more traditional design and ultimately got canceled except for some internal use, with 
Jaguar Shores now being the successor for the Ponte Vecchio GPU in Aurora and no architecture
known yet. The NVIDIA Grace-Hopper and Grace-Blackwell chips also do not completely follow
the design philosophy of MI300A as that chip also still has separate memory for the CPU die and
GPU dies, but the connection between both is so fast that at least the CPU should be able to 
work with data in GPU-attached memory without the need for copying.


## Building LUMI: The Slingshot interconnect

### Principles

<figure markdown style="border: 1px solid #000">
  ![Slide Slingshot interconnect](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/Slingshot.png){ loading=lazy }
</figure>

All nodes of LUMI, including the login, management and storage nodes, are linked
together using the Slingshot interconnect (and almost all use Slingshot 11, the full
implementation with 200 Gb/s bandwidth per direction).

Slingshot is an interconnect developed by HPE Cray and based on Ethernet, but with
proprietary extensions for better HPC performance. It adapts to the regular Ethernet
protocols when talking to a node that only supports Ethernet, so one of the attractive
features is that regular servers with Ethernet can be directly connected to the 
Slingshot network switches.
HPE Cray has a tradition of developing their own interconnect for very large systems.
As in previous generations, a lot of attention went to adaptive routing and congestion
control.
In a recent [paper](https://arxiv.org/pdf/2408.14090), a comparison between networks in similar supercomputers
has been done. One of the outcomes of this paper is that the Slingshot network, 
when compared to traditional Infiniband (LEONARDO) approach provided a slightly worse "best" and "average" cases, 
but a better performing "worst" case. And the reason why this is important is that
in a HPC large job (which are the real reasons why HPC systems are built), at a synchronization point
(be it a barrier or a collective operation) you need to wait for the last process to join the operation,
so what really matters is the "worst" case time.

There are basically two versions of it. The early version was named Slingshot 10,
ran at 100 Gb/s per direction and did not yet have all features. It was used on the initial
deployment of LUMI-C compute nodes but has since been upgraded to the full version.
The full version with all features is called Slingshot 11. It supports a bandwidth of 200 Gb/s
per direction, comparable to HDR InfiniBand with 4x links. 
The network also has some features for MPI acceleration.

Slingshot is a different interconnect from your typical Mellanox/NVIDIA InfiniBand implementation
and hence also has a different software stack. This implies that there are no UCX libraries on
the system as the Slingshot 11 adapters do not support that. Instead, the software stack is 
based on libfabric (as is the stack for many other Ethernet-derived solutions and even Omni-Path
has switched to libfabric under its new owner).

LUMI uses the dragonfly topology. This network topology has been used by Cray for a long time
already. To function well, it does require a number of features from the switches though.


### Dragonfly topology

<figure markdown style="border: 1px solid #000">
  ![Slide Dragonfly Topology 1](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/DragonflyConcept1.png){ loading=lazy }
</figure>

The dragonfly topology is designed to scale to a very large number of 
connections while still minimizing the amount of long cables that have to be used. However, with
its complicated set of connections it does rely heavily on adaptive routing and congestion control for
optimal performance more than the fat tree topology used in many smaller clusters.
It also needs so-called high-radix switches. The Slingshot switch, code-named Rosetta, has 64 ports.
16 of those ports connect directly to compute nodes (and the in a few slides, we will show you how),
while the other ports are used to connect the switches.

<figure markdown style="border: 1px solid #000">
  ![Slide Dragonfly Topology 2](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/DragonflyConcept2.png){ loading=lazy }
</figure>
<!-- Figure in the slide: https://commons.wikimedia.org/wiki/File:Dragonfly-topology.svg -->

The figure in the slide above gives an idea how a dragonfly network is organised. It is shown
with far fewer nodes and ports per switch as is used on LUMI, but that makes it easier to grasp
the concept.

Contrary to a fat tree network used in a lot of clusters, where some switches connect to nodes
and other switches only connect to switches, in a dragonfly topology, each switch connects to
a number of nodes and to other switches. The figure shows two colours for the connections between
switches, and on modern clusters, they will correspond to a different type of cabling being used.

Switches are organised in groups. All switches in a group have all-to-all connections to one another.
A group usually corresponds with a single rack. Within the rack, distances are short enough that at
current network speeds, copper cables can still be used to make the connections.

Groups are then also connected in an all-to-all way. These connections go over longer distances
(LUMI is the size of a tennis court if you also count storage etc. that is also in the high
performance interconnect) and are made with optical cables. Within a group, each switch is
used to make connections to some other groups, but no switch is connected to all groups.
So if two nodes in different groups communicate to each other, the path is typically:

1.  Node talks to the switch it is connected to.
2.  Switch talks to the switch in the group that connects to the receiving group.
3.  That switch then talks to its counterpart in the receiving group.
4.  From there the message is sent to the switch connecting to the node
5.  and finally to the node.

So the shortest path between two nodes in a dragonfly topology never involves 
more than 3 hops between switches (so 4 switches): One from the switch the node is connected to 
the switch in its group that connects to the other group, a second hop to the other group, and then
a third hop in the destination group to the switch the destination node is attached to.

We can see the problem here though: Assume that our code would be running on 32 nodes, 16 each
connected to the same switch, but both switches in different groups. The nodes connected to
the same switch would likely each be able to communicate with one another at the full network
speed. However, if all that traffic would go over the single connection which we just outlined
to reach the other 16 nodes, all that traffic would go over a single network connection, so 
essentially at the speed that a single node can talk to the network. The Slingshot network will
then intervene and send some of that traffic over a longer path to avoid saturation.
Whereas you may have been told on your local cluster that you should try to get your compute
nodes on as few switches as possible, on LUMI that does not make sense unless they would all be on 
a single switch (which by the way is non-trivial to request on LUMI as we shall see later),
and you're often best off if the nodes are distributed across the cluster. Which fortunately is
also a strategy that is less demanding for the scheduler, enabling better throughput of jobs
for everybody.

(We're a bit pessimistic here though. On smaller slingshot configurations, there could be multiple 
links between two switches in a group or multiple links between two groups.)

<figure markdown style="border: 1px solid #000">
  ![Slide Dragonfly Topology on LUMI](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/DragonflyLUMI.png){ loading=lazy }
</figure>

On LUMI,

-   Each switch has 16 node-facing ports. Depending on the node type, these will connect to 8 or 16
    different nodes.

    There are another 48 ports to connect to other switches.

-   Groups can contain 16 or 32 switches, all in a single rack, and those switches
    are then connected in an all-to-all way via copper cables.

-   The groups are then connected with optical cables.


## Assembling LUMI

### Compute blades

<figure markdown style="border: 1px solid #000">
  ![Slide LUMI compute blades](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/LUMIComputeBlades.png){ loading=lazy }
</figure>

LUMI has two types of compute blades: CPU node blades that each contain 4 CPU nodes, and
GPU node blades that each contain 2 nodes.

The left picture is from a typical Cray EX CPU node, but it is not the LUMI node. The LUMI
blades have only two network cards per blade, as each network card is capable of connecting
to PCIe slots on two nodes.

The right picture is a GPU node blade, again very similar to those on LUMI with one difference 
(an additional board covering the CPU). The blade as a whole now has 4 network boards, again
with each offering two network connections. 

Both types of blades are fully water cooled.


### Switch blades

<figure markdown style="border: 1px solid #000">
  ![Slide LUMI switch blades](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/LUMISwitchBlades.png){ loading=lazy }
</figure>

The upper right of the above slide shows the switch side facing the compute blades. The picture in the upper right
shows how the side where the inter-switch connections are made. You may think that the switch has only 32 connections 
(8 on one side and 24 on the other), but all these connections are actually double.

The bottom left picture shows how a compute blade would connect to the switches, including a 
separate network for management. The picture does contain an error though as NMC0 should connect
to the switch 3 slot. Note also that the node layout is 2x2, with each network card connecting
to two connectors on the motherboard that come from different nodes.

From this picture we can already derive that consecutively numbered nodes on LUMI are not on the same switch.
Node 0 and 1 are on "Switch 3", node 2 and 3 on "Switch 7", then on the next node blade the first two nodes
would again be on "Switch 3" and so on. So asking for consecutive nodes on LUMI does not give you nodes on a single
switch and as we have discussed, this shouldn't really bother you at all. In fact, users should never make such requests
due to the way the Slurm scheduler works, as such request can block launching other jobs if the highest
priority job is waiting to gather a set of consecutively numbered nodes...

The picture on the bottom right is for a CPU node with two network connections per node. In this case, each
node would actually be on two different switches as both NMC0 and NMC2 serve node 0 and 1.
However, if we think of node 0 and 1 as one node, and node 2 and 3 the other node, this picture would also
work for a GPU node (but again with the remark that NMC0 which is shown to be connected to HSS is actually
connected to "Switch 3"). 

Each GPU node has 4 network connections, one per GPU, but these are made through two boards with two network
interfaces each. So GPU node 0 on the board would be connected to "Switch 1" and "Switch 3" through two network
cards, and similarly GPU node 1 is connected to "Switch 5" and "Switch 7". So note that two consecutively numbered
GPU nodes are actually connected to a different pair of switches!

These figures actually also already explain why we have only 8 connectors on the compute node-facing side of the 
switches: Each connection goes to a single network card, but that card takes care of two independent connections
through a single set of wires.


### Putting it all in racks

<figure markdown style="border: 1px solid #000">
  ![Slide HPE Cray EX System](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/AssemblyEX.png){ loading=lazy }
</figure>

Let's now have a look at how everything connects together to the supercomputer LUMI.
It does show that LUMI is not your standard cluster build out of standard servers.

LUMI is built very compactly to minimise physical distance between nodes and to reduce
the cabling mess typical for many clusters and the costs of cabling. High-speed copper cables 
are expensive, but optical cables and the transceivers that are needed are even more
expensive and actually also consume a significant amount of power compared to the switch
power. The design of LUMI is compact enough that within a rack, switches can be connected
with copper cables in the current network technology and optical cabling is only
needed between racks.

LUMI does use a custom rack design for the compute nodes that is also fully water cooled.
It is build out of units that can contain up to 4 custom cabinets, and a cooling distribution
unit (CDU). The size of the complex as depicted in the slide is approximately 12 m<sup>2</sup>.
Each cabinet contains 8 compute chassis in 2 columns of 4 rows. In between the two
columns is all the power circuitry. Each compute chassis can contain 8 compute blades
that are mounted vertically. Each compute blade can contain multiple nodes, depending on
the type of compute blades. HPE Cray have multiple types of compute nodes, also with 
different types of GPUs. In fact, the Aurora supercomputer which uses Intel CPUs and GPUs and
El Capitan, which uses the MI300A APUs (integrated CPU and GPU) use the same
design with a different compute blade. Aurora uses compute blades that each contain only
a single node, with two Intel Xeon CPUs and 6 Intel Data Centre GPU Max's (code named 
Ponte Vecchio). The El Capitan compute blades contain two nodes, each with 4 NMI300A APUs.
Each LUMI-C compute blade contains 4 compute nodes
and two network interface cards, with each network interface card implementing two Slingshot
interfaces and connecting to two nodes. A LUMI-G compute blade contains two nodes and
4 network interface cards, where each interface card now connects to two GPUs in the same 
node. All connections for power, management network and high performance interconnect
of the compute node are at the back of the compute blade. At the front of the compute
blades one can find the connections to the cooling manifolds that distribute cooling
water to the blades. One compute blade of LUMI-G can consume up to 5kW, so the power
density of this setup is incredible, with 40 kW for a single compute chassis.

The back of each cabinet is equally genius. At the back each cabinet has 8 switch chassis,
each matching the position of a compute chassis. The switch chassis contains the connection to
the power delivery system and a switch for the management network and has 8 positions for 
switch blades. These are mounted horizontally and connect directly to the compute blades.
Each slingshot switch has 8x2 ports on the inner side for that purpose, two for each compute
blade. Hence for LUMI-C two switch blades are needed in each switch chassis as each blade has
4 network interfaces, and for LUMI-G 4 switch blades are needed for each compute chassis as
those nodes have 8 network interfaces. Note that this also implies that the nodes on the same 
compute blade of LUMI-C will be on two different switches even though in the node numbering they
are numbered consecutively. For LUMI-G both nodes on a blade will be on a different pair of switches 
and each node is connected to two switches. So when you get a few sequentially numbered nodes, they
will not be on a single switch (LUMI-C) or switch pair (LUMI-G).
The switch blades are also water cooled (each one can 
consume up to 250W). No currently possible configuration of the Cray EX system needs 
all switch positions in the switch chassis.

This does not mean that the extra positions cannot be useful in the future. If not for an interconnect,
one could, e.g., export PCIe ports to the back and attach, e.g., PCIe-based storage via blades as the 
switch blade environment is certainly less hostile to such storage than the very dense and very hot
compute blades.

This architecture is very popular for very large supercomputers. In fact, in the 
[June 2025 Top-500 list](https://top500.org/lists/top500/2025/06/), 6 of the top-10 systems
and 10 of the top 20 systems
use this system architecture, but with different types of compute blades.


## LUMI assembled

<figure markdown style="border: 1px solid #000">
  ![Slide LUMI](https://462000265.lumidata.eu/2day-20251020/img/LUMI-2day-20251020-101-Architecture/AssemblyLUMI.png){ loading=lazy }
</figure>

This slide shows LUMI fully assembled (as least as it was at the end of 2022).

At the front there are 5 rows of cabinets similar to the ones in the exploded Cray EX picture 
on the previous slide.
Each row has 2 CDUs and 6 cabinets with compute nodes. 
The first row, the one with the wolf, contains all nodes of LUMI-C, while the other four 
rows, with the letters of LUMI, contain the GPU accelerator nodes.
At the back of the room there are more 
regular server racks that house the storage, management nodes, some special compute nodes , etc.
The total size is roughly the size of a tennis court. 

!!! Remark
    The water temperature that a system like the Cray EX can handle is so high that in fact the water can
    be cooled again with so-called "free cooling", by just radiating the heat to the environment rather 
    than using systems with compressors similar to air conditioning systems, especially in regions with a
    colder climate. The LUMI supercomputer is housed in Kajaani in Finland, with moderate temperature almost 
    year round, and the heat produced by the supercomputer is fed into the central heating system of the
    city, making it one of the greenest supercomputers in the world as it is also fed with renewable energy.


<!-- BELGIUM
## Local trainings

The following trainings provide useful preliminary material for this section,
and in one case even more details.

-   VSC:

    -   VSC@UAntwerpen: [Supercomputers for Starters course](https://www.uantwerpen.be/en/research-facilities/calcua/training/),
        organised twice each year.

        [Course notes are available](https://klust.github.io/SupercomputersForStarters/)

        This course given in 2 4 hour sessions goes into more detail about CPU architecture, memory, storage, accelerators,
        and the software that binds all hardware together to build a cluster.

    -   The other introductory courses have a high-level overview of a cluster

        -   [VSC@VUB HPC Introduction](https://hpc.vub.be/docs/slides/hpc-intro/)

        -   [VSC@UGent Introduction to HPC](https://www.ugent.be/hpc/en/training/2023/introhpcugent)

        -   [VSC@KULeuven HPC-intro](https://hpcleuven.github.io/HPC-intro/)

-   CÉCI: The annual introductory course "Learning how to use HPC infrastructure" covers the basics 
    of cluster architecture.

    -   [2022 edition: presentation "Introduction to high-performance computing](https://indico.cism.ucl.ac.be/event/120/contributions/54/)
-->
