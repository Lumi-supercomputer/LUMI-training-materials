# Using EasyBuild on LUMI I: Basics

## Installing software on HPC systems

<figure markdown style="border: 1px solid #000">
  ![Slide Why HPC-specific installation tools 1](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/SoftwareHPC1.png){ loading=lazy }
</figure>

A supercomputer the scale of LUMI is a very expensive machine. If you invest 160 M EURO in
a supercomputer (or 250M EURO including operating expenses), just a 10% efficiency gain
represents a lot of money and a lot of additional science that could be done. Some of the 
extreme scale projects on LUMI have a value of several millions of EURO so for 10% of 
that amount you can even spent a lot of time optimising.

The Intel/AMD architecture have a long history of remaining compatible with code written
for older versions of the architecture. Yet much of the performance gain of new processors
has come from new instructions and in particular longer vectors or, for AI, new shorter
data formats. The ordering of instructions for optimal performance may also change
though in particular modern CPUs have such powerful instruction reordering features that
this may not always be felt in application performance. Much of this also holds for GPUs, 
in particular the data formats, but also the instruction ordering as GPUs have a very simple
instruction flow and depend more on compiler optimisations for the specific architecture.

All this implies that recompiling software for a specific CPU and GPU can make a lot of sense.

Some CPU libraries have multiple code paths for different CPUs and GPU binaries are often very
fat containing code for multiple architectures, but this is certainly not always standard
and a lot of code can use recompilation for a specific architecture.

Some people promote just-in-time compiler techniques as the end-all solution for those issues,
but in reality they don't solve all those issues as they eat from the run-time and the original
claims that they can then profile and recompile automatically has never paid off as those steps
are too expensive to perform and may in fact also cause issues for parallel applications.
Moreover, they make verification of software more difficult as you may not always have sufficient
control over the version of the JIT compiler. E.g., after a system update, your application could
behave differently even when starting from the same "executable" if the JIT is system-level
and has been updated.


<figure markdown style="border: 1px solid #000">
  ![Slide Why HPC-specific installation tools 2](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/SoftwareHPC2.png){ loading=lazy }
</figure>

Software on HPC systems is **rarely installed from RPMs** (a popular format to package Linux software
distributed as binaries) or any other similar format for various reasons. 

-   Generic RPMs are
    **rarely optimised for the specific CPU** of the system as they have to work on a range
    of systems and including optimised code paths in a single executable for multiple architectures is
    hard to even impossible.

-   Secondly generic RPMs **might not even work with the specific LUMI environment**. They may not fully
    support the Slingshot interconnect and hence run at reduced speed, or they may need particular
    kernel modules or daemons that are not present on the system or they may not work well with
    the resource manager on the system. 
    This is expected to happen especially with packages that require specific MPI versions
    or implementations.

-   Moreover, LUMI is a **multi-user system** so there is usually **no "one version fits all"**.
    You can only install multiple versions if they install in different directories and if there
    is a runtime mechanism to select versions (which is where modules come in on a HPC system).

-   LUMI needs a **small system image as nodes are diskless** which means that RPMs need to be
    relocatable so that they can be installed elsewhere, outside the image.

The last two issues are hard to deal with with RPMs. You cannot always select 
where a RPM is installed. The only solution to create different
setups for multiple users or provide additional packages in the system directories,
is containerisation, but then the installation of some RPMs may 
require elevated privileges that may not be available in the container build environment
for security reasons or may be incompatible with the container runtime.

Yet RPMs also have advantages:

-   They are very easy to install (provided they work well with
    the limitations of the container technology chosen), so we do use containers as one of the ways
    to offer software on LUMI (also for other reasons), but this is not the topic of these notes 
    and this training.

-   Some applications spend most of their time in just a few libraries or even pieces of code in those
    libraries. If these libraries support multiple code paths for different CPUs, the RPM may offer
    the same performance as a hand-compiled code for a specific architecture (or even better as the
    compiler and configuration options may be chosen by an expert in that package).

    A typical example is the BLAS linear algebra library installed on a system.

-   For very interactive software, extensive system-specific optimisations may not make much sense
    as most of the time is spent waiting for user input.

-   The software may only represent a very small fraction of the use of the machine and the cost
    of creating a better-optimised binary for a particular system may just be too much compared 
    to the gains. 

The remarks we've made here about RPMs also hold for other installation techniques from binaries
like Conda or Python wheels.


<figure markdown style="border: 1px solid #000">
  ![Slide Why HPC-specific installation tools 3](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/SoftwareHPC3.png){ loading=lazy }
</figure>

