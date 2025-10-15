# Scalable Parallel Programming with Chapel: From Multicore CPUs to GPU-Powered Supercomputers

**Presenter:** [Engin Kayraklioglu (HPE)](https://chapel-lang.org/blog/authors/engin-kayraklioglu/)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20251015-user-coffee-break-Chapel.mp4" controls="controls"></video>


## Q&A

*Below is a very short summary of the questions asked during the presentations,
with some links added to it. The full question session is part of the recording
(but without the voice or name of those asking questions).*

1.  Any workshops for Chapel?

    -   The annual ChapelCon focusses on applications and tutorials. The content becomes available on the 
        [Chapel website](https://chapel-lang.org/) some weeks after the conference. Talks are also put on [YouTube](https://www.youtube.com/@ChapelLanguage).

        [ChapelCon '25](https://chapel-lang.org/chapelcon25/) was just a week before the seminar...

1.   Chapel is based on LLVM. Are you experimenting with MLIR?
     -   Chapel used to use a C backend but now goes to LLVM IR directly. But it is a big jump to use MLIR instead of LLVM IR.   

2.  Is it possible to interface with existing BLAS/LAPACK libraries in Chapel?
    -   Yes, there is strong C interoperability that can be used to bind to BLAS and LAPACK libraries. There are even package modules in Chapel for BLAS and LAPACK.
    -   There is also a linear algebra library that does all that under the hood.
    -   Chapel will always have to co-exist with other languages so it is important to have interoperability. 
        C has always been strong, but now there is also interoperability with Python. There is also Fortran interoperability.

3.  How debuggable is a Chapel application

    -   Not very good in the beginning, but it is starting to improve. 
        You can now use `lldb` to debug Chapel applications and inspect data. 
        The team is also working on a proper debugger wrapper to also inspect, e.g., 
        how on-constructs work. This is in fact a new feature in 2.6.0. 
        There are also demos on YouTube, e.g., a 
        [talk from ChapelCon '24](https://www.youtube.com/watch?v=joZ62lN_5P8).

4.  Julia seems to have the same objectives and functionality that Chapel has. So why choose Chapel over Julia?

    -   There are differences in philosophy. Julia focuses strongly on scientific computing, 
        and started with that in mind. Parallel programming is added on top of it. 
        Chapel started with parallelism in mind, and applications in scientific computations came from that. 
        But Julia has a better environment for scientific computing, but the Chapel team claims that they 
        will outperform Julia on large machines.

    -   JuliaCon has had a [short Chapel versus Julia talk](https://pretalx.com/juliacon-2025/talk/XKRPXC/) 
        and a [Chapel loves Julia BoF](https://pretalx.com/juliacon-2025/talk/DADLAW/) in their last edition. 
        ChapelCon 25 also had a [keynote speaker of MIT](https://chapel-lang.org/chapelcon25/#keynote). 
        So the communities do interact.



