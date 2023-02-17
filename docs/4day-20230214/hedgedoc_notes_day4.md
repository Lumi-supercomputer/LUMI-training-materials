# Notes from the HedgeDoc page - day 4

These are the notes from the LUMI training,
1114-17.02.2023, 9:00--17:30 (CET) on Zoom.

-   [Day 1](hedgedoc_notes_day1.md)
-   [Day 2](hedgedoc_notes_day2.md)
-   [Day 3](hedgedoc_notes_day3.md)
-   [Day 4](hedgedoc_notes_day4.md): This page


## Introduction to Perftools

2.  A question from the first day, sorry :-) My Fortran code with OpenMP offload does not compile with -O2 (cray compiler) due to inlining issues; is it possible to quench inlining for a specific routine only? 
    -   (Harvey) `man inline`
        it might apply to whole file though so need to check, manpage might indicate this.
    -   The ipa compiler option (man crayftn) also affects inlining.
        -   yes, I discovered it does not compile due to inling, ao I reduced to level 1, 2 gives errors as well..
        -   Thank you!
    -   (Peter) Setting `__attribute__((noinline))` before the subroutine can be done in standard Clang, at least. CrayCC seems to accept it when I compile a simple program.
    -   It might also be worth to compile with -O2 but just turn of inlining with the appropriate compiler option (-hipa0 I believe for Fortran).


3.  Would it be possible to use a pointer / annotate / ??? to visually guide the narration through complex slides ? not sure whether technically possible
    -   (Harvey) It looks like Zoom does now have this capability but it has to be enabled before sharing a presentation and is embedded in menus,  I really don't want to interrupt Alfio to try this live but we will look into this.  Thanks for the suggestion.
    -   (not Harvey) It is certainly possible but depending on the software that is used for the presentation and the way of sharing (just a window or the whole screen) it requires additional software that the speaker may not have installed.
        -   okay
    -   It's a remark to take with us should there once again be a fully virtual course but it looks like the next two will be in-person with broadcast and then the technique that works for the room will determine how slides are broadcast.
        -   thank you
        -   I second the suggestion/request for future courses, it was especially difficult to follow through Alfio's slides. Maybe consider a different meeting software (one more targeted at teaching like BigBlueButton which supports the pointer) in the future? At least for me on Linux it is hit-and-miss if Zoom finds my audio (no problems with BBB or jitsi or even Teams, though)

4.  Is there a maximum duration of the measurement session supported, more or less?
    -   Not in time terms but you can use a lot of disk space with a very large number of ranks and specifically if you turn off the statistics aggregation in time.  There are controls to help here, for example only tracing a subset of the ranks or turning on and off collection at certain points.

5.  Where can I find the apprentice downloads?

    -   On LUMI, in `$CRAYPAT_ROOT/share/desktop_installers/` (with `perftools-base` loaded, which is loaded in the login environment)
    -   See also `module help perftools-base`.
    -   (Note that on LUMI the perftools default is the latest version installed. If you were using a system somewhere else with a newer perftools available than the default you can download the desktop installer of the latest version.)
    -   (Kurt) Actually the above about the default is only true at login and at the moment as currently it is indeed the latest version of the PE which is the default at login. If you load a `cpe` module of an older environmont (`cpe/21.12` for example) the default version of `perftools-base` will be the one that came with that release of the PE, and the same holds if you use the an older version of the `LUMI` software stacks.


### Exercises

!!! info "Exercise"
    General remarks

    -   Exercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -   Directories for this exercise: `perftools-lite`, `perftools-lite-gpu`
    -   Copy the files to your home or project folder before working on the exercises.
    -   In some exercises you have source additional files to load the right modules necessary, check the README file.
    -   To run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_g.sh` (GPU) or `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU)

    Exercise: 

    -   Follow the readme and get familiar with the perftools-lite commands and outputs


5.  Can we connect jupyternotebook on Lumi? How to set the environments?  

    -   Answered on Tuesday already. At your own risk at the moment, and you'll have to use ssh tunneling to connect to the Jupyter Notebook. A better solution will come when Open OnDemand is installed. Keep in mind that LUMI is not meant to be an interactive workstation, so big Jupyter sessions have to go on the compute node and it is walltime that is being billed, so you'll pay for the time that Jupyter is waiting for your input which is not a very efficient way of using a supercomputer... It is more meant to prepare data and some simple postprocessing, but doing most of the work in regular jobs.
        -   Follow up: When launching Jupyter from compute nodes, is it possible to forward on the login node the ports? I tried and the SSH fails (asks for password) `ssh -N -L 5000:localhost:5000 -i ID_FILE uan4`
    -   You'd be running ssh on the client where you want to run the browser connecting to your Jupyter Notebook, loging in to one of the login nodes but doing the port forwarding to the compute node. See what happens when you use the `lumi-vnc` module on a compute node for instance. So something along the lines 
        ```
        ssh -N -L :nid001060:5000 -i ID_FILE myname@lumi.csc.fi
        ```
        -   Running SSH from the local machine indeed works, but we have to know the nid in advance. I was thinking to do the tunneling in two steps, first from the compute node, and then complete it from the local machine. This way it can be automated. (Yes, local machine would be remote forwarding)
    -   That will not work, tunneling has to go in the right direction. Maybe with -R. But also be aware that the port that you want on the login node has a high chance of being taken already. The correct process is to (1) log on to LUMI and start your job that starts the Jupyter Notebook, then (2) look on what node the job is running (possible to see with Slurm commands) and (3) then start your ssh tunnel as given above.
        -   Understood, thanks!

