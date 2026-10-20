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
