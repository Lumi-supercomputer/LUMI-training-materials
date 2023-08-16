# The dev-g and eap partitions

## Policy change of dev-g

The dev-g partition has always been meant for the development of GPU software, and in particular
to get a quick turnaround time if you need to run software under the control of a debugger or
for short profiling runs. We have observed that the queue has been abused for production
or near-production runs instead. Simultaneously a maximum of 16 nodes per job has not always
been enough for some debugging runs.

Therefore the following policy changes will be implemented:

-   The maximum size for a job increases from 16 to 32 nodes.
-   The maximum runtime (walltime) for a job is decreased from 6 to 3 hours.
-   The maximum number of jobs is unmodified. Users can have only one running job in this
    partition.

**User action: Some job scripts may require changes and you may have to move to a different
partition if you were not using dev-g in the intended way.**


## The eap partition

The EAP partition was a leftover of the early days of LUMI when there was a GPU development system
with MI100 nodes attached to the system. As a transition measure a new eap partition was created on
LUMI-G with the full MI250X hardware, and just as the original eap partition it allowed development
of GPU software without GPU billing units. However, we've recently seen abuse of this partition for
regular runs, and developers have now had ample time to request development projects at EuroHPC or,
for groups in LUMI consortium countries, their local resource allocators.

The eap partition is removed during the update and will not return. All users who want to experiment
on the GPU nodes now need projects with GPU billing units.

**User action: Request GPU billing units from your resource allocator. Depending on your use profile, 
use dev-g, small-g or standard-g instead.**
