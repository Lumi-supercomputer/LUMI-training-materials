# Performance Optimization: Improving Single-core Efficiency

*Presenter: Jean Pourroy (HPE)*

<!--
Course materials will be provided during and after the course.
-->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001362/Slides/HPE/13_cpu_performance_optimization.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-4_02_Performance_Optimization_Improving_Single_Core.pdf`

<!--
-   Recording: `/appl/local/training/4day-20241028/recordings/4_02_Performance_Optimization_Improving_Single_Core.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  How cache-misses are measured actually?

    -   Using hardware counters. Was that your question?

    Question: I mean which tools are used ? I might have missed sorry.

    -   Profiling software will usually show them, if it can access them.


2.  Can we programmatically see the size of cache lines and the associativity of the caches?

    -   The cache line is partially standardized by the size of memory transfer to DRAM, and so can be taken as a constant: 64. This can be tested programmatically by disabling pre-fetching. The associativity of caches would most easily be found in hardware manuals..

3.  What block size is recommended for cache blocking for each precision?

    -   As a cache line is 64 bytes, you could say 8 double precision of 16 single precision numbers. But it is more complicated than this. Basically you make your block size such that the "hot" data fits in the L2 data cache, and uses it as optimally as possible. Too small blocks may, e.g., give you gain too much loop overhead or make it impossible to use loop unrolling, which then could make it impossible to use the floating point units efficiently. On LUMI the vector units are half the cache line width and there are two of those, but then it takes 4 or 5 cycles before you can use the result in the next computation, so you'd want to unroll loops to work with 8 or 10 times the vector width in a single loop iteration.

        The talk was really just an introduction to make you aware of the issues. It takes a longer course to learn all the tricks. PRACE used to organise such courses, I'd expect they will reappear in the EuroHPC program. There are some people form the FAU Erlangen-Nurmberg who are particularly good at teaching this, but when I took that course, it was a three day course by itself rather than a 40 minute talk.

