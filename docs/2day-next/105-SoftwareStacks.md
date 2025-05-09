# LUMI Software Stacks

In this section we discuss

-   Several of the ways in which we offer software on LUMI
-   Managing software in our primary software stack which is based on EasyBuild

## The software stacks on LUMI

### Design considerations

<figure markdown style="border: 1px solid #000">
  ![Software stack design considerations](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/SoftwareStacksDesignConsiderations.png){ loading=lazy }
</figure>

-   LUMI is a **very leading edge** and also an **inhomogeneous machine**. Leading edge often implies
    **teething problems** and inhomogeneous doesn't make life easier either.

    1.  It uses a **novel interconnect** which is an extension of Ethernet rather than being based on InfiniBand, 
        and that interconnect has a different software stack than your typical Mellanox InfiniBand cluster. 
    2.  It also uses a **relatively new GPU architecture**, AMD CDNA2, with a not fully mature software ecosystem. 
        The GPU nodes are really **GPU-first**, with the **interconnect cards connected directly to the GPU packages** 
        and only one CPU socket, and another feature which is relatively new: the option to use a **partly coherent fully unified memory**
        space between the CPU and GPUs, though of course very NUMA. This is a feature that has previously
        only been seen in supercomputers in some clusters with NVIDIA P100 and V100 GPUs and IBM Power 8 and 9 CPUs used
        for some USA pre-exascale systems.
    3.  LUMI is also **inhomogeneous** because some nodes have zen2 processors while the two main compute partitions
        have zen3-based CPUs, and the compute GPU nodes have AMD GPUs while the visualisation nodes have
        NVIDIA GPUs. 
        
    Given the rather novel interconnect and GPU we cannot expect that all system and application software
    is already fully mature and we need to be prepared for **fast evolution**, 
    hence we needed a setup that enables us
    to remain very agile, which leads to different compromises compared to a software stack for a more
    conventional and mature system as an x86 cluster with NVIDIA GPUs and Mellanox InfiniBand.

-   Users also come to LUMI from **12 different channels**, not counting subchannels as some countries have
    multiple organisations managing allocations, and those channels all have different expectations about
    what LUMI should be and what kind of users should be served. For the major LUMI stakeholder, the EuroHPC JU,
    LUMI is a pre-exascale system meant to prepare users and applications to make use of future even large
    systems, while some of the LUMI consortium countries see LUMI more as an extension of their tier-1 or
    even tier-2 machines.

-   The central support team of LUMI is also **relatively small compared to the nature of LUMI** with its
    many different partitions and storage services and the expected number of projects and users. 
    Support from users coming in via the national channels will rely a lot on efforts from **local organisations**
    also. **So we must set up a system so that they can support their users without breaking things on
    LUMI, and to work with restricted rights.** And in fact, LUMI User Support team members also have very limited additional
    rights on the machine compared to regular users or support people from the local organisations.
    LUST is currently 10 FTE. Compare this to 41 people in the Jülich Supercomputer Centre for software
    installation and support only... (I give this number because it was mentioned in a a talk in the
    EasyBuild user meeting in 2022.)

-   The Cray Programming Environment is also a **key part of LUMI** and the environment for which we get
    support from HPE Cray. It is however different from more traditional environments such as a typical
    Intel oneAPI installation of a typical installation build around the GNU Compiler Collection and Open MPI
    or MPICH. The programming environment is **installed with the operating system** rather than through the
    user application software stack hence not managed through the tools used for the application software
    stack, and it also works differently with its **universal compiler wrappers** that are typically configured
    through modules. 

-   There is an increasing **need for customised setups**. Everybody wants a central stack as long as their
    software is in there but not much more as otherwise it is hard to find, and as long as software is 
    configured in the way they are used to. And everybody would like LUMI to look as much as possible 
    as their home system. But this is of course impossible. Moreover, there are more and more conflicts
    between software packages and modules are only a partial solution to this problem. The success of
    containers, conda and Python virtual environments is certainly to some extent explained by the 
    need for more customised setups and the need for multiple setups as it has become nearly impossible
    to combine everything in a single setup due to conflicts between packages and the dependencies they need.

### The LUMI solution

<figure markdown style="border: 1px solid #000">
  ![The LUMI solution](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/SoftwareStacksTheLUMISolution.png){ loading=lazy }
</figure>

The LUMI User Support Team (LUST) tried to take all these considerations into account 
and came up with a solution that may look **a little unconventional** to many users.

In principle there should be a high degree of compatibility between releases of the HPE Cray Programming
Environment but LUST decided not to take the risk and **build our software for a specific release of the 
programming environment**, which is also a better fit with the typical tools used to manage a scientific 
software stack such as EasyBuild and Spack as they also prefer precise versions for all dependencies and
compilers etc. The stack is also made very easy to extend. So LUMI has **many base libraries and some packages
already pre-installed** but also provides an **easy and very transparent way to install additional packages in
your project space in exactly the same way as is done for the central stack**, with the same performance but the
benefit that the installation can be customised more easily to the needs of your project. Not everybody needs
the same configuration of GROMACS or LAMMPS or other big packages, and in fact a one-configuration-that-works-for-everybody
may even be completely impossible due to conflicting options that cannot be used together.

For the **module system** a choice had to be made between two systems supported by HPE Cray. They support 
Environment Modules with module files based on the TCL scripting language, but only the old version
that is no longer really developed and not the newer versions 4 and 5 developed in France, and Lmod,
a module system based on the LUA scripting language that also support many TCL module files through a
translation layer. **LUMI chose to go with Lmod** as LUA is an easier and more modern language to work with
and as Lmod is much more powerful than Environment Modules 3, certainly for **searching modules**.

