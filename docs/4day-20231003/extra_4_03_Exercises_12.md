# Exercise session 12

<!--
No materials available at the moment.
-->

<!--
-    Overview exercises day 1-4 temporarily available on
     [this link](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-4_Exercises_day4.pdf)
-->

-   See the exercise notes in  `/project/project_465000644/slides/HPE/Exercises.pdf` 
    for the exercises (for the lifetime of the project).

-   Files are in 
    `/project/project_465000644/exercises/HPE/day3` (for the lifetime of the project).

-   Permanent archive on LUMI:

    -   Exercise notes in `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_HPE.pdf`

    -   Exercises as bizp2-compressed tar file in
        `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_HPE.tar.bz2`

    -   Exercises as uncompressed tar file in
        `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_HPE.tar`


## Q&A


3.  What is the expexcted difference between -O1 and -O3 in day4/node_performance test? Suprisingly I got longer total time for -O3 (37.668011) than for -O1 (37.296712) and I wondering is this is completely outside expected range or the optimizations produce similar results in this case? Thanks!

    -   Is optimization level in Makefile overwritten by command-line-set value?
    -   Are you sure? It looks like both are using the same optimization level, the difference is well within noise and differences between nodes.

    Is there a way to verify which optimization was used in each run?
    
    -   The goal of the exercise is not to compare runtimes though but compare the output of the profiler which may point to different problems in some part of the code. I do indeed also get very similar performance otherwise.

    Ohh, thanks for explanation, I supposed there will be also a noticeble performance boost so I was wondering whether I am doing something wrong...
    
    -   I just tried the exercise myself and the results are strange. I'll try to figure out who made that exercise but he's not here at the moment. It might be that it was tested with a different or older compiler that gave other results or had worse optimisation at `-O1`. With `-O0` you do see significant differences and one particular loop operation that takes a lot more time.

    I tried -O0 and got also a significant slowdown (75.074496) so probably in this case -O1 and -O3 just led to similar compute times and there was no error...

    -  This is indeed what I suspect, the exercise needs an update...

