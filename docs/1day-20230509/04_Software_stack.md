# Managing software on LUMI

In this section we discuss

-   Several of the ways in which we offer software on LUMI
-   Managing software in our primary software stack which is based on EasyBuild

## The software stacks on LUMI

### Design considerations

<figure markdown style="border: 1px solid #000">
  ![Software stack design considerations](img/LUMI-1day-20230509-04-software/Dia2.png){ loading=lazy }
</figure>

-   LUMI is a **very leading edge** and also an **inhomogeneous machine**. Leading edge often implies
    **teething problems** and inhomogeneous doesn't make life easier either.

    1.  It uses a **novel interconnect** which is an extension of Ethernet rather than being based on InfiniBand, 
        and that interconnect has a different software stack of your typical Mellanox InfiniBand cluster. 
    2.  It also uses a **relatively new GPU architecture**, AMD CDNA2, with an immature software ecosystem. 
        The GPU nodes are really **GPU-first**, with the **interconnect cards connected directly to the GPU packages** 
        and only one CPU socket, and another feature which is relatively new: the option to use a **coherent unified memory**
        space between the CPU and GPUs, though of course very NUMA. This is a feature that has previously
        only been seen in some clusters with NVIDIA P100 and V100 GPUs and IBM Power 8 and 9 CPUs used
        for some USA pre-exascale systems, and of course in Apple Silicon M-series but then without the NUMA character
        (except maybe for the Ultra version that consists of two dies).
    3.  LUMI is also **inhomogeneous** because some nodes have zen2 processors while the two main compute partitions
        have zen3-based CPUs, and the compute GPU nodes have AMD GPUs while the visualisation nodes have
        NVIDIA GPUs. 
        
    Given the novel interconnect and GPU we do expect that both system and application
    software will be immature at first and **evolve quickly**, hence we needed a setup that enables us
    to remain very agile, which leads to different compromises compared to a software stack for a more
    conventional and mature system as an x86 cluster with NVIDIA GPUs and Mellanox InfiniBand.

-   Users also come to LUMI from **11 different channels**, not counting subchannels as some countries have
    multiple organisations managing allocations, and those channels all have different expectations about
    what LUMI should be and what kind of users should be served. For our major stakeholder, the EuroHPC JU,
    LUMI is a pre-exascale system meant to prepare users and applications to make use of future even large
    systems, while some of the LUMI consortium countries see LUMI more as an extension of their tier-1 or
    even tier-2 machines.

-   The central support team of LUMI is also **relatively small compared to the nature of LUMI** with its
    many different partitions and storage services and the expected number of projects and users. 
    Support from users coming in via the national channels will rely a lot on efforts from **local organisations**
    also. **So we must set up a system so that they can support their users without breaking things on
    LUMI, and to work with restricted rights.** And in fact, LUMI User Support team members also have very limited additional
    rights on the machine compared to regular users or support people from the local organisations.
    LUST is currently 9 FTE. Compare this to 41 people in the Jülich Supercomputer Centre for software
    installation and support only... (I give this number because it was mentioned in a a talk in the
    EasyBuild user meeting in 2022.)

-   The Cray Programming Environment is also a **key part of LUMI** and the environment for which we get
    support from HPE Cray. It is however different from more traditional environments such as a typical
    Intel oneAPI installation of a typical installation build around the GNU Compiler Collection and Open MPI
    or MPICH. The programming environment is **installed with the operating system** rather than through the
    user application software stack hence not managed through the tools used for the application software
    stack, and it also works differently with its **universal compiler wrappers** that are typically configured
    through modules. 

-   We also see an increasing **need for customised setups**. Everybody wants a central stack as long as their
    software is in there but not much more as otherwise it is hard to find, and as long as software is 
    configured in the way they are used to. And everybody would like LUMI to look as much as possible 
    as their home system. But this is of course impossible. Moreover, there are more and more conflicts
    between software packages and modules are only a partial solution to this problem. The success of
    containers, conda and Python virtual environments is certainly to some extent explained by the 
    need for more customised setups and the need for multiple setups as it has become nearly impossible
    to combine everything in a single setup due to conflicts between packages and the dependencies they need.

