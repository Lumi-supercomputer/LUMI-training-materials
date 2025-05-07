# HPE Cray PE tools introduction

<em>Presenters: Jean Pourroy and Thierry Braconnier (HPE)</em>

-   Slides on LUMI in `/appl/local/training/profiling-20250507/files/01_HPE_Cray_PE_tools.pdf`

<!--
-   Recordings: To make the presentations more accessible, the presentation has been split in
    6 parts:

    1.  Introduction and LUMI hardware (*Jean Pourroy*): slides 1-8:
        `/appl/local/training/profiling-20250507/recordings/01a_HPE_Cray_PE_tools__Hardware.mp4`

    2.  The HPE Cray Programming Environment (*Jean Pourroy*): slides 9-38:
        `/appl/local/training/profiling-20250507/recordings/01b_HPE_Cray_PE_tools__Programming_environment.mp4`

    3.  Job placement (*Jean Pourroy*): slides 39-51:
        `/appl/local/training/profiling-20250507/recordings/01c_HPE_Cray_PE_tools__Job_placement.mp4`

    4.  Cray MPICH for GPUs (*Jean Pourroy*): slides 52-57:
        `/appl/local/training/profiling-20250507/recordings/01d_HPE_Cray_PE_tools__MPICH_GPU.mp4`

    5.  CCE Fortran and C/C++ & Offload to the GPUs (*Thierry Braconnier*): slides 58-75
        `/appl/local/training/profiling-20250507/recordings/01e_HPE_Cray_PE_tools__CCE_Fortran_and_offload.mp4`

    6.  Performance Analysis (*Thierry Braconnier*): slides 76-116:
        `/appl/local/training/profiling-20250507/recordings/01f_HPE_Cray_PE_tools__Performance_analysis.mp4`

    The "GDB for HPC" slides (117-130) were not covered in the presentation.

HPE training materials can only be shared with other LUMI users and therefore are not available on the
web.
-->

## Q&A


1.  Is it possible to compile HIP and OpenMP target directives together? and Yes can you please tell how?

    -   (Alfio, HPE) OpenMP offload? No, this is not possible in the same compilation unit (you can use OpenMP without offloading though). Then, you can have 2 compilation units (HIP and OpenMP offload), compile them independetly and link. A different topic is how to use HIP code within OpenMP offload... Could you elaborate more on your question?
    
    For example: The HIP API is used for managing data movement, while OpenMP directives are added to launch parallel loops on the device in a single source file?
        
    -    No, this is the same file == same compilation unit... But, OpenMP offload has to "manage" data movement, so it would not work anyway... Well, you can use `has_device_addr`, I think, to tell OpenMP that you did the data movement externally (still on 2 files)... Let me check... https://www.openmp.org/spec-html/5.2/openmpsu43.html
    
    Ok thank you!

2.  Are there examples of GPU binding scripts for non-OpenMP? Or is OpenMP recommended for this purpose?

    -   There is no difference in binding techniques for HIP and for OpenMP. Binding is done outside of the OpenMP runtime, in the ROCm runtime which is why it is done by setting RORC_VISIBLE_DEVICES. This is at one of the lowest levels in the ROCm stack, below HIP or any OpenMP offload runtime.

        Some applications may try to internally set GPUs for each task, but that is a different story. In those cases, using the ROCR_VISIBLE_DEVICES in gpu_select technique may be inappropriate.
        
        The [Bindings lecture](https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/202-Binding/#combining-slurm-task-binding-with-rocr_visible_devices) in our intro courses contains various examples, as does the "Advanced Placement" talk in our advanced courses (e.g., [from slide 51 onwards in the materials from a course in October 2024](https://lumi-supercomputer.github.io/LUMI-training-materials/4day-20241028/extra_2_01_Advanced_Application_Placement/)).
        
    Alright, thank you very much! :)

3.  A question after the course not recorded: When should I use the HPE tools and when the AMD tools?

    -   The AMD tools are developed specifically for AMD GPUs while the HPE tools are more generic and 
        for more types of systems (also support NVIDIA) and less developed to analyse all details of the 
        AMD GPU behaviour.

    -   But then HPE has a long tradition in analysing behaviour of distributed memory applications.

    -   So use the AMD tools if you want to understand what is going on in a single process that uses the
        GPU (single task optimisation) and switch to the HPE tools if you want to optimise the distributed
        memory program behaviour.
