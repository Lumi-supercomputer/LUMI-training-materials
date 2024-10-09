# HPE Cray PE tools introduction

<em>Presenter: Harvey Richardson and Alfio Lazzaro (HPE)</em>

-   Slides on LUMI in `/appl/local/training/profiling-20241009/files/01_HPE_Cray_PE_tools.pdf`

<!-- 
-   Files from the demo on LUMI in `/appl/local/training/profiling-20241009/files/01_HPE_Demo.tar`

-   Recordings: To make the presentations more accessible, the presentation has been split in
    6 parts:

    1.  Introduction and LUMI hardware (*Harvey Richardson*): slides 1-8:
        `/appl/local/training/profiling-20241009/recordings/01a_HPE_Cray_PE_tools__Hardware.mp4`

    2.  The HPE Cray Programming Environment (*Harvey Richardson*): slides 9-38:
        `/appl/local/training/profiling-20241009/recordings/01b_HPE_Cray_PE_tools__Programming_environment.mp4`

    3.  Job placement (*Harvey Richardson*): slides 39-51:
        `/appl/local/training/profiling-20241009/recordings/01c_HPE_Cray_PE_tools__Job_placement.mp4`

    4.  Cray MPICH for GPUs (*Harvey Richardson*): slides 52-57:
        `/appl/local/training/profiling-20241009/recordings/01d_HPE_Cray_PE_tools__MPICH_GPU.mp4`

    5.  CCE Fortran and C/C++ & Offload to the GPUs (*Alfio Lazzaro*): slides 58-75
        `/appl/local/training/profiling-20241009/recordings/01e_HPE_Cray_PE_tools__CCE_Fortran_and_offload.mp4`

    6.  Performance Analysis (*Alfio Lazzaro*): slides 76-113:
        `/appl/local/training/profiling-20241009/recordings/01f_HPE_Cray_PE_tools__Performance_analysis.mp4`

    The "GDB for HPC" slides (114-127) were not covered in the presentation.
-->

HPE training materials can only be shared with other LUMI users and therefore are not available on the
web.

## Q&A

1.  Slide 25 may need an update. With the 24.03 edition it is better to use `gcc-native-mixed` 
    to get the gcc installation specifically for this version of the PE. And then you have to 
    use `gcc-13 --version` as `gcc --version` would give you the (ancient) system gcc.

    -   (Alfio) the comment is correct, then you have to use `gcc-13` instead of `gcc`. 
        However, `gcc-13` is always available, so don't need to load the `gcc-native-mixed` module. 
        Proper linking to `gcc` has been fixed in PE 24.07 (not yet on LUMI).


