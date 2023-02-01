# Lmod modules

## Module environments

<figure markdown style="border: 1px solid #000">
  ![Module environments](../img/LUMI-1day-20230321-modules/Dia2.png)
</figure>

Modules are commonly used on HPC systems to enable users to create 
custom environments and select between multiple versions of applications.
Note that this also implies that applications on HPC systems are often not
installed in the regular directories one would expect from the documentation
of some packages, as that location may not even always support proper multi-version
installations and as one prefers to have a software stack which is as isolated as
possible from the system installation to keep the image that has to be loaded
on the compute nodes small.

There are 3 systems in use for module management.
The oldest is a C implementation of the commands using module files written in Tcl.
The development of that system stopped around 2012, with version 3.2.10. 
This system is supported by the HPE Cray Programming Environment.
A second system builds upon the C implementation but now uses Tcl also for the
module command and not only for the module files. It is developed in France at
the CÉA compute centre. The version numbering was continued from the C implementation,
starting with version 4.0.0. 
The third system and currently probably the most popular one is Lmod, a version
written in Lua with module files also written in Lua. Lmod also supports most
Tcl module files. It is also supported by HPE Cray, though they tend to be a bit
slow in following versions.

On LUMI we have chosen to use Lmod. As it is very popular, many users may already be
familiar with it, though it does make sense to revisit some of the commands that are
specific for Lmod and differ from those in the two other implementations.