Another observation is that one-size-fits-all less and less works for scientific 
software ans support teams are too small to solve all issues. Different users want
different versions of an application, or different sets of options, or even specific
patches to an application. Building a version of a package that supports all options
at once, may be too time-consuming and a support team can lose a lot of time adding 
features that in the end nobody will use. A full-feature configuration is also very 
hard to debug if something doesn't work as expected, and sometimes various options 
conflict with one another and cannot be used together. Specific patches have become
rather popular for packages such as VASP, GROMACS and LAMMPS (e.g., LAMMPS with 
GRACE which uses a specific branch in a cloned repository).

More and more users also want a workflow with packages that can be used together
well, hence rely on a single set of libraries (though there is a solution to work
around that, namely rpath or runpath linking, but these then introduce other issues).

Because of this, we need flexible instruments that also offer an easy way to communicate
instructions to users who can then also experiment. And this is precisely what this course
is all about.


<figure markdown style="border: 1px solid #000">
  ![Slide Why HPC-specific installation tools 4](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/SoftwareHPC4.png){ loading=lazy }
</figure>

Spack and EasyBuild are the two most popular HPC-specific software build and installation
frameworks. 
These two systems **usually install packages from sources** so that the software can be adapted
to the underlying hardware and operating system.
They do offer a **mean to communicate and execute installation instructions easily** so that in
practice once a package is well supported by these tools a regular user can install them also.
Both packages make **software available via modules** so that you can customise your environment
and select appropriate versions for your work. 
And they do **take care of dependency handling** in a way that is compatible with modules.

But both packages are also very different. A full discussion is outside the scope of these
course notes and this training. But EasyBuild is very much focused on building a fully-defined
software stack and therefore can be a very rigid tool, while modern Spack is more like a 
conda-done-better, focussing on creating a user-specific environment where the concretiser in
Spack takes care of selecting options for each software package in the environment in function
of the other packages in the environment.


## EasyBuild on LUMI

<figure markdown style="border: 1px solid #000">
  ![Slide EasyBuild on LUMI](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/EasybuildOnLUMI.png){ loading=lazy }
</figure>

EasyBuild is offered on LUMI in different ways, each with their own target audience and purpose:

