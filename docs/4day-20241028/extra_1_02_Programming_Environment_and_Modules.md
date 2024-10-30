# Programming Environment and Modules

*Presenter: Harvey Richardson (HPE)*

<!--
Course materials will be provided during and after the course.
-->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001362/Slides/HPE/02_PE_and_Modules.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-1_02_Programming_Environment_and_Modules.pdf`

<!--
-   Recording: `/appl/local/training/4day-20241028/recordings/1_02_Programming_Environment_and_Modules.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

6.  You said you never use the GNU toolchain. Is it because it deteriorates the performance?
    It's usually the most compatible toolchain for scientific codes.

    -    I think you misunderstood. We never use the GNU compilers directly, 
         but use them via the wrappers. However, performance wise, gfortran is bad 
         compared to Cray Fortran. And the scientific community should get rid of GNU. 
         We're one of the last communities still using it that much. 
         E.g., all GPU compilers from vendors are based on LLVM with clang for C. 
         For Fortran though, the LLVM ecosystem is still a bit messy.


7.  It was mentioned that the Cray compiler uses LLVM as a backend. 
    Would other languages that use LLVM like Julia and Rust have good performance out 
    of the box or can  the performance be improved by some configurations?

    -   No really, for C/C++ there are some optimizations at the front-end level 
        (see first presentation of this afternoon), then the standard LLVM is 
        used (17.0.1) as backend. Note that we don't provide the entire LLVM stack. 
        Another LLVM-based compiler is AMD. 
    -   Julia is not easy to build yourself so you typically have to do with the build 
        the Julia people provide. Which is a pity. I have no doubts about the quality 
        of the JIT in the Julia that you download, but I have some doubts about proper 
        support for the Slingshot interconnect.