To manage the software installations there was a choice between EasyBuild, which is mostly developed in
Europe and hence a good match with a EuroHPC project as EuroHPC wants to develop a European HPC technology stack
from hardware to application software, and Spack, a package developed in the USA national labs.
Both have their own strengths and weaknesses.
LUMI chose to go with **EasyBuild as the primary tool** for which the LUST also does some development. 
However, as we shall see, the EasyBuild installation is not your typical EasyBuild installation
that you may be accustomed with from clusters at your home institution. **It uses toolchains
specifically for the HPE Cray programming environment** so recipes need to be adapted. LUMI does offer a
**growing library of Cray-specific installation recipes** though.
The whole setup of EasyBuild is done such that you can build on top of the central software stack
and such that **your modules appear in your module view** without having to add directories by hand
to environment variables etc. You only need to point to the place where you want to install software
for your project as LUMI cannot automatically determine a suitable place. 

**The LUST does offer some help to set up
Spack also but it is mostly offered "as is" and LUST will not do bug-fixing or development in Spack
package files.** Spack is very attractive for users who want to set up a personal environment with
fully customised versions of the software rather than the rather fixed versions provided by EasyBuild
for every version of the software stack. It is possible to specify versions for the main packages
that you need and then let Spack figure out a minimal compatible set of dependencies to install 
those packages.


### Software policies

<figure markdown style="border: 1px solid #000">
  ![Policies](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/SoftwareStacksPolicies.png){ loading=lazy }
</figure>

As any site, LUMI also has a number of policies about software installation, and these policies
are further developed as the LUMI team gains experience in what they can do with the amount of people 
in LUST and what they cannot do.

LUMI uses a **bring-your-own-license model except for a selection of tools that are useful to a larger
community**. 

-   This is partly caused by the **distributed user management** as the LUST does not even have the necessary
    information to determine if a particular user can use a particular license, so that 
    responsibility must be shifted to people who have that information, which is often the PI of your project.
-   You also have to take into account that **up to 20% of LUMI is reserved for industry** use which makes 
    negotiations with software vendors rather difficult as they will want to push LUMI onto the industrial
    rather than academic pricing as they have no guarantee that LUMI operations will obey 
    to the academic license restrictions. 
-   And lastly, **the LUMI project doesn't have an infinite budget**. 
    There was a questionnaire sent out to 
    some groups even before the support team was assembled and that contained a number of packages that
    by themselves would likely consume the whole LUMI software budget for a single package if I look at the 
    size of the company that produces the package and the potential size of their industrial market. 
    So LUMI has to make choices and with any choice for a very specialised package you favour a few 
    groups. And there is also a political problem as without doubt the EuroHPC JU would prefer that LUMI
    invests in packages that are developed by European companies or at least have large development
    teams in Europe.

