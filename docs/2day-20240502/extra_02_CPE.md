# The HPE Cray Programming Environment

A video recording will follow.

<!--
Materials will be made available after the lecture
-->

Extra materials

-   [Slides](https://462000265.lumidata.eu/2day-20240502/files/LUMI-2day-20240502-02-CPE.pdf)

-   [Course notes](02_CPE.md)


## Q&A

2.  Are there plans to bump the available rocm version in the near future ?

    -   It is planned in summer 

    -   But LUMI will never be on the bleeding edge. It is a small effort to do so 
        on a workstation because it has to work only for you so you upgrade whenever 
        you are ready. It is a big upgrade on a supercomputer as it has to work with 
        all other software also. E.g., users relying on GPU-aware MPI would not like 
        that feature to be broken just because some AI people want the latest ROCm to 
        use the latest nightly PyTorch build. GPU software stacks consist of lots of 
        libraries running on top of a driver, and you can have only one driver on the 
        system and each driver support only a limited range of library versions. 
        So you can see that it is hard to keep everybody happy... 
        Basically we have to wait until it is supported in all components that are 
        important in LUMI for all users.