### The LUMI solution

<figure markdown style="border: 1px solid #000">
  ![The LUMI solution](img/LUMI-1day-20230509-04-software/Dia3.png){ loading=lazy }
</figure>

We tried to take all these considerations into account and came up with a solution that may look **a
little unconventional** to many users.

In principle there should be a high degree of compatibility between releases of the HPE Cray Programming
Environment but we decided not to take the risk and **build our software for a specific release of the 
programming environment**, which is also a better fit with the typical tools used to manage a scientific 
software stack such as EasyBuild and Spack as they also prefer precise versions for all dependencies and
compilers etc. We also made the stack very easy to extend. So we have **many base libraries and some packages
already pre-installed** but also provide an **easy and very transparent way to install additional packages in
your project space in exactly the same way as we do for the central stack**, with the same performance but the
benefit that the installation can be customised more easily to the needs of your project. Not everybody needs
the same configuration of GROMACS or LAMMPS or other big packages, and in fact a one-configuration-that-works-for-everybody
may even be completely impossible due to conflicting options that cannot be used together.

For the **module system** we could chose between two systems supported by HPE Cray. They support 
Environment Modules with module files based on the TCL scripting language, but only the old version
that is no longer really developed and not the newer versions 4 and 5 developed in France, and Lmod,
a module system based on the LUA scripting language that also support many TCL module files through a
translation layer. **We chose to go with Lmod** as LUA is an easier and more modern language to work with
and as Lmod is much more powerful than Environment Modules 3, certainly for **searching modules**.

To manage the software installations we could chose between EasyBuild, which is mostly developed in
Europe and hence a good match with a EuroHPC project as EuroHPC wants to develop a European HPC technology stack
from hardware to application software, and Spack, a package developed in the USA national labs.
We chose to go with **EasyBuild as our primary tool** for which we also do some development. 
However, as we shall see, our EasyBuild installation is not your typical EasyBuild installation
that you may be accustomed with from clusters at your home institution. **It uses toolchains
specifically for the HPE Cray programming environment** so recipes need to be adapted. We do offer an
**growing library of Cray-specific installation recipes** though.
The whole setup of EasyBuild is done such that you can build on top of the central software stack
and such that **your modules appear in your module view** without having to add directories by hand
to environment variables etc. You only need to point to the place where you want to install software
for your project as we cannot automatically determine a suitable place. **We do offer some help so set up
Spack also but it is mostly offered "as is" an we will not do bug-fixing or development in Spack
package files.**


### Software policies

<figure markdown style="border: 1px solid #000">
  ![Policies](img/LUMI-1day-20230509-04-software/Dia4.png){ loading=lazy }
</figure>

As any site, we also have a number of policies about software installation, and we're still further
developing them as we gain experience in what we can do with the amount of people we have and what we
cannot do.

LUMI uses a **bring-your-on-license model except for a selection of tools that are useful to a larger
community**. 

-   This is partly caused by the **distributed user management** as we do not even have the necessary
    information to determine if a particular user can use a particular license, so we must shift that 
    responsibility to people who have that information, which is often the PI of your project.
-   You also have to take into account that **up to 20% of LUMI is reserved for industry** use which makes 
    negotiations with software vendors rather difficult as they will want to push us onto the industrial
    rather than academic pricing as they have no guarantee that we will obey to the academic license
    restrictions. 
-   And lastly, **we don't have an infinite budget**. There was a questionnaire send out to 
    some groups even before the support team was assembled and that contained a number of packages that
    by themselves would likely consume our whole software budget for a single package if I look at the 
    size of the company that produces the package and the potential size of their industrial market. 
    So we'd have to make choices and with any choice for a very specialised package you favour a few 
    groups. And there is also a political problem as without doubt the EuroHPC JU would prefer that we
    invest in packages that are developed by European companies or at least have large development
    teams in Europe.

