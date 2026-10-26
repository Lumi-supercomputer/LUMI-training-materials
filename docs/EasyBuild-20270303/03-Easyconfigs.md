# The Easyconfig file

## Introduction: Easyconfig parameters

<figure markdown style="border: 1px solid #000">
  ![Introduction: Easyconfig parameters](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/EasyConfigIntroParameters.png){ loading=lazy }
</figure>

In this section, we will walk through the parameters that are most common in easyconfigs.
This is a very non-exhaustive list. Some parameters are also specific to some generic EasyBlocks.

EasyBuild currently has 2 sets of parameter names.
The original parameter names grew organically and there are a lot of inconsistencies in the naming, making
it sometimes hard to remember (should I use an underscore between the words that form the parameter or not?).
These are deprecated in version 5 and will disappear in version 6 which may launch in 2027.
For EasyBuild 5, a more consistent naming scheme was developed, and it will become mandatory to use
these versions in EasyBuild 6.

On LUMI, we started the switch to the new names in the 25.09 software stack to be ready for a future version
of EasyBuild, even though we usually don't update EasyBuild versions in a given stack. 


## An example

Below we show an example of an easyconfig file. In the following subsections we will walk
through the parameters and then some more.

([Example without the sidebars](B01-libpng.md))

``` python
easyblock = 'ConfigureMake'

name =    'libpng'
version = '1.6.58'

homepage = 'http://www.libpng.org/pub/png/libpng.html'
whatis = [
    'Description: libpng is the official PNG reference library',
    'This module provides some command line tools and static and shared libraries',
]

description = """
libpng is the official PNG reference library. It supports almost all PNG
features, is extensible, and has been extensively tested for over 22 years. The
home site for development versions (i.e., may be buggy or subject to change or
include experimental features) is https://libpng.sourceforge.io/, and the place
to go for questions about the library is the png-mng-implement mailing list.

libpng is available as ANSI C (C89) source code
"""

toolchain = {'name': 'cpeCray', 'version': '26.03'}
toolchain_opts = {'pic': True}

# https://sourceforge.net/projects/libpng/files/libpng16/1.6.58/libpng-1.6.58.tar.xz/download
source_urls = [SOURCEFORGE_SOURCE]
sources =     [SOURCELOWER_TAR_XZ]
checksums =   ['28eb403f51f0f7405249132cecfe82ea5c0ef97f1b32c5a65828814ae0d34775']

build_deps = [ # Create a reproducible build environment.
    ('buildtools', '%(toolchain_version)s', '', True),
]

deps = [
    ('zlib', '2.3.3'),
]

# Doesn't need MPI, ROCm or BLAS, and module unload never fails so this is safe.
pre_configure_opts = 'module unload cray-libsci cray-mpich rocm xpmem && '
pre_build_opts = pre_configure_opts

configure_opts = "--with-pic"

post_install_cmds = [
    'ln -s %(installdir)s/include/libpng16 %(installdir)s/include/libpng',
    'mkdir -p %(installdir)s/share/licenses/%(name)s',
    'cp ANNOUNCE AUTHORS CHANGES LICENSE README TRADEMARK %(installdir)s/share/licenses/%(name)s',   
]

local_majminver = '%(version_major)s%(version_minor)s'

sanity_check_paths = {
    'files': ['include/pngconf.h', 'include/png.h', 'include/pnglibconf.h', 'lib/libpng.a',
              'lib/libpng.%s' % SHLIB_EXT, 'lib/libpng%s.a' % local_majminver, 'lib/libpng%s.%s' % (local_majminver, SHLIB_EXT),
              f'share/licenses/{name}/LICENSE'],
    'dirs':  ['bin', 'include/libpng%s' % local_majminver, 'share/man'],
}

sanity_check_cmds = [
    'libpng16-config --version',
    'pkg-config --libs libpng16',
]

env_mod_category = 'lib'
```


## Easyblock or easyconfig?

<figure markdown style="border: 1px solid #000">
  ![Easyblock or easyconfig?](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/EasyConfigEasyBlockOrEasyConfig.png){ loading=lazy }
