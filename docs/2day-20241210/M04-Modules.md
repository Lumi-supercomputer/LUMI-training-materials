# Modules on LUMI

*Presenter: Kurt Lust*

LUMI uses Lmod, but as Lmod can be configured in different ways, even an experienced
Lmod user can learn from this presentation how we use modules on LUMI and how
modules can be found.


## Materials

<!--
Materials will be made available during and after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20241210/recordings/04-Modules.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20241210/files/LUMI-2day-20241210-04-Modules.pdf)

-   [Course notes](04-Modules.md)

-   [Exercises](E04-Modules.md)


## Q&A

1.  What is the difference between amd and rocm modules?

    -   The `rocm` module allows you to use ROCm only with any other environment while `amd` module is to use AMD compilers with the Cray Programming Environment, including proper versions of LibSci and other libraries. 

2.  What is the best way to clean cache after installing a new module?

    -   `rm -rf ~/.cache/lmod` and the cache will be rebuilt automatically at the next module command that needs it

3.  I am a bit confused about how the "Cray Compiling Environment" and the "Cray Programming Environment" are related to one another. Furthermore, the different compilers, like amd, GNU and so on. I assume that `PrgEnv-GNU` is essentially kind of a wrapper that loads several module in the right way and tells the "system" (whatever that is) to use a certain set of compilers.

    -   Cray Programming Environment is the name that is used for the whole software stack that Cray provides for programming. This consists of software they have wholly or partially written themselves, and some software that is really just a repackaging of third party software. Cray Compiling Environment or Cray Compilation Environment (I see both depending on the sources), abbreviated CCE, is the name they use for their C/C++ and Fortran compilers that they provide themselves, with the C/C++ compiler being regular clang/LLVM with some extra plugins, and the Fortran compiler their own on top of LLVM for the actual code generation.

    -   `PrgEnv-gnu` may look a bit complex if you check the coded, but it only loads some other modules and sets an environment variable that is probably used by the wrappers. The magic is more in the other modules, that set several modules that are picked up by the wrappers. The wrappers themselves are provided by the `craype` module which is one of the modules load by `PrgEnv-gnu`. 

4.  How to check which version is available when I tried `module spider bison`. It gives different version of buildtools? Which one to choose?

    -    It is showing the buildtools that are associated to the different available stacks, from 24.03 (the latest one), to 22.08. which version of the buildtools you want to use is related to which stack you are using. In this way you can load the buildtools module compiled with the correct stack when you are using that stack to work. 

    -   There is basically only one other version available, Bison 3.8.2, as Bison doesn't change quickly anymore. You see that at the top of the output of `module spider Bison`, but it is in a lot of versions of the `buildtools` module. Of course, if you load one of these module combinations, you could then also try `bison --version` if you don't believe that the version we used in the module extension Bison is actually the version of the `bison` program.

5.  Which version of modules is loaded by default, the latest? Can I just say 'module load systools' instead of 'module load systools/24.03'?

    -    After first loading `CrayEnv`, you'll have several `systools` modules but if you would do a `module av` after loading `CrayEnv`, you'd see that the 24.03 version has a `(D)` behind its name. Lmod always tries to take the highest version number and is rather good at figuring out which version this is, even with some rather strange version numbering. In `LUMI/24.03` it ven doesn't matter at the moment as there is only one `systools` module.

    -    But loading without a version is dangerous when a new version is installed, or when the default changes. We can also define a different version as the default, and that is something that we often do when a new programming environment is installed on the system. The corresponding `LUMI` module is often still too incomplete so we keep an older one as the default.

6.  A silly question, but when I do `module show PrgEnv-gnu` then I see the line `load("gcc-native")`. On the other hand when I run `module show gcc-native` I see the line `load("PrgEnv-gnu")`, which looks like an infinite loop, but it works, how is that? I know this is a super specific question, but it just very interesting.

    -    To be honest, i don't think is an infinite loop. it just mean that one needs the other so the moment you load one of them, you automatically need to load the other one. is not like when you load the other you unload the first.

    -    For me the idea beyond this logic is to prevent using `gcc-native` module with other programming environmnents than `PrgEnv-gnu`; if you really want to do such a mixture load `gcc-native-mixed` module instead. Although actual module script avoids circular loading.


