# CCE Offloading Models

*Presenter: Alfio Lazzaro (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001098/Slides/HPE/06_Directives_Programming.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-1_09_Offload_CCE.pdf`

-   Recording: `/appl/local/training/4day-20240423/recordings/1_09_Offload_CCE.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

2.  Going back to compiling codes with HIP, could you just clarify how it would be best to do this with cmake 
    in either the GNU or Cray environments? I have attempted it with a code I use (FHI-aims) 
    since the talk on this this morning, but I am still struggling with it. 
    Obviously this is quite specific to my own use case. I am also happy to talk about this on the zoom call if it's easier.     - 
    
    -   You can use `-DCMAKE_CXX_COMPILER=CC` and add the flag `-DCMAKE_CXX_FLAGS="-xhip"`, 
        but it really depends on the cmake. 
        I suggest to check [rocm.docs.amd.com/en/latest/conceptual/cmake-packages.html](https://rocm.docs.amd.com/en/latest/conceptual/cmake-packages.html).

