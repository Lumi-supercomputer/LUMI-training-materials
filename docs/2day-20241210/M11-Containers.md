# Containers on LUMI-C and LUMI-G

*Presenter: Kurt Lust*

Containers are a way on LUMI to deal with the too-many-small-files software
installations on LUMI, e.g., large Python or Conda installations. They are also a 
way to install software that is hard to compile, e.g., because no source code is
available or because there are simply too many dependencies.


## Materials

<!--
Materials will be made available during and after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20241210/recordings/11-Containers.mp4" controls="controls"></video>

-   [Slides](https://462000265.lumidata.eu/2day-20241210/files/LUMI-2day-20241210-11-Containers.pdf)

-   [Course notes](11-Containers.md)

<!--
-   A video recording will follow.
-->


## Q&A

1.  In the example of the Distributed Learning, there are 8 tasks per node requested, shouldn't it be 7, because one is reserved for the OS?

    -   No, each node contains 8 GCDs. Typically you would run one task per GCD, so 8 in total. I think you may be confused with the number of CPUs that is available per GPU. On a LUMI-G node we have 64 CPU cores and 8 GPUs. So there are 8 CPUs per GPU, however since we operate the nodes in "low-noise mode" we reserve 1 CPU core for the OS. As a result you can only request 7 CPUs per GPU.

2.  I have also heard of [MPI trampoline](https://github.com/eschnett/MPItrampoline) which promises more universal access to MPI in the system when installing a software by forwarding mpi related variables. Or is this not well developed for using on LUMI yet?

    -   All those translation libraries don't do miracles. And many work in the wrong direction: 
        You link to the translation library and that one then give you access to several specific implementations. MPI trampoline is of that type: You link MPI trampoline in the application and then when you run you can chose between different MPI implementations. It also does not support Fortran according to its GitHub which already excludes some codes. 
       
        A similar example is [FlexiBLAS](https://www.mpi-magdeburg.mpg.de/projects/flexiblas) for BLAS: You link to the FlexiBLAS libraries, but then at runtime you can chose between a number of options. So that only helps us in the container story if the applications in the container would be built with such an MPI library. To be fair, there are some that do runtime translation where the application is linked with one of the regular MPI libraries, and the portability library then pretends to be that library and translates calls instead to another MPI library. The `mpixlate` module on LUMI contains such a tool. 
        
        One problem with tools like MPI trampoline and FlexiBLAS is that you must ensure that when you compile an application, it picks up MPI trampoline and FlexiBLAS instead of the regular MPI libraries and whatever BLAS library you have on the system. Which may be less than trivial as few if any installer knows about those libraries and will auto-detect them as the first candidate,

        Another such example is [wi4mpi](http://pm.epicure-hpc.eu/) which is used on the Irene Joliot-Curie supercomputer at TGCC. It actually supports both modes of operation.