!!! Note "Some restrictions coming from software licenses"

    -   Anaconda is currently in a very grey area on LUMI. Point 2.1 of the 
        ["Anaconda Terms of Service"](https://legal.anaconda.com/policies/en?name=terms-of-service#terms-of-service) as published on March 31 2024
        suggest that hardly anybody on
        LUMI can use Anaconda legally without paying for one of the commercial
        offerings. However, in September 2024 an
        [Update on Anaconda Terms of Service](https://www.anaconda.com/blog/update-on-anacondas-terms-of-service-for-academia-and-research)
        was posted that may exempt users from universities on LUMI. What is 
        unclear though, is if ownership of the computer matters, or the legal employer
        of the user. And in any case, even the clarification of September 2024
        does not allow CSC, the operator of LUMI, to assist users to install Anaconda. 
        Just to remain
        on the safe side, even Miniconda, that can still be used even by companies
        as long as they don't download from the Anaconda repositories, will
        be removed from tools offered by CSC and replaced by miniforge.

        Downloading from [conda-forge](https://conda-forge.org/) is perfectly OK
        though.

    -   The LUMI support team cannot really help much with VASP as most people in the support 
        team are not covered by a valid VASP license. VASP licenses typically even contain a list
        of people who are allowed to touch the source code, and one person per license who can
        download the source code. We're trying to get better access with a support license
        but it takes time.

<!-- BELGIUM
The LUMI User Support Team **tries to help with installations of recent software** but **porting or bug
correction in software is not their task**. In Flanders some help is possible by the VSC Tier-0 support team
but do not expect that they will port your whole application.
For very complicated installations the 
[EPICURE project](https://epicure-hpc.eu) may sometimes be able to help.
As a user, you have to realise that **not all Linux or even
supercomputer software will work on LUMI**. This holds even more for software that comes only as
a binary. The **biggest problems are the GPU and anything that uses distributed memory** and requires
high performance from the interconnect. For example,
END BELGIUM -->

<!-- GENERAL More general version -->
The LUMI User Support Team **tries to help with installations of recent software** but **porting or bug
correction in software is not their task**. Some consortium countries may also have a local support
team that can help, and for very complicated installations the 
[EPICURE project](https://epicure-hpc.eu) may sometimes be able to help.
As a user, you have to realise that **not all Linux or even
supercomputer software will work on LUMI**. This holds even more for software that comes only as
a binary. The **biggest problems are the GPU and anything that uses distributed memory** and requires
high performance from the interconnect. For example,
<!-- END GENERAL -->

-   software that use NVIDIA proprietary programming models and
    libraries needs to be ported. 
-   Binaries that do only contain NVIDIA code paths, even if the programming
    model is supported on AMD GPUs, will not run on LUMI. 
-   Binaries for AMD GPUs must work with the ROCm versions that can be supported on the system.
    There can be only one driver version and each driver version supports only a limited range
    of ROCm versions.
-   The LUMI interconnect requires **libfabric**, the Open Fabrics Interface (OFI) library,
    using a specific provider for the NIC used on LUMI, the so-called Cassini provider (CXI), 
    so any software compiled with an MPI library that
    requires UCX, or any other distributed memory model built on top of UCX, will not work on LUMI, or at
    least not work efficiently as there might be a fallback path to TCP communications. 
-   Even intra-node interprocess communication can already cause problems
    as there are three different kernel extensions
    that provide more efficient interprocess messaging than the standard Linux mechanism. Many clusters
    use **knem** for that but on LUMI **xpmem** is used. So software that is not build to support xpmem will
    also fall back to the default mechanism or fail. 
-   Also, the MPI implementation needs to **collaborate
    with certain modules in our Slurm installation** to start correctly and experience has shown that this
    can also be a source of trouble as the fallback mechanisms that are often used do not work on LUMI. 
-   **Containers solve none of these problems**. There can be more subtle compatibility problems also. 
    As has been discussed earlier in the course, LUMI runs SUSE Linux and not Ubuntu which is popular on 
    workstations or a Red Hat-derived Linux popular on many clusters. Subtle differences between Linux 
    versions can cause compatibility problems that in some cases can be solved with containers. But containers
    won't help you if they are build for different kernel extensions and hardware interfaces.
-   The **compute nodes also lack some Linux daemons** that may be present on smaller clusters. HPE Cray use an
    optimised Linux version called COS or Cray Operating System on the compute nodes. It is optimised to
    reduce OS jitter and hence to enhance scalability of applications as that is after all the primary
    goal of a pre-exascale machine. But that implies that certain Linux daemons that your software may 
    expect to find are not present on the compute nodes. D-Bus comes to mind.

Also, the LUMI user support team is **too small to do all software installations** which is why LUMI currently
states in its policy that a LUMI user should be capable of installing their software themselves or have
another support channel. The LUST cannot install every single piece of often badly documented research-quality
code that was never meant to be used by people who don't understand the code. Again some help is possible 
at the Belgian level but our resources are also limited.

Another soft compatibility problem that I did not yet mention is that software that **accesses tens
of thousands of small files and abuses the file system as a database** rather than using structured
data formats designed to organise data on supercomputers is not welcome on LUMI. For that reason LUMI
also requires to **containerize conda and Python installations**. 
On LUMI three tools are offered for this. 

1.  [cotainr](https://docs.lumi-supercomputer.eu/software/containers/singularity/#building-containers-using-the-cotainr-tool) 
    is a tool developed by the Danish LUMI-partner DeIC that helps with building some types of 
    containers that can be built in user space. Its current version focusses on containerising 
    a conda-installation.
2.  The second tool is a container-based wrapper generator that offers 
    a way to install conda packages or to install Python packages with pip on top of 
    the Python provided by the `cray-python` module. On LUMI the tool is called
    [lumi-container-wrapper](https://docs.lumi-supercomputer.eu/software/installing/container-wrapper/)
    but users of the CSC national systems will know it as Tykky. 
3.  SingularityCE supports the so-called 
    [unprivileged proot build process](https://docs.sylabs.io/guides/4.1/user-guide/build_a_container.html#unprivilged-proot-builds) 
    to build containers. With this process, it is also possible to add additional OS packages, etc., to the container.

Both cotainr and lumi-container-wrapper are pre-installed on the system as modules. Furthermore, there is also
a module that provides the `proot` command needed by the SingularityCE unprivileged proot build process.


### Organisation of the software in software stacks

<figure markdown style="border: 1px solid #000">
  ![Organisation"Software Stacks](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/SoftwareStacksOrganisation.png){ loading=lazy }
</figure>

LUMI offers several software stacks:

**CrayEnv** is the minimal software stack for users who only need the 
**Cray Programming Environment** but want a **more recent set of build tools etc** 
than the OS provides. We also take care of a few issues that we will discuss
on the next slide that are present right after login on LUMI.

Next we have the **stacks called "LUMI"**. Each one corresponds to a **particular release of the HPE Cray
Programming Environment**. It is the stack in which the LUST installs software using that programming environment
and mostly EasyBuild. **The Cray Programming Environment modules are still used, but they are accessed through
a replacement for the PrgEnv modules that is managed by EasyBuild**. There are **tuned versions for the 3 types
of hardware in the regular LUMI system**: zen2 CPUs in the login nodes and large memory nodes, zen3 for the 
LUMI-C compute nodes and zen3 + MI250X for
the LUMI-G partition. If the need would arise, a fourth partition could be created for the visualisation nodes
with zen2 CPUs and NVIDIA GPUs.

LUMI also offers an extensible software stack based on **Spack** which has been pre-configured to use the compilers
from the Cray PE. This stack is offered as-is for users who know how to use Spack, but support is limited and
no bug-fixing in Spack is done.

Some partner organisations in the LUMI consortium also provide pre-installed software on LUMI.
This software is not managed by the LUMI User Support Team and as a consequence of this, support
is only provided through those organisations that manage the software. Though they did promise
to offer some basic support for everybody, the level of support may be different depending on
how your project ended up on LUMI as they receive no EuroHPC funding for this. 
There is also no guarantee that software in those stacks is compatible with anything else
on LUMI. The stacks are provided by modules whose name starts with `Local-`.
Currently there are two such stacks on LUMI:

-   `Local-CSC`: Enables software installed and maintained by CSC. 
    Most of that software is available to all users, though some packages are 
    restricted or only useful to users of other CSC services (e.g., the allas module).

    Some of that software builds on software in the LUMI stacks, some is based on 
    containers with wrapper scripts, and some is compiled outside of any software 
    management environment on LUMI.

    The names of the modules don't follow the conventions of the LUMI stacks, but those
    used on the Finnish national systems.

-   `Local-quantum` contains some packages of general use, but also some packages that 
    are only relevant to Finnish researchers with an account on the Helmi quantum computer. 
    Helmi is not a EuroHPC-JU computer so being eligible for an account on LUMI does 
    not mean that you are also eligible for an account on Helmi.

In the far future the LUST will also look at **a stack based on the common EasyBuild toolchains as-is**, 
but problems are expected with MPI
that will make this difficult to implement, and the common toolchains also do not yet support
the AMD GPU ecosystem, so no promises whatsoever are made about a time frame for this development.


### 3 ways to access the Cray Programming environment on LUMI.

#### Bare environment and CrayEnv

<figure markdown style="border: 1px solid #000">
  ![Accessing the Cray PE on LUMI slide 1](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/SoftwareStacksAccessingCrayPE_1.png){ loading=lazy }
</figure>

Right after login you have a **very bare environment available with the Cray Programming Environment
with the PrgEnv-cray module loaded**. It gives you basically **what you can expect on a typical Cray system**.
There aren't many tools available, basically **mostly only the tools in the base OS image and some tools that
will not impact software installed in one of the software stacks**.
The set of target modules loaded is the one for the login nodes and not tuned to any particular node type.
**As a user you're fully responsible for managing the target modules**, reloading them when needed or loading the
appropriate set for the hardware you're using or want to cross-compile for.

The **second way** to access the Cray Programming Environment is through the **CrayEnv software stack**. This stack
offers an **"enriched" version of the Cray environment**. It **takes care of the target modules**: Loading or reloading
CrayEnv will reload an optimal set of target modules for the node you're on. It also provides **some additional 
tools** like newer build tools than provided with the OS. They are offered here and not in the bare environment to be
sure that those tools don't create conflicts with software in other stacks. But otherwise the Cray Programming 
Environment **works exactly as you'd expect from this course or the 4-day comprehensive courses
that LUST organises**.


#### LUMI stack

<figure markdown style="border: 1px solid #000">
  ![Accessing the Cray PE on LUMI slide 2](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/SoftwareStacksAccessingCrayPE_2.png){ loading=lazy }
</figure>

The **third way** to access the Cray Programming Environment is through the **LUMI software stacks**, where each stack
is **based on a particular release of the HPE Cray Programming Environment**. We advise against mixing with modules
that came with other versions of the Cray PE, but they **remain accessible** although they are hidden from the default
view for regular users. It is also better to **not use the PrgEnv modules, but the equivalent LUMI EasyBuild 
toolchains** instead as indicated by the following table:

| HPE Cray PE   | LUMI toolchain | What?                                           |
|:--------------|:---------------|:------------------------------------------------|
| `PrgEnv-cray` | `cpeCray`      | Cray Compiling Environment                      |
| `PrgEnv-gnu`  | `cpeGNU`       | GNU C/C++ and Fortran                           |
| `PrgEnv-aocc` | `cpeAOCC`      | AMD CPU compilers (login nodes and LUMI-C only) |
| `PrgEnv-amd`  | `cpeAMD`       | AMD ROCm GPU compilers (LUMI-G only)            |

The cpeCray etc modules also load the MPI libraries and Cray LibSci just as the PrgEnv modules do.
And they are sometimes used to work around problems in Cray-provided modules that cannot changed
easily due to the way system administration on a Cray system is done. 

This is also the environment in which the LUST installs most software, 
and from the name of the modules you can see which compilers we used.


#### LUMI stack module organisation

<figure markdown style="border: 1px solid #000">
  ![Accessing the Cray PE on LUMI slide 3](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/SoftwareStacksAccessingCrayPE_3.png){ loading=lazy }
</figure>

To manage the heterogeneity in the hardware, the LUMI software stack uses **two levels of modules**

First there are the **LUMI/24.03, LUMI/23.12, LUMI/23.09, LUMI/23.03, LUMI/22.12 and LUMI/22.08 modules**. 
Each of the LUMI modules loads a particular version of the LUMI stack.

The **second level consists of partition modules**. 
There is partition/L for the login and large memory nodes,
partition/C for the regular compute nodes and 
partition/G for the AMD GPU nodes.
There may be a separate partition for the visualisation nodes in the future 
but that is not clear yet.

There is also a **hidden partition/common module** in which software is installed that is available everywhere, 
but we advise you to be careful to install software in there in your own installs as it is risky to rely on
software in one of the regular partitions, and impossible in our EasyBuild setup.

The LUMI module will **automatically load the best partition module** for the current hardware whenever it
is loaded or reloaded. So if you want to cross-compile, you can do so by loading a different partition 
module after loading the LUMI module, but you'll have to reload every time you reload the LUMI module.

Hence you should also **be very careful in your job scripts**. On LUMI the environment from the login nodes
is used when your job starts, so unless you switched to the suitable partition for the compute nodes,
your job will start with the software stack for the login nodes. If in your job script you reload the 
LUMI module it will instead switch to the software stack that corresponds to the type of compute node
you're using and more optimised binaries can be available. If for some reason you'd like to use the
same software on LUMI-C and on the login or large memory nodes and don't want two copies of locally
installed software, you'll have to make sure that after reloading the LUMI module in your job script you
explicitly load the partition/L module.

!!! Note "Supported stacks after the August 2024 system update"
    Since 24.03 is the only version of the Cray Programming Environment currently fully supported
    by HPE on LUMI, as it is the only version which is from the ground up built for ROCm/6.0, 
    SUSE Enterprise 15 SP5, and the current version of the SlingShot software, it is also the only
    fully supported version of the LUMI software stacks.

    The 23.12 and 23.09 version function reasonably well, but keep in mind that 23.09 was originally
    meant to be used with ROCm 5.2 or 5.5 depending on the SUSE version while you will now get a much
    newer version of the compilers that come with ROCm.

    The even older stacks are only there for projects that were using them. We've had problems with
    them already in the past and they currently don't work properly anymore for installing software
    via EasyBuild.


## EasyBuild to extend the LUMI software stack

### Installing software on HPC systems

<figure markdown style="border: 1px solid #000">
  ![Installing software on HPC systems](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildInstallingSoftwareHPC.png){ loading=lazy }
</figure>

Software on HPC systems is **rarely installed from RPMs** 
(**R**ed Hat **P**ackage **M**anager, a popular format to package Linux software
distributed as binaries) or any other similar format for various reasons. Generic RPMs are
**rarely optimised for the specific CPU** of the system as they have to work on a range
of systems and including optimised code paths in a single executable for multiple architectures is
hard to even impossible.
Secondly generic RPMs **might not even work with the specific LUMI environment**. They may not fully
support the SlingShot interconnect and hence run at reduced speed, or they may need particular
kernel modules or daemons that are not present on the system or they may not work well with
the resource manager on the system. 
This is expected to happen especially with packages that require specific MPI versions
or implementations.
Moreover, LUMI is a **multi-user system** so there is usually **no "one version fits all"**.
And LUMI needs a **small system image as nodes are diskless** which means that RPMs need to be
relocatable so that they can be installed elsewhere.

Spack and EasyBuild are the two most popular HPC-specific software build and installation
frameworks. 
These two systems **usually install packages from sources** so that the software can be adapted
to the underlying hardware and operating system.
They do offer a **mean to communicate and execute installation instructions easily** so that in
practice once a package is well supported by these tools a regular user can install them also.
Both packages make **software available via modules** so that you can customise your environment
and select appropriate versions for your work. 
And they do **take care of dependency handling** in a way that is compatible with modules.


### Extending the LUMI stack with EasyBuild

<figure markdown style="border: 1px solid #000">
  ![Extending the LUMI stack with EasyBuild](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildExtendingLUMIStack.png){ loading=lazy }
</figure>

On LUMI EasyBuild is the primary software installation tool. 
EasyBuild was selected as there is
already a lot of experience with EasyBuild in several LUMI consortium countries and as
it is also a tool developed in Europe which makes it a nice fit with EuroHPC's goal of
creating a fully European HPC ecosystem.

EasyBuild is **fully integrated in the LUMI software stack**. Loading the LUMI module will
not only make centrally installed packages available, but also packages installed in
your personal or project stack. Installing packages in that space
is done by loading the EasyBuild-user module that will load a suitable version of
EasyBuild and configure it for installation in a way that is compatible with the
LUMI stack.
EasyBuild will then use existing modules for dependencies if those are already on the system
or in your personal or project stack.

Note however that the **built-in easyconfig files that come with EasyBuild do not work on LUMI** at
the moment.

-   For the GNU toolchain there would be problems with MPI. EasyBuild uses Open MPI and that
    needs to be configured differently to work well on LUMI, and there are also still issues with
    getting it to collaborate with the resource manager as it is installed on LUMI.
-   The Intel-based toolchains have their problems also. At the moment, the Intel compilers with the
    AMD CPUs are a problematic cocktail. There have recently been performance and correctness problems 
    with the MKL math library and also failures with some versions of Intel MPI, 
    and you need to be careful selecting compiler options and not use `-xHost`
    or the classic Intel compilers will simply optimize for a two decades old CPU.
    The situation is better with the new LLVM-based compilers though, and it looks like
    very recent versions of MKL are less AMD-hostile. Problems have also been reported
    with Intel MPI running on LUMI.

Instead LUMI has its **own EasyBuild build recipes** that are also made available in the 
[LUMI-EasyBuild-contrib GitHub repository](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib).
The EasyBuild configuration done by the EasyBuild-user module will find a copy of that repository
on the system or in your own install directory. The latter is useful if you always want the very
latest, before it is even deployed on the system. 

LUMI also offers the
[LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
which documents all software for which there are LUMI-specific EasyBuild recipes available. 
This includes both the pre-installed software and the software for which recipes are provided in the
[LUMI-EasyBuild-contrib GitHub repository](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib),
and even instructions for some software that is not suitable for installation through EasyBuild or
Spack, e.g., because it likes to write in its own directories while running.


### EasyBuild recipes - easyconfigs

<figure markdown style="border: 1px solid #000">
  ![EasyBuild recipes - easyconfigs](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildEasyConfig.png){ loading=lazy }
</figure>

EasyBuild uses a build recipe for each individual package, or better said, each individual module
as it is possible to install more than one software package in the same module. That installation
description relies on either a generic or a specific installation process provided by an easyblock.
The build recipes are called easyconfig files or simply easyconfigs and are Python files with 
the extension `.eb`. 

The typical steps in an installation process are:

1.  Downloading and unpacking sources and applying patches. 
    For licensed software you may have to provide the sources as
    often they cannot be downloaded automatically.
2.  A typical configure - build - test - install process, where the test process is optional and
    depends on the package providing useable pre-installation tests.
3.  An extension mechanism can be used to install perl/python/R extension packages
4.  Then EasyBuild will do some simple checks (some default ones or checks defined in the recipe)
5.  And finally it will generate the module file using lots of information specified in the 
    EasyBuild recipe.

Most or all of these steps can be influenced by parameters in the easyconfig.


### The toolchain concept

<figure markdown style="border: 1px solid #000">
  ![The toolchain concept](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildToolchain_1.png){ loading=lazy }
</figure>

EasyBuild uses the toolchain concept. A toolchain consists of compilers, an MPI implementation
and some basic mathematics libraries. The latter two are optional in a toolchain. All these 
components have a level of exchangeability as there are language standards, as MPI is standardised,
and the math libraries that are typically included are those that provide a standard API for which
several implementations exist. All these components also have in common that it is risky to combine 
pieces of code compiled with different sets of such libraries and compilers because there can
be conflicts in names in the libraries.

LUMI doesn't use the standard EasyBuild toolchains but its own toolchains specifically for Cray
and these are precisely the `cpeCray`, `cpeGNU`, `cpeAOCC` and `cpeAMD` modules already mentioned 
before.

| HPE Cray PE   | LUMI toolchain | What?                                           |
|:--------------|:---------------|:------------------------------------------------|
| `PrgEnv-cray` | `cpeCray`      | Cray Compiling Environment                      |
| `PrgEnv-gnu`  | `cpeGNU`       | GNU C/C++ and Fortran                           |
| `PrgEnv-aocc` | `cpeAOCC`      | AMD CPU compilers (login nodes and LUMI-C only) |
| `PrgEnv-amd`  | `cpeAMD`       | AMD ROCm GPU compilers (LUMI-G only)            |


<figure markdown style="border: 1px solid #000">
  ![The toolchain concept 2](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildToolchain_2.png){ loading=lazy }
</figure>

There is also a special toolchain called the SYSTEM toolchain that uses the compiler
provided by the operating system. This toolchain does not fully function in the same way as the other
toolchains when it comes to handling dependencies of a package and is therefore a bit harder to use.
The EasyBuild designers had in mind that this compiler would only be used to bootstrap an
EasyBuild-managed software stack, but on LUMI it is used for a bit more as it offers a
relatively easy way to compile some packages also for the CrayEnv stack and do this in a way
that they interact as little as possible with other software.

It is not possible to load packages from different cpe toolchains at the same time.
This is an EasyBuild restriction, because mixing libraries compiled with different compilers
does not always work. This could happen, e.g., if a package compiled with the Cray Compiling
Environment and one compiled with the GNU compiler collection would both use a particular 
library, as these would have the same name and hence the last loaded one would be used
by both executables (LUMI doesn't use rpath or runpath linking in EasyBuild for those familiar
with that technique).

However, as LUMI does not use hierarchy in the Lmod implementation of the software stack
at the toolchain level, the module system will not protect you from these mistakes. 
When the LUST set up the software stack, most people in the support team considered it too misleading
and difficult to ask users to first select the toolchain they want to use and then see the 
software for that toolchain.

It is however possible to combine packages compiled with one CPE-based toolchain with packages
compiled with the system toolchain, but you should avoid mixing those when linking as that may cause
problems. The reason that it works when running software is because static linking
is used as much as possible in the SYSTEM
toolchain so that these packages are as independent as possible.

And with some tricks it might also be possible to combine packages from the LUMI software stack
with packages compiled with Spack, but one should make sure that no Spack packages are available
when building as mixing libraries could cause problems. Spack uses rpath linking which is why
this may work.


### EasyConfig names and module names

<figure markdown style="border: 1px solid #000">
  ![easyconfig names and module names](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyConfigModuleNames.png){ loading=lazy }
</figure>

There is a convention for the naming of an EasyConfig as shown on the slide. This is not
mandatory, but EasyBuild will fail to automatically locate easyconfigs for dependencies 
of a package that are not yet installed if the easyconfigs don't follow the naming
convention. Each part of the name also corresponds to a parameter in the easyconfig 
file.

Consider, e.g., the easyconfig file `GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb`.

1.  The first part of the name, `GROMACS`, is the name of the package, specified by the
    `name` parameter in the easyconfig, and is after installation also the name of the
    module.
2.  The second part, `2024.3`, is the version of GROMACS and specified by the
    `version` parameter in the easyconfig.
3.  The next part, `cpeGNU-24.03` is the name and version of the toolchain,
    specified by the `toolchain` parameter in the easyconfig. The version of the
    toolchain must always correspond to the version of the LUMI stack. So this is
    an easyconfig for installation in `LUMI/24.03`.

    This part is not present for the SYSTEM toolchain

4.  The final part, `-PLUMED-2.9.3-noPython-CPU`, is the version suffix and used to provide
    additional information and distinguish different builds with different options
    of the same package. It is specified in the `versionsuffix` parameter of the
    easyconfig.

    This part is optional.

The version, toolchain + toolchain version and versionsuffix together also combine
to the version of the module that will be generated during the installation process.
Hence this easyconfig file will generate the module 
`GROMACS/2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU`.



### Installing

#### Step 1: Where to install

<figure markdown style="border: 1px solid #000">
  ![Installing: Where to install](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildInstallingStep1.png){ loading=lazy }
</figure>

Let's now discuss how you can extend the central LUMI software stack with packages that you
need for your project.

The default location for the EasyBuild user modules and software is in `$HOME/EasyBuild`. This is not
the ideal place though as then the software is not available for other users in your project, and
as the size of your home directory is also limited and cannot be expanded. The home file system on LUMI 
is simply not meant to install software. However, as LUMI users can have multiple projects there is no
easy way to figure out automatically where else to install software.

The best place to install software is in your project directory so that it also becomes available
for the whole project. After all, a project is meant to be a collaboration between all participants
of the project to solve a scientific problem. 
You'll need to point LUMI to the right location though and that has to
be done by setting the environment variable `EBU_USER_PREFIX` to point to the location where you
want to have your custom installation. Also don't forget to export that variable as otherwise the
module system and EasyBuild will not find it when they need it. So a good choice would be 
something like 
`export EBU_USER_PREFIX=/project/project_465000000/EasyBuild`. 
You have to do this **before** loading the `LUMI` module as it is then already used to ensure that
user modules are included in the module search path. You can do this in your `.profile` or
`.bashrc`. 
This variable is not only **used by EasyBuild-user** to know where to install software, but also 
by the `LUMI` - or actually **the `partition` - module to find software** so all users in your project
who want to use the software should set that variable.


#### Step 2: Configure the environment

<figure markdown style="border: 1px solid #000">
  ![Installing: Configure the environment](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildInstallingStep2_1.png){ loading=lazy }
</figure>

The next step is to configure your environment. First load the proper version of the LUMI
stack for which you want to install software, and you may want to change to the proper
partition also if you are cross-compiling.

Once you have selected the software stack and partition, all you need to do to 
activate EasyBuild to install additional software is to load
the `LUMI` module, load a partition module if you want a different one from the default, and 
then load the `EasyBuild-user` module. In fact, if you switch to a different `partition` 
or `LUMI` module after loading `EasyBuild-user` EasyBuild will still be correctly reconfigured 
for the new stack and new partition. 

Cross-compilation which is installing software for a different partition than the one you're
working on does not always work since there is so much software around with installation scripts
that don't follow good practices, but when it works it is easy to do on LUMI by simply loading
a different partition module than the one that is auto-loaded by the `LUMI` module. It works 
correctly for a lot of CPU-only software, but fails more frequently for GPU software as the
installation scripts will try to run scripts that detect which GPU is present, or try to run
tests on the GPU, even if you tell which GPU type to use, which does not work on the login nodes.

**Note that the `EasyBuild-user` module is only needed for the installation process. For using
the software that is installed that way it is sufficient to ensure that `EBU_USER_PREFIX` has
the proper value before loading the `LUMI` module.**

<figure markdown style="border: 1px solid #000">
  ![Step 2: Configure the environment - Demo](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildInstallingStep2_2.png){ loading=lazy }
</figure>


#### Step 3: Install the software.

<figure markdown style="border: 1px solid #000">
  ![Installing: Install the software](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildInstallingStep3.png){ loading=lazy }
</figure>

Let's look at GROMACS as an example. I will not try to do this completely live though as the 
installation takes 15 or 20 minutes.

First we need to figure out for which versions of GROMACS there is already support on LUMI.
An easy way to do that is to simply check the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/).
This web site lists all software that we manage via EasyBuild and make available either pre-installed on
the system or as an EasyBuild recipe for user installation.
Alternatively one can use `eb -S` or `eb --search` for that. So in our example this is
``` bash
eb --search GROMACS
```

!!! Note "Results of the searches:"

    In the LUMI Software Library, after some scrolling through 
    [the page for GROMACS](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/g/GROMACS/), 
    the list of EasyBuild recipes is found in the 
    ["User-installable modules (and EasyConfigs)"](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/g/GROMACS/#user-installable-modules-and-easyconfigs)
    section:

    <figure markdown style="border: 1px solid #000">
      ![GROMACS in the LUMI Software Library](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSSoftLib.png){ loading=lazy }
    </figure>

    `eb --search GROMACS` produces:

    <figure markdown style="border: 1px solid #000">
      ![eb --search GROMACS](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSSearch_1.png){ loading=lazy }
    </figure>

    while `eb -S GROMACS` produces:

    <figure markdown style="border: 1px solid #000">
      ![eb -S GROMACS](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSSearch_2.png){ loading=lazy }
    </figure>

    The information provided by both variants of the search command is the same, but `-S` presents the information in a more
    compact form.

Now let's take the variant `GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb`. 
This is GROMACS 2024.3 with the PLUMED 2.9.3 plugin, built with the GNU compilers
from `LUMI/24.03`, and a build meant for CPU-only systems. The `-CPU` extension is not
always added for CPU-only system, but in case of GROMACS there already is a GPU version
for AMD GPUs in active development so even before LUMI-G was active we chose to ensure
that we could distinguish between GPU and CPU-only versions.
To install it, we first run 

```bash
eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb –D
```

The `-D` flag tells EasyBuild to just perform a check for the dependencies that are needed
when installing this package.

!!! Demo "The output of this command looks like:"

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb –D](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSDep_01.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb –D (2)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSDep_02.png){ loading=lazy }
    </figure>

    Most lines start with `[x]` which means that the dependency is already installed. At the end of the list, we notice that 
    non only the GROMACS module is missing, but the `eb` command also failed to find a module for `PLUMED`, a dependency of
    this GROMACS configuration. So that module needs to be installed first, but EasyBuild can take care of that for us...


To install GROMACS and also automatically install missing dependencies (only PLUMED
in this case), we run

```bash
eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb -r
```

The `-r` argument tells EasyBuild to also look for dependencies in a preset search path
and to install them. The installation of dependencies is not automatic
since there are scenarios where this is not desired and it cannot be turned off as easily as
it can be turned on.

!!! Demo "Running EasyBuild to install GROMACS and dependency"
    The command

    ```bash
    eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb -r
    ```

    results in:

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb -r](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSInst_01.png){ loading=lazy }
    </figure>

    EasyBuild detects PLUMED is a dependency and because of the `-r` option, it first installs the
    required version of PLUMED.

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb -r (2)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSInst_02.png){ loading=lazy }
    </figure>

    When the installation of PLUMED finishes, EasyBuild starts the installation of GROMACS.
    It mentions something we haven't seen when installing PLUMED:

    ```
    == starting iteration #0
    ```

    GROMACS can be installed in many configurations, and they generate executables with different names.
    Our EasyConfig combines 4 popular installations in one: Single and double precision and with and without
    MPI, so it will do 4 iterations. As EasyBuild is developed by geeks, counting starts from 0.

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb -r (3)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSInst_03.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb -r (4)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSInst_04.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb -r (5)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSInst_05.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.3-noPython-CPU.eb -r (6)](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildGROMACSInst_06.png){ loading=lazy }
    </figure>

This takes too long to wait for, but once it finished the software should be available
and you should be able to see the module in the output of
```bash
module avail
```


#### Step 3: Install the software - Note

<figure markdown style="border: 1px solid #000">
  ![Installing: Install the software](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildInstallingStep3Note.png){ loading=lazy }
</figure>

Installing software this way is **99% equivalent to an installation in the central software
tree**. The application is compiled in exactly the same way as we would do and served from Lustre file systems in both cases. The one difference is that the central software stack is on all 4 hard disk based Lustre 
filesystem for availability reasons if one of the file systems is taken down for maintanence 
(and a bit for performance reasons as executable and shared library loading for a big
multi-node job will likely be spread across 4 filesystems),
but on the other hand, as long as the retention policy is not active, you could even
use `/flash` for a software installation if you have enough storage billing units
and get better startup performance for some packages, or even better runtime performance
for those packages that keep opening files in the software installation.
Furthermore, it helps **keep the output of `module avail` reasonably short** and **focused
on your projects**, and it **puts you in control of installing updates**. For instance, we may find out
that something in a module does not work for some users and that it needs to be re-installed. 
Do this in the central stack and either you have to chose a different name or risk breaking running
jobs as the software would become unavailable during the re-installation and also jobs may get
confused if they all of a sudden find different binaries. However, have this in your own stack
extension and you can update whenever it suits your project best or even not update at all if 
you figure out that the problem we discovered has no influence on your work.

Lmod does keep a user cache of modules. EasyBuild will try to erase that cache after a
software installation to ensure that the newly installed module(s) show up immediately.
We have seen some very rare cases where clearing the cache did not help likely because some
internal data structures in Lmod where corrupt. The easiest way to solve this is to simply
log out and log in again and rebuild your environment.

In case you see strange behaviour using modules you can also try to manually
remove the Lmod user cache which is in `$HOME/.cache/lmod`.
You can do this with 
```bash
rm -rf $HOME/.cache/lmod
```
(With older versions of Lmod the cache directory is `$HOME/.lmod.d/cache`.)


### More advanced work

<figure markdown style="border: 1px solid #000">
  ![More advanced work](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildAdvanced_1.png){ loading=lazy }
</figure>

You can also install some EasyBuild recipes that you got from support. For this it is best to
create a subdirectory where you put those files, then go into that directory and run 
something like
```bash
eb my_recipe.eb -r . 
```
The dot after the `-r` is very important here as it does tell EasyBuild to also look for 
dependencies in the current directory, the directory where you have put the recipes you got from
support, but also in its subdirectories so for speed reasons you should not do this just in your
home directory but in a subdirectory that only contains those files.

In some cases you will have to download sources by hand as packages don't allow to download 
software unless you sign in to their web site first. This is the case for a lot of licensed software,
for instance, for VASP. LUMI would likely be in violation of the license if it would 
offer the download somewhere
where EasyBuild can find it, and it is also a way to ensure that you have a license for VASP.
For instance, 
```bash
eb --search VASP
```
will tell you for which versions of VASP LUMI provides EasyBuild recipes, but you will still have
to download the source file that the EasyBuild recipe expects. 
Put it somewhere in a directory, and then from that
directory run EasyBuild, for instance for VASP 6.5.0 with the GNU compilers:
```bash
eb VASP-6.5.0-cpeGNU-24.03-build02.eb –r . 
```

### More advanced work (2): Repositories

<figure markdown style="border: 1px solid #000">
  ![More advanced work (2): Repositories](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildAdvanced_2.png){ loading=lazy }
</figure>

It is also possible to have your own clone of the `LUMI-EasyBuild-contrib` GitHub repository
in your `$EBU_USER_PREFIX` subdirectory if you want the latest and greatest before it is in
the centrally maintained clone of the repository. All you need to do is
```bash
cd $EBU_USER_PREFIX
git clone https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib.git
```
and then of course keep the repository up to date.

And it is even possible to maintain your own GitHub repository.
The only restrictions are that it should also be in `$EBU_USER_PREFIX` and that
the subdirectory should be called `UserRepo`, but that doesn't stop you from using
a different name for the repository on GitHub. After cloning your GitHub version you
can always change the name of the directory.
The structure should also be compatible with the structure that EasyBuild uses, so
easyconfig files go in `$EBU_USER_PREFIX/UserRepo/easybuild/easyconfigs`.


### More advanced work (3): Reproducibility

<figure markdown style="border: 1px solid #000">
  ![More advanced work (3): Reproducibility](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildAdvanced_3.png){ loading=lazy }
</figure>

EasyBuild also takes care of a **high level of reproducibility of installations**.

It will **keep a copy of all the downloaded sources** in the `$EBU_USER_PREFIX/sources`
subdirectory (unless the sources are already available elswhere where EasyBuild can find them,
e.g., in the system EasyBuild sources directory), 
and use that source file again rather than downloading it again. Of course
in some cases those "sources" could be downloaded tar files with binaries instead
as EasyBuild can install downloaded binaries or relocatable RPMs.
And if you know the structure of those directories, this is also a place where
you could manually put the downloaded installation files for licensed software.

Moreover, EasyBuild also keeps **copies of all installed easyconfig files in two locations**.

1.  There is a **copy in `$EBU_USER_PREFIX/ebfiles_repo`**. And in fact, EasyBuild will use this version
    first if you try to re-install and did not delete this version first. This is a policy
    we set on LUMI which has **both its advantages and disadvantages**. The **advantage** is that it ensures
    that the **information that EasyBuild has about the installed application is compatible with what is
    in the module files**. But the **disadvantage** of course is that if you install an EasyConfig file
    without being in the subdirectory that contains that file, **it is easily overlooked that it
    is installing based on the EasyConfig in the `ebfiles_repo` subdirectory** and not based on the
    version of the recipe that you likely changed and is in your user repository or one of the 
    other repositories that EasyBuild uses.
2.  The second copy is with the installed software in `$EBU_USER_PREFIX/SW` in a subdirectory
    called `easybuild`. This subdirectory is meant to have all information about how EasyBuild
    installed the application, also some other files that play a role in the installation process, and hence
    to help in reproducing an installation or checking what's in an existing installation. It is
    also the directory where you will find the extensive log file with all commands executed during
    the installation and their output.

### EasyBuild tips and tricks

<figure markdown style="border: 1px solid #000">
  ![EasyBuild tips and tricks](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildTipsTricks.png){ loading=lazy }
</figure>

Updating the version of a package often requires only trivial changes in the easyconfig file.
However, we do tend to use checksums for the sources so that we can detect if the available
sources have changed. This may point to files being tampered with, or other changes that might
need us to be a bit more careful when installing software and check a bit more again. 
Should the checksum sit in the way, you can always disable it by using 
`--ignore-checksums` with the `eb` command.

Updating an existing recipe to a new toolchain might be a bit more involving as you also have
to make build recipes for all dependencies. When a toolchain is updated on the system, 
the versions of all installed libraries are often also bumped to one of the latest versions to have
most bug fixes and security patches in the software stack, so you need to check for those
versions also to avoid installing yet another unneeded version of a library.

LUMI provides documentation on the available software that is either pre-installed or can be
user-installed with EasyBuild in the 
[LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/).
For most packages this documentation does also contain information about the license.
The user documentation for some packages gives more information about how to use the
package on LUMI, or sometimes also about things that do not work.
The documentation also shows all EasyBuild recipes, and for many packages there is 
also some technical documentation that is more geared towards users who want to
build or modify recipes. It sometimes also tells why things are done in a particular way.


### EasyBuild training for advanced users and developers

<figure markdown style="border: 1px solid #000">
  ![EasyBuild training](https://462000265.lumidata.eu/2day-next/img/LUMI-2day-next-105-SoftwareStacks/EasyBuildTraining.png){ loading=lazy }
</figure>

Pointers to all information about EasyBuild can be found on the EasyBuild web site 
[easybuild.io](https://easybuild.io/). This
page also includes links to training materials, both written and as recordings on YouTube, and the
EasyBuild documentation.

Generic EasyBuild training materials are available on 
[tutorial.easybuild.io](https:/tutorial.easybuild.io/).
The site also contains a LUST-specific tutorial oriented towards Cray systems.

There is also a later course developed by LUST for developers of EasyConfigs for LUMI
that can be found on 
[lumi-supercomputer.github.io/easybuild-tutorial](https://lumi-supercomputer.github.io/easybuild-tutorial/).

