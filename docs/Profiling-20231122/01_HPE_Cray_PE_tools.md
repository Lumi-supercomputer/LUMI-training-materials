# HPE Cray PE tools introduction

<!--
-   Slides in `/appl/local/training/profiling-20231122/files/01_Preparing_an_Application_for_Hybrid_Supercomputing.pdf`
  
-   Recording in `/appl/local/training/profiling-20231122/recordings/00_Introduction.mp4`
-->

## Q&A

1.  When specifying a single GCD, is the limit GPU memory 64 or 128 G ?

    -   The slide said 8 GPUS (remember he said the context in the talk was now that 'GPU'=GCD) so it is 64 per GCD.
    -   And due to the slow connection between two GCDs (basically 200 GB/s per direction) using all memory of a package is not supported.
    -   For completeness - memory in the GPU is coherent so it is possible for one GCD use memory from the other. E.g. in the current implementation, having a copy kernel that picks up data of the other GCD on the chip is the fastest way to move data between GPUs. So, one can use all the memory on the chip, but the GCD will have 1.6 TB/s (peak) for the HBM next to it and 200 GB/s (peak) from the HBM next to the other GCD.

2.  Normally I use gdb4hpc to check what are my MPI processes and individual threads doing. Is there an alternative for this in hpe / cray toolset where I could really nicely get an overview of what all the threads are doing? There can be more of them and it's important to have it well visualized to find reasons for hangs in MPI during sends and receives and probes.

    -   We also have ARM Forge (now Linaro) on LUMI.
  
    -   I'm not clear on the request, you can list threads in gdb4hpc (at least for CPU). I expect it to work for GPU kernels but have not actually tried this myself.  Are you just looking for a nicer display?
   
    yes, that's what I'm normally using, just wondering if there is a better tool on the market, so I wanted to check if you know about anything.. visualization and really nice overview would be a plus, as sometimes it's hard to navigate in what these threads are up to. I want to try cray stat as well, but not sure what detail can it provide

    -   The AMD tools also give a thread view, maybe someone can do a demo during the hackathon for you if you have not seen this.
    -   Linaro Forge promises a lot, but the AMD GPU support is not yet spectacular. We'll upgrade our version of that as soon as it gets better.

    Thanks, I should try it out then :)

    That would be great. The GPU support of the debugger is not the biggest issue right now as the current issue that I'm looking into can be reproduced also in CPU-only regime, even though our code supports gpus and we're using all the GPUs on a node.

3.  How to check if NIC is used when running GPU-aware MPI
    -   This is tricky. You can tell which NICs an MPI process has access to via the environment variable Alfio mentioned.  Proving a particular NIC was used would be nontrivial and possibly involve performance counters.
 
4.  Our application (as every distributed mem coupled cluster code) is relatively heavy on internode communication. How can I measure and analyze when the GPUs are waiting for internode communication, offloading and obtain an overview of what is the percentages of theoretical flop rates on both cpus and gpus? .. and analyze communication vs compute intensity

    -   Waiting in which API?
    -   We will cover both the Cray PE profiling tools and AMD profiling tools so you should get an idea of which tool is appropriate for a given investigation by the end of the day.

    The code can wait on mpi communication (mpi is run from fortran) between the nodes (each with multiple mpi processes). Also can wait on offloading to a GPU (using HIP) and then the gpu does not get to more than 10% of theoretical peak flop rate on average, it's use-time is like 55%. I'd like to analyze, measure and visualize these bottlenecks.
    Not sure what you mean by which API. I want to use whatever tool does the job for the analysis.
    I see that the presented tools can do a lot on this, which is great.
    
    -   API, for example MPI, HIP (cpu to GPU) ? 

    Yes, MPI called from fortran and HIP. cpu to gpu, we tried gpu aware mpi comm for the first time a week ago, it's just in an experimental phase

5.  Can I see the percentage use of theoretical GPU flop rate?

    -   No. For this kind of analysis, in particular roofline analysis, AMD omniperf is the tool to use.

6.  Do you have any experience with OOD disconnection? I've tried several times VNC or VSCode and after a while I get a "disconnected" message. Thanks.

    -   After how much time? Sessions are by default for 4 hours I believe.

