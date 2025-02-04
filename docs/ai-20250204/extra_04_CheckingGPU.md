# Understanding GPU activity & checking jobs

*Presenter:* Luka Stanisic (AMD)

Content:

-   Checking jobs with rocm-smi
-   Setting environment variables for ROCm/AMD debug info
-   Simple profiling using rocprof


<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20250204/recordings/04_CheckingGPU.mp4" controls="controls"></video>


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250204/files/LUMI-ai-20250204-04-Understanding_GPU_activity.pdf)

-   [Hands-on exercises](E04_CheckingGPU.md)


## Q&A

1.  Does the use of rocmprof slow down a program? And if yes, does it remove the time used by the profile from the trace logs?

    -   There will always be profilling overhead. It is hard to say exactly how much the overhead is as it depends on the application and on the quantity of profile information one collects in a given time window. Hence, it is a good idea to collect profiles of data and regions that one cares about instead of just profile everything and then filter after runing the information. Typically, this overhead will be in the order of a few % and won't compromise the insight you are looking to have. The profiler won't show you the overhead - some profilers try to but that is never accurate.

2.  In slide 5, it is mentioned to run parallel session for monitoring using `srun --interactive` to initiate a parallel session and then do the monitoring. But this method needs available gpus, meaning that is all the gpus are under the load, this command does not run? am I right about this?

    -   I am not sure I am getting the question right, but, in general, once you have GPUs allocated, you can run multiple processes on them, including those which are used to monitor them.

    -   Maybe the source of confusion is what is meant by "parallel session". The first step is to submit the AI job (sbatch or interactively leveraging salloc). Then, you need another terminal on the login node (that is what is meant by parallel session) to connect to that same node the workload was issued to before. So, at the end there are two parallel sessions, one running the training and another that can be used interactively to peak at what is going one in the node. The parallel session won't use more resources as it is meant to track what is happening in the resources allocated in the first place. That is the point of monitoring.
  
