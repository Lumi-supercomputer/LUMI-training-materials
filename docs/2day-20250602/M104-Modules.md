# Modules on LUMI

*Presenter: Kurt Lust (LUST)*

LUMI uses Lmod, but as Lmod can be configured in different ways, even an experienced
Lmod user can learn from this presentation how we use modules on LUMI and how
modules can be found.


## Materials

<!--
Materials will be made available after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20250602/recordings/104-Modules.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-104-Modules.pdf)

-   [Course notes](104-Modules.md)

-   [Exercises](E104-Modules.md)

Archived materials on LUMI:

-   Slides: `/appl/local/training/2day-20250602/files/LUMI-2day-20250602-104-Modules.pdf`

-   Recording: `/appl/local/training/2day-20250602/recordings/104-Modules.mp4`


## Q&A

1.  Is AMD Oniperf installed? I can not find it. I've loaded the rocm module  

    -   Omniperf is not part of the default module (as installed by HPE), as it used not to be part of ROCm
        You can find it in the `rocm/6.2.2` module (but that is a custom installation of ROCm, so there may be other issues), 
        and it should be part of newer ROCm. 
        This is because Omniperf was basically a research project before and has only been officially released as an officially supported part of ROCm with ROCm 6.2. 

