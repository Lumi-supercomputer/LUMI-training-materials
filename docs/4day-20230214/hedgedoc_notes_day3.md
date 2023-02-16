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

