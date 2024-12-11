# Using Lustre

*Presenter: Emanuele Vitali*

Lustre is a parallel file system and the main file system on LUMI.
It is important to realise what the strengths and weaknesses of Lustre at the
scale of a machine as LUMI are and how to use it properly and not disturb the
work of other users.


## Materials

<!--
Materials will be made available during and after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20241210/recordings/09-Lustre.mp4" controls="controls"></video>

-   [Slides](https://462000265.lumidata.eu/2day-20241210/files/LUMI-2day-20241210-09-Lustre.pdf)

-   [Course notes](09-Lustre.md) (based on an earlier version of the presentation from a different presenter)

<!--
-   A video recording will follow.
-->


## Q&A

1.  So file size of 15-50 mb is ok? in terms of striping.

    -   It will probably not kill Lustre unless you try to read or write a lot of those files simultaneously from different nodes, but it is still too smal to come anwhere close to what Lustre can deliver. 1 MB is what Cray tells us as the minimal stripe size, but our experience is that it may have to be a lot larger. But if you mean a stripe size of 15-50 MB and not a file size of 15-50 MB, that would be good values to start with. 

        Ideally, you also have different processes writing to different chunks in the file but that is not always easy to organise....

2.  Will there be some exercises to cover some use cases on changing the stripe size and stripe count affect data transfer?

    -   No unfortunately. If you do this in group, it could become a denial-of-service attack on the Lustre filesystem... In the 4-day course there are some but not to the extent that you ask. And really, the ideal stripe size also depends on how the data is written. It really requires some experimenting with a specific code...

    I understand the concern, but I want to know as a user how can I know/experiment with my example, per say if I am running a vasp calculation or an MD run in GROMACS should I tune these parameters for effective data storage?

    -   If your job is not very I/O bound, it is not the first thing to tune. I am not a VASP expert and unfortunately our VASP expert has left the team some time ago already. But he turned off an option in VASP in our EasyBuild configuration files because it causes too much trouble on Lustre, and the ".build2" recipes you will find in our LUMI Software Library is also because of issues between VASP and Lustre (I think VASP opened and closed the same file a bit too often). I hope the next major update of VASP will solve some of these issues... For GROMACS, I haven't really heard of many issues.

3.  If we have for example a 100GB sqlite database where we need 'random' access (e.g. based on index), would you have any suggestions on first steps to improve performance on Lustre? (Is it even possible/feasible in such a case?)

    -    The database is a single file right? if so, i don't think that is an addressable problem, sadly. That pattern just can't use the underlying parallelism. Note that at least that won't hammer MDS (so is not evil, just inefficient)
  
    TY! It's what we thought, so redesign of the strategy it is! =)

    -    And the locking may not work well in Lustre, but that only matters for writing to that database.

4.  Out of curiosity and related to the previous question - Do you have any experience / has anyone done anything with Apache Spark (e.g., via pyspark) for something like that? As in - can we get that to play nicely with Lustre? (Might be a bit of an overkill, but it was something we considered for the redesign of the pipeline)

    - From all I know, this is more a platform for use in the cloud than on an HPC cluster. In Flanders we had a couple of users for it on one of the HPC cluster, but as far as I know, they have given up on that platform. I didn't see a new installation for a while.



