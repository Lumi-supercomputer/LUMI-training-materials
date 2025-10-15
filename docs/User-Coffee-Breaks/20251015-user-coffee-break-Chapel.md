# Scalable Parallel Programming with Chapel: From Multicore CPUs to GPU-Powered Supercomputers

**Presenter:** [Engin Kayraklioglu (HPE)](https://chapel-lang.org/blog/authors/engin-kayraklioglu/)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20251015-user-coffee-break-Chapel.mp4" controls="controls"></video>


## Q&A
 
1.  Any workshops for Chapel?

    -   Anual ChapelCon focusses on applications and tutorials. Content available on the website some weeks after the conference.
        -   And talks are also on YouTube

2.   Chapel is based on LLVM. Are you experimenting with MLIR?
     -   Used to use a C backend but now goes to LLVM IR directly. But it is a big jump to use MLIR instead of LLVM IR   

3.  Is it possible to interface with existing BLAS/Lapack libraries in Chapel?
    -   Yes, strong C interoperability that can be used to bind to BLAS and LAPACK libraries. There are even package modules in Chapel for BLAS and LAPACK.
    -   There is also a linear algebra library that does all that under the hood.
    -   Chapel will always have to co-exist with other languages so it is important to have interoperability. C has always been strong, but now there is also interoperability with Python. There is also Fortran interoperability.

4.  How debuggable is a Chapel application

    -   Not very good in the beginning, but starting to improve. You can now use lldb to debug Chapel applications and inspect data. The team is also working on a proper debugger wrapper to also inspect, e.g., how on-constructs work. This is in fact a new feature in 2.6.0. There are also demos on YouTube.

5.  Julia seems to have the same objectives and functionality that Chapel has. So why choose Chapel over Julia?

    -   Differences in phylosophy. Julia focuses strongly on scientific computing, and started with that in mind. Parallel programming is added on top of it. Chapel started with parallelism in mind, and applications in scientific computations came from that. But Julia has a better environment for scientific computing, but the Chapel team claims that they will outperform Julia on large machines.
    -   JuliaCon has had a Chapel versus Julia BoF in their last edition. ChapelCon 25 also had a keynote speaker of MIT. So the communities do interact.