</figure>

Before continuing, we should ask us the question whether we should use an easyblock to do most
of the implementation of the installation of a package, or simply use an easyconfig.

This question is largely academic for the topic of this course, which focuses on what you need
to know to adapt an existing easyconfig on LUMI to make it suited for your needs. Yet we want
to give a brief answer.

It is often said that an easyblock is an "implement once and forget". All the complexity is buried
in the easyblock and the person developing the easyconfig only has to specify some parameters that 
the easyblock may define, or may not have to know all the complexities of which dependencies can
be used together and how can they be specified to the configure step. 
The reality is though that this is often theory. Packages evolve, and the easyblock has to evolve 
with them. But while an easyconfig only has to work for a single very specific installation, the
easyblock has to work for a lot of configurations and versions of the same package, and this 
requires extensive testing after every change to ensure that other installations of the package
that use the easyblock are not broken. So in the end, the job can become pretty complex.

On the other hand, an easyconfig leveraging a generic easyblock can sometimes become very comples,
though this is also subjective, and become hard to adapt for someone who has less experience.

Sometimes a custom easyblock is really needed because the work cannot be done with a generic
easyblock:

-   Complex or very non-standard installation procedures.<br/>
    *For example, the 
    [easyblock to install the gcc compilers from source](https://github.com/easybuilders/easybuild-easyblocks/blob/develop/easybuild/easyblocks/g/gcc.py),
    bootstrapping with the system compiler and then re-installing with itself.*

-   Interactive commands that need to be run<br/>. 
    *For example: The 
    [easyblock for maple](https://github.com/easybuilders/easybuild-easyblocks/blob/easybuild-easyblocks-v5.4.1/easybuild/easyblocks/m/maple.py) does 
    [respond to a number of interactive questions](https://github.com/easybuilders/easybuild-easyblocks/blob/easybuild-easyblocks-v5.4.1/easybuild/easyblocks/m/maple.py#L58)
    (link for the EasyBuild 5.4.1 easyblock; search for the `install_step` method).*

-   Having to create or adjust specific (configuration) files.<br/>
    *For example, the [easyblock for Siesta](https://github.com/easybuilders/easybuild-easyblocks/blob/easybuild-easyblocks-v5.4.1/easybuild/easyblocks/s/siesta.py) does 
    [edit one of the configuration files through regular expressions](https://github.com/easybuilders/easybuild-easyblocks/blob/easybuild-easyblocks-v5.4.1/easybuild/easyblocks/s/siesta.py#L96) 
    (link for the EasyBuild 5.4.1 easyblock, work done in the `configure_step` method).*

Sometimes the work can be rather easily done in a generic easyconfig also.

-   "critical" values for easyconfig parameters required to make installation succeed.<br/>
    For example, the 
    [easyblock for bowtie2](https://github.com/easybuilders/easybuild-easyblocks/blob/easybuild-easyblocks-v5.4.1/easybuild/easyblocks/b/bowtie2.py) defines a 
    [number of variables used in the Makefile on the make command line to ensure that the right compilers are used](https://github.com/easybuilders/easybuild-easyblocks/blob/easybuild-easyblocks-v5.4.1/easybuild/easyblocks/b/bowtie2.py#L58) 
    as they are not properly picked up from the environment in some cases (and there is also a special one)
    (look for the `build_step` in the easyblock; the link is for the EasyBuild 5.4.1 easyblock).

    This custom easyblock is really just a direct derivative of the `MakeCp` generic easyblock, filling in some parameters
    for you to avoid mistakes.

-   Toolchain-specific aspects of the build and installation procedure (e.g., configure options).<br/>
    *For example, the 
    [easyblock for CP2K](https://github.com/easybuilders/easybuild-easyblocks/blob/easybuild-easyblocks-v5.4.1/easybuild/easyblocks/c/cp2k.py) 
    will add several compiler options when compiling with gcc and gfortran, including the 
    [infamous -fallow-argument-mismatch](https://github.com/easybuilders/easybuild-easyblocks/blob/easybuild-easyblocks-v5.4.1/easybuild/easyblocks/c/cp2k.py#L562) 
    which is required from gfortran 10 on for many older codes (link for the 5.4.1 easyblock).*

    The particular task that we highlight here could also easily be done in a regular easyconfig.
    The installation procedure of CP2K is complex enough though that an easyblock may make sense,
    though on LUMI we have always done the installation using generic easyblocks, as adapting the
    easyblock to some of the specifics of LUMI is a lot of work and hard to maintain across versions
    of EasyBuild.

-   Custom (configure) options for dependencies.<br/>
    For example, the 
    [easyblock for VMD](https://github.com/easybuilders/easybuild-easyblocks/blob/easybuild-easyblocks-v5.4.1/easybuild/easyblocks/v/vmd.py) will 
    [add configure options depending on the dependency list of the package](https://github.com/easybuilders/easybuild-easyblocks/blob/easybuild-easyblocks-v5.4.1/easybuild/easyblocks/v/vmd.py#L173) 
    (link for the 5.4.1 easyblock; search for "additional configopts based on available dependencies" in `configure_step`).

    This is already a very substantial easyblock though that also embeds a lot of knowledge about the
    installation of VMD that someone would need to have to do all the work in an easyconfig using the
    generic `ConfigureMake` easyblock, especially as the easyblock also calls the make command in some
    other directories to build one or two extra components. So using an easyblock was still a good idea.


## Easyconfig parameter: `easyblock`

<figure markdown style="border: 1px solid #000">
  ![Easyconfig parameter: easyblock (1)](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/EasyConfigEasyblock1.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![Easyconfig parameter: easyblock (2)](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/EasyConfigEasyblock2.png){ loading=lazy }
</figure>

Each easyconfig file does a build process with a particular easyblock.

If the easyconfig uses an application-specific easyblock that follows the naming convention
(with the name of the easyblock derived from the name of the package in a particular way),
it is not needed to specify the easyblock at the top of the easyconfig file. 
On LUMI, we do not follow that convention if we make our own variant of an easyblock that 
already exists in EasyBuild to ensure that our version is always taken.
**Example: The [ESMF package in EasyBuild](https://github.com/easybuilders/easybuild-easyconfigs/tree/develop/easybuild/easyconfigs/e/ESMF) uses a custom easyblock (see, e.g., 
[ESMF-8.9.0-foss-2025b.eb](https://github.com/easybuilders/easybuild-easyconfigs/blob/develop/easybuild/easyconfigs/e/ESMF/ESMF-8.9.0-foss-2025b.eb))
but we have our own variant for LUMI so we need to specify it at the top of the easyconfig file,
see, e.g., [ESMF-8.9.1-cpeGNU-26.03-MPI-PIO.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/e/ESMF/ESMF-8.9.1-cpeGNU-26.03-MPI-PIO/).**

EasyBuild has an [extensive list of generic easyblocks](https://docs.easybuild.io/version-specific/generic-easyblocks/) 
(48 in version 5.4.1).
Some of the more important ones that you will come across in the LUMI software stacks are:

-   [`ConfigureMake`](https://docs.easybuild.io/version-specific/generic-easyblocks/#configuremake):
    Use GNU Autotools in the configure step, then build and install with `make`.

    *Examples in the LUMI software stacks: There are literally 10s of packages installed with this
    easyblock. One example is [gnuplot](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/g/gnuplot/#pre-installed-modules-and-easyconfigs),
    e.g., [gnuplot-6.0.4-cpeGNU-26.03.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/g/gnuplot/gnuplot-6.0.4-cpeGNU-26.03/).*

-   [`CMakeMake`](https://docs.easybuild.io/version-specific/generic-easyblocks/#cmakemake):
    Use `cmake` for the configure step, then build and install with `make`.
    CMake is definitely a tool that is gaining popularity as it supports more than only Linux,
    but it does have its quirks also.

    *Examples in the LUMI software stacks: Here too there are literally 10s of packages installed with
    this easyblock. One example is [GROMACS](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/g/GROMACS/),
    e.g., [GROMACS-2026.3-cpeGNU-26.03-CPU.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/g/GROMACS/GROMACS-2026.3-cpeGNU-26.03-CPU/).*

-   [`MesonNinja`](https://docs.easybuild.io/version-specific/generic-easyblocks/#mesonninja):
    Configure with Meson, then build and install with `ninja`.

    [Meson](https://mesonbuild.com/) itself is Python software. It is also rather immature. 
    You may need multiple versions on a system,
    as if it is used to install Python packages, it has to be available for that particular version of Python,
    and as often multiple versions are needed because too many packages are only compatible with a limited 
    version range. It is also not very Fortran-friendly (even though it claims to be so). 
    In our opinion, it is to be avoided if possible
    and we have had software with broken Meson definition files for which we could not build some versions
    of that package. Python may be a very powerful scripting language, but configure tools seem to be 
    better served by application-specific languages.
    [Ninja](https://ninja-build.org/) is a nice and compact alternative to building 
    with `make` an claims more speed as its greatest feature. 

    *Meson is a very popular tool for software from the [GNOME project](https://www.gnome.org/). As such, it is
    used in several packages from the GNOME project that are pre-installed in the LUMI software stacks. 
    One example is [GLib](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/g/GLib/),
    e.g., [GLib-2.89.1-cpeGNU-26.03.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/g/GLib/GLib-2.89.1-cpeGNU-26.03/),
    which despite being a basic library that we would prefer to offer for all containers, currently cannot be 
    offered with `cpeAMD/26.03` due to build issues.
    Currently we have only one scientific software package that uses the `MesonNinja` easyblock,
    [DFT-D4](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/d/DFTD4/), 
    e.g., [DFTD4-4.2.0-cpeGNU-26.03.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/d/DFTD4/DFTD4-4.2.0-cpeGNU-26.03/).*

-   [`SCons`](https://docs.easybuild.io/version-specific/generic-easyblocks/#scons): 
    SCons has no configure step, but is used as a tool in the build and install steps.

    [SCons](https://scons.org/) itself is Python software and it has basically the same 
    disadvantages as Meson.

    *It is currently on LUMI only used for one component in the 
    [syslibs libraries](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/s/syslibs/),
    see, e.g., [syslibs-26.03-static.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/s/syslibs/syslibs-26.03-static/).
    At the time of writing, there are also only 3 packages using SCons in the standard EasyBuild packages.*

-   [`Binary`](https://docs.easybuild.io/version-specific/generic-easyblocks/#binary): An easyblock to install software
    from a binary distribution. It has no configure and build step. It unpacks the sources into the build 
    directory and then runs the install step which can consist of a 
    single command or a list of commands specified in the easyconfig, or the default behaviour
    which is to just copy the unpacked files to the install directory.

    As such it is also a good easyblock to abuse if software has a non-standard installation procedure but you
    want to avoid creating an easyblock for it, as you can give a list of installation commands to run.

    *An example on LUMI where we use it as intended are recent versions of 
    [HyperQueue](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/h/HyperQueue/),
    e.g., [HyperQueue-0.26.2-bindist-noPython.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/h/HyperQueue/HyperQueue-0.26.2-bindist-noPython/).
    In this particular example we give an explicit install command as we do not want to copy the files to the
    installation directory, but to the `bin` subdirectory in that directory to ensure that EasyBuild automatically
    generates the correct lines in the environment module file to add the `hq` command to the `PATH`.
    An example where we abuse the `Binary` easyblock to install software from sources, is in our
    [OpenFOAM](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/o/OpenFOAM/) easyconfigs,
    e.g., [OpenFOAM-v2506-cpeGNU-26.03.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/o/OpenFOAM/OpenFOAM-v2506-cpeGNU-26.03/). 
    Here we use some options to let EasyBuild first copy to the install directory instead of to the build directory,
    and then use one single long install command. We cannot split that over multiple commands in an
    `install_cmds` line as we really first build an environment and then execute two commands in it to
    configure and build OpenFOAM. If we would have used a list of commands, each of them would run in
    their own shell.*

-   [`PackedBinary`](https://docs.easybuild.io/version-specific/generic-easyblocks/#packedbinary):
    This easyblock is meant to just copy the downloaded file to the installation directory.
    This is really a simplified version of `Binary` that simply copies all unpacked source files
    to the installation directory without further options (they are defined, but ignored?).

    *An example in the LUMI software stack where we use this easyblock, is
    the [unicore-uftp](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/u/unicore-uftp/) 
    client which is simply Java software (lots of jar files) and a wrapper script to start the tool, e.g.,
    [unicore-uftp-2.4.2-Java-25.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/u/unicore-uftp/unicore-uftp-2.4.2-Java-25/).*

-   [`Bundle`](https://docs.easybuild.io/version-specific/generic-easyblocks/#bundle): A special
    easyblock that enables installing multiple packages from a single easyconfig in a single
    environment module. Each component of the bundle can be installed with a different easyblock
    with all available options of that easyblock, though some things work differently than you
    might expect at first and we may make some more remarks about this further in this section.
    A special use of a `Bundle` is to install no package at all but to simply generate a module
    that loads a number of dependencies.

    *One example in the LUMI software stack is the easyconfig that we use to install
    [EasyBuild](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/e/EasyBuild/) itself, e.g.,
    [EasyBuild-5.4.0.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/e/EasyBuild/EasyBuild-5.4.0/).
    This easyconfig is rather different from the 
    [standard easyconfigs to install EasyBuild](https://github.com/easybuilders/easybuild-easyconfigs/tree/develop/easybuild/easyconfigs/e/EasyBuild),
    partly because we don't use the (rather old) system Python and need to work around some issues that 
    that introduces, partly because we want to install some additional tools that we use from EasyBuild,
    and partly as the Python implementation that we use misses a Python package that we need to install
    EasyBuild.*

    *Another example is the [buildtools](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/b/buildtools/) module, 
    e.g., [buildtools-26.03.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/b/buildtools/buildtools-26.03/),
    which we use to provide a number of tools that are used during the configure and build phases
    to provide an as consistent as possible build environment, even across updates of LUMI.
    This is in fact a rather tricky easyconfig. We want to install these tools with the system
    compiler to make them independent from the HPE Cray Programming Environment and also want to
    link them statically to make any interference with software that is being installed impossible,
    so we first build a limited version 
    (e.g., [buildtools-26.03-bootstrap.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/b/buildtools/buildtools-26.03-bootstrap/)),
    then build a bundle of static libraries that we need to build a more full-featured version
    (the [syslibs](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/s/syslibs/) modules)
    and finally build the full buildtools bundle.*

    *An example of using the `Bundle` easyblock to simply generate a module that loads multiple 
    dependencies, is the [GCC](https://github.com/easybuilders/easybuild-easyconfigs/tree/develop/easybuild/easyconfigs/g/GCC)
    package in the regular EasyBuild distribution (e.g., [GCC-16.2.0.eb](https://github.com/easybuilders/easybuild-easyconfigs/blob/develop/easybuild/easyconfigs/g/GCC/GCC-16.2.0.eb)). The module simply loads the `GCCcore` and
    `binutils` modules but it does play an important role in the toolchain hierarchy of the FOSS
    toolchain.*

-   [`PythonPackage`](https://docs.easybuild.io/version-specific/generic-easyblocks/#pythonpackage):
    An easyblock to install a single Python package. 

    This should be used with care on LUMI, as some Python installations put a very high stress on a parallel
    filesystem. In fact, the file access pattern of Python itself when using packages is more suited to a 
    local disk than to any shared filesystem. Therefore we advise to put Python installations in containers.
    Yet the `PythonPackage` easyblock is still a good choice for a minor addition on top of Cray Python,
    in particular for software that is not used at scale but mostly used in pre- or postprocessing or 
    data staging.

    *We do have some examples in the LUMI software stack, sometimes also because containerisation turned
    out to be very difficult as we needed to compile software with different compilers than Python is
    usually compiled with. One example is 
    [h5py](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/h/h5py/) where we offer a
    configuration that runs on top of Cray Python and uses the Cray HDF5 module 
    (e.g., [h5py-3.11.0-cpeGNU-25.03.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/h/h5py/h5py-3.11.0-cpeGNU-25.03/)).
    A not-so-good example where it proved difficult to offer a container with the resources
    that we have available in LUST, is
    [VeloxChem](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/v/VeloxChem/),
    e.g., [VeloxChem-1.0-gpu-cpeAMD-25.03-rocm.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/v/VeloxChem/VeloxChem-1.0-gpu-cpeAMD-25.03-rocm/),
    which we built for a single project that needed it and for which we also had to build a special version
    of NumPy and SciPy. That package had to be compiled with the AMD compilers and uses OpenMP offload.
    The tricky bit is that the AMD OpenMP library is not compatible with the one that is used for the
    stock NumPy and SciPy in Cray Python, as Python itself is usually compiled with the GNU compilers.*

-   [`PythonBundle`](https://docs.easybuild.io/version-specific/generic-easyblocks/#pythonbundle):
    An easyblock to install one or more Python packages through the extension mechanism. 
    It is based on the `Bundle` easyblock but installs no regular components. Instead it sets up
    the extensions part of the easyconfig to install Python packages. 
    Installing Python packages through the extensions mechanism is easier to debug than a `Bundle`
    with `PythonPackage` components would be, because if installing a `Bundle` fails, you have to
    start over from scratch, while with extensions there is a mechanism to detect which extensions
    have already been installed.

    All remarks made for `PythonPackage` on LUMI of course hold even more here. 

    *Examples are necessarily limited as it is usually not a very good idea to install Python that
    way on LUMI, but over the years we have made some `PythonBundle` easyconfigs for individual needs,
    and they haven't always been updated to newer toolchains because they were often for specific 
    projects. You'll find older ones for, e.g., 
    [matplotlib](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/m/matplotlib/).
    In most cases, it might be better to install this tool in a container or with 
    [lumi-container-wrapper](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-container-wrapper/)
    using conda-forge. Containerising becomes more difficult though if a package needs a high-performance
    MPI implementation, though we have some tricks for that also.*


## Easyconfig parameters: `name`, `version` and `version_suffix`

<figure markdown style="border: 1px solid #000">
  ![Easyconfig parameters: name, version and version_suffix](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/EasyConfigNameVersion.png){ loading=lazy }
</figure>

Example:

``` python
name =           'GROMACS'
version =        '2025.4'
version_suffix = '-CPU'
```

All EasyBuild installations must have a `name` and a `version` (the meaning speaks for itself).

In some cases, a version may not be directly available, e.g., because you install just from a commit
in GitHub. You could then use the GitHub commit as the version, but from the point of view of maintenance,
this would be a nightmare. It is also impossible for users to interpret the version in that case. So
much better would be to use the date of the commit, and if you make that a number YYYYMMDD, the 
EasyConfigs (and environment module names in `module avail` and `module spider`) would even sort 
correctly, making it very easy for a user to see what version is the most recent one or to 
remember which one they used before.

In some cases, you want to install multiple configurations of the same version of a software package
(or different users need a different configuration and we have those EasyConfigs in our software library).
In that case, you can use the `version_suffix` parameter (`versionsuffix` in older versions of EasyBuild)
to distinguish the different versions as we have already discussed before when we discussed the
[relationship between those parameters, the name of the easyconfig and the name of the environment module](02-Basic-concepts.md#easyconfig-names-and-module-names).

On LUMI, we also use `version_suffix` to indicate that a package needs a GPU and has been built with ROCm(tm).
We then add `-rocm` to the `version_siffux` unless we used a version that was not standard for the toolchain,
in which case we add the ROCm(tm) version too. 

One quirk of EasyBuild is that it does not automatically add the dash between the toolchain version and
the version suffix when generating the environment module name (or the name for the easyconfig according
to the naming convention, which it stores in a repo after installing the package).
So the value of the `version_suffix` should start with a `-`.
In fact, we've lied when writing down the different directory and file names in the previous chapter
when discussing [where EasyBuild write things](02-Basic-concepts.md#where-does-easybuild-write-when-installing-software)
as we set a `-` before `<version_suffix>`, but that dash really has to come from the value of
`version_suffix`.


## Easyconfig parameters for `module help`

<figure markdown style="border: 1px solid #000">
  ![Info for module help (1)](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/EasyConfigHelp1.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![Info for module help (2)](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/EasyConfigHelp2.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![Info for module help (3)](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/EasyConfigHelp3.png){ loading=lazy }
</figure>

There are a number of easyconfig parameters used by EasyBuild to assemble the text shown by the
`module help` command:

-   `homepage`: A mandatory parameter, meant to provide a URL to the home page of the software package or
    library. If there is really no homepage available, you can leave it empty though there is an unspoken
    convention to use `(none)` as the value in that case.

-   `description`: A mandatory parameter with a description of what the module provides. This can be a 
    multi-line string in Python.

    The trouble with this parameter is that it is currently used in two different ways if the 
    parameter that we will discuss next is not used:

    -   It is a block of text printed literally in the `module help` information.
        Here you would like to provide very specific information about the specific configuration
        of that particular module in case there are multiple configuration characterised by
        different version suffixes.

    -   But it is also used for a `Description:` whatis-line in the module where it is used by the 
        `module whatis` command but also by the `module spider` command. 
        
        When used by 
        `module spider`, you want it to provide more generic information as it appears in three 
        different contexts:

        1.  `module spider` without arguments: The `Description:` whatis-line is used to give a
            short description that should be valid for all modules with that name.

        2.  `module spider` with the name of a package for which there are multiple modules: The 
            `Description:` whatis-field is now shown before all versions are shown, and should
            again be valid for all modules that are shown.

        3.  `module spider` with a full name and module version: The information given by the easyconfig `description`
            parameter is now shown twice: Once at the top where it is meant to be a short description,
            and once when the help information for the module is shown.

        When used by the `module whatis` command, a long, multi-line argument for the `Description:`
        parameter, and especially one with multiple paragraphs, causes an ugly layout in the output
        of the `module whatis` command. E.g., try `module whatis ASE/3.26.0-gfbf-2025b` in the 2025.06
        version of EESSI.

    Therefore, on LUMI, we suggest to combine `description` with the next parameter, even though it
    does come with a considerable disadvantage also.

-   `whatis`: A list of strings that will be used to generate `whatis` module functions in the 
    module file. Though it is not enforced, to be consistent with what Lmod expects, each line
    should be of the form "Keyword: value", and there should be a line starting with `Description:`
    as that line is searched for by Lmod for the output of the `module whatis` and 
    `module spider` commands.

    E.g., to return to our GROMACS example [GROMACS-2025.4-cpeGNU-26.03-CPU.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/g/GROMACS/GROMACS-2025.4-cpeGNU-26.03-CPU/),
    we have

    ``` python
    whatis = [
        'Description: GROMACS is a versatile package to perform molecular dynamics, i.e. simulate the Newtonian equations of motion for systems with hundreds to millions of particles.',
    ]
    ```

    The disadvantage of this parameter is that it completely turns off the generation of the 
    automatically added `whatis`-lines in EasyBuild rather than merging both giving priority to
    those specified by `whatis` if one overwrites an automatically generated value.

    This is very clear if you know look at the information provided by `module whatis` in the LUMI
    stacks and compare with that provided in the `EESSI` stacks. In most EasyConfigs for the LUMI 
    stack, we overwrite the `whatis`-lines to provide a shorter more generic description as 
    discussed for the `description` parameter. However, this means we also loose other lines
    that are added automatically such as the `Homepage:`, `URL:` and `Extensions:` fields
    (the latter for packages that define extensions).

    For our GROMACS case, we could have obtained the same information as EasyBuild would have
    generated should we have put that one-liner in the `description` field instead of the long one 
    with:

    ``` python
    whatis = [
        'Description: GROMACS is a versatile package to perform molecular dynamics, i.e. simulate the Newtonian equations of motion for systems with hundreds to millions of particles.',
        f'Homepage: {homepage}',
        f'URL: {homepage}'
    ]
    ```

    but for modules with extensions we would have to do more work by hand.

-   `usage`: A multi-line string that is used for the "Usage" block in the help information 
    shown by `module help`. This parameter is entirely optional and there are not that many
    easyconfigs that use it.

-   `examples`: A multi-line string that is used for the "Examples" block in the help information
    hown by `module help`. This parameter is entirely optional and there are even less
    easyconfigs that use it. But if you want, you can use it to provide a lot of information
    in the module files.

-   `doc_urls` (before EB5: `docurls`): A list of URLs to documentation for the package.

    On LUMI we also abuse the parameter to refer to available manual pages, etc. 

    One example in the LUMI stacks is [FFmpeg-8.1.1-cpeGNU-26.03.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/f/FFmpeg/FFmpeg-8.1.1-cpeGNU-26.03/), where we find

    ``` python
    doc_urls = [
        'Manual pages in section 1 and 3',
        'Web-based documentation at https://ffmpeg.org/documentation.html'
    ]
    ```

-   `doc_paths` (before EB5: `docpaths`): A list of strings, each string a relative path with respect
    to the installation directory to a file or directory with documentation about the package.

    An example in the LUMI software stack is 
    [Pango-1.57.1-cpeGNU-26.03.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/Pango/Pango-1.57.1-cpeGNU-26.03/),
    where we find

    ``` Python
    doc_paths = [
        'share/gtk-doc/html/pango'
    ]
    ```

    which will result in 

    ```
    - Documentation:
    - $EBROOTPANGO/share/gtk-doc/html/pango
    ```

    in the information shown by `module help`.

-   `site_contacts`: A list of strings, adding lines towards the end of the `module help` information
    telling the user who can be contacted in case of issues with this module.

    In the LUMI software stacks we use an EasyBuild hook to add this parameter automatically to all
    easyconfigs for software installed in the central software stack so even though the information
    is present in all modules, you will not find it back in our easyconfigs.
    (A hook is a bit of site-specific Python code that hooks into EasyBuild to provide additional
    functionality, but this is an advanced feature outside the scope of this course as it is also
    something site administrators should do.)

-   `upstream_contacts`: A list of string, adding lines towards the end of the `module help` information
    telling the user who can be contacted upstream (outside the LUMI support teams) in case help
    is needed. It can be used to refer to, e.g., a user forum available for the software.

    An example in the LUMI Software Library is 
    [NAMD-3.0.3-cpeGNU-26.03-mpi-crayshasta.eb](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/n/NAMD/NAMD-3.0.3-cpeGNU-26.03-mpi-crayshasta/),
    where we find

    ``` python
    upstream_contacts = [
        'NAMD Mailing List/forum: http://www.ks.uiuc.edu/Research/namd/mailing_list/',
        'NAMD bug report instructions: http://www.ks.uiuc.edu/Research/namd/bugreport.html',
    ]
    ```

EasyBuild also has two parameters that were meant to provide information about the license for
the software, `software_license` and `software_license_urls` that despite still being mentioned
as mandatory on the ["Available easyconfig parameters" page in the EasyBuild documentation](https://docs.easybuild.io/version-specific/easyconfig-parameters/?h=easyconfig+parameter)
are not mandatory at all and have never been fully implemented. The information is not shown
in the module files, and in particular `software_license` is even used in the wrong way in
several standard EasyConfigs. It was not meant to be a sentence but just a kind of constant
defined in EasyBuild. You can already see the problem here: There are really too many different
software licenses to include them all into EasyBuild and even then you'd still have to provide
a special value for a custom license. These parameters were mandatory in EasyBuild 2 but 
it became quickly clear that they were hard to use. 

In fact, the same list also mentions `doc_urls` as mandatory even though it isn't at all.