The LUMI User Support Team **tries to help with installations of recent software** but **porting or bug
correction in software is not our task**. As a user, you have to realise that **not all Linux or even
supercomputer software will work on LUMI**. This holds even more for software that comes only as
a binary. The **biggest problems are the GPU and anything that uses distributed memory** and requires
high performance from the interconnect. For example,

-   software that use NVIDIA proprietary programming models and
    libraries needs to be ported. 
-   Binaries that do only contain NVIDIA code paths, even if the programming
    model is supported on AMD GPUs, will not run on LUMI. 
-   The LUMI interconnect requires **libfabric**
    using a specific provider for the NIC used on LUMI, the so-called Cassini provider, 
    so any software compiled with an MPI library that
    requires UCX, or any other distributed memory model build on top of UCX, will not work on LUMI, or at
    least not work efficiently as there might be a fallback path to TCP communications. 
-   Even intra-node interprocess communication can already cause problems as there are three different kernel extensions
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
    expect to find are not present on the compute nodes. D-bus comes to mind.

Also, the LUMI user support team is **too small to do all software installations** which is why we currently
state in our policy that a LUMI user should be capable of installing their software themselves or have
another support channel. We cannot install every single piece of often badly documented research-quality
code that was never meant to be used by people who don't understand the code.

Another soft compatibility problem that I did not yet mention is that software that **accesses tens
of thousands of small files and abuses the file system as a database** rather than using structured
data formats designed to organise data on supercomputers is not welcome on LUMI. For that reason we
also require to **containerize conda and Python installations**. We do offer a container-based wrapper
that offers a way to install conda packages or to install Python packages with pip on top of 
the Python provided by the `cray-python` module. On LUMI the tool is called
[lumi-container-wrapper](https://docs.lumi-supercomputer.eu/software/installing/container_wrapper/)
but it may by some from CSC also be known as Tykky.

### Organisation of the software in software stacks

<figure markdown style="border: 1px solid #000">
  ![Organisation"Software Stacks](img/LUMI-1day-20230509-04-software/Dia5.png){ loading=lazy }
</figure>

On LUMI we have several software stacks.

**CrayEnv** is the software stack for users who only need the **Cray Programming Environment** but want a **more
recent set of build tools etc** than the OS provides. We also take care of a few issues that we will discuss
on the next slide that are present right after login on LUMI.

Next we have the **stacks called "LUMI"**. Each one corresponds to a **particular release of the HPE Cray
Programming Environment**. It is the stack in which we install software using that programming environment
and mostly EasyBuild. **The Cray Programming Environment modules are still used, but they are accessed through
a replacement for the PrgEnv modules that is managed by EasyBuild**. We have **tuned versions for the 3 types
of hardware in the regular LUMI system**: zen2 CPUs in the login nodes and large memory nodes, zen3 for the 
LUMI-C compute nodes and zen3 + MI250X for
the LUMI-G partition. We were also planning to have a fourth version for the visualisation nodes with 
zen2 CPUs combined with NVIDIA GPUs, but that may never materialise and we may manage those differently.

In the distant future we will also look at **a stack based on the common EasyBuild toolchains as-is**, but we do expect
problems with MPI that will make this difficult to implement, and the common toolchains also do not yet support
the AMD GPU ecosystem, so we make no promises whatsoever about a time frame for this development.


### 3 ways to access the Cray Programming environment on LUMI.

#### Bare environment and CrayEnv

<figure markdown style="border: 1px solid #000">
  ![Accessing the Cray PE on LUMI slide 1](img/LUMI-1day-20230509-04-software/Dia6.png){ loading=lazy }
</figure>

Right after login you have a **very bare environment available with the Cray Programming Environment
with the PrgEnv-cray module loaded**. It gives you basically **what you can expect on a typical Cray system**.
There aren't many tools available, basically **mostly only the tools in the base OS image and some tools that
we are sure will not impact software installed in one of the software stacks**.
The set of target modules loaded is the one for the login nodes and not tuned to any particular node type.
**As a user you're fully responsible for managing the target modules**, reloading them when needed or loading the
appropriate set for the hardware you're using or want to cross-compile for.

The **second way** to access the Cray Programming Environment is through the **CrayEnv software stack**. This stack
offers an **"enriched" version of the Cray environment**. It **takes care of the target modules**: Loading or reloading
CrayEnv will reload an optimal set of target modules for the node you're on. It also provides **some additional 
tools** like newer build tools than provided with the OS. They are offered here and not in the bare environment to be
sure that those tools don't create conflicts with software in other stacks. But otherwise the Cray Programming 
Environment **works exactly as you'd expect from this course**.

#### LUMI stack

<figure markdown style="border: 1px solid #000">
  ![Accessing the Cray PE on LUMI slide 2](img/LUMI-1day-20230509-04-software/Dia7.png){ loading=lazy }
</figure>

The **third way** to access the Cray Programming Environment is through the **LUMI software stacks**, where each stack
is **based on a particular release of the HPE Cray Programming Environment**. We advise against mixing with modules
that came with other versions of the Cray PE, but they **remain accessible** although they are hidden from the default
view for regular users. It ia also better to **not use the PrgEnv modules, but the equivalent LUMI EasyBuild 
toolchains** instead as indicated by the following table:

| HPE Cray PE   | LUMI toolchain | What?                                           |
|:--------------|:---------------|:------------------------------------------------|
| `PrgEnv-cray` | `cpeCray`      | Cray Compiler Environment                       |
| `PrgEnv-gnu`  | `cpeGNU`       | GNU C/C++ and Fortran                           |
| `PrgEnv-aocc` | `cpeAOCC`      | AMD CPU compilers (login nodes and LUMI-C only) |
| `PrgEnv-amd`  | `cpeAMD`       | AMD ROCm GPU compilers (LUMI-G only)            |

The cpeCray etc modules also load the MPI libraries and Cray LibSci just as the PrgEnv modules do.
And we sometimes use this to work around problems in Cray-provided modules that we cannot change. 

This is also the environment in which we install most software, and from the name of the modules you can see which
compilers we used.

#### LUMI stack module organisation

<figure markdown style="border: 1px solid #000">
  ![Accessing the Cray PE on LUMI slide 3](img/LUMI-1day-20230509-04-software/Dia8.png){ loading=lazy }
</figure>

To manage the heterogeneity in the hardware, the LUMI software stack uses **two levels of modules**

First there are the **LUMI/22.08, LUMI/22.12 and LUMI/23.03 modules**. Each of the LUMI modules loads a particular
version of the LUMI stack.

The **second level consists of partition modules**. There is partition/L for the login and large memory nodes,
partition/C for the regular compute nodes, partition/EAP for the early access platform and in the future
we will have partition/D for the visualisation nodes and partition/G for the AMD GPU nodes.

There is also a **hidden partition/common module** in which we install software that is available everywhere, 
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


## EasyBuild to extend the LUMI software stack

### Installing software on HPC systems

<figure markdown style="border: 1px solid #000">
  ![Installing software on HPC systems](img/LUMI-1day-20230509-04-software/Dia9.png){ loading=lazy }
</figure>

Software on HPC systems is **rarely installed from RPMs** for various reasons.
Generic RPMs are **rarely optimised for the specific CPU** of the system as they have to work on a range
of systems and including optimised code paths in a single executable for multiple architectures is
hard to even impossible. 
Secondly generic RPMs **might not even work with the specific LUMI environment**. They may not fully
support the SlingShot interconnect and hence run at reduced speed, or they may need particular
kernel modules or daemons that are not present on the system or they may not work well with
the resource manager on the system. We expect this to happen especially with packages that 
require specific MPI versions.
Moreover, LUMI is a **multi-user system** so there is usually **no "one version fits all"**.
And we need a **small system image as nodes are diskless** which means that RPMs need to be
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
  ![Extending the LUMI stack with EasyBuild](img/LUMI-1day-20230509-04-software/Dia10.png){ loading=lazy }
</figure>

On LUMI EasyBuild is our primary software installation tool. We selected this as there is
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

Note however that the **build-in easyconfig files that come with EasyBuild do not work on LUMI** at
the moment.

-   For the GNU toolchain we would have problems with MPI. EasyBuild there uses Open MPI and that
    needs to be configured differently to work well on LUMI, and there are also still issues with
    getting it to collaborate with the resource manager as it is installed on LUMI.
-   The Intel-based toolchains have their problems also. At the moment, the Intel compilers with the
    AMD CPUs are a problematic cocktail. There have recently been performance and correctness problems 
    with the MKL math library and also failures with some versions of Intel MPI, 
    and you need to be careful selecting compiler options and not use `-xHost`
    or the Intel compiler will simply optimize for a two decades old CPU.

Instead we make our **own EasyBuild build recipes** that we also make available in the 
[LUMI-EasyBuild-contrib GitHub repository](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib).
The EasyBuild configuration done by the EasyBuild-user module will find a copy of that repository
on the system or in your own install directory. The latter is useful if you always want the very
latest, before we deploy it on the system. 

We also have the
[LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
which documents all software for which we have EasyBuild recipes available. 
This includes both the pre-installed software and the software for which we provide recipes in the
[LUMI-EasyBuild-contrib GitHub repository](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib),
and even instructions for some software that is not suitable for installation through EasyBuild or
Spack, e.g., because it likes to write in its own directories while running.


### EasyBuild recipes - easyconfigs

<figure markdown style="border: 1px solid #000">
  ![EasyBuild recipes - easyconfigs](img/LUMI-1day-20230509-04-software/Dia11.png){ loading=lazy }
</figure>

EasyBuild uses a build recipe for each individual package, or better said, each individual module
as it is possible to install more than one software package in the same module. That installation
description relies on either a generic or a specific installation process provided by an easyblock.
The build recipes are called easyconfig files or simply easyconfigs and are Python files with 
the extension `.eb`. 

The typical steps in an installation process are:

1.  Downloading sources and patches. For licensed software you may have to provide the sources as
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
  ![The toolchain concept](img/LUMI-1day-20230509-04-software/Dia12.png){ loading=lazy }
</figure>

EasyBuild uses the toolchain concept. A toolchain consists of compilers, an MPI implementation
and some basic mathematics libraries. The latter two are optional in a toolchain. All these 
components have a level of exchangeability as there are language standards, as MPI is standardised,
and the math libraries that are typically included are those that provide a standard API for which
several implementations exist. All these components also have in common that it is risky to combine 
pieces of code compiled with different sets of such libraries and compilers because there can
be conflicts in names in the libraries.

On LUMI we don't use the standard EasyBuild toolchains but our own toolchains specifically for Cray
and these are precisely the `cpeCray`, `cpeGNU`, `cpeAOCC` and `cpeAMD` modules already mentioned 
before.

| HPE Cray PE   | LUMI toolchain | What?                                           |
|:--------------|:---------------|:------------------------------------------------|
| `PrgEnv-cray` | `cpeCray`      | Cray Compiler Environment                       |
| `PrgEnv-gnu`  | `cpeGNU`       | GNU C/C++ and Fortran                           |
| `PrgEnv-aocc` | `cpeAOCC`      | AMD CPU compilers (login nodes and LUMI-C only) |
| `PrgEnv-amd`  | `cpeAMD`       | AMD ROCm GPU compilers (LUMI-G only)            |


<figure markdown style="border: 1px solid #000">
  ![The toolchain concept 2](img/LUMI-1day-20230509-04-software/Dia13.png){ loading=lazy }
</figure>

There is also a special toolchain called the SYSTEM toolchain that uses the compiler
provided by the operating system. This toolchain does not fully function in the same way as the other
toolchains when it comes to handling dependencies of a package and is therefore a bit harder to use.
The EasyBuild designers had in mind that this compiler would only be used to bootstrap an
EasyBuild-managed software stack, but we do use it for a bit more on LUMI as it offers us a
relatively easy way to compile some packages also for the CrayEnv stack and do this in a way
that they interact as little as possible with other software.

It is not possible to load packages from different cpe toolchains at the same time.
This is an EasyBuild restriction, because mixing libraries compiled with different compilers
does not always work. This could happen, e.g., if a package compiled with the Cray Compiling
Environment and one compiled with the GNU compiler collection would both use a particular 
library, as these would have the same name and hence the last loaded one would be used
by both executables (we don't use rpath or runpath linking in EasyBuild for those familiar
with that technique).

However, as we did not implement a hierarchy in the Lmod implementation of our software stack
at the toolchain level, the module system will not protect you from these mistakes. 
When we set up the software stack, most people in the support team considered it too misleading
and difficult to ask users to first select the toolchain they want to use and then see the 
software for that toolchain.

It is however possible to combine packages compiled with one CPE-based toolchain with packages
compiled with teh system toolchain, but we do avoid mixing those when linking as that may cause
problems. The reason is that we try to use as much as possible static linking in the SYSTEM
toolchain so that these packages are as independent as possible.

And with some tricks it might also be possible to combine packages from the LUMI software stack
with packages compiled with Spack, but one should make sure that no Spack packages are available
when building as mixing libraries could cause problems. Spack uses rpath linking which is why
this may work.


### EasyConfig names and module names

<figure markdown style="border: 1px solid #000">
  ![easyconfig names and module names](img/LUMI-1day-20230509-04-software/Dia14.png){ loading=lazy }
</figure>

There is a convention for the naming of an EasyConfig as shown on the slide. This is not
mandatory, but EasyBuild will fail to automatically locate easyconfigs for dependencies 
of a package that are not yet installed if the easyconfigs don't follow the naming
convention. Each part of the name also corresponds to a parameter in the easyconfig 
file.

Consider, e.g., the easyconfig file `GROMACS-2021.4-cpeCray-22.08-PLUMED-2.8.0-CPU.eb`.

1.  The first part of the name, `GROMACS`, is the name of the package, specified by the
    `name` parameter in the easyconfig, and is after installation also the name of the
    module.
2.  The second part, `2021.4`, is the version of GROMACS and specified by the
    `version` parameter in the easyconfig.
3.  The next part, `cpeCray-22.08` is the name and version of the toolchain,
    specified by the `toolchain` parameter in the easyconfig. The version of the
    toolchain must always correspond to the version of the LUMI stack. So this is
    an easyconfig for installation in `LUMI/22.08`.

    This part is not present for the SYSTEM toolchain

4.  The final part, `-PLUMED-2.8.0-CPU`, is the version suffix and used to provide
    additional information and distinguish different builds with different options
    of the same package. It is specified in the `versionsuffix` parameter of the
    easyconfig.

    This part is optional.

The version, toolchain + toolchain version and versionsuffix together also combine
to the version of the module that will be generated during the installation process.
Hence this easyconfig file will generate the module 
`GROMACS/2021.4-cpeCray-22.08-PLUMED-2.8.0-CPE`.



### Installing

#### Step 1: Where to install

<figure markdown style="border: 1px solid #000">
  ![Installing: Where to install](img/LUMI-1day-20230509-04-software/Dia15.png){ loading=lazy }
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
on a scientific problem. You'll need to point LUMI to the right location though and that has to
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
  ![Installing: Configure the environment](img/LUMI-1day-20230509-04-software/Dia16.png){ loading=lazy }
</figure>

The next step is to configure your environment. First load the proper version of the LUMI
stack for which you want to install software, and you may want to change to the proper
partition also if you are cross-compiling.

Once you have selected the software stack and partition, all you need to do to activate EasyBuild to install
additional software is to load
the `LUMI` module, load a partition module if you want a different one from the default, and 
then load the `EasyBuild-user` module. In fact, if you switch to a different `partition` 
or `LUMI` module after loading `EasyBuild-user` EasyBuild will still be correctly reconfigured 
for the new stack and new partition. 

Cross-compilation which is installing software for a different partition than the one you're
working on does not always work since there is so much software around with installation scripts
that don't follow good practices, but when it works it is easy to do on LUMI by simply loading
a different partition module than the one that is auto-loaded by the `LUMI` module.

**Note that the `EasyBuild-user` module is only needed for the installation process. For using
the software that is installed that way it is sufficient to ensure that `EBU_USER_PREFIX` has
the proper value before loading the `LUMI` module.**


#### Step 3: Install the software.

<figure markdown style="border: 1px solid #000">
  ![Installing: Install the software](img/LUMI-1day-20230509-04-software/Dia18.png){ loading=lazy }
</figure>

Let's look at GROMACS as an example. I will not try to do this completely live though as the 
installation takes 15 or 20 minutes.
First we need to figure out for which versions of GROMACS we already have support.
At the moment we have to use `eb -S` or `eb --search` for that. So in our example this is
``` bash
eb --search GROMACS
```
We now also have the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
which lists all software that we manage via EasyBuild and make available either pre-installed on
the system or as an EasyBuild recipe for user installation.

Now let's take the variant `GROMACS-2021.4-cpeCray-22.08-PLUMED-2.8.0-CPU.eb`. 
This is GROMACS 2021.4 with the PLUMED 2.8.0 plugin, build with the Cray compilers
from `LUMI/22.08`, and a build meant for CPU-only systems. The `-CPU` extension is not
always added for CPU-only system, but in case of GROMACS there already is a GPU version
for AMD GPUs in active development so even before LUMI-G was active we chose to ensure
that we could distinguish between GPU and CPU-only versions.
To install it, we first run 
```bash
eb –r GROMACS-2021.4-cpeCray-22.08-PLUMED-2.8.0-CPU.eb –D
```
The `-D` flag tells EasyBuild to just perform a check for the dependencies that are needed
when installing this package, while the `-r` argument is needed to tell EasyBuild to also 
look for dependencies in a preset search path. The installation of dependencies is not automatic
since there are scenarios where this is not desired and it cannot be turned off as easily as
it can be turned on.

Looking at the output we see that EasyBuild will also need to install `PLUMED` for us.
But it will do so automatically when we run
```bash
eb –r GROMACS-2021.4-cpeCray-22.08-PLUMED-2.8.0-CPU.eb
```

This takes too long to wait for, but once it finished the software should be available
and you should be able to see the module in the output of
```bash
module avail
```


#### Step 3: Install the software - Note

<figure markdown style="border: 1px solid #000">
  ![Installing: Install the software](img/LUMI-1day-20230509-04-software/Dia29.png){ loading=lazy }
</figure>

There is a little problem though that you may run into. Sometimes the module does not
show up immediately. This is because Lmod keeps a cache when it feels that Lmod searches
become too slow and often fails to detect that the cache is outdated.
The easy solution is then to simply remove the cache which is in `$HOME/.lmod.d/.cache`, 
which you can do with 
```bash
rm -rf $HOME/.lmod.d/.cache
```
And we have seen some very rare cases where even that did not help likely because some
internal data structures in Lmod where corrupt. The easiest way to solve this is to simply
log out and log in again and rebuild your environment.

Installing software this way is **100% equivalent to an installation in the central software
tree**. The application is compiled in exactly the same way as we would do and served from the
same file systems. But it helps **keep the output of `module avail` reasonably short** and **focused
on your projects**, and it **puts you in control of installing updates**. For instance, we may find out
that something in a module does not work for some users and that it needs to be re-installed. 
Do this in the central stack and either you have to chose a different name or risk breaking running
jobs as the software would become unavailable during the re-installation and also jobs may get
confused if they all of a sudden find different binaries. However, have this in your own stack
extension and you can update whenever it suits your project best or even not update at all if 
you figure out that the problem we discovered has no influence on your work.


### More advanced work

<figure markdown style="border: 1px solid #000">
  ![More advanced work](img/LUMI-1day-20230509-04-software/Dia30.png){ loading=lazy }
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
for instance, for VASP. We'd likely be in violation of the license if we would put the download somewhere
where EasyBuild can find it, and it is also a way for us to ensure that you have a license for VASP.
For instance, 
```bash
eb --search VASP
```
will tell you for which versions of VASP we already have build instructions, but you will still have
to download the file that the EasyBuild recipe expects. Put it somewhere in a directory, and then from that
directory run EasyBuild, for instance for VASP 6.3.0 with the GNU compilers:
```bash
eb VASP-6.3.0-cpeGNU-22.08.eb –r . 
```

### More advanced work (2): Repositories

<figure markdown style="border: 1px solid #000">
  ![More advanced work (2): Repositories](img/LUMI-1day-20230509-04-software/Dia31.png){ loading=lazy }
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
easyconfig files go in `$EBU_USER_PREFIX/easybuild/easyconfigs`.


### More advanced work (3): Reproducibility

<figure markdown style="border: 1px solid #000">
  ![More advanced work (3): Reproducibility](img/LUMI-1day-20230509-04-software/Dia32.png){ loading=lazy }
</figure>

EasyBuild also takes care of a **high level of reproducibility of installations**.

It will **keep a copy of all the downloaded sources** in the `$EBU_USER_PREFIX/sources`
subdirectory, and use that source file again rather than downloading it again. Of course
in some cases those "sources" could be downloaded tar files with binaries instead
as EasyBuild can install downloaded binaries or relocatable RPMs.
And if you know the structure of those directories, this is also a place where
you could manually put the downloaded installation files for licensed software.

Moreover, EasyBuild also keeps **copies of all installed easyconfig files in two locations**.

1.  There is a **copy in `$EBU_USER_PREFIX/ebrepo_files`**. And in fact, EasyBuild will use this version
    first if you try to re-install and did not delete this version first. This is a policy
    we set on LUMI which has **both its advantages and disadvantages**. The **advantage** is that it ensures
    that the **information that EasyBuild has about the installed application is compatible with what is
    in the module files**. But the **disadvantage** of course is that if you install an EasyConfig file
    without being in the subdirectory that contains that file, **it is easily overlooked that it
    is installing based on the EasyConfig in the `ebrepo_files` subdirectory** and not based on the
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
  ![EasyBuild tips and tricks](img/LUMI-1day-20230509-04-software/Dia33.png){ loading=lazy }
</figure>

Updating the version of a package often requires only trivial changes in the easyconfig file.
However, we do tend to use checksums for the sources so that we can detect if the available
sources have changed. This may point to files being tampered with, or other changes that might
need us to be a bit more careful when installing software and check a bit more again. 
Should the checksum sit in the way, you can always disable it by using 
`--ignore-checksums` with the `eb` command.

Updating an existing recipe to a new toolchain might be a bit more involving as you also have
to make build recipes for all dependencies. When we update a toolchain on the system, we
often bump the versions of all installed libraries to one of the latest versions to have
most bug fixes and security patches in the software stack, so you need to check for those
versions also to avoid installing yet another unneeded version of a library.

We provide documentation on the available software that is either pre-installed or can be
user-installed with EasyBuild in the 
[LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/).
For most packages this documentation does also contain information about the license.
The user documentation for some packages gives more information about how to use the
package on LUMI, or sometimes also about things that do not work.
The documentation also shows all EasyBuild recipes, and for many packages there is 
also some technical documentation that is more geared towards users who want to
build or modify recipes. It sometimes also tells why we did things in a particular way.


### EasyBuild training for advanced users and developers

<figure markdown style="border: 1px solid #000">
  ![EasyBuild training](img/LUMI-1day-20230509-04-software/Dia34.png){ loading=lazy }
</figure>

Pointers to all information about EasyBuild can be found on the EasyBuild web site 
[easybuild.io](https://easybuild.io/). This
page also includes links to training materials, both written and as recordings on YouTube, and the
EasyBuild documentation.

Generic EasyBuild training materials are available on 
[easybuilders.github.io/easybuild-tutorial](https:/easybuilders.github.io/easybuild-tutorial/).
The site also contains a LUST-specific tutorial oriented towards Cray systems.

There is also a later course developed by LUST for developers of EasyConfigs for LUMI
that can be found on 
[lumi-supercomputer.github.io/easybuild-tutorial](https://lumi-supercomputer.github.io/easybuild-tutorial/).

