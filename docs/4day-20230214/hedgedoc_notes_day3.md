# Notes from the HedgeDoc page - day 3

These are the notes from the LUMI training,
1114-17.02.2023, 9:00--17:30 (CET) on Zoom.

-   [Day 1](hedgedoc_notes_day1.md)
-   [Day 2](hedgedoc_notes_day2.md)
-   [Day 3](hedgedoc_notes_day3.md): This page
-   [Day 4](hedgedoc_notes_day4.md)

## Performance Optimization: Improving single-core efficiency

1.  Sorry, I have a question from yesterday.  I run the hello_jobstep example, and for each rank RT_GPU_ID is zero, while GPU_ID is the one expected. Probably it is not so clear to me the meaning of RT_GPU_ID, but why is it zero? Thank you!
    PS: I found this https://github.com/olcf-tutorials/jsrun_quick_start_guide/blob/master/README.md ; is this number zero for all GPU_IDs because this is the only GPU seen by the rank?
    -   So, RT is the runtime value taken from the get `hipGetDevice`. Now, you run by forcing `ROCR_VISIBLE_DEVICES` to a given GPU per each rank (via the select_gpu scripts). Let's assume we do `ROCR_VISIBLE_DEVICES=2`, then at runtime you will access a single GPU whose id is 0. If you set `ROCR_VISIBLE_DEVICES=2,3`, then runtime ID will be `0, 1`. I'm not sure if I'm confusing you... You can find more examples at `https://docs.olcf.ornl.gov/systems/crusher_quick_start_guide.html#mapping-1-task-per-gpu`.
        -   I think I understood! Thank you very much!
    -   This is why that code can print the busid of the GPU, so that you can tell which physical GPU was being used.

2.  I might have missed it, but what is the motivation for padding arrays? Don't we destroy the locality of our original arrays if there is something in-between ?
    -   (Alfio) this is for memory access, you access the data in cache lines (64 bytes), so you want to align your data for that size. Note that also MI250x can require data alignemnt. I think AMD will discuss that. A CPU example: https://stackoverflow.com/questions/3994035/what-is-aligned-memory-allocation
    -   (Harvey) The point (as noted below) is that often you index into both arrays by the same offset and both of those accesses might collide on cache resources. The point of the presentation is to really give you a feel for the transformations the compilers can and might do so that if you start to delve into optimizing an important part of your code then this is useful to understand, even if you just look at compiler commentry and optimization options and don't want to consider restructuring the code. The compilers (and hardware) get better and better all the time.
    -   (Kurt) A data element at a particular address cannot end up everywhere in cache, but only in a limited set of cache elements (for L1/L2 cache often only 4 or 8 locations). Now with the original declarations, assume that array A starts at address addr_a, then array B will start at address addr_b = addr_a + 64*64*8 (number of elements in the array times 8 bytes per data element). Alignment of B will still be OK if that for A is OK (and actually for modern CPUs doesn't matter too much according to two experts of Erlangen I recnetly talked to). But as addr_b = addr_A + 2^15, so shifted by a power of two, it is rather likely that B(1,1) ends up in the same small set of cache lines as A(1,1), and the same for C(1,1). So doing operations in the same index region in A, B and C simultaneously may have the effect that they kick each other out of the cache. This is most easily seen if we would have cache associativity 1 (imaginary case), where each data element can be in only one cache location, and with a cache size of 2^15 bytes. Then B(1,1) and C(1,1) would map to the same cache location as A(1,1) and even doing something simple as C(i,j) = sin(A(i,j)) + cos(B(i,j)) would cause cache conflicts. By shifting with 128 bytes as in the example this is avoided. 

3.  How do you know what loop unroll level and strip mining size to use? Trial and error? Or is there some information to look for?
    -   (Alfio) Most of the compilers are doing a good job already. It really depends on the instructions of the loop (number of loads/store and computation intensity). You can check the listings to check what the compiler is doing for you and then you can add some directives to try to force more unrolling. Unrolling by hand is quite unsual nowadays...
    -   (Kurt) But it is one of those points were selecting the right architecture in the compiler can make a difference, and something that will definitely matter with Zen4 (which we do not have on LUMI). But the AVX-512 instruction set supported by Zen4 (code named Genoa) has features that enable the compiler to generate more elegant loop unrolling code. Some users may think that there cannot be a difference since the vector units still process in 256-bit chunks in that version of the CPU, but it is one of those cases where using new instructions can improve performance, which is why I stressed so much yesterday that it is important to optimize for the architecture. For zen2 and zen3, even though the core design is different and latencies for instructions have changed, I don't know if the differences are large enough that the compiler would chose for different unrolling strategies. In a course on program optimization I recently took we got an example where it turned out that AVX-512 even when restricted to 256 bit registers had a big advantage over AVX-2 even though with both instruction sets you get the same theoretical peak performance on the processor we were using for the training (which was in Intel Skylake, it was not on LUMI).


## Debugging at Scale – gdb4hpc, valgrind4hpc, ATP, stat

4. Is STAT and ATP for cray compiler only?
    - They are not restricted to just the Cray compiler
        - Are all the tools in this morning lecture for cray compiler only? I anticipate the question :)
    - No, you can use with any compilers (PrgEnv's)
        - Thank you!
    - Please be aware that there are some known issues with the current software on LUMI so some of these tools are not operating properly. Until the software can be updated we recommend using gdb4hpc.


### Exercise

!!! exercise
    General remarks:
    -   Exercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -   Directory for this exercise: `debugging`
    -   Copy the files to your home or project folder before working on the exercises.
    -   In some exercises you have source additional files to load the right modules necessary, check the README file.

    -   To run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_g.sh` (GPU) or `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU)
  
    Exercise:

    1.   __deadlock__ subfolder: gdb4hpc for CPU example
         Don't forget to `source /project/project_465000388/exercises/HPE/lumi_c.sh`
    2.   subfolder: environment variables for GPU example
         Don't forget to `source /project/project_465000388/exercises/HPE/lumi_g.sh` & load GPU modules


