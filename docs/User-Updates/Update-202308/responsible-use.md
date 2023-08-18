# Responsible use of LUMI-C and LUMI-G

Responsible use of LUMI can help to reduce waiting times for everybody and helps the priority
system to function as designed.


## Use small or small-g for small jobs

The small and small-g partition support jobs that need up to four nodes. Though these partitions
are allocatable by resources rather than allocatable by node, it is possible by adding some options
to `sbatch` to use them in the same way as the standard and standard-g partitions.

You can get the same environment on the small and standard partitions by:

-   Adding the option `--exclusive` to the `sbatch` flags (as a command line argument or
    in an `#SBATCH` line), and
-   Requesting memory, e.g., using `--mem`. For migrating from standard to small on LUMI-C, a good
    choice is `--mem=224g` and for migrating from standard-g to small-g, a good option is
    `--mem=480g`. This is needed because `--exclusive` does not yet give you access to memory in 
    the same way as the standard and standard-g partition do, but instead still impose the regular
    restrictions of small and small-g.

***These options should only be used if you indeed need job exclusive nodes and you will also be
billed for the full node if you use these options as described here.***

Job scripts using the above two options can still also run on standard and standard-g without 
negative consequences if you adapt the partition.

!!! Example "Lines for LUMI-C"

    ```
    #SBATCH --partition=small
    #SBATCH --exclusive
    #SBATCH --mem=224g
    ```

!!! Example "Lines for LUMI-G"

    ```
    #SBATCH --partition=small-g
    #SBATCH --exclusive
    #SBATCH --mem=480g
    ```

**User action: We encourage users to consider using small instead of standard and small-g instead of
standard-g for jobs that require 4 nodes or less, in particular if those jobs run for longer than
one hour. Shorter low-nodecount jobs can run as backfill and do not so much affect queueing times
for users with big jobs who can only use standard or standard-g.**


## Don't use standard-g if you cannot use all GPUs

A common error on LUMI-G is that users use a GPU node in the standard-g partition but cannot or
do not use all GPUs. Standard-g is only allocatable per node. So if you have a job running on a
node in standard-g, nor you nor any other user can use the remaining resources on that node (and you
are in fact billed for the full node).

Common errors include:

-   Running on a GPU node but forget to request GPUs. In some cases you will see a warning or even
    error message from your application in your output, 
    but in other cases the software will just run fine without a warning as
    the same binary may support both GPU and non-GPU use.

-   Running software that is not built for a GPU. Software will not use a GPU in some magical way
    just because there is a GPU in the system, but needs to be written and built for using a GPU.
    Most Python and R packages do not support GPU computing. And packages written for an NVIDIA GPU
    cannot run on an AMD GPU, just as software compiled for an x86 processor cannot run on an ARM
    processor.

    If you use a package which is not written for GPU use, you will not get any warning as software 
    does not give warnings if there is more hardware in the system than it needs or if it doesn't 
    know a piece of hardware and also doesn't need it.

-   Know your software. Not all software can use more than one GPU, let alone that it could use more
    than one GPU efficiently for the problem that you are trying to solve. And for all practical 
    purposes one GPU is one GCD or half of an MI250X package.

    Again, in many cases you won't get a warning as computers warn or produce error messages if they
    try to use something which is not available but don't produce warnings if some piece of software does
    not use all the hardware in the node (and that is a good thing as most shell commands would then also
    have to produce that warning).


## Proper test jobs are not only short in duration but also small in size

Try to avoid running short test jobs that need a lot of nodes. 

A supercomputer is never run in preemptive mode. Jobs run until they are finished and are not interrupted
for other jobs.

Now assume you submit a 512 node job on LUMI-C, half the size of the standard partition, and assume that all other
jobs in the system would be running for the maximum allowed walltime of 2 days. The scheduler will need to
gather nodes as they become available for the 512 node job, so if all jobs would run for 2 days and you need 
half of the total number of nodes, then on average this could take one full day, with the first resources in 
the pool becoming available almost immediately but the last few of the requested nodes only when the job starts.

You can see that this process makes a lot of resources unavailable for other jobs for a long time and leads to
inefficient use of the supercomputer. Luckily LUMI also supports backfill, i.e., small and short jobs can still start
if the scheduler knows these jobs will finish before it expects to be able to collect the nodes for the 512 node
job. 

However, usually there are not enough suitable jobs for backfill,
so very large jobs will usually lead to lots of nodes being idle for some time and hence inefficient use
of resources. LUMI is built for research into jobs for the exascale area, so we do want to keep it possible to run
large jobs. But users who do this should be responsible: Test on smaller configurations on a smaller number of nodes,
then when you scale up for the large number of nodes go immediately for a long run and instead ensure that your job
is cancelled properly if something goes wrong. 15-minute 512-node test jobs are a very bad idea.


## Don't use large jobs just for the fun of it

Sometimes you have the choice between using more nodes and getting a shorter runtime, or fewer nodes with a larger runtime.
In general using fewer nodes will always be more efficient as parallel efficiency for a given problem size usually decreases
with increasing node counts. So you'll likely get more from your allocation by using smaller jobs.

Also, the more nodes a job requires, the longer it may take to get scheduled, even just because it may take a while to gather 
the required number of nodes. Showing how well your code can scale may certainly be a worthwhile addition to your paper, but it
does not mean that all runs have to be done at those extreme node counts.

And as already discussed, very large jobs also have a negative impact on the efficiency of the resource use of the scheduler,
and hence on the waiting times for everybody.

If you need a big run requiring a 100 nodes or more, do so responsibly and ensure that it can run for a while so that 
resources haven't been kept idle by the scheduler for basically nothing.


## Use a reasonable estimate for the walltime

Of course it is OK to use a good safety margin when estimating the walltime a job will need, but just taking the 
maximum allowed for a partition just to always be safe is very asocial behaviour. It makes it impossible for a 
scheduler to properly use backfill to use resources that are idle while nodes are being collected for a big job.
Not only are jobs that request the maximum allowed walltime not suitable as backfill, but overestimating the 
walltime needed for a job will also needlessly delay that big job
simply because the scheduler thinks the nodes will only be available at
a later time than they actually are and hence will wrongly assume that it is still safe to start short
lower priority jobs as backfill..

The maximum walltime on LUMI is high compared to many other large clusters in Europe that have a 24 hour limit
for larger jobs. Don't abuse it.


## Core and memory use on small-g and dev-g

The changes made to the configuration of LUMI are not yet reflected in the billing policy. However, 
to enable everybody to maximally exploit the nodes of LUMI-G one should

-   Request at most 60 GB of CPU memory for every GPU requested as then all 8 GPUs can be used
    by jobs with a fair amount of system memory for everybody, and
-   Not request more than 7 cores for each GPU requested. If all users do this, the GPUs
    in a node can be used maximally.

