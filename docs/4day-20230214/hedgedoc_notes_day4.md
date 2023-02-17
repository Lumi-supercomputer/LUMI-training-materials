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

14. Related to the previous question on hardware counters. - if HW counters are disabled, how to identify the node-level performance efficiency (w.r.t. HW capabilities)? And follow-up: is it planned to enable the HW counters access (what timeframe if yes)?
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


## Introduction to AMD Omnitrace

19. Related again to the hardware counter issues: Is there a workaround to get at least some basic metrics, e.g. IPC or bandwidth, with the disabled counters?
    -   Not that I know. Sampling-based tracing cannot generate these. I'm not sure if the kernel setting has also disabled all hardware counters on the GPUs though, worth testing.
    -   Omnitrace does have a variety of data collection methods including hardware counters and sampling. Some of these capabilities are still available even if hardware counters are blocked. 

20. Is ommitrace installed on LUMI as a module?
    -   Not yet. It is installed in a project directory for the exercises following the talk.

### Exercise

!!! info "Exercises"
    Find the instructions [here](https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA?view#Omnitrace).
    Try the _Omnitrace_ section.

    The slides of the presentation are available on LUMI at `/projappl/project_465000388/slides/AMD/`


21. When can the users expect Omnitrace to become available? Okey, there is the easyconfig available in a branch omnitrace.
    -   We have two levels in the stack depending on how stable a package is, how many configurations are needed to cover all uses, and to what extent we can offer support for it. The reality is that we get requests for so many different tools that we can no longer follow it all with the central support team, let alone update it every time a new version of the PE is installed, and users would already want this to also happen more frequently.
        -   The answer in the Zoom session went far from the question. Simply was asking, if you will provide the eb file. But I found it. ~~https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib/blob/omnitrace/easybuild/easyconfigs/o/omnitrace/omnitrace-1.7.3.eb~~
    -   Yes, we are looking into it. No committed date yet, when it will be ready. The version you refer to above is not supported and in a branch where development happens.
    - You can try to install it with the `spack` module also, but when I tried right now (`spack install omnitrace`) the installation failed ("missing boost"), likely some problem with the upstream package.py.

22. I am having an issue trying to allocate resources `salloc: error: Job submit/allocate failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)` even trying for 10 mins allocation.
    -   The lumi_g.sh file in the HPE exercises directory will setup Slurm for the LUMI-G nodes using the course project etc. If you have not loaded that can you share the Slurm options you used?
        -   Used before, with sourced the lumi_g , now after re-sourcing it returns: 
            ```
            salloc: error: Job submit/allocate failed: Requested node configuration is not available
            salloc: Job allocation 2933626 has been revoked.
            ```
            I am trying `salloc -N 1 -p small-g -t 120:00 -A project_465000388`

    -   Did you have a previous salloc active? Yes and I cancelled it with `scancel <jobid>`.

23. I am trying "srun -n 1 --gpus 1 omnitrace-avail --categories omnitrace", but an error message is generated "/project/project_465000388/software/omnitrace/1.7.3/bin/omnitrace-avail: error while loading shared libraries: libamdhip64.so.5: cannot open shared object file: No such file or directory" +3
    -   some hip module missing?
        -   `module load rocm` seemed to fix it
    -   yes, should be mentioned in the instructions..

24. Is this output expected?
    ```
    srun -n 1 omnitrace-avail -G omnitrace_all.cfg --all
    /project/project_465000388/software/omnitrace/1.7.3/bin/omnitrace-avail: /project/project_465000388/software/omnitrace/1.7.3/lib/libroctracer64.so.4: no version information available (required by /project/project_465000388/software/omnitrace/1.7.3/bin/omnitrace-avail)
    /project/project_465000388/software/omnitrace/1.7.3/bin/omnitrace-avail: /project/project_465000388/software/omnitrace/1.7.3/lib/libroctracer64.so.4: no version information available (required by /project/project_465000388/software/omnitrace/1.7.3/bin/omnitrace-avail)
    [omnitrace] /proc/sys/kernel/perf_event_paranoid has a value of 3. Disabling PAPI (requires a value <= 2)...
    [omnitrace] In order to enable PAPI support, run 'echo N | sudo tee /proc/sys/kernel/perf_event_paranoid' where N is <= 2
    [omnitrace][avail] No HIP devices found. GPU HW counters will not be available
    ```
    - I'm afraid you may not have loaded ROCm properly into your environment.
    - I loaded rocm/5.0.2 module and exported the PATH and LD_LIBRARY_PATH environments as mentioned in instructions in an interactive job (salloc)
    - What was your salloc command?
        - just sourced lumi_g.sh with longer walltime
    - (Alfio) see previous questions on hardware counters, PAPI events are not available on LUMI. 
      Have you added `--gres` option to allocate GPUs?
        - I'm aware of that, but not sure if related to e.g. ```no version information available``` or ```No HIP devices found```
        - with ```srun -n 1 --gres=gpu:8  omnitrace-avail -G omnitrace_all.cfg --all``` the command hangs after the "PAPI not supported" lines



## Introduction to AMD Omniperf

25. What is the issue with the GUI of OmniPerf?
    -   It is browser based and starts a web server. The port on which the server runs is very easy to guess as the software uses a deterministic rule to try out ports, and access to the port is not protected by a password or better mechanism, so it is very easy to hack into an OmniPerf session of another user. As a support team, we do not want to take any responsibility for that so will not support it until better security in the package is in place.

        If you run the GUI on your laptop it might be best to ensure that access to your laptop is also restricted by a firewall or other people on the network you're on might be able to break into your session. 

26. I find this tool very interesting, is there any HPC site supporting it? (centralized support)
    -   I don't know, I also cannot find the tool in the Frontier documentation so we are likely not the only one with concerns...
    -   ORNL has the tool they used it to many hackathons 
    -   https://www.olcf.ornl.gov/wp-content/uploads/AMD_Hierarchical_Roofline_ORNL_10-12-22.pdf they had also an event just for roofline

27. When I am executing "srun -n 1 --gpus 1 omniperf profile -n vcopy_all -- ./vcopy 1048576 256", an error is generated "ROOFLINE ERROR: Unable to locate expected binary (/pfs/lustrep1/projappl/project_465000388/software/omniperf/bin/utils/rooflines/roofline-sle15sp3-mi200-rocm5))." It looks like : "ls: cannot access '/pfs/lustrep1/projappl/project_465000388/software/omniperf/bin/utils/rooflines/roofline-sle15sp3-mi200-rocm5': Permission denied"
    -   Permissions on the file are indeed wrong, I've messaged the owner of the files to change them.
    -   Try again please
        -   yes, it works OK now


## Tools in Action - An Example with Pytorch

28. Can we get ROCm 5.3.3 on the system?

    -   It is there but we cannot guarantee it will always play nicely with the HPE Cray PE nor that it will always work correctly as in the past there have been problems with hard-coded paths in some libraries etc. We cannot actively support it.
    -   It is available in the CrayEnv or LUMI/22.08 + partition/G environments.

        ```
        module load CrayEnv
        module load rocm/5.3.3
        ```
        or
        ```
        module load LUMI/22.08
        module load partition/G
        module load rocm/5.3.3
        ```
        
        Note that, with MIOpen and this module, you will use the rocm installed in `/opt/rocm` for kernels JIT compilation due to some hardcoded paths in the MIOpen library.
    
29. This looks really interesting, can the presentation be uploaded?
    -   As with all presentations the video will be uploaded some time after the session. Slides should come also but they have some problems with slow upload speed from the machine from which they were trying.
        -   Thanks   

30. (Harvey) Loved the srun command which flew by too fast to catch fully, I adapted it a little to avoid the hex map...
    ```
    > srun -c 7 -N 1 -n 4 bash -c 'echo "Task $SLURM_PROCID RVD $ROCR_VISIBLE_DEVICES `taskset -c -p $$`"' | sed 's/pid.*current //'
    Task 0 RVD 0,1,2,3,4,5,6,7 affinity list: 1-7
    Task 2 RVD 0,1,2,3,4,5,6,7 affinity list: 15-21
    Task 3 RVD 0,1,2,3,4,5,6,7 affinity list: 22-28
    Task 1 RVD 0,1,2,3,4,5,6,7 affinity list: 8-14

    ```

31. A late question on Perftools... should I use a particular approach if I compile my app with autotools? Or loading the module is enough?
    
    -   If you pass the compiler wrappers to configure script, i.e., `CC=cc CXX=CC FC=ftn F90=ftn` it should be enough to load the module. 
    -   One small caveat: some autotools (and the same for CMake etc.) installation "scripts" do not follow all the conventions of those tools and in that case there can be difficulties. I have seen tools that had the compiler name or compiler options hardcoded instead of using the environment variables...
        -  I confess I raised this question because I was trying measuring the application with perftools-lite, but without instrumenting and I get no report. Compiling with the module loaded fails but I did not reconfigure
    -   Then it is rather likely you were using the system gcc, or if you were using PrgEnv-gnu it may have found that gcc. That is usually first in the search list when autotools tries to locate the compiler itselves. Which is kind of strange as the original name of the C compiler on UNIX was actually `cc` (but there was no C++ in those days, when dinosaurs like "Mainframus Rex" and "Digitalus PDP" still roamed the earth).
        -   I am afraid is something nastier.. is parallel compilation discouraged with instrumentation?
    -   For C or C++ code it would surprise me, but for fortran code parallel compilation (if you mean things like `make -j 16`) does not always work, independent from the fact that you are using instrumentation.   
        -   It is Fortran.. hope sequential compilations solves, thank you for the help!
        -   sequential worked, at least to compile.. Can I understand somehow that the binary is instrumented? From ldd *.exe I don't know what to look for.
    -   In a very simple Fortran test program that I tried, I see that among others `libpapi.so.6.0` is now shown in the output of `ldd` which is definitely a library that has to do with instrumentation.

32. When we are pip installing a package that requires some compilation step using PyTorch as dependency (e.g. https://github.com/rusty1s/pytorch_scatter), what is the preferred approach to make sure that we are using the right compiler and flags for LUMI?
    -   There is unfortunately no fixed rule for Python. There are compilers hard-coded in a Python configuration file, but not all install scripts for `pip` look at these. Others will honour the environment variables given in the previous question. As a software installer, I despise Python as installing packages has become a complete mess with like 10 different official ways of installing packages in as many different styles of installation and yet packages that find something else to try. So it is sometimes really a case-by-case answer. And given that AI applications have a tradition of coming up with strange installation procedures...
    -   Please send us a ticket if you want us to have a closer look. We need more time than what such a QA provide to give you a proper answer regarding this particular package.
        -   Thanks, will do! I completely agree with the broken packaging and distribution system of Python, but it seems that they are trying to amend with some recent PEPs (don't remember the numbers though).


## General Q&A

33. For how long the access to this course account at lumi (project_465000388) and materials (in particular, to go through all exercises) will be available after the last day of the course? Do we expect to have updated instructions/ guidelines (cleaned from "bugs" & more clearly written text) for exercises? or still to follow the older versions (and trying to find on what was/is missing and to fix somehow)?
    -   The data: I think for three months at least. But access to the compute time allocated to the project ends automatically at the end of the day.
        -   It would be really valuable if we could run the exercises for 1-2 more days 
        -   Agree (Thanasis) - keep it running for the weekend (+1)

34. Is this example Samuel is showing available somewhere?
    -   not the large example which was used to show a real application
    -   He promised a smaller example (easier managable) applicable to LUMI. Looking forward for that.

37. Can we get examples from Samuel's presentation?
    -   I can share scripts and slides - the application would need to go with something more simple with no license issues.
        -   Thanks alot
    -   Look in `/project/project_465000388/slides/AMD/pytorch-based-examples`

35. When compiling for LUMI AMD GPU, what is the difference between the flags `--offload-arch=gfx90a` and `--amdgpu-target=gfx90a`? (sorry for the mistake)
    -   Answer from AMD in the session: `--amdgpu-target` is the older one that is deprecated.
    -   I saw it when compiling pip packages (see above) as output when `--debug --verbose` and on the frontier docs.
        -   OK, thanks 

38. Are there BLAS / LAPACK besides Cray LibSci available? 
    -   Both OpenBLAS and BLIS tend to work well by themselves on LUMI (for CPU calculations), but watch out if you mix e.g. OpenBLAS and LibSci because they can contain identical symbols. Intel MKL works, in some cases, with some "hacks", but it can be difficult, hit and miss...
        -   In which module are they included?
    -   You can install some of them in your own home/project directory with Spack if you want, e.g. `spack install openblas`.
    -   And there are EasyBuild recipes for some of them also, check the [LUMI Software Libary](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/) mentioned a few times over the course, but these will almost certainly cause problems when linked with other modules build with EasyBuild that employ BLAS or Lapack (but then the same would hold if you would start mixing spack generated libraries that are generated with a different BLAS and/or LAPACK library). We do not install software that so clearly can conflict with other software that we installed in the central stack.
        -   Ok, thanks. 

39. It would be cool to have a GH repo for the docs where we can send pull requests to.
    -   Our docs are hosted on GH and you can find the link in the bottom right (click on the little GH logo). https://github.com/Lumi-supercomputer/lumi-userguide/
    -   Pull request are of course the best but we are also grateful for issues about improvements or topics missing.
        -   Very cool thanks! p.s. are typos fixes also accepted?
    -   Sure. We will carefully review all PR and if we can support the changes, we will definitely merge it.

40. We are porting an C++ MPI app to LUMI and getting MPI errors like:
    (Cray MPI)
    ```
    Assertion failed in file ../src/mpid/ch4/netmod/include/../ofi/ofi_events.c at line 379: dtp_ != NULL
    MPICH ERROR [Rank 1800] [job id 2932607.0] [Fri Feb 17 14:38:57 2023] [nid001179] - Abort(1): Internal error
    ```
    or (AOCC)
    ```
    MPICH ERROR [Rank 6088] [job id 2618312.0] [Sun Jan 22 20:58:44 2023] [nid001271] - Abort(404369807) (rank 6088 in comm 0): Fatal error in PMPI_Waitany: Other MPI error, error stack:
    PMPI_Waitany(277)..............: MPI_Waitany(count=13, req_array=0x2b7b970, index=0x7ffcc40da984, status=0x7ffcc40da988) failed
    PMPI_Waitany(245)..............: 
    MPIDI_Progress_test(80)........: 
    MPIDI_OFI_handle_cq_error(1062): OFI poll failed (ofi_events.c:1064:MPIDI_OFI_handle_cq_error:Input/output error - PTLTE_NOT_FOUND)
    ```
    
    -   Please submit a ticket.
        -   ok
    -   We've had the same issue and opened a ticket but as you say the team is small and could not really dive deep because any suggestion the LUST team offered did not work. Would be interested it this problem is resolved.
        -   Can you write the ticket number here, will review next week (or as per comment below)
            - "LUMI #1059 MPICH errors". Send by my colleague at UCL
    -   This is an issue that probably requires a software upgrade that is outside the control of LUST. Sending a ticket is still useful as it help us detect recurring issues. The issue is with HPE already and discussed with the HPE person that assists the sysadmins as the OFI poll errors are very low level. They also often result from a failure on another node of your job. 

        These errors are also not related to any specific compiler but come from errors that occur in layers underneath the MPI libraries.