6.  what exactly is "exclusive time" mentioned in report ?
    -   you have inclusive and exclusive time per each function: the latter is the amount of time spent purely in that function, excluding time spent in child functions (inclusive is the opposite).

7.  What tool is suitable for tracing memory allocations/free? 
    -   you can use the perftools and analyse the memory traffic. Check the man page for pat_build, option -g memory (and wait for next talk on pat_build description).
    -   If you are more interested in debugging memory allocations then valgrind/valgrind4hpc might be more relevant
    -   I would be interested to detect where the allocations and frees happen (for analysing different applications, without knowing the details from source codes)
        -   wrapping them would it be an option? https://stackoverflow.com/questions/262439/create-a-wrapper-function-for-malloc-and-free-in-c I think jemalloc has something similar too (no sure though), see https://github.com/jemalloc/jemalloc/wiki/Use-Case%3A-Heap-Profiling
    -   I'm not aware of that, I'll check it, thank you

8. Are the perftools available also outside LUMI, e.g. outside Cray environment?
    -   No they are not. They are designed for analysis of large scale applications in the HPE Cray EX environment, there are a lot of dependencies and assumptions (fast file system for example), I'm not sure it would be that easy to do this.
    -   You can get the HPE Cray PE for certain HPE servers also but it is a commercial product and I don't know the pricing. I know a non-Cray HPE cluster that has them though.
        -   yes, I'm thinking about non-Cray HPE cluster. Can you reveal what is the name of that non-Cray HPE cluster with perftools installed? I think I've heard about HLRS, but not sure.
    -   HLRS doesn't have them from what I remember (I worked on that machine two years ago). That is a cluster that was ordered before the HPE-Cray merger I believe. It has some older modules from HPE, like aan HPE MPI implementation. Unless things have changed recently. But Lucia, a very recent cluster in Belgium (and not a EuroHPC cluster), came with the HPE Cray PE so likely also perftools (I don't have an account on that machine so I cannot verify). Not sure if Karolina, one of the EuroHPC petascale systems and also an HPE system has them.
        -   Karolina unfortunately doesn't have them

9. pat[WARNING][0]: performance counters are disabled because PAPI initialization failed ; perftool-lite-gpu can not measure gpu performance and hardware counters with papi together?

    -   This is OK, it will explained in the next presentation. LUMI doesn't allow hardware counters at the moment due to a security issue, but the rest of tracing information is fine. It is not a problem of the perftools, it is OS setup defined by LUMI system administration that does not allow performance counters (PAPI events are not available).
        -   understood, thank you! papi_avail is quite martinet here.. is this so on all partitions?
    -   LUST people can confirm, but I see that the put the kernel in paranoid mode on all compute nodes, so I would say yes... 
    -   Indeed yes at the moment. They were disabled after some security issues were discovered.
        -   Thank you!!

10. why "pat_report expfile.lite-samples" has no more information?
    -   could you elaborate more?
        -   based on readme "More information can be retrieved with pat_report expfile.lite-samples.*/"", but it is empty file?
    -   OK, you are running `pat_report expfile.lite-samples.*/` and don't see the output?
        -    ok now

11. my_output.lite-loops.* is empty!, I cant see any output after run?
    -   is it still running maybe? 
        -   yes, thank you

13. Can I see how many GPUs per rank from the summary and their ID? 
    -   summary of craypat? Well, I would suggest to use the tools we presented for the affinity checking... 
        -   Yes and it worked perfectly thank you! But I would like to check with other tools if possible, and I guess that the kernel performances are summarized over GPUs here, maybe there is an option to resolve this information?
    -   No sure, really. Check the man pages. If it is something we can get from rocprof, then I would say yes (assuming that craypat can do over MPI ranks). I have to check... Update: it seems it not possible, at least I cannot find anything useful for multigpus.. 
        -   Thank you very much! 

13. There is an issue with OpenMP offload region?
    ```
    Warnings:
    OpenMP regions included 2 regions with no end address, and
    2 regions with an invalid address range, and they were ignored.
     
    An exit() call or a STOP statement can cause missing end addresses.
    Invalid address ranges indicate a problem with data collection.
    ```
    -   This is a warning that it says you are using a STOP within the parallel region. Is it one of our example?
        -   yes, I am in perftools-lite-gpu/ directory
    -   This warning means that somehow the loop completed and the end address could not be recorded. If the reason is not clear by inspection of the loop (and it is hard to work out where it is) I'm afraid it needs knowledge of the perftools internals to investigate this further.
    -   OK, we will look into it. What matters is that you get the info you need in the profile of course.

