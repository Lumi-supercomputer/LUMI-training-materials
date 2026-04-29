# Modules on LUMI

*Presenter: Kurt Lust (LUST)*

LUMI uses Lmod, but as Lmod can be configured in different ways, even an experienced
Lmod user can learn from this presentation how we use modules on LUMI and how
modules can be found.


## Materials

<!--
Materials will be made available after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20260422/recordings/LUMI-2day-20260422-104-Modules.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20260422/files/LUMI-2day-20260422-104-Modules.pdf)

-   [Course notes](104-Modules.md)

-   [Exercises](E104-Modules.md)


## Q&A


1.  Why `module spider` or `module avail` take so much time to fetch result? (Answered in the talk).

    -   It is very slow when it has to rebuild the cache.

2.  `module spider cmake` shows "åutoconf" in Description :)

    -    to me it shows all the programs that are available in the buildtool module, so yes autoconf is the first in alphabetical order :D but if you continue cmake is there 

    No, sorry, I wanted to point out "å" 

    -    never noticed that one :D

    -    I'll put it on my list of things to check when we make a new version of the module.

