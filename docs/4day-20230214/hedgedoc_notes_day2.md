# Notes from the HedgeDoc page

These are the notes from the LUMI training,
1114-17.02.2023, 9:00--17:30 (CET) on Zoom.

-   [Day 1](hedgedoc_notes_day1.md)
-   [Day 2](hedgedoc_notes_day2.md): This page
-   [Day 3](hedgedoc_notes_day3.md)
-   [Day 4](hedgedoc_notes_day4.md)

## OpenACC and OpenMP offload with Cray Compilation Environment

1.  Can you have both OpenMP and OpenACC directives in a code (assuming you only activate one of them)?
  
    -   Yes. This is quite common to mix OpenMP for multithreading on  the host and OpenACC for the device. For OpenMP and OpenACC, both on the device, yes you can selectively select one of the other using macros. Note that OpenACC is enabled by default for the Cray Fortran compiler so if you don't want to use OpenACC you have to explicitly disable it. OpenMP need to be enabled explicitly.

2.  Are there features in OpenACC that are not available (and not planned) in OpenMP?
    -   I will raise this at the end of the talk.
        -   Thanks for the answer. Very useful.
    -   In practice, we have seen that people only stay with OpenACC if they already have in their (Fortran) code (i.e. from previous work with enabling Nvidia GPU support), new porting projects tend to choose OpenMP offloading. 
        -   Follow-up question: How is the support of OpenACC vs OpenMP in compilers. I would maybe expect that OpenMP would be more widely supported, now and especially in the future?
    -   The assumption is correct, OpenMP is the target for most compilers. As far I know, GNU will target Mi250 in GCC 13. I'm not aware of a real OpenACC in GNU. NVIDIA is supporting OpenACC for their compilers.

3.  What gives better performance on LUMI-G OpenMP offloading or OpenACC offloading? (C/C++)
    -   There is no OpenACC support for C/C++.
    -   Hypothetically speaking, there is no big performance difference between OpenACC and OpenMP offload in theory, sometimes they even share the same back-end. In practice, OpenMP offers somewhat more control at the programmer level for optimizations, whereas in OpenACC, they compiler has more freedom in optimizing.

4. T his is not related to the presented topic, but every time I login to Lumi I get this message: "/usr/bin/manpath: can't set the locale; make sure $LC_* and $LANG are correct", how can I fix it?
    -   I think I saw that on Mac ssh consoles
        -   I am using a Mac, so that is probably related
    -   I have had the same problem before and fixed it by adding `SendEnv LANG LC_*` in my SSH config file.
        -   Will try that - No difference
            -   Did you simply add a line in the .ssh/config with `SendEnv LANG LC_*`?
    -   The other problem that I have also had on a Mac was that it had sent a locale that was not recognized by the system I was logging on to.
        -   Nothing seems to fix it, I will leave it like that for now since it does not affect anything else

6.  Working on a Fortran+OpenACC+hipBlas/hipFFT code which has currently a CPU and a GPU version. The two versions have become very different: CPU version has lots of function calls inside the OpenMP loop. GPU version has all the parallelism at the lowest level. Looking for ways to get back to one code base. Any chance to use craype-accel-host to get good performance on CPU and GPU targets?!
    -   the host is not meant to be for performance, for instance it will likely use a single thread. Check the man page intro_openmp for more details.
    -   How to (best) organize the code to support multiple GPU architectures is still an open question. Before, you could "get away" with only having support for 1 type of GPUs, and have that as a special branch of compilation, but with several types of GPUs and/or accelerators in the future (at least Nvidia, Intel, AMD...) it will become more difficult to do it like that. I have seen a few projects with successful support of several kinds of accelerators, what they typically do is to abstract it to a common matrix/vector library in the application (a "matrix class" or similar) and then have this module support different GPU/accelerator backends (including pure CPU execution).
        -   Yes, this a common issue. Moreover, it you have multiple libraries accessing to the GPU, they don't talk each other (even worse for a multi-gpu case), so memory pooling is quite difficult. 

7.  Can we print out some of the slides from yesterday, for personal use? "Programming Environment and Modules"
    -   Sure, but please do not redistribute the digital form.
        -   Ok, thank you.
    -   The HPE slides and exercises can be copied for personal use by people attending the course. Some of the exercise examples are open source and were downloaded from the relevant repositories.

