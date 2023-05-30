# Introduction to OmniTrace

-   [Slides](https://462000265.lumidata.eu/profiling-20230413/files/03_intro_omnitrace.pdf)

-   Recording in `/appl/local/training/profiling-20230413/recordings/03_Intro_OmniTrace.mp4`


## Remarks

-   [Perfetto](https://perfetto.dev/), the "program" used to visualise the output of omnitrace, is not a regular application but 
    [a browser application](https://ui.perfetto.dev/). Some browsers nowadays offer the option to install it on your
    system in a way that makes it look and behave more like a regular application (Chrome, Edge among others).
    

## Q&A

1.  Since there is support for OpenCL, does it support also SYCL? Or it will in the future?

    **Answer**
    
    -   There currently no plans to support the SYCL programming models in the AMD tools. For SYCL you'd have to rely on the HIP/HSA activity it generates.
    -   **Peter:** I have tested HipSYCL code with rocprof, and you can see the kernels launching.
    -   OpenSYCL uses HIP for AMD GPUs, so it should be able to track.

2.  On LUMI ROCm is only available on LUMI-G, correct? What about onmitrace/perf? Is this available on LUMI-C?

    **Answer**
    
    -   Omnitrace could eventually be used to sample CPU code - omniperf is useless in no-GPU systems. 
        These tools are not generally available but can be easily installed as indicated in the presentations.
    -   The AMD μProf tool is used for the AMD CPUs. 
    -   The ROCm modules are available on LUMI-C and the login nodes also, but there was a problem with versions 
        before the maintenance. If these tools connect to GPU-specific device drivers though they will fail on non-GPU nodes.

3.  What is a reasonable maximum number of mpi processes for omnitrace/perf to deal with?

    **Answer**
    
    -   Omniperf needs application replaying to collect multiple counters so the application would have to be replayed equally in all ranks. Omnitrace as MPI trace features and can use wil multiple ranks. In general, you'd be interested in profiling at the scale that is relevant for you and then maybe focus on more problematic/representative ranks, i.e. activate profile on only a given rank or set of ranks while using multiple ranks.
    -   A related question is how many MPI ranks to use per GPU - this depends but usually a rank por GCD is the choice for many apps. You can use more and the runtime/driver is ready for it without any requires wrapping. My recommendation however is to use ROCm 5.4+ if the intent is to overpopulate the GCDs with ranks.
    -   Omniperf requires 1 MPI process only. Omnitrace, can be large, not sure what limit except how to analyze the data.

4.  Can you track memory usage with these tools? Thanks, will it give you maximum memory usage and where the memory is allocated in the code? Thanks

    **Answer**
    
    - Yes, omnitrace samples memory usage. 
    