5.  launcher-args -N2 is the one identical to srun argument list ? (in valgrind4hpc call)
    -   yes: it sets the number of nodes used for the underlying srun command used by valgrind4hpc
        -   but -n1 is given by valgrid arg
    - yes -n is the number of processes used by valgrind4hpc (and also the number of processes for the underlying srun command used by valgrind4hpc)
        -    valgrind4hpc –n1 --launcher-args... gives me cannot find exec n1
        -    when I post the code line I cannot edit anymore; trying to modify pi_threads.slurm; added module load; put the srun args into --launcher-args; but -n1 seems to be a problem
    -   The launcher-args are for you to specify extra arguments about the distribution of the tasks (you don't put -n though)

6. With gdb4hpc in an interactive job, how to check I'm on the allocated compute node and not the login node? (hostname doesn't work there)
    -   the launch command in gdb4hpc uses an underlying srun command and thus, used the ressources of the salloc command 
        -   ok thanks, and theoretically in case of multiple allocated jobs, how to select which to use?
    -   focus p{0}, check the slides (page 24). The man page is also giving some good examples
        -   Sorry, I don't understand how to use the focus comand to select a job (not process). On page 24 I can see only how to select set of processes.
    -   Ah, you want to attach to an existing job? 
        -  yes, I mean if I allocate multiple interactive jobs and then I want to launch gdb4hpc on one of them
    -   You have to run gdb4hpc in the same salloc. You start salloc and then run the app under gdb4hpc. 
        -  ok, probably I have to check how really salloc works, I'm PBS user, thanks
    -   So, salloc gives you a set of reserved nodes and it will return with a shell on the login node. Then you can run `srun` to submit to the reserved nodes. The equivalent on batch processing is sbatch.
        -  oh I see, I was confused with the login shell - so even its a login, it is already linked with the particular interactive job (allocated nodes), right?
    -   correct, everyting you run after salloc with `srun` (gdb4hpc or valgrind4hpc use srun under the hood) will run on the reserved nodes. You can check that with salloc you get a lot of `SLURM_` environment variables set by SLURM, for example `echo $SLURM_NODELIST`
        - ok, understand, cool tip, thank you
    -   the corresponding PBS is `qsub -I`, if recall correctly...
        - yes, but it returns directly the first node shell
    -   ah, this can be configured on SLURM too (sysadmin SLURM conf). However, on LUMI you will still remain on the login node.

