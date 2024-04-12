# Introduction to the AMD ROCm<sup>TM</sup> Ecosystem

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter: Jakub Kurzak (AMD)*

<!--
Course materials will be provided during and after the course.
-->

<video src="https://462000265.lumidata.eu/4day-20231003/recordings/2_06_Introduction_to_AMD_ROCm_Ecosystem.mp4" controls="controls">
</video>

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465000644/Slides/AMD/session-1-hip_intro.pdf`
-->

Materials available on the web:

-   [Slides on the web](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-2_06_Introduction_to_AMD_ROCm_Ecosystem.pdf)

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-2_06_Introduction_to_AMD_ROCm_Ecosystem.pdf`

-   Recording: `/appl/local/training/4day-20231003/recordings/2_06_Introduction_to_AMD_ROCm_Ecosystem.mp4`


!!! Note
    ROCm 5.5 for the brave:

    ```
    module purge
    module load CrayEnv
    module load PrgEnv-cray/8.3.3
    module load craype-accel-amd-gfx90a
    module load gcc/11.2.0 

    module use /pfs/lustrep2/projappl/project_462000125/samantao-public/mymodules
    module load suse-repo-deps
    module load rocm/5.5.0.lua
    ```

    (Not provided by LUST and as it says, for the brave, problems can be expected...)


## Q&A

21. Me too doing CUDA. But is it a way to write code able to run both on AMD and CUDA?

    - CUDA is code meant to run on NVIDIA GPUs, it won't run on AMD. HIP, on the other hand, can run on both NVIDIA and AMD GPUs. There are also some porting codes(hipify-clang, hipify-perl) to help in translating your code from CUDA to HIP.
    
22. If I have a code that runs with Pytorch for CUDA , in principle it would work on LUMI too by only installing the PyTorch version for ROCm, right? (particularly torchscatter)

    - Yes, it should without change if you only use PyTorch. If you use other packages that depend on CUDA it might not. I have to check for torchscatter. Pytorch comes with a builtin "hipify" tools that can convert CUDA code of plugins automatically, but it needs to be enabled by the developper of the plugin. Sometimes, it's really simple. I had a ticket in the past where I "ported" a pytorch plugin to HIP by changing 2 lines of code :) 

    I will try then! Thanks
    
    - I had a look and I see references to ROCm in the setup.py, so I think it should work on LUMI. If you need help building this plugin, please submit a ticket.

23. What is a "warp" (or a "wave")?

    -   Warp is NVIDIA terminology and Wavefront is AMD terminology. For both they correspond to the same level structure. Warp is a structure of 32 threads that run at the same time and execute the same instructions, basically a vector thread. For AMD it is the same, but with 64 threads.

24. How are LUMI and Frontier different with regards to the user guides?

    -   Slurm setup is different

    -   The whole software stack is different. There are differences at the HPE level as they have a different management stack which translates into other differences, and different versions of the PE installed, and there are differences in the software they installed on top of that.