??? Note "Links"
    -   [Old-style environment modules on SourceForge](https://sourceforge.net/projects/modules/files/Modules/modules-3.2.10/)
    -   [TCL Environment Modules home page on SourceForge](http://modules.sourceforge.net/) and the
        [development on GitHub](https://github.com/cea-hpc/modules)
    -   [Lmod documentation](https://lmod.readthedocs.io/en/latest/) and 
        [Lmod development on GitHub](https://github.com/TACC/Lmod)


## Exploring modules with Lmod

<figure markdown style="border: 1px solid #000">
  ![Exploring modules with Lmod](../img/LUMI-1day-20230321-modules/Dia3.png)
</figure>

Contrary to some other module systems, or even some other Lmod installations, **not all modules are
immediately available for loading**. So don't be disappointed by the few modules you will see with
`module available` right after login. Lmod has a **so-called hierarchical setup** that tries to protect
you from being confronted with all modules at the same time, even those that may conflict with 
each other, and we use that to some extent on LUMI. Lmod **distinguishes between installed modules and
available modules**. Installed modules are all modules on the system that can be loaded one way or
another, sometimes through loading other modules first. Available modules are all those modules
that can be loaded at a given point in time without first loading other modules.

The HPE Cray Programming Environment also uses a hierarchy though it is not fully implemented in
the way the Lmod developer intended so that some features do not function as they should.

-   For example, **the `cray-mpich` module** can only be loaded if **both a network target module and a
    compiler module** are loaded (and that is already the example that is implemented differently from
    what the Lmod developer had in mind). 
-   Another example is the **performance monitoring tools.** Many of those
    tools only become available after loading the `perftools-base` module. 
-   Another example is the
    **`cray-fftw`** module which requires a **processor target module** to be loaded first.

Lmod has **several tools to search for modules**. 

-   The `module avail` command is one that is also
    present in the various Environment Modules implementations and is the command to search in the
    available modules. 
-   But Lmod also has other commands, `module spider` and `module keyword`, to 
    search in the list of installed modules.


## Extensions

<figure markdown style="border: 1px solid #000">
  ![Extensions](../img/LUMI-1day-20230321-modules/Dia4.png)
</figure>

It would not make sense to have a separate module for each of the hundreds of R
packages or tens of Python packages that a software stack may contain.
In fact, as the software for each module is installed in a separate directory
it would also create a performance problem due to excess directory accesses simply
to find out where a command is located, and very long search path environment
variables such as PATH or the various variables packages such as Python, R or Julia use
to find extension packages.
On LUMI related packages are often bundled in a single module. 

Now you may wonder: If a module cannot be simply named after the package it contains as
it contains several ones, how can I then find the appropriate module to load?
Lmod has a solution for that through the so-called **extension** mechanism. An Lmod module
can define extensions, and some of the search commands for modules will also search in the extensions
of a module. Unfortunately, the HP{E Cray PE cray-python and cray-R modules do not provide that 
information at the moment as they too contain several packages that may benefit from linking
to optimised math libraries.


### Searching for modules: the module spider command

<figure markdown style="border: 1px solid #000">
  ![module spider](../img/LUMI-1day-20230321-modules/Dia5.png)
</figure>

There are three ways to use `module spider`, discovering software in more and more detail.

1.  `module spider` by itself will show a list of all installed software with a short description.
    Software is bundled by name of the module, and it shows the description taken from the default
    version. `module spider` will also look for "extensions" defined in a module and show those also
    and mark them with an "E". Extensions are a useful Lmod feature to make clear that a module offers
    features that one would not expect from its name. E.g., in a Python module the extensions could be
    a list of major Python packages installed in the module which would allow you to find `NumPy` if
    it were hidden in a module with a different name. This is also a very useful feature to make
    tools that are bundled in one module to reduce the module clutter findable.

2.  `module spider` with the name of a package will show all versions of that package installed on
    the system. This is also case-insensitive. Let's try for instance `module spider gnuplot`. This
    will show 5 versions of GNUplot. There are two installations of GNUplot 5.4.2 and three of 5.4.3. The 
    remainder of the name shows us with what compilers gnuplot was compiled. The reason to have 
    versions for two or three compilers is that no two compiler modules can be loaded simultaneously,
    and this offers a solution to use multiple tools without having to rebuild your environment for
    every tool, and hence also to combine tools. 

    Now try `module spider CMake`. We see that there are two versions, 3.21.2 and 3.22.2, but now
    they are shown in blue with an "E" behind the name. That is because there is no module called
    `CMake` on LUMI. Instead the tool is provided by another module that in this case contains
    a collection of popular build tools and that we will discover shortly.

3.  The third use of `module spider` is with the full name of a module. Try for instance
    `module spider gnuplot/5.4.3-cpeGNU-21.12`. This will now show full help information for
    the specific module, including what should be done to make the module available. For 
    this GNUplot module we see that there are two ways to load the module: By loading `LUMI/21.12` 
    combined with `partition/C` or by loading `LUMI/21.12` combined with `partition/L`. So use only
    a single line, but chose it in function of the other modules that you will also need. In this case
    it means that that version of GNUplot is available in the `LUMI/21.12` stack which we could already
    have guessed from its name, with binaries for the login and large memory nodes and the LUMI-C compute
    partition. This does however not always work with the Cray Programming Environment modules.

    We can also use `module spider` with the name and version of an extension. So try
    `module spider CMake/3.22.2`. This will now show us that this tool is in the `buildtools/21.12`
    module and give us 6 different options to load that module as it is provided in the `CrayEnv`
    and the `LUMI/211.12` software stacks and for all partitions (basically because we don't do
    processor-specific optimisations for these tools).


### Example 1: Running `module spider` on LUMI

Let's first run the `module spider` command. The output varies over time, but at the time of writing,
and leaving out a lot of the output, one would have gotten:

![module spider 1](../img/03_mod_ms_1.png)

![module spider 1](../img/03_mod_ms_2.png)

![module spider 1](../img/03_mod_ms_3.png)

On the second screen we see, e.g., the ARMForge mdoule which was available in just a single version
at that time, and then Autoconf where the version is in blue and followed by `(E)`. This denotes
that the Autoconf package is actually provided as an extension of another module, and one of the next
examples will tell us how to figure out which one.

The third screen shows the last few lines of the output, which actually also shows some help information
for the command.


### Example 2: Searching for the FFTW module which happens to be provided by the PE

Next let us search for the popular FFTW library on LUMI:

```bash
$ module spider FFTW
```

produces

![module spider FFTW](../img/03_mod_ms_FFTW_1.png)

This shows that the FFTW library is actually provided by the `cray-fftw` module and was at the time
that this was tested available in 3 versions. 
Note that (a) it is not case sensitive as FFTW is not in capitals in the module name and (b) it
also finds modules where the argument of module spider is only part of the name.

The output also suggests us to dig a bit deeper and 
check for a specific version, so let's run

```bash
$ module spider cray-fftw/3.3.10.1
```

This produces:

![module spider FFTW](../img/03_mod_ms_FFTW_version_1.png)

![module spider FFTW](../img/03_mod_ms_FFTW_version_2.png)

We now get a long list of possible combinations of modules that would enable us to load this module.
What these modules are will be explained in the next session of this course. However, it does show
a weakness when module spider is used with the HPE Cray PE. In some cases, not all possible combinations
are shown (and this is the case here as the module is actually available directly after login and also
via some other combinations of modules that are not shown). This is because the HPE Cray Programming
Environment is system-installed and sits next to the application software stacks that are managed differently,
but in some cases also because the HPE Cray PE sometimes fails to give the complete combination of modules
that is needed. The command does work well with the software managed by the LUMI User Support Team as the
next two examples will show.


## Example 3: Searching for GNUplot

To see if GNUplot is available, we'd first search for the name of the package:

```bash
$ module spider GNUplot
```

This produces:

![module spider FFTW](../img/03_mod_ms_gnuplot_1.png)

![module spider FFTW](../img/03_mod_ms_gnuplot_2.png)

The output again shows that the search is not case sensitive which is fortunate as uppercase and lowercase
letters are not always used in the same way on different clusters. Some management tools for scientific software
stacks will only use lowercase letters, while the package we use on LUMI often uses both.

We see that there are a lot of versions isntalled on the system and that the version actually contains more 
information (e.g., `-cpeGNU-22.08`) that we will explain in the next part of this course. (Though you might of
course guess that it has to do with the compilers that were used.)

The output again suggests to dig a bit further for more information, so let's try

```bash
$ module spider gnuplot/5.4.3-cpeGNU-22.08
```

This produces:

![module spider FFTW](../img/03_mod_ms_gnuplot_version_1.png)

![module spider FFTW](../img/03_mod_ms_gnuplot_version_2.png)

In this case, this module is provided by 3 different combinations of modules that also will be explained
in the next part of this course. Furthermore, the output of the command now also shows some help information
about the module, with some links to further documentation available on the system or on the web.
The format of the output is generated automatically by the software installation tool that we use
and we sometimes have to do some effort to fit all information in there.

For some packages we also have additional information in our
[LUMI Software Library web site](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/) so it is often
worth looking there also.

## Example 4: Searching for an extension of a module: CMake.

The `cmake` command on LUMI is available in the operating system image, but as is often the case with
such tools distributed with the OS, it is a rather old version and you may want to use a newer one.

If you would just look through the list of available modules, even after loading some other modules to
acitvate a larger software stack, you will not find any module called `CMake` though. But let's use the
powers of `module spider` and try

```bash
$ module spider cmake
```

which produces

![module spider cmake](../img/03_mod_ms_cmake_1.png)

The output above shows us that there are actually four other versions of CMake on the system, but their
version is followed by `(E)` which says that they are extensions of other modules. Lmod already tells us
how to find out which module actually provides the CMake tools. So let's try

```bash
$ module spider CMake/3.24.0
```

which produces

![module spider cmake](../img/03_mod_ms_cmake_version_1.png)

![module spider cmake](../img/03_mod_ms_cmake_version_2.png)

This shows us that the version is provided by a number of `buildtools` modules, and for each of those
modules also shows us which other modules should be loaded to get access to the commands. E.g.,
the first line tells us that there is a module `buildtools/22.08` that provides that version of CMake, but
that we first need to load some other modules, with `LUMI/22.08` and `partition/L` (in that order) 
one such combination.

So in this case, after

```bash
$ module load LUMI/22.08 partition/L buildtools/22.08
```

the `cmake` command would be available.

And you could of course also use

```
$ module spider buildtools/22.08
```

to get even more information about the buildtools module, including any help included in the module.