14. Related to 9. - if HW counters are disabled, how to identify the node-level performance efficiency (w.r.t. HW capabilities)? And follow-up: is it planned to enable the HW counters access (what timeframe if yes)?
    -   There is no time frame as we don't know when the security concerns that triggered disabling them will be resolved.
        -   Can you please elaborate more on the security issue?
    -   We have representatives from the LUMI Support Team here but policies around the system are set by the CSC staff managing the system and they are not represented in this training, and even then might not want to comment. If you want to make your voice heard that this capability should be enabled then you could put in a ticket.
    -   (Kurt) I cannot really say much as this is decided and followed up by the sysadmins, not by us. It is well known however that hardware counters can often be abused to get information about other processes running on the CPU which can be abused. But as that should have been known already when LUMI was set up and the counters were enabled initially, it appears that there has been more than that, or active exploits, that may have driven that decision. I'd hope a solution could be that some nodes are set aside with exclusive use, but maintining different settings on different nodes of the same type is always risky by itself, and it may have been decided that you could still gain crucial information about the OS... LUMI is a shared machine so we also have to take the right for privacy and the fact that we also have to cater to industrial research into account and hence that safety of data of other users is important. A shared machine always comes with compromises...

15. Sorry, this question is still related to the CPU-GPU affinity check that I would like to run with an alternative approach than hello_jobstep. My concern is motivated by this result that I get when I check the affinity, by using a batch job and environmnet we are using for some tests on LUMI
    ```
    Lmod is automatically replacing "gcc/11.2.0" with "cce/14.0.2".

    ROCR_VISIBLE_DEVICES: 0,1,2,3,4,5,6,7
    MPI 000 - OMP 000 - HWT 001 - Node nid005031 - RT_GPU_ID 0 - GPU_ID 0 - Bus_ID c1
    MPI 001 - OMP 000 - HWT 002 - Node nid005031 - RT_GPU_ID 0 - GPU_ID 0 - Bus_ID c6
    MPI 002 - OMP 000 - HWT 003 - Node nid005031 - RT_GPU_ID 0 - GPU_ID 0 - Bus_ID c9
    MPI 003 - OMP 000 - HWT 004 - Node nid005031 - RT_GPU_ID 0 - GPU_ID 0 - Bus_ID ce
    ```
    
    Am I initializing something wrong in the environment? Do the MPI ranks see the same GPU? I see different BUS_ID
    
    -   (Alfio) Yes, indeed. These are different GPUs. What options slurm you are using?
    -   (Alfio) I see, you are using SLURM `--gpu-bind=per_task:1`. Although I am not sure SLURM does the right configuration, you should know that SLURM makes cgroups, so each rank gets its GPU, which has ID 0. So it seems fine. Note that in our examples we don't rely on SLURM options, but it is good you are testing the affinity program ;) (that's the goal of the entire discussion, always check!)
        ```       
        > #SBATCH --job-name=myjob2             # Job name
        > #SBATCH --partition=eap              # Partition (queue) name
        > #SBATCH --nodes=1                    # Total number of nodes
        > #SBATCH --exclusive
        > #SBATCH --ntasks-per-node=4          # Number of mpi tasks per node  -8va..
        > #SBATCH --cpus-per-task=1            # Number of cores (threads) per task
        > #SBATCH --gpus-per-task=1
        > #SBATCH --time=02:00:00              # Run time (d-hh:mm:ss)
        > #SBATCH --gpu-bind=per_task:1
        ```
    -   The ROCR runtime is enumerating the GPUS per task that are available.  So only one available and the numbering starts at 0.  You can see from the BUS ids in the output that there are different physical GPUs.
        -   I compared with another job script that follows your example, and I see the same bus_id for each rank of the naive example. So the CPU-GPU affinity is suboptimal (?) [rank 0 : GPU 0 , rank 1 : GPU 1 ...]
    -   (Alfio) same bus_id? Are you using select_gpu script? We don't rely on SLURM GPU affinity in our examples...
    -   I am intending to edit the acheck binding code to add GPU information, not done yet.
    

## Advanced performance analysis

16. Is there any user guide or tutorials for the advanced perftools (except the man/help pages of commands)?
    -   These slides are the best material
        -   Any plans?
    -   (Alfio) https://support.hpe.com/hpesc/public/docDisplay?docId=a00114942en_us&page=About_the_Performance_Analysis_Tools_User_Guide.html
        -   Thank you, looks nice
    -   There is more documentation on that site but it is a very hard one to find things on. There are, e.g., also PDF manuals.


### Exercise

!!! info "Exercises"
    General remarks:

    -   Exercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -   Directory for this exercise: `perftools`
    -   Copy the files to your home or project folder before working on the exercises.
    -   In some exercises you have source additional files to load the right modules necessary, check the README file.
    -   To run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_g.sh` (GPU) or `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU)

    Exercise:

    -   __Follow the Readme.md files in each subfolder of `perftools` and get familiar with the `perftools` commands and outputs__




