# GPU application porting strategies

*Presenter: Alfio Lazzaro (HPE)*

Course materials will be provided during and after the course.

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001726/Slides/HPE/05_GPU_porting.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-501-Porting_to_GPU.pdf`

<!--
-   Recording: `/appl/local/training/2p3day-20250303/recordings/501-Porting_to_GPU.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  Our software is written in c++ using OpenACC and MPI. We want implement something to run on LUMI (AMD GPUs). What do you suggest (we think about OpenMP)?  (for Alfio)

    -   Yes, it is a starting point. You can use the Intel tool for the translation, but some people are reporting it doesn't work in all cases. I did some investigation of using [clacc](https://www.exascaleproject.org/highlight/clacc-an-open-source-openacc-compiler-and-source-code-translation-project/), but it needs a full installation. I have not tried OpenACC-GNU...
   
    We also report that the Intel tool does not work properly
   
    Does CLACC works on LUMI?
   
    -   CLACC is still under heavy development and not at all a finished product and we also have no upstream support organisation, so it is not supported. We don't have the personpower to support things for which we cannot get upstream support. Moreover, supporting a compiler is more than just offering the compiler, as it needs to be compatible with an MPI library and with mathematical libraries. As long as HPE or AMD do not officially support clacc, we won't either.
      
2.  If I understand correctly you say about  GNU compiler on LUMI? Is it possible using GNU compiler + OpenMP to target GPUs on LUMI? 

    -   No. As said before in the course, the GCC we have on LUMI at the moment is the SUSE distribution without OpenMP offload. And there are no plans in the support team to compile our own GCC with that support given that performance on AMD GPUs is poor anyway. LLVM-based compilers is the way forwards for GPU compute as all GPU manufacturers build on top of those compilers anyway.

        The official message from both HPE and ?AMD since the start of LUMI has been HIP or OpenMP.... 
 
