# AMD ROCm<sup>TM</sup> profiling tools

<em>Presenter: Samuel Antao (AMD)</em>

=== "Part 1: GPU timeline profiling"
    <video src="https://462000265.lumidata.eu/profiling-20250507/recordings/02a_AMD_tools__GPU_timeline_profiling.mp4" controls="controls"></video>

=== "Part 2:  OmniPerf and the roofline model"
    <video src="https://462000265.lumidata.eu/profiling-20250507/recordings/02b_AMD_tools__omniperf_and_roofline.mp4" controls="controls"></video>

=== "Part 3: Tips and Tricks"
    <video src="https://462000265.lumidata.eu/profiling-20250507/recordings/02c_AMD_tools__tips_and_tricks.mp4" controls="controls"></video>


## Additional materials

-   Slides:

    -   [Part 1: GPU timeline profiling (PDF, 4.6M)](https://462000265.lumidata.eu/profiling-20250507/files/02a_AMD_ROCm_profiling_tools_GPU_timeline_profiling.pdf)

    -   [Part 2: OmniPerf and the roofline model (PDF, 2.7M)](https://462000265.lumidata.eu/profiling-20250507/files/02b_AMD_ROCm_profiling_tools_omniperf_and_roofline.pdf)

    -   [Part 3: Tips and Tricks (PDF, 1M)](https://462000265.lumidata.eu/profiling-20250507/files/02c_AMD_ROCm_profiling_tools_tips_and_tricks.pdf)

        Note: Talks about using and extending singularity containers on LUMI referred to in this presentation:

        -   [Intro course container talk in the afternoon of day 2](https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/M205-Containers/) (Link is to the version of the 
            ["LUMI Intensive Course" of March 2025](../2p3day-20250303/index.md)) This also includes links to
            some previously recorded demos.

        -   AI training: Various talks in the afternoon of day 1, see, e.g., the 
            [AI training of February 2025](../ai-20250204/index.md).

    The slide files are also available on LUMI in
    `/appl/local/training/profiling-20250507/files`.

-   The recordings are also available on LUMI in
    `/appl/local/training/profiling-20250507/recordings`.


## Q&A

1.  Do we need specific modules for rocprof?
  
    -   The regular rocprofv1 is just part of the ROCm module. 
    
        For rocprofv3 you can use the rocm/6.2.2 module in some of our stacks. There are also some additional modules available after using `module use /appl/local/containers/test-modules`. We also have containers with ROCm preinstalled in various versions and soon we'll announce containers with newer versions of the Cray PE that also contain the matching ROCm versions. If needed, you can use those at the hackathon. The "realistic" one is one with the 24.11 version of the Cray PE which is based on Clang 18 for the Cray compilers and ROCm 6.2. There is now also one for 25.03 which is based on the Cray compilers versions 19 (based on clang 19) and ROCm 6.3, but there we expect issues as the drivers are to old.
   
   
   - srun rocprof --stats nbody-orig 65536, what is number 65536 in here? 
   -

2.  Following the slide I run rocprof --hip-trace  --output-format pftrace ./pluto
   
    ```
    RPL: on '250507_143448' from '/opt/rocm-6.0.3' in '/users/...'
    /opt/rocm-6.0.3/bin/rocprof: **Error: Wrong option '--output-format'**
    ```

    -   You need to go to ROCm 6.2 for that. Try `module spider rocm/6.2`

    I load rocm/6.2.2 but i obtain the same error rocprof --hip-trace  --output-format pftrace ./pluto -maxsteps 5

    ```
    RPL: on '250507_150325' from '/pfs/lustrep2/appl/lumi/SW/LUMI-24.03/G/EB/rocm/6.2.2' in '/users/...'
    /appl/lumi/SW/LUMI-24.03/G/EB/rocm/6.2.2/bin/rocprof: **Error: Wrong option '--output-format'**
    ```

    -   You need to use `rocprofv3` instead of `rocprof` to get the newest rocprof. The `rocprof` command is still rocprof version 1.


3.  Does perfetto work "out-of-box" already, or we still used a specific branch of it as in the AMD profiling workshop in October 2024?

    -   There is information in the exercises. For ROCm 6.2 you should be able to use perfetto UI out-of-the-box.

        Information is on [perfetto.dev](https://perfetto.dev), the app is on [ui.perfetto.dev](https://ui.perfetto.dev).