-   EasyBuild is offered in the LUMI software stacks.
    These stacks are built on top of the [HPE Cray Programming Environment](https://cpe.ext.hpe.com/docs/26.03/index.html)
    installation on LUMI
    and require a customised version of EasyBuild to interface with those compilers.
    As a result of this, this stack also does not use the standard EasyBuild recipes but 
    instead relies on custom recipes specifically for LUMI. The reason for that will become
    clearer later in this training.

    This software stack is entirely managed by the LUMI User Support Team (LUST) so the 
    [main LUMI help desk](https://lumi-supercomputer.eu/user-support/need-help/)
    should be contacted for support.

-   EasyBuild is also offered in the EESSI software stacks, 
    on EuroHPC machines known as the [EuroHPD Federation Platform (EFP) Software Catalog](https://docs.my-eurohpc.eu/software-catalog/overview/).

    [EESSI or the European Environment for Scientific Software Installations](https://www.eessi.io/)
    is an initiative that grew out of the EasyBuild community to make a software stack available
    as ready-to-use binaries. This will always be a subset of software supported by EasyBuild as 
    software that is not freely distributable but requires mandatory registration or even a license
    fee cannot be offered that way.

    This stack is based on a standard EasyBuild distribution.

    Support for that stack is delivered through the [EFP helpdesk](https://docs.my-eurohpc.eu/support/)
    as LUST can't really do anything here as the stack is not installed by us.

    Note: The accessing the EFP software catalog requires an EFP registration, but
    the EESSI software stack is also available on LUMI for other users and another 
    version of the software catalog can also be found on the
    ["Software available in EESSI page of the EESSI documentation](https://www.eessi.io/docs/available_software/).

-   The LUMI User Support Team is also starting to prepare for LUMI-AI, the successor of LUMI.

    That system is also equipped with AMD GPUs, but uses a different interconnect (Bull BXI3)
    that requires a different MPI implementation, this time based on Open MPI
    rather than on MPICH.

    At this moment, it is not yet clear what compilers and other libraries Bull will support and how 
    they will offer them (pre-installed on the system and where, which modules, ...) but we do know that
    the AMD compilers (ROCm(tm) and AOCC) will play a bigger role on the system, besides the GNU compilers
    and maybe the Intel compilers (though with Open MPI rather than Intel MPI and maybe without support
    for MKL and the like).

    At the same time, HPE has stopped all development of the Cray Programming Environment and is instead now
    offering the [HPE Supercomputer Programming Software (SUPS)](https://cpe.ext.hpe.com/docs/1.0.0/index.html)
    suite with far fewer HPE-specific components and more open source components, and some software even
    completely missing (e.g., no linear algebra libraries as part of the suite). The environment is really meant
    to be offered through containers (with containers for AMD hardware and for NVIDIA hardware based on a
    different set of compilers and tools) rather than in the traditional way. Depending on whether it is possible
    at all and how much work it is, we may offer some parts of SUPS on the system also, especially if the only
    difference with the software stacks offered for LUMI-AI would be the MPI implementation. In fact, as long as
    issues with Open MPI on Slingshot continue, we may just use Cray MPICH for the stacks for LUMI-AI also.

    This work is done by LUST and other groups involved specifically with LUMI-AI.

    At the time of writing, finishing software stacks for LUMI after the January 2027 system update has a higher
    priority though.


## Extensible stacks

<figure markdown style="border: 1px solid #000">
  ![Slide Extensible stacks](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/ExtensibleStacks.png){ loading=lazy }
</figure>

Realising that building a single software stack that contains everything for everybody is impossible and 
that it is also not possible to solve all issues with a small support team, 
and realising that not all software can be distributed freely to a larger community and access needs to
be controlled,
all these software stacks are made as extensible software stacks: Users can install additional software
using EasyBuild on top of those stacks.
Moreover, sometimes one just ones to experiment with different configurations, different versions, etc.

The LUMI software stacks can be extended through the `EasyBuild-user` module. This module loads the appropriate
version of EasyBuild for the software stack and configures EasyBuild to install in your project or user space
on top of the existing software stack.

EESSI in the EFP can be extended in a similar way, through the 
[`EESSI-extend`](https://www.eessi.io/docs/using_eessi/building_on_eessi/#using-the-eessi-extend-module) 
module. While the LUMI software stack consists of two layers (system level or central installation and one level at the
project or user level), the EESSI stack can consist out of up to 4 layers:

-   Central layer offered by EESSI

-   Site-specific extensions that would typically be managed by the site.
    LUST currently has no plans in this direction.

-   A level to make software available to all members in your own project.

-   A level to install software only for you.

Which level is used and where the software is installed, depends on some environment variables that
need to be set before loading the `EESSI-extend` module.

Note however that more layers are not necessarily better. One can argue that it can save storage space,
but most applications take very little space compared to the amount of data they produce or need as input.
So even with the high prices of storage today this is not a very strong argument. 

More levels can lead to more errors. If a module appears on multiple levels, it can lead to issues,
independent of the priority set between levels. If the user level has the highest priority 
(as in the LUMI stacks) and a module with the same name and full version is added at the 
system level with a different function, packages depending on that module will fail for you as they
will load the wrong module that does not offer the desired functionality. In the LUMI stacks we try
to avoid this as much as possible by defining a stack carefully at the start and avoid to extend it
a lot at the system level afterwards (and offer some extensions as user-installable software, to be
considered for a system-level installation in the next stack). Adversely, if the system level
would have the highest priority, installing a package at that level would break a module with the 
same name and full version at the other levels. The problem is that those levels are coordinated
by different people, and a manager at the system level has no information what a site (in the EESSI)
case or users are doing at the other levels. With a dynamic stack that changes all the time
such as the EESSI stacks, this can be a real problem.


## Some history

<figure markdown style="border: 1px solid #000">
  ![Slide Some history](https://462000265.lumidata.eu/easybuild-20270303/img/LUMI-UD-20270303-EasyBuild/History.png){ loading=lazy }
</figure>

-   In late 2007 the Flemish government in Belgium decided to start a project to provide supercomputing
    in Flanders for all universities (the VSC or Flemish Supercomputer Centre). 
    It was set up as a collaboration between all five universities with
    Tier-2 clusters at 4 of the 5 universities and a larger Tier-1 machine for the larger work managed by
    one university for the others (and LUMI then later became the Tier-0 level).

    To ease the creation of a common software stack in all universities, the HPC service of Ghent University
    started the development of EasyBuild.

-   There was a lot of interest from other universities also, both in the French speaking part of Belgium
    and in other countries. As a result of this interest, a first public release of EasyBuild, version 0.5,
    followed in April 2012 and version 1.0.0 was released in November 2012 during SC'12.

    EasyBuild is also [available on GitHub](https://github.com/easybuilders/).

-   As the community grew, more people from different sites got involved in the development, and the core
    team of maintainers is also international.

    The majority of the community is in Europe though, with some use in the USA and Canada (with the Digital
    Research Alliance of Canada, formerly ComputeCanada as a big user), and some individual sites in other 
    continents.

    The community meets in an annual EasyBuild User Meeting, with the first one in 2016.

-   It is used on a variety of systems, from small departmental clusters to some of the largest supercomputers
    in Europe. Both EasyBuild and EESSI can also be used on Linux workstations to
    create a supercomputer-like environment for experimentation and development.
