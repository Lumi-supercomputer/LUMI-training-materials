# Programming Environment and Modules

*Presenter: Harvey Richardson (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001098/Slides/HPE/02_PE_and_Modules.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-1_02_Programming_Environment_and_Modules.pdf`

-   Recording: `/appl/local/training/4day-20240423/recordings/1_02_Programming_Environment_and_Modules.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

## Q&A

1.  Because you talked about FFTW3, is there something I can do to use a distributed FFT on GPUs? I checked and there is only the intra-node hipFFTXt.

    -   We can support 3rd party libraries also if we know which ones users want.

        In one of the talks tomorrow you will see that supporting distributed libraries is not trivial for a vendor, as they need to be compiled specifically for the right MPI library, which is why it is hard to do for AMD.
     
    -   There is work in progress from AMD but I can not say for any timeline. 
        You can check this one: https://icl.utk.edu/fft/ but I htink I heard that the performance is not great.




