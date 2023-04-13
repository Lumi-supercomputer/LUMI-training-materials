# Notes from the HedgeDoc document

## Questions regarding course organisation or LUMI in general

1.  Can I ask for incresing the home directory capacity?

     **Answer**: No. The home directory cannot be extended, not in capacity and not in number of files as it is also the only directory that is not billed. The home directory is only for stricly personal files and typically the type of stuff that Linux software tends to put in home directories such as caches. The project directory is the directory to install software, work on code, etc., and the scratch and flash directory are for temporary data. You can always create a subdirectory for yourself in your project directory and take away the group read rights if you need more personal space.

2.  `/project/project_465000502/slides` is empty now, right? Thanks.

    **Answer** Yes. HPE tends to upload the slides only at the end of the presentation.
               PDF file is now copied.
               
3.  How one can see `/project/project_465000502/` on LUMI?
    When I do `ls` in the terminal, I do not see this folder.

    **Answer** Did you accept the project invite you got earlier this week? And if you have a Finnish user account you will now have a second userid and that is the one you have to use.
    
    Did you try to `cd` into `/project/project_465000502`? That directory is **not** a subdirectory of your home directory!
    
    ```
    cd /project/project_465000502
    ```
    
  
    
## HPE Cray PE tools

4.  Can the tools be used for profiling GPU code which is not directive-based, but written in CUDA/HIP?

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


8. Completely unrelated to this course, but, is it possible to use all 128GB of GPU memory on the chip from a single GCD? i.e. have processes running on one GCD access memory on the other GCD.
    
    **Answer** Not sure if this is allowed. We never investigated since the performance will be really, really bad. The inter-die bandwidth is low compared to the memory bandwidth. BAsically 200 GB/s read and write (theoretical peak) while the theoretical memory bandwidth of a single die is 1.6 TB/s. 
    
    ***Follow up*** Yes, I appreciate it will be slow, but probably not as slow as swapping back and forwards with main memory? i.e. if I need the full 128GB I can just swap out stuff with DRAM, but that's really, really, really, really bad performance ;). So it'd be 8x slower than on a die, but 8x isn't really really bad. Anyway, I assumed it wasn't supported, just wanted to check if I'd missed something
    
    **Peter**: but if you already have the data in memory on the other GCD, would it not make more sense to do the compute there in-place, rather than waiting for the kernel to finish on GCD 1 and then transfer the data to GCD 2? It is supported in the sense that it will work with managed memory. The kernel on GCD 1 can load data automatically from GCD 2 with decent bandwidth, typically 150 GB/s (see [this paper](https://arxiv.org/pdf/2302.14827.pdf)).
    
    **George**: some of the above are true if you use both GCDs, in your case is like you use only one.
   


