# AMD ROCm<sup>TM</sup> profiling tools

<!--
-   [Slides](https://462000265.lumidata.eu/profiling-20231122/files/02_intro_rocprof.pdf)

-   Recording in `/appl/local/training/profiling-20231122/recordings/02_Intro_rocprof.mp4`
-->

## Q&A

<!--
1.  Can the PyTorch profiler be used without any specific things to take into account, 
    see [link](https://pytorch.org/docs/stable/profiler.html)?  
 
    **Answer**: 
    
    That is correct. Let us know if you come across any problems.


2.  Could you give a rough estimate on the overhead in terms of percentage?

    **Answer**
    
    - Generally very low, but can be high in unusual cases.
    - Hard to say exactly what the overhead is, depends usually on the ammount of data being collected. A code with a lot of smaller chunks of GPU activity are usually more pronoe to show more overhead.

-->
