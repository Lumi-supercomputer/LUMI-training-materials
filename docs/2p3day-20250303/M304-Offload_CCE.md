# CCE Offloading Models and Porting Applications to GPUs

*Presenter: Alfio Lazzaro (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001726/Slides/HPE/04_Directives_Programming.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-304-Offload_CCE.pdf`

-   Recording: `/appl/local/training/2p3day-20250303/recordings/304-Offload_CCE.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  In case I have a complex Struct in C++ how can I map that with OpenMP on GPU?
    ```
    struct Data{
      subStruct Vc; 
      double **array_of_array;
      double max_mach;
      double ... 
      double ...
    }
    ```
    How can I map Data? 

    -   *(Alfio) In OpenMP you can use [Mapper Identiﬁers and mapper Modiﬁers](https://www.openmp.org/spec-html/5.2/openmpsu61.html). [See this example](https://passlab.github.io/Examples/contents/Chap_devices/9_declare_mapper_Directive.html)*

    Managed can help in this case (without deep copy)? 

    -   *Yes, indeed (note that managed is what C++ parellel frameworks do, e.g. SYCL)*
  
    If he can show some example it would be helpful. 

    -   *[See this example](https://passlab.github.io/Examples/contents/Chap_devices/9_declare_mapper_Directive.html)*

    -   *This is an example that might need unified memory to work. And it will likely only be truly efficient on something like an MI300A.*


2.  Sorry for the repetition, can you clarify better the differences between managed and unified memory

    -   *(Alfio) Unified memory is related to OpenMP (aka Unified Shared Memory, USM), which uses managed memory in HIP (see [HipMallocManaged in "HIP Runtime API Reference: Managed Memory"](https://rocm.docs.amd.com/projects/HIP/en/latest/doxygen/html/group___memory_m.html#gaadf4780d920bb6f5cc755880740ef7dc))*