7.  When in an gdb4hpc session, I can switch to one process with `focus $p{0}`. But how do I get a listing of that process to see the source of where it is stuck or breaked?
    -   this is the standard gdb command then, for instance `where`
    -   use the list (short 1) gdb command. Since you "have" a focus on 0, gdb will list source file for process 0


8.  For the valgrind4hpc exercise, I did it a first time and got the expected output, then I fixed the code, recompiled and ran the ./hello directly to make sure it worked. However when running valgring4hpc again I still get the same output as the first time (whereas this time obviously there was no more bug): is there something I should have reset to get the correct output instead of:
    ```
    HEAP SUMMARY:
      in use at exit: 16 bytes in 1 blocks

    LEAK SUMMARY:
       definitely lost: 16 bytes in 1 blocks
       indirectly lost: 0 bytes in 0 blocks
         possibly lost: 0 bytes in 0 blocks
       still reachable: 0 bytes in 0 blocks

    ERROR SUMMARY: 31 errors from 109 contexts (suppressed 1259
    ```
    -   you have the same error on the 16 bytes lost because you do not free(test) in both cases. But the invalid write of size 4 are removed if you change test[6]= and test[10]= by for example test[2]= and test[3]=
        -   OK, so now I added free(test) and things seem to have improved:
            ```
            All heap blocks were freed -- no leaks are possible

            ERROR SUMMARY: 30 errors from 54 contexts (suppressed 1259)
            ```
            so there is no more leak and all blocks were freed, but why are there still 30 errors???
      -   these are in the libraries, no related to users. You can expect masking of those errors in the future.
      -   yes the library where the errors occur in the outputs is /usr/lib64/libcxi.so.1 and you can see the errors are in cxil_* functions from this library




## I/O Optimisation - Parallel I/O

9.  How does Lustre work with HDF5?

    -   HDF5 is built on top of MPI-IO, which means that HDF5 will make good use of all the underlying infrastructure provided for Lustre by MPI-IO.


### Exercise

!!! exercise
    Remarks:

    -    Exercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -    Directory for this exercise: `io_lustre`
    -    Copy the files to your home or project folder before working on the exercises.
    -    In some exercises you have source additional files to load the right modules necessary, check the README file.
    -    To run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_g.sh` (GPU) or `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU)
  
    Exercise

    -   Try out different Lustre striping parameters and use relevant MPI environment variables
        -    Do the environmental variables (like MPICH_MPIIO_HINTS) always prevail over what could be explicitely set in the code/script?
        

10. Do the environmental variables (like MPICH_MPIIO_HINTS) always prevail over what could be explicitely set in the code/script?
    - If you set striping on a file by lfs setstripe then that is fixed. For a directory then I expect an API or the envar to override the default policy when files are created.
    - I'm not sure if the envar will override something set explicity in an API, for example hints passed to an Open function, I would doubt it.


## Introduction to the AMD ROCm<sup>TM</sup> ecosystem

11. When we use `gres=gpu:2` are we guaranteed that the two dies will be on the same card?
    -   I doubt. The scheduler is not very good at assigning only a part of a GPU node. And the same actually holds for the CPU where you are not guaranteed to have all cores in, e.g., the same socket even if your allocations can fit into a single socket. If you are performance concerned you should really allocate nodes exclusively and then organise multiple jobs within the node yourself if you want to make good use of your GPU billing units.

