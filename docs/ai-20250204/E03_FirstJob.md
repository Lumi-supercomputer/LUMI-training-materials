# Hands-on: Run a simple single-GPU PyTorch AI training job

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20250204/03_Your_first_AI_training_job_on_LUMI).
-->
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/03_Your_first_AI_training_job_on_LUMI).

A video recording of the discussion of the solution will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250204/recordings/E03_FirstJob.mp4" controls="controls"></video>
-->


## Q&A

1.  It seems that the [*Further Examples*](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/03_Your_first_AI_training_job_on_LUMI#further-example) in the GitHub is not in the git under [*Bonus material*](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/bonus_material)

    -   Some materials got removed at the last moment because they were outdated but it looks like some links remained in the repository. The [instructions to run the exercises from the previous workshop](http://lumi-supercomputer.github.io/LUMI-training-materials/ai-20241126/#after-the-termination-of-the-course-project) would show you the repository as it was then with those materials, but they may not work anymore.

2.  In general, (not the case for the present hands-on execise) how to improve efficiency when the GPU utilization does not reach 100% (or close). For example rather 70% or 80% (asking for a friend:-)). What are the options to improve this besides parallel data loading which is already used. Is there an equivalent of NVIDIA Nsight ? 

    -   There is no easy answer here. You'll first need to identify the bottlenecks through proper profiling and then see how you can deal with that particular bottleneck. We have a course that is largely set up in the way of "how to detect this problem" and then "what to do about it", but even those answers are still very generic. The issue can be I/O, or it can be the way PyTorch is used as there are many parameters that can influence performance, ... Some may be discussed in later presentations. 

    -   There are several AMD-provided and HPE-provided profiling tools. Presenting them is more than one day of our more HPC-oriented advanced course. Materials from the last such course, in late October 2024 in Amsterdam, can be found [here]
(https://lumi-supercomputer.github.io/LUMI-training-materials/4day-20241028/). HPE has the perftools suite. AMD has rocprof as the basic tool and then Omnitrace and Omniperf as the more advanced tools. In the materials of the last day in the afternoon you'll find the talk [Best practices: GPU Optimization, tips & tricks / demo](https://lumi-supercomputer.github.io/LUMI-training-materials/4day-20241028/extra_4_11_Best_Practices_GPU_Optimization/) where some of those tools are used to analyse the behaviour of PyTorch. PyTorch also has its own built-in profiling tools that may help.

3.  What is the difference between --gpus-per-node and --ntasks-per-node?
 
    -   Task here means individual process (which by default gets one cpu core allocated) so `--ntasks-per-node` says how many processes per node your job executes; `--gpus-per-node` is to allocate gpus **per node** to your job. If you need to allocate more cpus per task (process with multithreading), use `--cpus-per-task` in addition. Note that combining `--ntasks-per-node` and `--gpus-per-node` results in each task (process) having access to all allocated gpus.

4.  How have you built the container with torch 2.5 and rocm 6.2? I cannot find it on the docker hub of rocm/pytorch

    -   Don't use docker hub for LUMI, it is a bad idea. 
        These containers will not be built for the communication network of LUMI. There will be more discussions about containers that are built specifically for LUMI, but we have some in `/appl/local/containers/sif-images`. 
       
        These are built with a special procedure that you cannot easily mimic as a user, to guarantee that they can interface correctly with the Slingshot interconnect, and in case additional packages need MPI, with the right MPI libraries. This requires access to some licensed software components while the build procedure is currently such that it cannot happen on LUMI as some privileges and OS features are needed that are not enabled on LUMI for security reasons. They are built on a system that users have no access to.

        There will be some discussion this afternoon about an alternative built, though without a fully optimised mpi4py (but with an OK RCCL library which is what most AI packages need).

5.  How can you add some missing packages in provided containers "/appl/local/containers/sif-images" 

    -   As answered in a previous question already, see [this afternoon where the manual procedure will be explained](extra_07_VirtualEnvironments.md), and there is some automation for this procedure in some user-installable modules that we offer in [the PyTorch page in the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/), but that may require going through the [Software Stack talk in the regular intro courses](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20241210/M05-SoftwareStacks/).
