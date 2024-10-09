# AMD ROCm<sup>TM</sup> profiling tools

<em>Presenter: Samuel Antao (AMD)</em>

-   Slides:

    -   [Part 1: GPU timeline profiling (PDF, 5.6M)](https://462000265.lumidata.eu/profiling-20241009/files/02a_AMD_ROCm_profiling_tools_GPU_timeline_profiling.pdf)

    -   [Part 2: OmniPerf and the roofline model (PDF, 2.9M)](https://462000265.lumidata.eu/profiling-20241009/files/02b_AMD_ROCm_profiling_tools_omniperf_and_roofline.pdf)

    -   [Part 3: Tips and Tricks (PDF, 1M)](https://462000265.lumidata.eu/profiling-20241009/files/02c_AMD_ROCm_profiling_tools_tips_and_tricks.pdf)

    The slide files are also available on LUMI in
    `/appl/local/training/profiling-20241009/files`.

=== "Part 1: GPU timeline profiling"
    <video src="https://462000265.lumidata.eu/profiling-20241009/recordings/02a_AMD_tools__GPU_timeline_profiling.mp4" controls="controls"></video>

=== "Part 2:  OmniPerf and the roofline model"
    <video src="https://462000265.lumidata.eu/profiling-20241009/recordings/02b_AMD_tools__omniperf_and_roofline.mp4" controls="controls"></video>

=== "Part 3: Tips and Tricks"
    <video src="https://462000265.lumidata.eu/profiling-20241009/recordings/02c_AMD_tools__tips_and_tricks.mp4" controls="controls"></video>

The recordings are also available on LUMI in
`/appl/local/training/profiling-20241009/recordings`.


## Q&A

!!! Note "Slide 7"
    We now have a `rocm/6.2.2` module on the system which is built by LUST, but there are 
    compatibility problems with the CCE compilers as ROCm 6.2 is based on Clang/LLVM 18 
    which has some conflicts with Clang/LLVM 17 from the 24.03 CPE. You can find it in `CrayEnv` 
    and `LUMI/24.03 partition/G`.


1.  Can we give multiple kernel names for omniprof for the profiling?

    -   Yes you can usually up to 10 kernels but there could be more probably

2.  Is there a way to capture the kernel running not every time, but in certain intervals. 
    For example only profile "my_great_kernel" every 5 runs.

    -   I am not sure for every 5 but you can say profile the 5th execution, 10th, etc. so this 
        is manual. However, it is improtant to know that all the kernels are running in the order 
        that they are called, so 5th execution does not mean is the kernel we want, you need to 
        identify first which call is for your kernel. Although they were planning to change it, 
        I need to check if something is changed.

    Thanks. This was exactly my question. a specific kernel's 5th and 10th invocation. I guess one 
    can check the order of kernels that are and map the invocation to the specific kernel one wants to profile. 

    -   I know this was under discussion but I assume the profiling team had more urgent tasks to solve, I will ask though.

    - It is not yet developed,

3.  Which modules do I need to load in order to use rocprofv3?

    -   You need ROCm 6.2 and later, then it is included there, no other module required

    -   After loading `rocm/6.2.2` (see above), it is in `$EBROOTROCM/bin` and also in the path. 
       However, loading this will likely also cause your code to use libraries from ROCm 6.2.2 which may cause some problems with some codes.

4.  pftrace files generated with rocprofv3 can quickly get rather large, I tried to upload one to 
    perfetto which had 1 GB. Can the size of the output files be reduced easily?

    -   I am not aware of a way to reduce the profile size. You can use, though, the offline 
        trace processor tool. Perfetto UI will look for an instance of that trace processor. 
        You can even choose to have the trace processor running remotelly (on LUMI) and forward 
        that with SSH to your laptop.

    -   (Harvey) I see rocprofv2 has a --trace-period option but that is not listed under help for rocprofv3. 
        There is also a start and stop API call mentioned in the rocprof documentation but again I don't 
        see that in the rocprofv3 equivalent webpage.

    -   [They are here](https://rocm.docs.amd.com/projects/rocprofiler/en/latest/how-to/using-rocprof.html#tracing-control-for-api-or-code-block) 
        (two sections) 