7.  For development I use VSCode very often and with Lumi I often have the problem that VSCode cannot write files to disk. Do you have any experience with that? Thanks.

    - Do you use VSCode + server on LUMI or OOD VSCode?
    
    VSCode + ssh extension + VSCode server on cluster
    
    - VScode can be very unreliable over high latency connections. I've given up on using it from where I live. And another factor is that the LUMI file systems occasionally freeze for 2 minutes or so. This is due to various mostly hardware related issues and is currently worse again as there are lots of changes in the network cabling after the last update, hence again broken cables etc. that need to be detected.
    - I (Sam from AMD) have relatively good experience using VSCode. The file writting issue most of the time comes from the home folder quota being small. This can be fixed with a symlink to scratch, e.g:
```
samantao@uan02:~> ls -la $HOME/.vscode-server
lrwxrwxrwx 1 samantao samantao 63 Nov  9 19:59 /users/samantao/.vscode-server -> /pfs/lustrep2/scratch/project_462000125/samantao/.vscode-server
```

8.  Would it be possible to enable running Xorg on GPU nodes (Some applications require OpenGL for calculation)?

    -   Not on the AMD GPU nodes. They are compute GPUs, not render GPUs and typical graphics APIs are not supported. They don't even have the hardware to run those APIs with full hardware acceleration as much of the render pipeline is eliminated from their design to have more transistors available for compute. Time to switch APIs I think as, e.g., NVIDIA, is also more an more making a distiction between compute and render GPUs with the former missing the necessary hardware to support render APIs.

    There is only problem with permission for running of Xorg :0, the example to allow Xorg running (CentOS7) - e.g. for prolog
    ```
    {
      log_debug "xorg_load"
      echo "allowed_users=anybody" > /etc/X11/Xwrapper.config
      echo "#%PAM-1.0
      auth       sufficient   pam_rootok.so
      auth       sufficient   pam_permit.so
      account    required     pam_permit.so
      session    optional     pam_keyinit.so force revoke" > /etc/pam.d/xserver
    }
    ```

    -   If something is not permitted, it is not permitted for a reason. So no hope we would change these permissions. Moreover, LUMI has an OS set up to run minimal services on the compute nodes to limit OS jitter. And there is more than a permissions problem. The next problem would be a driver problem as there is no driver for OpenGL (or graphics in general) on MI250X.

        The name "GPU" is very misleading for MI100/MI200 (but in fact also for the NVIDIA H100). MI100 and MI200 are really vector- and matrix compute accelerators, but with an architecture similar to that of GPUs (in the AMD case an evolution of GCN/Vega), and not graphics processing units.
     
        You might be able to run some kind of X server in a container (after all, this is what is done to run VNC on LUMI also as a VNC server is some sort of X server, at least the ones that we use) but that still would only give you software based rendering.
   
   Use case for off-screen rendering (OpenGL/Vulkan): There is off-screen rendering/rasterization that is used as input to neural network algorithms. There are articles and research papers that need this use case for research.

   -   Then I think you'll have to look at a different way of developing such software, splitting the parts that need rendering GPUs and compute GPUs, run on supercomputers with lots of rendering GPUs, or use different libraries that still perform decent on vector accelerators. The only rendering you could do on LUMI would be fully software-based anyway. Clusters that still have a battery of rendering GPUs, will probably also have the necessary hardware acceleration for AI in the forseeable future as AI is becomming business in the PC space also (though even that isn't sure as AMD in some of their PC APUs did not integrate matrix units in the GPU part for AI acceleration, but uses instead a dedicated accelerator for AI - called XDNA, just as most phone SOCs do). And large partitions with rendering GPUs are becoming rare in the supercomputer space...
   
   -   There is HIP support for Prorender but that means you need to use that API instead of Vulkan/EGL: https://gpuopen.com/radeon-prorender-hip-updates/

   -   For computer vision and AI - the GPU accelerated pre-processing can be accomlished with [rocAL](https://rocm.docs.amd.com/projects/rocAL/en/latest/doxygen/html/index.html) part of the [MIVisionX suite](https://rocm.docs.amd.com/projects/MIVisionX/en/latest/) (or [on GitHub](https://github.com/GPUOpen-ProfessionalCompute-Libraries/MIVisionX)) that comes with ROCm.



