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

!!! info "Exercise"
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
!!! info "Exercise"
    Remarks:

    -    Exercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -    Directory for this exercise: `io_lustre`
    -    Copy the files to your home or project folder before working on the exercises.
    -    In some exercises you have source additional files to load the right modules necessary, check the README file.
    -    To run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_g.sh` (GPU) or `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU)
  
    Exercise

    -   Try out different Lustre striping parameters and use relevant MPI environment variables
        -    Do the environmental variables (like MPICH_MPIIO_HINTS) always prevail over what could be explicitely set in the code/script?
        
:::

