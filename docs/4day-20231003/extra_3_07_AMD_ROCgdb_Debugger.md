# AMD ROCgdb debugger

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter: Jakub Kurzak (AMD)*

<!--
Course materials will be provided during and after the course.
-->

<video src="https://462000265.lumidata.eu/4day-20231003/recordings/3_07_AMD_ROCgdb_Debugger.mp4" controls="controls">
</video>

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465000644/Slides/AMD/session-2-rocgdb-tutorial.pdf`
-->

Materials on the web:

-   [Slides on the web](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-3_07_AMD_ROCgdb_Debugger.pdf)

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-3_07_AMD_ROCgdb_Debugger.pdf`

-   Recording: `/appl/local/training/4day-20231003/recordings/3_07_AMD_ROCgdb_Debugger.mp4`


## Q&A

8.  What is FMA?

    -   Fused Multiply Add: Computes `x*y+z` (if it where scalar) or multiplying equivalent elements if x, y and z are vectors (so `x[i]*y[i]+z[i]` for all elements).

        This instruction has some advantages. It is a common operation in numeric codes and it does 2 flops per vector element in a single operation (and can do so faster than a separate multiple and add instruction). Moreover, it is usually done with a smaller roundoff error than using two separate instructions.
        
        It has been popular on CPUs from certain vendors since the nineties, and was added to the x86 instruction set with the haswell generation around 2014. It is also a popular operation on GPUs.


9. About the slide 26. Do I understand correctly that there are 16 units that each is like and ALU more than a core? The difference would be that ALUs can run different instructions, while these units have to run the same one. Do I understand correctly? You called the 10 threads running like the hyperthreading and I wondered if it works like this. ...

    -   There are 4 vector units which are 16 lanes wide and process 64-element vectors in 4 passes. These units have to be compared to, e.g., the AVX/AVX2/AVX-512 vector units on an Intel processor.

        Thanks to NVIDIA, core, thread, etc., are all confusing names in the GPU world as they are all redefined in a completely different meaning as for CPUs. 
        
10. I have a bit off-topic question. Can the ROCm be run also on Radeon cards, like 7900 XTX? Thank you!

    -   The very latest version of ROCm (5.7) has support for some Radeon cards. We and other sites have been pushing AMD for a long time as we feel users need a cheaper way to write software for AMD GPUs. You should be aware though that the RDNA architecture is rather different vrom the CDNA architecture. It is based on vectors of length 32 instead of 64 (though it still supports the latter I believe for compatibility with the older GCN architecture).

        I am not sure which features are supported and which are not, and AMD person would need to answer that.
        
    - The 7900 XTX is supported on [windows](https://rocm.docs.amd.com/en/latest/release/windows_support.html#windows-supported-gpus) but not on Linux, where the only supported Radeon card in the Radeon VII. Note that, some ROCm libraries are Linux exclusive. At the moment, you do not have the full ROCm experience with a Radeon card.

 
