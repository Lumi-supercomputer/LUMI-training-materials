# Introduction to the AMD ROCm<sup>TM</sup> Ecosystem

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter:* Samuel Antão (AMD)

-   [Slides on the web](https://462000265.lumidata.eu/4day-20230530/files/LUMI-4day-20230530-2_06_Introduction_to_AMD_ROCm_Ecosystem.pdf)

-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-2_06_Introduction_to_AMD_ROCm_Ecosystem.pdf`
    -   `/project/project_465000524/slides/AMD/session-1-intro_hip_programming.pdf` (temporary, for the lifetime of the project)


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

1.  Are CUDA applications using tensor cores (through cuBLAS or similar libraries) expected to translate well to HIP/ROCm code using matrix cores (AMD’s equivalent to NVIDIA tensor cores)? What is the current status regarding support for matrix cores on HIP/ROCm libraries?

    -   Yes, the libraries support matrix cores, for example hipBLAS will use cuBLAS if you run on NVIDIA and rocBLAS if you run on AMD GPUS. Matrix cores are supported through the libraries.
    -   (Peter) I know that at least rocBLAS and rocWMMA have matrix core support.

2.  What are the expected numbers for hip-stream? For instance for the `Copy` I get 1280GiB/s, while peak memory bandwidth is advertised to be above 3000GiB/s (https://www.amd.com/en/products/server-accelerators/instinct-mi250x)?

    - This number sounds good, peak memory is theoretical 1.6 TB/s but achievable 1.3 TB/s per GCD, if you use both GCDs, then you get double close to 2.6 TB/s. This hip-stream works for one GCD only.  It is improtant to know when we compare data to be familiar with the GCDs, if you use 1 GCD, you use actually half the GPU. See this: https://www.servethehome.com/wp-content/uploads/2022/08/AMD-MI250X-MVM-at-HC34-Floorplan.jpg in the middle there is the connection between the GCDs.
