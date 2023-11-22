# HPE Cray PE tools introduction

<!--
-   Slides in `/appl/local/training/profiling-20230413/files/01_Preparing_an_Application_for_Hybrid_Supercomputing.pdf`
  
-   Recording in `/appl/local/training/profiling-20230413/recordings/00_Introduction.mp4`


## Q&A

1.  Can the tools be used for profiling GPU code which is not directive-based, but written in CUDA/HIP?

    **Answer:** Yes, we provide examples in perftools/perftools-for-hip (and clearly CUDA is supported too) and perftools-lite-gpu. Perftools-lite can give output like this for HIP code:
    ```
    Table 2:  Profile by Function Group and Function

      Time% |     Time | Imb. |  Imb. | Team |    Calls | Group
            |          | Time | Time% | Size |          |  Function=[MAX10]
            |          |      |       |      |          |   Thread=HIDE
            |          |      |       |      |          |    PE=HIDE

     100.0% | 0.593195 |   -- |    -- |   -- | 14,960.0 | Total
    |---------------------------------------------------------------------------
    |  57.5% | 0.341232 |   -- |    -- |   -- |     18.0 | HIP
    ||--------------------------------------------------------------------------
    ||  39.5% | 0.234131 |   -- |    -- |    1 |      3.0 | hipMemcpy
    ||  10.2% | 0.060392 |   -- |    -- |    1 |      2.0 | hipMalloc
    ||   7.2% | 0.042665 |   -- |    -- |    1 |      1.0 | hipKernel.saxpy_kernel
    ||==========================================================================

    ```


2. Completely unrelated to this course, but, is it possible to use all 128GB of GPU memory on the chip from a single GCD? i.e. have processes running on one GCD access memory on the other GCD.
    
    **Answer** Not sure if this is allowed. We never investigated since the performance will be really, really bad. The inter-die bandwidth is low compared to the memory bandwidth. BAsically 200 GB/s read and write (theoretical peak) while the theoretical memory bandwidth of a single die is 1.6 TB/s. 
    
    ***Follow up*** Yes, I appreciate it will be slow, but probably not as slow as swapping back and forwards with main memory? i.e. if I need the full 128GB I can just swap out stuff with DRAM, but that's really, really, really, really bad performance ;). So it'd be 8x slower than on a die, but 8x isn't really really bad. Anyway, I assumed it wasn't supported, just wanted to check if I'd missed something
    
    **Peter**: but if you already have the data in memory on the other GCD, would it not make more sense to do the compute there in-place, rather than waiting for the kernel to finish on GCD 1 and then transfer the data to GCD 2? It is supported in the sense that it will work with managed memory. The kernel on GCD 1 can load data automatically from GCD 2 with decent bandwidth, typically 150 GB/s (see [this paper](https://arxiv.org/pdf/2302.14827.pdf)).
    
    **George**: some of the above are true if you use both GCDs, in your case is like you use only one.
   
-->
