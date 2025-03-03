# The HPE Cray Programming Environment

*Presenter: Kurt Lust (LUST)*

As Linux itself is not a complete supercomputer operating system, many components
that are essential for the proper functioning of a supercomputer are separate packages
(such as the [Slurm scheduler](M201-Slurm.md) discussed later in this course) or part 
of programming environments. 
It is important to understand the consequences of this, even if all you want is to simply
run a program.


## Materials

<!--
Materials will be made available after the lecture
-->
<!--
<video src="https://462000265.lumidata.eu/2p3day-20250303/recordings/102-CPE.mp4" controls="controls"></video>
-->

-   A video recording will follow.

-   [Slides](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-102-CPE.pdf)

-   [Course notes](102-CPE.md)

-   [Exercises](E102-CPE.md)


## Q&A

1.  Why there is no OpenACC for C++?

    *   There is no compiler that supports this available on LUMI. All compiler families (clang, gnu) are focussed on OpenMP.

    *   Both AMD and Cray have chosen for OpenMP as the more open way to go forward. As said, OpenACC is too much controlled by NVIDIA making other vendors unhappy. Intel has also chosen for OpenMP for their GPUs.  There is work going on in the Clang community for OpenACC support, but it is unclear if AMD and/or Cray would use that in their distribution of the compilers.

2.  For MPI-CPU jobs, are GNU compilers recommended over AMD ones ?

    *   Not really. I'd say that they are more or less equivalent. AMD have some optimizations targeting their CPUs. I'd try both and profile :D But keep in mind that there may be some non-standard extensions to language that may break some code. It is quite common with fortran, less with C/C++.

    I'll have a try then! It's mostly C++. Both would work with the same MPI though? (Is it better to have a second bulet point or a new question ?)

    *   the stack lecture will clarify this. but in the end, yes they use the same cray-mpich

3.  If I load a module for LUMI-C (Milan I think?) can i still compile my code on the login node?

    -   Yes, we will cover that later today. But you can load modules that set the correct target architecture to compile for LUMI-C on a login node: see [this page](https://docs.lumi-supercomputer.eu/development/compiling/prgenv/#choosing-the-target-architecture_) in our documentation. However, be mindfull with compiling on the login nodes. It is a shared resource and if you have a large build, you should use a job for compiling.

    -   This process is called cross-compiling. Most of the time, this works fine, but it depends on the installation process of the code. There are codes that in their configure script automatically add options to compile for the CPU you are compiling on and overwrite the other settings, and with that kind of ill-behaved applications it does not work.