### Exercises

!!! exercise
    -   Exercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -   Directories for this exercise: `openmp-target`, `openacc-mpi-demos`, `BabelStream`
    -   Copy the files to your home or project folder before working on the exercises.
    -   In some exercises you have source additional files to load the right modules necessary, check the README file.
    - T  o run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_g.sh` (GPU) or `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU)

    Try different parallel offload programming models (openACC, OpenMP, HIP) and examples.



1.  Has anything changed in the exercise files since yesterday, i.e., should we update our copy?
    -   Probably no changes to these folders but better copy again. Some other files for later changed.

2.  Are there job scripts available for today's exercise or I make them myself ?
    -   they are available (follow the readme)
    -   readme says Execute ... srun -n1 ... 
    -   yes, correct. If you would like to submit (they are quite short runs), you can use one of the yesterday batch script.
    -   sorry, in my build/ there is no file ctest; nto sure I understand what to submit +1
        -   ctest is a command, it will run the tests produced by cmake. If you are interested in the single binaries, then they are in the directories `build/tests/bin`. Otherwise ctest will execute all.
    -   test all worked; thanks
    -   Might be an easy one, sorry: I got the return that No partition was specified. Has anyone experience with that?
        -   Need to source the lumi_g.sh file to get SLURM configurtion.
    -   is there a useful sequence in which to study the tests/*/.cpp s ? Seem many of those
        -   So, check the original code at https://github.com/ye-luo/openmp-target. The idea is to check OpenMP offload functionalities and check if they are supported by Compilers. If the tests are OK, then the assumption is that the compile is working.
        -   The exercise is not to understand the workings of the source files ? but to apply this comprehensive test then ? (tests were all passed according to job output)
            -   It depends if you want to understand how OpenMP works, then you are welcome to check the code, sure. Otherwise the exercises is to give examples on how to use the Offload OpenMP with CCE.
            -   okay, got it, thanks.

3.  In openmp-target exercise I got the following error after the last make command "An accelerator module must be loaded for the compiler to support "target" related directive !$OMP TARGET"
    -   Have you loaded the GPU module? (`source setup_modules/setup_LUMI-G.sh`)
    -   I use the command "source /project/project_465000388/exercises/HPE/lumi_g.sh"
        -   This one is to set SLURM, you need to set the modules for the GPU (a different file)

4.  Modules were loaded, but `make` couldn't find the compiler - BabelStream
    -   Which example are you trying to run? 
    -   What's the error? could check the modules too? 
        -   `Currently Loaded Modules:1) libfabric/1.15.0.0   3) xpmem/2.4.4-2.3_9.1__gff0e1d9.shasta       5) LUMI/22.08        (S)   7) craype-accel-amd-gfx90a 2) craype-network-ofi   4) partition/L`
        -   You are missing PrgEnv-cray...

6.  Inside the `makefile` of `/exercises/HPE/openacc-mpi-demos/src/`, there are some comments after FC and FFLAGS. Are they meant as a guide for something?
    -   Those examples are taken from https://github.com/RonRahaman/openacc-mpi-demos which uses the NVIDIA compiler as baseline. I agree that I can remove the comments... Sorry for the confusion.
        -   Thanks, actually I find those comments useful, I might try in a machine with NVIDIA. Some comment that these are for NVIDIA would clarify things.
    -   Then you are welcome to use the original code. Note, it requires the nvidia compiler (previously PGI).

7.  In BabelStream example, the OpenMP compilation (with `make`) gives an error:
    ```
    CC -fopenmp -O3 -DOMP src/main.cpp src/omp/OMPStream.cpp -I src/ -I src/omp -DOMP_TARGET_GPU -o omp.x
    warning: src/omp/OMPStream.cpp:108:3: loop not vectorized: the optimizer was unable to perform the requested transformation; the transformation might be disabled or specified as part of an unsupported transformation ordering [-Wpass-failed=transform-warning]
    ```
    The HIP compilation works fine.
    -   this is a warning. It says that it cannot vectorize the loop (O3 enables vectorization), but this is fine since we are running on the GPU anyway. BTW, if you want to inspect more, I suggest to add the listing flag (-fsave-loopmark) to get more info.
        -   I added the flag in Makefile (CC -fopenmp -O3 -fsave-loopmark -DOMP src/main.cpp src/omp/OMPStream.cpp -I src/ -I src/omp -DOMP_TARGET_GPU -o omp.x) but the output is the same as before
    -   It will generate a file .lst that you can inspect and get more info.
        -   Ah, ok, thanks
                
8.  In BabelStream, the OpenMP code OMPStream.cpp, there is #pragma omp target enter data map... I assume this defines mapping of data onto devices. Where is the device list for OMP further defined in the code? or is this all?
    -   This is an OpenMP question, actually. With the call `pragma omp target enter data map(alloc: a[0:array_size], b[0:array_size], c[0:array_size])` (line 31) you map those data to the GPUs (it does allocate them). Then there will be an `#pragma omp target exit data map(release: a[0:array_size], b[0:array_size], c[0:array_size])` (line 46) to release the data. Then, the way OpenMP offload works is that if you do another map for the same data, OpenMP will check that data exists already on the device and it will reuse those allocations.
        -   Thanks! Could you please clarify where is the device list itself defined in the code, so that OMP knows which devices it should map the data to?
    -   This the default device, i.e. device_id 0.
        -   Ahh, ok, thanks. I saw this device_id 0, but I thought it can't be so easy :)
    -   Yeah, it is done via `omp_set_default_device(device);` (line 26). You can also use the clause `device` (this is for multi-gpus, actually).
        -   the id 0 means graphic card 0 on a multi-card node?
    -  It is part of the current talk. It is GPU 0, but then you can set `HIP_VISIBLE_DEVICES=2` and OpenMP will have GPU_ID=0 for the device 2 (maybe I'm confusing you). The point is that OpenMP uses at runtime the available GPUs, provided by ROCM. But then you can change the GPU order via `HIP_VISIBLE_DEVICES=1,0`. Wait for this afternoon exercises...
        -   perfect, thanks!


## Advanced Application Placement

16. I was a bit confused by this definition of CPU. Can it be repeated and expanded?
    -   I have uploaded the talk
    -   We will try to use cpu in this talk to mean what Linux calls a cpu which is a hardware thread in a core - so 2 per core. 

17. Could it be the case that when a thread needs to access data in a remote cache (different core), OS rather migrates the thread instead of accessing (or even copying) the data? I'm suspecting such a behavior since sometimes pinning threads is slower than allowing OS to migrate them inside a NUMA domain. Any suggestions what to check?
    -   Well, this is definitely the case. Within the same NUMA can be a good trade-off. This is a bit experimental, you have to try which affinity is best for you.

18. Any possibility to identify who did a binding (the different SW components)?
    -   You can get various components to report what they did (Slurm/MPI/OpenMP) but in general anything can override the binding or at least further constrain it. This is why it is good to run an application (as a proxy for your own) from your job script to double check this.
    -   It is not obvious when it comes to frameworks and applications that do their own thing to set the binding. We are covering MPI, MPI/OpenMP as they are the most common. We can at least use Slurm to set the binding of any process it starts and as long as that keeps within the binding it was given that at least gives us some control.
    -   In general, there is no trace on what is setting the binding...
 

### Exercises

!!! exercise
    -   Exercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -   Directories for this exercise: `XTHI` (try out application) and `ACHECK` (pdf doc & application similar to xthi but nicer output)
    -   Copy the files to your home or project folder before working on the exercises.
    -   In some exercises you have source additional files to load the right modules necessary, check the README file. __Check that you don't have unnecessary (GPU) modules loaded.__
    -   To run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU)

    Try different parallel different binding options for CPU execution (look at slides and use envars to change and display the order

19. Is it common to use different bindings depending on the size of the computations? 
    -   No sure I understand the question on what you mean by "different". Usually you have to check the best match for your application. For example, if you are memory bound, then you may decide to spread your threads such that they will use multiple memory channels.
    -   The most common situation at scale is just to fill up multiple nodes using cores in sequence and if you use threads then choose OMP_NUM_THREADS so tasks fit nicely in NUMA regions and don't span them. It is when you want to do something special where other options come into play.

20. While compiling xthi.c I got the following error
    ```
    ld.lld: error: undefined symbol: omp_get_thread_num
    >>> referenced by xthi.c
    >>>               /tmp/xthi-c56fa1.o:(main)
    clang-14: error: linker command failed with exit code 1 (use -v to see invocation)
    ```
    -   Sorry, the readme is missing `-fopenmp`.
        -   I'm a bit confused, the Cray cc wasn't supposed to have openmp ON by default?
    -   Only OpenACC is the default.
    -   Not anymore, but it was before yes !

21. I'm trying the example ACHECK and I get `./acheck-cray: error while loading shared libraries: libamdhip64.so.5: cannot open shared object file: No such file or directory`. I have done `source /project/project_465000388/exercises/HPE/lumi_c.sh`. What am I missing here ?
    -   I think you will need to `source /project/project_465000388/exercises/HPE/lumi_g.sh` instead to get the relevant modules for the GPUs.
    -   Those modules are setting the SLURM environment. I assume you have the GPU modules loaded. Please, unload them, recompile and run.
    -   I suggest you do the exercise on LUMI-C for this session.  Perhaps you built it with gpu modules and are running on LUMI-C.  (it would work on LUMI-G if you have LUMI-G Slurm and modules setup but there is no need to)

22. Why? -> slurmstepd: error: execve(): xthi.c: Permission denied!!!
    -   are you using the provided job.slurm?
        -   yes
    -   I have the following there:
        ```
        #!/bin/bash

        #SBATCH -t 1

        export OMP_NUM_THREADS=1

        echo srun a.out
        srun a.out | sort
        ```
        then ou have to run via `sbatch job.slurm`. Is it what you are doing?
        -   a.out I have change it to xthi.c as the above script cause an error "execve(): xthi: No such file or directory"
    -   Put it back to a.out...
        -   Error: execve(): xthi: No such file or directory
    -   OK, you compile and it will produce a.out, do you have it? Then, `sbatch job.slurm` will submit it. The job.slurm above doesn't mention any `xthi`, so I don't know where you error is coming from...

        ```      
        #!/bin/bash

        #SBATCH -t 1

        export OMP_NUM_THREADS=1

        echo srun a.out
        srun a.out | sort
        ```        

        -   Sorry, this is the error : 
            ```
            srun a.out
            slurmstepd: error: execve(): a.out: No such file or directory
            srun: error: nid005032: task 0: Exited with exit code 2
            srun: launch/slurm: _step_signal: Terminating StepId=2876961.0
            ```

    -   Then you have to compile first...
        -   when i try to compile i got 
        -   ld.lld: error: undefined symbol: omp_get_thread_num
    -   Need to add -fopenmp flag. I've update the Readme.
        -   I cant see the update letme try copy it again
        -   Done, thank you

23. I tried "cc -fopenmp xthi.c " but got many errors like "xthi.c:65:27: error: use of undeclared identifier 'hnbuf'
            rank, thread, hnbuf, clbuf);
            "
    -   Need to set for LUMI_C. Unload the GPU modules and recompile.
        -   Yes.. I use "source /project/project_465000388/exercises/HPE/lumi_c.sh"..still the same error.
    -   This is for setting SLURM stuff. Do you hav ethe modules `rocm` and `craype-accel-amd-gfx90a`? If so, please unload them and recompile.
        -   Now I got the error "fatal error: mpi.h: No such file or directory"..
    -   Which modules do you have? I suggest to open a new and fresh terminal connection...
        -   Got it ..working now

24. Run make on _openmp-target_ and it went well. Next ran
    ```
    srun -v -n1 --gres=gpu:8 ctest
    srun: error: Unable to allocate resources: Requested node configuration is not available
    ```
    What node configuration was it looking for or is there a way to see what is required there.
    should we swap back to rome for that use case : _swap craype-x86-rome craype-x86-trento_
    -   openmp-target example is usig GPU. Are you setting SLURM for the GPU nodes (script lumi_g.sh)?


25. Is the Lumi-D partition mentionned yesterday accessible now to try, or should we make a new application for that?
    -   There is a session this afternoon describing the LUMI environment in detail, suggest you ask again if this is not covered there.
    -   LUMI-D is two things:
        -   The large memory nodes that are available and have the same architecture as the login nodes
        -   The visualisation nodes. They were releases again on February 13 but have hardly any software installed at the moment.
            Given the relative investment in LUMI-G, LUMI-C and the visualisation nodes it is clear that they won't get too much
            attention anytime soon.

26. Bit Mask: Slurm Script -> sbatch: error: Batch job submission failed: Requested node configuration is not available, why?
    -   is the SLURM setting done? (script lumi_c.sh)
        -   Yes, i will do it again
    -   Could post the job.slum script?
        -   I just copy and paste from slides, am I correct? page 50
    -   let me try... Works for me. 
        -   please share job.slum.
    -   There are other problems that I'm investigating. but at least I can submit it. Check at `/pfs/lustrep1/projappl/project_465000388/alfiolaz/training_exercises/XTHI/mask.slurm`


## Understanding Cray MPI on Slingshot, rank reordering and MPMD launch

27. Is the overlap really happens in practice? Or only when there is extra core available with openmp?
    -   Threads have little to do with cores. One core can run multiple threads, but in case of computational threads this is not a good idea as they will fight for the cache. But having a background thread on top of a computational thread is sometimes a good idea. And actually a good use of hyperthreading also (using the Intel term, AMD calls them SMT I believe)
    -   And sometimes part of the background work is also done by the network adapter, which should be the case for SlingShot 11.
        -   Is there a way to check that the communications really happen while the computation is done and not just at the mpi_Wait?
            - No, unfortunatelly
        - Some answers were given at slides 21-24. 

28. Could one for example use a hyperthread for a MPI async thread even if the application doesn't use hyperthreading?
    - Yes, but likely it would not help that much


29. In terms of overlapping computation/communication, what happens when one uses neighbourhood collectives? They have the non-blocking alternative and all processes involved know who they are sending to and receiving from. eg: MPI_Ineighbor_alltoall
    - I'm not sure that we provide special optimizations for those collectives. I assume it is just like all others... It is worth to try!
        - MPI expert reply: We do support non-blocking neighborhood collectives. They are functional but not super optimized. If there are specific use cases then we suggest to open a ticket and we can investigate more.
    - I understand that the nonblocking collectives can be progressed by the progress thread, the neighbourhood collectives are much newer to I'm not sure of the status of that.
    
30. With NVIDIA gpu-aware MPI, MPI calls perform a whole-device barrier call before/after the communications, rendering async calls ... not async. Does LUMI's implementation do the same?
    - I'm not sure if we do the same blocking, but the LUMI design is different and NIC are attached to the GPUs memory directly. As far I can see, we use streams for the communications, so it should not be blocking.
        - MPI expert reply: Cray MPI does not do a device-level barrier before/after sync. More specifically, we do not do a hipStreamSynchronize before/after MPI. But, an application still needs to do a device-level sync on their own to make sure specific compute kernels have completed and the buffers used for MPI ops are correctly updated before MPI ops can be issued. They need to do MPI_Waitall to make sure MPI non-blocking ops have completed. They do not have to do a cuda(hip)StreamSynchronize/cuda(hip)DeviceSynchronize before starting the next round of kernels.
    -   Is there a way for the user to interact with the stream used by MPI, or to direct MPI to a specific stream?
        - I don't think so, at least the man page doesn't report any hint for that.

31. How many times does rank re-ordering really helped in performance according to your experience?
    - Answered by the speaker: HPE Cray's internal benchmarking team has found it useful on many occasions.

32. I asked this yesterday and understand that is "difficult" to use MPMD on LUMI-C and LUMI-G at the same time which I hope will change. Can you comment on that?
    -   I've basically said everything I can say about that yesterday. It is not an MPI issue but an issue with the way the scheduler works when different parts of the job run in different partitions.
        -    Does difficult effectively mean impossible? If not, are there any tricks to make it work better?
    -   It is just not well-tested. Remember that LUMI-G is very new, so there has simple not been enough time and/or people trying it out to establish "best practice" yet. We need brave users (like you!) to try it out and bring some feedback.
        -   :+1:
    -   (Kurt) I don't think the previous remark is right. From the technical staff of LUMI I heard that the problem is that if a job uses 2 (or more) partitions, it does not follow the regular route through the scheduler but uses backfill slots.

33. Related to question 30, what is the recommended way on LUMI to perform async communications between GPUs, ideally with control of the GPU stream, sot that the synchronisation is done in the background and we avoid the latency of StreamSynchronise. GPU-aware MPI? RCCL? One-sided MPI? 
    -   RCCL is not really MPI. Then, GPU-aware uses a special library (called GTL = GPU Transfer library), so MPI P2P and one-sided follows the same route. I don't think you have controls on streams used in the MPI.
    -   RCCL allows asynchronous control of the streams and also computes the collective on the GPU. 
    -   The problem of RCCL is that you have to use the Slingshot plugin to use the network, otherwise it would not work (and it is only collectives, btw). I would stick with MPI, unless yo have an application which already uses RCCL...
        -   Is the Slingshot plugin bad? at the moment, I can choose between RCCL (I cannot use collectives, so I use ncclGroupStart), CPU-based MPI and GPU-aware MPI in my app, but all of these options are kind of unsatisfactory at the moment. (CPU-based MPI is the fastest...)
    -   Then, I suggest to open a ticket and ask help for your particular case... without knowing the details is hard to reply.
        -    ok, thank you, I'll do that. 
    -   There are good reasons to use RCCL over MPI - you can have collectives queued in the device while previous compute are being done. This is important for latency bound codes. The plugin should work well. I'm only aware of a bug that can be exposed with heavy threading - but that is a libfabric bug not really a plugin bug. RCCL also allows point to point.
     -   This is a good question and in fact is the low-level layer I alluded to in the presentation without naming it. At the moment I'm inclined to say we have to look at this on a case by case basis.
         
34. What benchmarks for async MPI (comp./comm overlap) are you exactly referring?
    -   Who are you asking? I did not mention a benchmark in the talk other than the osu on or off device bandwidth test.
        -   I was asking Harvey. Sorry, I thought you said some people are doing benchmarking on MPI communication and computation overlapping. I'm quite interested in enabling that. Do you know any materials or examples how exactly this should be implemented (e.g. the use of buffers that you mentioned), configured, and checked?
    -   (Alfio) A lot of work in this context was done in CP2K code. Unfortunately, there are no special tricks. For large message MPI will wait... It depends on your case.
        -   my usecase is grid based algorithm (LBM) with a process sending rather small messages only to neigbours (stencil) but in very short timesteps, meaning the MPI latency is significant for large scales. My feeling is it is suitable for the overlapping, but not sure how to enable that.
        -   And follow-up question: why the expected improvement is only 10-15% (as mentioned)? I would expect theoretically near to 100% overlap in case of sufficient computation portion (similar to GPU computation/data transfer overlaping)
    -   (Peter): I interpreted what Harvey said as 10-15% application performance improvment. So even if the MPI communication is improved a lot, there is still compute to do...
        -   thanks, then that really depends on application, not sure about the numbers. Any suggestions about the material requested?
    -   (Harvey) I'm just reporting examples people have mentioned to me, that does not mean that you can't do better, as with all optimizations it all depends on the specific situation.


### Exercises

!!! exercise
    -   Exercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -   Directories for this exercise: `ProgrammingModels` or any other you want to try.
    -   Copy the files to your home or project folder before working on the exercises.
    -   In some exercises you have source additional files to load the right modules necessary, check the README file. __Check that you don't have unnecessary (GPU) modules loaded.__
    -   To run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU) or `
    ` (GPU).

    Suggestions: 

    1.  Test the Pi Example with MPI or MPI/openMP on 4 nodes and 4 tasks
    2.  Show where the ranks/threads are running by using the appropriate MPICH-environment variable
    3.  Use environment variables to change this order (rank-reordering)

    __Alternatively__: Try different different binding options for GPU execution. Files are in `gpu_perf_binding`, see `Exercise_day1-2.pdf` (`/project/project_465000388/slides/HPE/`)
:::


35. I did not understand how to generate the report for gpu binding, sorry. Is there a script or are we still using xthi?
    -   This is the hello_jobstep tool, xthi does not report anything about GPUs
        -   Thank you!
    -   You can also find it here https://code.ornl.gov/olcf/hello_jobstep/-/tree/master

36. went through the exercise pdf steps; but get HIP Error - hello_jobstep.cpp:54: 'hipErrorNoDevice'; submitted to standard-g
    -   did you use --gres to request gpus?
        -   yes, that was missing
    -   Have you updated the exercice's folder since yesterday ? I think the 'gres' part has been added this morning.
        - did not for this directory; will do
    -   Ok great !

37. When I try to run job.slurm in hello_jobstep, an error arise "sbatch: error: Batch job submission failed: Requested node configuration is not available"!!!
    -   Have you source the ../lumi_g.sh script ?
        -   yes source /project/project_465000388/exercises/HPE/lumi_c.sh, is it?
        -   so, why the error arise, have tried for the second folder, but the same error!!!
    -   Use lumi_g.sh, this is gpu_perf_binding
        -   I havew used both
    -   In which order?
        -   Perfect, thank you...


38. I am trying to run the gpu_perf_binding test, but in the slurm output I get: 
    `HIP Error - hello_jobstep.cpp:54: 'hipErrorNoDevice'`
    -   you are missing the "#SBATCH --gres=gpu:8" option in the batch file, so you don't reserve any GPU.
    -   In fact, this has been corrected this morning, if you download the exercices folder again, it should work fine now
        -   No, I am using:
            ```
            #!/bin/bash 
            #SBATCH -J himeno_gpu
            #SBATCH --ntasks-per-node=8
            #SBATCH --cpus-per-task=1
            #SBATCH --time=00:10:00
            #SBATCH --gres=gpu:8
            #SBATCH --hint=nomultithread
            ```
            I will try to download the folder again, maybe it is something else. 

    -   ok ! let me know. Don't forget to source both lumi_g.sh and gpu_env.sh

        -   It works now, the problem seems to have been an interactive run that didn't shut down properly. 
    - Ok that's great then :)

39. What do you mean by "Launch himeno from the root directory"? the job.slurm is located in the dir gpu_perf_binding/himeno
    -   sorry this is not up to date, you can launch it from the himeno directory directly.
    -   you can launch the job.slurm directly from /himeno directory
        -   but the file "select_gpu.sh" is located in another dir & the error mesage is generated: "slurmstepd: error: execve(): select_gpu.sh"
    -   could you update the entire directory? We did update it before lunch, sorry for the incovenience. 
        -   OK, understood.
            -- still does not work as the file "select_gpu.sh" is located in another dir (one level above, i.e. in gpu_perf_binding/ dir), not in the gpu_perf_binding/himeno/ dir
            it works only in case if in file job.job.slurm the shown below lines are both kept commented : ## UNCOMMENT to add proper binding #gpu_bind=select_gpu.sh cpu_bind="--cpu-bind=map_cpu:50,58,18,26,2,10,34,42"
            what for is used the "## UNCOMMENT to add proper binding"
    
40. Not related to this tutorial's material.
    I have a problem with one of my applications which does domain decomposition and uses MPI. I could run 4 tasks on 4 nodes (1 task/node) without issues. Or run 128 tasks in a single node. However, MPI crashes start when running more tasks per node (>=4). MPI appears to crash with `MPIDI_OFI_handle_cq_error(1062): OFI poll failed (ofi_events.c:1064:MPIDI_OFI_handle_cq_error:Input/output error - PTLTE_NOT_FOUND)`. This software was run on another cray machine (ARCHER2 to be precise) on ~ 200 nodes and no issues were observed. So at least, there is some confidence that the communication/MPI part was implemented correctly. Any quick advice/hints, or if anyone has experienced something similar? (sorry for the off-topic)
    -   Open a ticket...
    -   (Harvey) That error signature can be a secondary effect, some other node/rank may have failed before you got that message, for example running out of memory. But I agree if you submit a ticket we can investigate.
        -   A colleague of mine had open a ticket on December and we tried all suggestions but unfortunately did not solve our problem. Even after the update, this issue still occurs. Thanks anyway!



## Additional software on LUMI

41. Do we have a strategy/recommended practice for storing parameterised 'passwords', hashes, etc. Or is there a _vault_ ala Terraform/Azure?
    -   We do not have any such service running on LUMI.

42. Typical workflow is to compile on a login node and run on LUMI-C or LUMI-G. For compilation, what module should we use: partition/L (because we are on a longin node) or partition/C or /G (to match the one optimised for the partition where we will be running the compiled binaries)?
    -   Yes, when compiling on the login nodes, you need to load the partition module  for the hardware you want to target/run. It means replacing partition/L by partition/C for LUMI-C and partition/G for LUMI-G.
    -   It is often possible to compile software for GPU nodes on the login nodes, using the `rocm` module, but it is better to compile GPU software on a GPU node, because the login nodes do not have any GPUs installed, which sometimes confuses installations scripts.
        - So partition/L module should only be used to run directly on the login nodes stuff that will not be used later on LUMI-C/LUMI-G? (e.g., post-processing)?
    -   Yes, or if you plan to use the "largemem" or LUMI-D nodes that have Zen 2 CPUs. It will work, you may gain some efficiency from using partition/C or partition/G, and it will not support compilation of GPU software properly
        - OK, thank you.

43. How do you get the paths that are set by a module if you need to give them explicitely (include/lib folders)?
    -   `module show modulename` shows what the module is really doing
    -   Easybuild installed packages define a `EBROOT<UPPERCASENAME>` environment variable. For example the zlib module will define the `EBROOTZLIB` environment variable. This variable can be used to provide installroot to autotools and cmake. Use `env | grep EBROOT` to list such variables
    
44. Is lumi-workspaces still deprecated? I got once or twice this message while loading it.
    -   `lumi-workspaces` is not deprecated but the module is. The command is available by default now. It has been extended to also show the compute and storage billing units consumption/allocation.
    -   As I said in the presentation, it is replaced by `lumi-tools` which is loaded by default. Try `module help lumi-tools` for more info on the commands that are in the current version as this will evolve over time.
    
45. I think he just mentioned it but I missed it. Is it possible for anyone to add LUMI EasyBuild recipes?
    -   Yes, we accept pull requests on GitHub into [the LUMI-EasyBuild-Contrib](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib) repository, which is available by default on LUMI for everyone. But you do not need to have your recipe accepted there, you just write own and use it with our toolchains.
        -   Sounds good. In case one would like it to be generally available to other users.
    -   Then it should be on Github.
        -   :+1:
    -   And of course you can also use your own repository if it is only for your own project. See also the [notes for the presentation](https://lumi-supercomputer.github.io/LUMI-training-materials/4day-20230214/software_stacks/)

46. What's the recommended way of building new packages with easybuild for LUMI-G? Launching an interactive job?
    -   This is definitely the safest thing to do. Hint: For now if you have CPU billing units and if the process does not take too long you could use the partition `eap` which is still free, but that might not be for long anymore.

47. I wrapped my conda env uisng lumi container wrapper, and usually I need to export some specific PATH and PYTHONPATH from Conda env to excute some programs directly from command line, how can I do the similar thing with lumi container wrapper?
    -   I'm not sure I understand the question sufficiently to take it to the developer. Is there a small example that we could try without having to install too much stuff?

        -  for example, under conda environment, i need to export the following paths `ISCE_HOME=/project/project_465000359/EasyBuild/SW/LUMI-22.08/C/Anaconda3/2021.04/envs/isce_test/lib/python3.8/site-packages/isce`, `export PATH="$PATH:$ISCE_HOME/bin:$ISCE_HOME/applications:$ISCE_HOME/components/contrib/stack/topsStack"` to run applications under topsStack from command line. 
         
    -   if you export `SINGULARITYENV_ISCE_HOME=<value>`, then `ISCE_HOME` will be set in the container


## General Q&A day 2

48. How long will we have access to this project for?
    -   3 months as for all expired LUMI project.

49. Will the number of files quota (100K) be a hard quota? As in it would be impossible to create more than 100K files.

    -   For the project and home directories, yes. Exception may be possible but it really need to have a **very** good motivation. You can have up to 2M files in your `/scratch` but the files there will be removed after 3 months.

50. How do you verify that frameworks like pytorch or other complex program packages use the resources efficiently?
    -   We have started planning some course material tackling that question. But early stage.

51. I am running the hello_jobstep example and for each rank RT_GPU_ID is zero, while GPU_ID is the one expected. Probably it is not so clear to me the meaning of RT_GPU_ID, but why is it zero? Thank you!
    PS: I found this https://github.com/olcf-tutorials/jsrun_quick_start_guide/blob/master/README.md ; is this number always zero because this is the only GPU seen by the rank?