12. Is there some slurm option gpus per node?
    -   I'm not sure how you would like to use it, as we only have one type of GPU node and as you would be billed the full node anyway even if you would use only two GPUs on a node as noone else can use them?
        -   Good point. 
    -   It actually exists in Slurm and you will see it in some examples in the documentation but it is one of those options that should be used with care as you may get more than you want. 

13. hipcc calls nvcc on nvidia platforms. What is it calling on amd platforms? Is it hip-clang?
    -   It is calling clang - HIP support has been upstreamed to the clang compiler.
    -   Basic idea is that `hipcc` calls `clang++ -xhip`. In practice it adds more flags. If you are really curious about what `hipcc` is doing, you can have a look at the [source code](https://github.com/ROCm-Developer-Tools/HIPCC).

14. On CUDA we can set --gpu-architecture=all, to compile for all supported architectures by this CUDA Toolkit version, this way our code is more portable. Is there a HIP equivalent to compile for all supported AMD architectures by this HIP version? I know we can set multiple architectures (using multiple uses of -offload-arch=), but is there also a way not to have to list them one by one (this would also make it future proof, so that we would not need to add new GPU architectures)?
    -   AMD can confirm but I don't think there is an equivalent to `--gpu-architecture=all` for the AMD GPUs compilation.
    -   No, there is not, as there is no promise of backward compatibility between ISAs for the different GPUs. Typically the relevant/tested targets are listed in the build system of an application. If not set explicitly, the tools will try to determine the GPUs available on the machine where the compile job is running. The GPUs are detected by the ROCm tools `rocminfo` and `rocm_agent_enumerate`. This means that the right automatic GPU identification happens if you compile in the compute nodes. I'd say, is always a good practice to list explicitly the targets.
    -   On the login nodes you can "trick" the `rocm_agent_enumerator` by setting an environment variable (`ROCM_TARGET_LST`) that points to a file with a list of targets. These targets will then be used by hipcc.

15. 4 SIMD per CU. Does this mean that 4 wavefronts are needed to utilize the CU 100%?
    -   No. You have 4 x 16-wide SIMD units. The wavefront is 64 wide. Each SIMD unit takes 4 cycles to process an instruction, as you have 4 of them you can imagine that, throughput wise, you have one wavefront being computed in each cycle.
        -   So the wavefront execution is splitted among the 4 SIMD units?
    -   Correct, having said that, most likely you want several wavefronts running to enable them to hide latencies from each other. 
            

16. What about the support for C++17 stdpar (GPU offloading) on LUMI. Is it possible? 
    -   Need to get back to you on that and check if the current version of clang enables that. I can say however that the thrust paradigm is supported and very much where the std::par inspiration comes from. 


### Exercises

!!! exercise
    Find the instructions [here](https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA)
    
17. I'm just compiled the exercise vectoradd.cpp, but I'm getting the following output:
    ```shell
    $ make vectoradd_hip.exe 
    /opt/rocm/hip/bin/hipcc --offload-arch=gfx90a -g   -c -o vectoradd_hip.o vectoradd_hip.cpp
    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LC_CTYPE = "UTF-8",
        LANG = (unset)
        are supported and installed on your system.
    perl: warning: Falling back to the standard locale ("C").
    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LC_CTYPE = "UTF-8",
        LANG = (unset)
        are supported and installed on your system.
    perl: warning: Falling back to the standard locale ("C").
    /opt/rocm/hip/bin/hipcc --offload-arch=gfx90a vectoradd_hip.o -o vectoradd_hip.exe
    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LC_CTYPE = "UTF-8",
        LANG = (unset)
        are supported and installed on your system.
    perl: warning: Falling back to the standard locale ("C").
    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LC_CTYPE = "UTF-8",
        LANG = (unset)
        are supported and installed on your system.
    perl: warning: Falling back to the standard locale ("C").
    ```
    But to my surprise I was able to submit and run the example:
    ```shell
    $ srun -n 1 ./vectoradd_hip.exe 
     System minor 0
     System major 9
     agent prop name 
    hip Device prop succeeded 
    PASSED!
    ```
    The questions are: 
    
    -   Is this normal? 
    -   am I forgetting something?

    Just for reference, I have loaded my PrgEnv as follows:
    
    ```shell
    $ salloc -N 1 -p small-g --gpus=1 -t 10:00 -A project_465000388
    salloc: Pending job allocation 2907604
    salloc: job 2907604 queued and waiting for resources
    salloc: job 2907604 has been allocated resources
    salloc: Granted job allocation 2907604
    $ module load rocm
    $ module load craype-accel-amd-gfx90a
    $ module load PrgEnv-amd
    ```
     
    -   These are error messages coming from Perl which I assume is used in the hipcc wrapper. This error message has little to do with our system and likely more to do with information that your client PC passes to LUMI. When I log on to LUMI I have LANG set to `en_US.UTF-8` but I remember having problems one one system (don't remember if it was LUMI) when logging in from my Mac as it tried to pass a locale that was not supported on the system I was logging on into. It is not something you will correct with loading modules.

    -   The LOCAL warnings are harmless when it comes to the code generation. I have in my SSH configuration:
        ```shell
        Host lumi*
        SetEnv LC_CTYPE="C"
        ```
    -   You could also try `export LC_ALL=en_US.utf8` or some other language.

18. I get the following output when I request `hipcc --version`: 
    ```shell
    $ module load PrgEnv-amd
    $ module load craype-accel-amd-gfx90a
    $ module load rocm
    $ hipcc --version
    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LC_CTYPE = "UTF-8",
        LANG = (unset)
        are supported and installed on your system.
    perl: warning: Falling back to the standard locale ("C").
    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LC_CTYPE = "UTF-8",
        LANG = (unset)
        are supported and installed on your system.
    perl: warning: Falling back to the standard locale ("C").
    HIP version: 5.0.13601-ded05588
    AMD clang version 14.0.0 (https://github.com/RadeonOpenCompute/llvm-project roc-5.0.2 22065 030a405a181176f1a7749819092f4ef8ea5f0758)
    Target: x86_64-unknown-linux-gnu
    Thread model: posix
    InstalledDir: /opt/rocm-5.0.2/llvm/bin
    ```

    -   See the previous question, it is the same issue.

19. I'm getting annoying output from the hipify-perl.sh script
    
    ```bash
    $ROCM_PATH/hip/bin/hipify-perl -inplace -print-stats  nbody-orig.cu 
    perl: warning: Setting locale failed.
    perl: warning: Please check that your locale settings:
        LANGUAGE = (unset),
        LC_ALL = (unset),
        LC_CTYPE = "UTF-8",
        LANG = (unset)
        are supported and installed on your system.
    perl: warning: Falling back to the standard locale ("C").
      info: converted 10 CUDA->HIP refs ( error:0 init:0 version:0 device:0 context:0 module:0 memory:4 virtual_memory:0 stream_ordered_memory:0 addressing:0 stream:0 event:0 external_resource_interop:0 stream_memory:0 execution:0 graph:0 occupancy:0 texture:0 surface:0 peer:0 graphics:0 interactions:0 profiler:0 openGL:0 D3D9:0 D3D10:0 D3D11:0 VDPAU:0 EGL:0 thread:0 complex:0 library:0 device_library:0 device_function:3 include:0 include_cuda_main_header:0 type:0 literal:0 numeric_literal:2 define:0 extern_shared:0 kernel_launch:1 )
      warning:0 LOC:91 in 'nbody-orig.cu'
      hipMemcpy 2
      hipLaunchKernelGGL 1
      hipFree 1
      hipMemcpyDeviceToHost 1
      hipMalloc 1
      hipMemcpyHostToDevice 1
    ```
    
    but I can see that the script produced the expected modifications. Is there a way to correct this so I can obtain the expected output?
    
    -   See the two previous questions
    -   did you login from a Mac?
    -    setting LANGUAGE=C or something like that should fix the problem. This is a Linux issue that your LANGUAGE is not set. It was also an issue mentioned in previous days. I'd have to look up the exact syntax and variables to set. I think there was a solution posted a day or two ago that if you are on a Mac you can set something in the terminal program to set these variables.


18. make gives error; does it need additional modules ? I sourced the setup_LUMI-G.sh
    -   You can use the ROCm stack directly without using the CPE modules if you want if you don't need integration with MPI etc.. There are a set of module commands at the top of the document.
    -   See below, the order of modules at the top of the docuement are not correct.
        -   but where should the vectoradd example be made ? 
        -   Ah, sorry, make was trying to execute vectoradd; which failed; so the build must be done one a gpu node ?
        -   where to do need to salloc here ?
        -   I made and salloc -n1 --gres=gpu:1 now; module swapped to PrgEnv-amd; make clean & make vector... ; then srun -n 1 ./vector...exe; error message ierror while loading shared libraries: libamdhip64.so.5
    -   execute module load rocm
        -   okay, PASSED; thanks


19. I get the error: Lmod has detected the following error:  Cannot load module "amd/5.0.2" because these module(s) are loaded:
    rocm
    -   unload rocm. I suggest to load `PrgEnv-amd`
    -   The rocm module of the Cray PE is for use with the GNU and Cray compilers. The `amd` module is the compiler module for `PrgEnv-amd` and provides these tools already.
        - When I try 'module load PrgEnv-amd', I got the same error
    -   Then use the universal trick in case of errors: Log out and log in again to have a proper clean shell as you've probably screwed up something in your modules. Just after login, `PrgEnv-amd` should load properly unless you screwed up something your `.profile` or `.bashrc` file.
    -   Another solution is to modify the LD_LIBRARY_PATH
    -   export LD_LIBRARY_PATH=/opt/rocm/llvm/lib:$LD_LIBRARY_PATH 
    -   The error is because the front-end has rocm 5.0.2 and the compute node has rocm 5.1.0. Going to /opt/rocm avoids the problem. You can also compile on the compute node (srun make) and it will avoid the problem.

20. Module swap PrgEnv-cray PrgEnv-amd causes this error ?
    ```
    Lmod has detected the following error:  Cannot load module "amd/5.0.2" because these module(s) are loaded:
    rocm

    While processing the following module(s):
    Module fullname   Module Filename
    ---------------   ---------------
    amd/5.0.2         /opt/cray/pe/lmod/modulefiles/core/amd/5.0.2.lua
    PrgEnv-amd/8.3.3  /opt/cray/pe/lmod/modulefiles/core/PrgEnv-amd/8.3.3.lua'
    ```

    - same as the previous question, unload rocm. Note that PrgEnv-amd is using rocm under the hood
        - When I try 'module load PrgEnv-amd', I got the same error
    - Did you run `module unload rocm` first?


21. When the command is applied `salloc -N 1 -p small-g --gpus=1 -t 10:00 -A project_465000388`, I am getting the following error message `salloc: error: Job submit/allocate failed: Requested node configuration is not available`
    -   This works for me. Try to reset your environment see if it helps.
        -   logout & login again to lumi, it works fine now, thank you!


22. Can somone confirm the correct order of the module commands listed at the top of the training page. https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA

    -   Yes, indeed, the order is incorrect. Please use:
        ```
        module rm rocm
        module load craype-accel-amd-gfx90a
        module load PrgEnv-amd
        module load rocm
        ```
        
        (I have confirmed that is the right order)
    
        -   what about ? source /project/project_465000388/exercises/HPE/lumi_g.sh

    -   This file is to set SLURM, no relation with modules. And it was for the HPE exercises

23. Nob question: where are located the perl scripts to test hipify the examples?
    -   /opt/rocm/bin/hipify-perl They are inside ROCm bin directory 

24. I am getting errors when I try to run for instance `./stream`:
    ```
    srun: Job xxx step creation still disabled, retrying (Requested nodes are busy)
    ```
    What does it mean (I did the salloc, etc.)?
    
    -   try `srun -n 1 ./stream `
        - This is what I did
    -   was the salloc success? or maybe you wait for a free node? run: srun -n 1 hostname
        -   I had the impression that I was allocated a node, but srun -n 1 hostname is stalled
    -   ok run salloc again and wait to be sure  
        -   Did everything again and now I get this error:
            ```
            srun: error: nid005062: task 0: Segmentation fault (core dumped)
            srun: launch/slurm: _step_signal: Terminating StepId=2908932.4
            ```

25. Once I  login to LUMI, I got the following modules:
    ```
    Currently Loaded Modules:
      1) craype-x86-rome      3) craype-network-ofi       5) xpmem/2.4.4-2.3_9.1__gff0e1d9.shasta   7) craype/2.7.17      9) cray-mpich/8.1.18      11) PrgEnv-cray/8.3.3      13) lumi-tools/23.01 (S)
      2) libfabric/1.15.0.0   4) perftools-base/22.06.0   6) cce/14.0.2                             8) cray-dsmml/0.2.2  10) cray-libsci/22.08.1.1  12) ModuleLabel/label (S)  14) init-lumi/0.1    (S)

      Where:
       S:  Module is Sticky, requires --force to unload or purge
    ```
    Supposing that now I want to run on the GPU partition, what's the recommend modules I should load or swap? I've seen a few ways of loading the modules, but I wonder if there's one recommended way of doing that. Specifically I'd like to run a code with HIP and GPU-aware MPI. Also, what should I do if I'm to install a new library using the interactive node.

    -   You have a few different options. You can run with the Cray and AMD and I think the GNU Programming Environments. The modules need to loaded in the proper order or a fix used for the path to work around the different rocm paths on the front-end and the compute node. Your choice between these three options is usually driven by what your code is usually compiled with. All of them have rocm support for the HIP code. The only question is if there is an issue with GPU-aware MPI, but I think it works with all of them.
    -   You can enable GPU-aware MPI via `export MPICH_GPU_SUPPORT_ENABLED=1`. Check HPE slides on MPI (day 2) for more details.

26. For Exercise 2: Code conversion from CUDA to HIP using HIPify tools (10 min) it says that `hipify-perl.sh is in $ROCM_PATH/hip/bin` however I cannot see it in `/opt/rocm/hip/bin`: is it `hipify-perl` (without `.sh`) that we should use? 
    -   yes sorry use `hipify-perl`   -   I think this changed with ROCm versions. This version is `hipify-perl` and later ones use `hipify-perl.sh`
        -   could be, I will check 


## AMD Debugging: ROCgdb

29. (How) does ROCgdb with multiple nodes/GPUS? or what are the differences to gdb4hpc in the end?
    -   (Alfio) gdb4hpc enables debugging of MPI applications, then you can use it to debug GPU kernels too. For GPU, gdb4hpc uses rocgdb
    -   note that we do need a software update to enable GPU kernel debugging (breaking inside the kernel) with gdb4hpc at the moment

### Exercise

!!! exercise
    Find the instructions [here](https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA?view#Debugging)
    Try the debugging section.

    To get the `saxpy.cpp` file:

    -   Get the exercise: `git clone https://github.com/AMD/HPCTrainingExamples.git`
    -   Go to `HPCTrainingExamples/HIP/saxpy`

    Also try the TUI (graphical interface) with `rocgdb -tui` interface
    Hint: Get an interactive session on the compute node to use the TUI interface with: 
    ```
    srun --interactive --pty [--jobid=<jobid>] bash
    ```
    which assumes that you already have an allocation with `salloc`.

    The slides of the presentation are available on LUMI at `/projappl/project_465000388/slides/AMD/02_Rocgdb_Tutorial.pdf`

30. Where exactly "saxpy" (Go to HPCTrainingExamples/HIP/saxpy) is located? in /project/project_465000388/exercises/AMD/HIP-Examples/ ?
    -   Get the exercise: 
        ```
        git clone https://github.com/AMD/HPCTrainingExamples.git
        ```
    -   Go to `HPCTrainingExamples/HIP/saxpy`


## Introduction to Rocprof Profiling Tool

31. It is a more general question, rather than practical. Some of us participate in EU projects and utilise AMDs technology, can you suggest how we can effectively implement Digital Twin Objects $applications, using this monitoring interface? Just suggetions => We can discuss it tomorrow during the Q&A!

    -   (Harvey) For anyone interested in CSC/LUMI connection here have a look at https://stories.ecmwf.int/finlands-csc-leads-international-partnership-to-deliver-destination-earths-climate-change-adaptation-digital-twin/index.html


### Exercises

!!! exercise
    Find the instructions [here](https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA?view#Rocprof).
    Try the _rocprof_ section.

    The slides of the presentation are available on LUMI at `/projappl/project_465000388/slides/AMD/03_intro_rocprof.pdf`


32. Can you refer where/when the "manual" from your colleague will be published?
    -     What do you mean by manual?
          -     The presenter mentioned, that some of his colleagues is preparing some kind of manual about rocm profiling (probably metrics, counters, etc.). I would be interested in that, so I'm basically just asking where to look.

33. I am getting an error message that the module called "rocminfo" is not loaded (when "rocprof --stats nbody-orig 65536" is executed)
    -   rocminfo should be in the path, not a module. Could this be a path or environment problem? 
        -   rocprof --stats nbody-orig 65536
            ```
            RPL: on '230216_180254' from '/opt/rocm-5.0.2/rocprofiler' in '/...path.../HPCTrainingExamples/HIPIFY/mini-nbody/hip'
            RPL: profiling '"nbody-orig" "65536"'
            RPL: input file ''
            RPL: output dir '/tmp/rpl_data_230216_180254_38827'
            RPL: result dir '/tmp/rpl_data_230216_180254_38827/input_results_230216_180254'
            65536, 6227.599
            Traceback (most recent call last):
            File "/opt/rocm-5.0.2/rocprofiler/bin/tblextr.py", line 777, in <module>
                metadata_gen(sysinfo_file, 'rocminfo')
            File "/opt/rocm-5.0.2/rocprofiler/bin/tblextr.py", line 107, in metadata_gen
                raise Exception('Could not run command: "' + sysinfo_cmd + '"')
            Exception: Could not run command: "rocminfo"
            Profiling data corrupted: ' /tmp/rpl_data_230216_180254_38827/input_results_230216_180254/results.txt'
            ```
    -   Definitely a path problem due to the mismatch in ROCm versions. Try
        ```
        export LD_LIBRARY_PATH=/opt/rocm/llvm/lib:$LD_LIBRARY_PATH
        ```
        You can see that it is trying to load rocm 5.0.2. Loading the modules in the right order will also fix the problem. You can see this by doing a srun ls -l /opt and you will see that compute nodes have /opt/rocm-5.1.0.
        -   But there is only rocm/5.0.2 available, it is loaded by default (checked with module list)
            Which order is correct??

    -   Try
        ``` 
        module rm rocm
        module load craype-accel-amd-gfx90a
        module load PrgEnv-amd
        module load rocm
        ```
    - login nodes have rocm/5.0.2, while compute nodes have rocm/5.1.0. Try `export PATH=/opt/rocm:$PATH` (same for LD_LIBRARY_PATH). Check question 19.
    
    

