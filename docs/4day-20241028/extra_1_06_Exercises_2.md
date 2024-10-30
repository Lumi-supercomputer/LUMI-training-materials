# Exercise session 2: Compilers

The exercises are basically the same as in 
[session #1](extra_1_04_Exercises_1.md). You can now play with different
programming models and optimisation options.


## Materials

<!--
No materials available at the moment.
-->

Temporary location of materials (for the lifetime of the training project):

-   See the exercise assignments in
    `/project/project_465001362/Slides/HPE/Exercises.pdf`

-   Exercise materials in 
    `/project/project_465001362/Exercises/HPE/day1/ProgrammingModels`.

    See `/project/project_465001362/Exercises/HPE/day1/ProgrammingModels/ProgrammingModelExamples_SLURM.pdf`

<!--
Temporary web-available materials:

-    Overview exercise assignments day 1 temporarily available on
     [this link](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-1_Exercises_day1.pdf)

-    Exercise notes (ProgrammingModelExamples_SLURM.pdf) on
     [this link](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-1_04a-ProgrammingModelExamples_SLURM.pdf).
-->

<!--
Archived materials on LUMI:

-   Exercise assignments in `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-Exercises_HPE.pdf`

-   Exercises as bizp2-compressed tar file in
    `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-Exercises_HPE.tar.bz2`

-   Exercises as uncompressed tar file in
    `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-Exercises_HPE.tar`
-->


## Q&A

12. Is this an expected result that when I switch compilers from Cray to GNU I get 
    pi_threads and pi_hybrid tests twice faster execution time? (i.e. cray binaries 
    run slower than gnu compiled versions)

    -   (Alfio) with a single thread? Do yo get any warning? I can speculate that CCE does a default binding, so all threads will use the same cores. In any case, the exercise is not meant to check the performance, rather to get familiar with modules and compilers.

    -   (Kurt) A bit surprising, but I didn't check. The default OpenMP behaviour of CCE is actually very decent. On the other hand, the default in GNU is to use `-O0` so if you don't specify proper optimisation options, the GNU compiler tends to be the slowest. Note though that if you are running on the login nodes, timings can be unreproducible.

    Thanks for your insights. I was suprised too. I get the speed-up for all models: serial (just 20% though), thread (OpenMP) and hybrid (mpi+OpenMP). I know it is just a simple test, but this was a funny result. Maybe the test is too small to show any scalability performance gains from Cray profiling.


