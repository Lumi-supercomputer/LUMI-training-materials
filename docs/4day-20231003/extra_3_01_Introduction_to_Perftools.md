# Introduction to Perftools

*Presenters: Thierry Braconnier (HPE) and Alfio Lazzaro (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465000644/Slides/HPE/09_introduction_to_perftools.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-3_01_Introduction_to_Perftools.pdf`

-   Recording: `/appl/local/training/4day-20231003/recordings/3_01_Introduction_to_Perftools.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

!!! Info
    You can find the downloads of Apprentice2 and Reveal on LUMI in
    `$CRAYPAT_ROOT/share/desktop_installers/`. This only works when the
    `perftools-base` module is loaded, but this is the case at login.


## Q&A

2.  Can I use perftools with an application that I build using Easybuilds?

    -   It is tricky. In principle when you do performance analysis you want complete control over how the application is build and that is rather the opposite of what you want when using EasyBuild. But there are tricks to inject additional compiler options in EasyBuild or to make sure that certain environment variables are set when compiling. But that requires changing the EasyConfig itself, there is no way to inject those things via command line options of EasyBuild.

        There will also be problems with the sanity checks as the executables get a modified name. So whenever EasyBuild implements a test to check if the executable is present, or tries to run the executable, that test will fail.
        
    - In general though the -lite modules should just work.  For the more advanced use of perftools you will need to inject an extra step into the build to get the instrumented executable.


3. Is it possible to use multiple `perftools-lite-*` modules at the same time?
    - No, the modules are exclusive and LMOD will present to load two modules (you get an unload of the current loaded module and load of the new one). For complex analysis, you  have to use `pat_build` and decide which analysis to do (next presentation).


