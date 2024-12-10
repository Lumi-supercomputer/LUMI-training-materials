# The HPE Cray Programming Environment

*Presenter: Kurt Lust*

As Linux itself is not a complete supercomputer operating system, many components
that are essential for the proper functioning of a supercomputer are separate packages
(such as the [Slurm scheduler](M07-Slurm.md) discussed later in this course) or part 
of programming environments. 
It is important to understand the consequences of this, even if all you want is to simply
run a program.


## Materials

<!--
Materials will be made available during and after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20241210/recordings/02-CPE.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20241210/files/LUMI-2day-20241210-02-CPE.pdf)

-   [Course notes](02-CPE.md)

-   [Exercises](E02-CPE.md)


## Q&A

1.  When using pytorch on LUMI everything looks as if it has cuda. How is it possible?
    
    -   It is legacy from when CUDA was the only language for that. AMD tried to map everything 1:1 to nvidia, to ease the adoption of his toolchain so python people didn't even bother to change names

2.  Are there any profiling tools available on the gpus, or any that are particularly recommended?
 
    -   In our documentation we cover some tools that HPE offers: https://docs.lumi-supercomputer.eu/development/profiling/strategies/.

    -   AMD ROCm also comes with tools specifically for the AMD GPUs. In ROCm 6.2 they have been improved a lot, and some that were considered research projects are now production tools. We do have a module on the system for ROCm 6.2, but cannot guarantee full compatibility with the current compilers and MPI library. Our AI users are already using ROCm 6.1 and 6.2 extensively in containers.
 
    -   If you want to learn more about profiling, in October we had a course that covered profiling. The recordings and material can be found in our training material archive: https://lumi-supercomputer.github.io/LUMI-training-materials/Profiling-20241009/. Likely we will have a course like this somehwere in 2025. There is also a lot of material in our Advanced LUMI course about the HPE and AMD tools.

3.  Is the OpenMP implementation buggy for the Fortran compiler or also for the C++? Sorry, I didn't quite get that. Kurt just mentioned some bugs in the OpenMP implementation, but I didn't catch whether it was Fortran-specific or not. No worries! :) thanks

    -    Which compiler? in general, there may be different in cray compiler or gnu compiler or amd compiler. They use different backend for openmp (gnu uses libgomp, clang uses libomp, and cray has craymp.) you cannot really know if something has bugs, from a SW engineering perspective that is a undecidable problem so you have to think that it may always happen. It is not really common though, as they are tested. The one i think Kurt mentioned is the omp-offload for the gnu stack, which is not even active because there is not great support from amd side for gnu compilers. And i think this applies to all gnu compiler (fortran, c, c++), never tested though.

    -    (Kurt) We do have a lot of problems with OpenMP offload and OpenACC in the Cray Fortran compiler. Yet this is still the best option for some users as currently there is no support for that in our GNU compilers (and performance would be very poor anyway) and this is also a work-in-progress on the AMD LLVM-based compilers, where really the big step forward is expected from the switch to the new Flang codebase. I believe that with ROCm 6.3 they will start offering these compilers publicly as an alternative, and maybe by the end of next year or so they may become the default. With the HLRS system that will be AMD (Stuttgart Germany) and the large Fortran codebase they have there, AMD is becoming more and more serious about improving their Fortran support.


