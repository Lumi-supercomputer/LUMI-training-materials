# LUMI Software Stacks

<figure markdown style="border: 1px solid #000">
  ![What this talk is about](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/IntroWhatThisTalkIs.png){ loading=lazy }
</figure>

In this part of the training, we cover:

-   Software stacks on LUMI, where we discuss the organisation of the software stacks
    that we offer and some of the policies surrounding it
-   Advanced Lmod use to make the best out of the software stacks
-   Creating your customised environment with EasyBuild, the tool that we use to install
    most software.
-   Some remarks about using containers on LUMI.

## The software stacks on LUMI

### Design considerations

<figure markdown style="border: 1px solid #000">
  ![Design consideration](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/SoftwareStacksDesignConsiderations.png){ loading=lazy }
</figure>

-   LUMI is a **very leading edge** and also an **inhomogeneous machine**. Leading edge often implies
    **teething problems** and inhomogeneous doesn't make life easier either.

    1.  It uses a **novel interconnect** which is an extension of Ethernet rather than being based on InfiniBand, 
        and that interconnect has a different software stack than your typical Mellanox InfiniBand cluster. 
    2.  It also uses a **relatively new GPU architecture**, AMD CDNA2, with an immature software ecosystem. 
        The GPU nodes are really **GPU-first**, with the **interconnect cards connected directly to the GPU packages** 
        and only one CPU socket, and another feature which is relatively new: the option to use a **partly coherent fully unified memory**
        space between the CPU and GPUs, though of course very NUMA. This is a feature that has previously
        only been seen in some clusters with NVIDIA P100 and V100 GPUs and IBM Power 8 and 9 CPUs used
        for some USA pre-exascale systems, and is also rumoured to be in the Apple Silicon M-series 
        but then without the NUMA character (except maybe for the Ultra version that consists of two dies).
    3.  LUMI is also **inhomogeneous** because some nodes have zen2 processors while the two main compute partitions
        have zen3-based CPUs, and the compute GPU nodes have AMD compute GPUs while the visualisation nodes have
        NVIDIA rendering GPUs. 
        
    Given the novel interconnect and GPU we do expect that both system and application
    software will be immature at first and **evolve quickly**, hence we needed a setup that enables us
    to remain very agile, which leads to different compromises compared to a software stack for a more
    conventional and mature system as an x86 cluster with NVIDIA GPUs and Mellanox InfiniBand.

-   Users also come to LUMI from **12 different channels**, not counting subchannels as some countries have
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

-   We also see an increasing **need for customised environments**. 
    Everybody wants a central stack as long as their
    software is in there but not much more as otherwise it is hard to find, and as long as software is 
    configured in the way they are used to. And everybody would like LUMI to look as much as possible 
    as their home system. But this is of course impossible. Moreover, there are more and more conflicts
    between software packages and modules are only a partial solution to this problem. The success of
    containers, conda and Python virtual environments is certainly to some extent explained by the 
    need for more customised setups and the need for multiple setups as it has become nearly impossible
    to combine everything in a single setup due to conflicts between packages and the dependencies they need.


### The LUMI solution

<figure markdown style="border: 1px solid #000">
  ![The LUMI solution](https://462000265.lumidata.eu/1day-20230921/img/LUMI-1day-20230921-04-software/SoftwareStacksTheLUMISolution.png){ loading=lazy }
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
Both have their own strengths and weaknesses.
We chose to go with **EasyBuild as our primary tool** for which we also do some development. 
However, as we shall see, our EasyBuild installation is not your typical EasyBuild installation
that you may be accustomed with from clusters at your home institution. **It uses toolchains
specifically for the HPE Cray programming environment** so recipes need to be adapted. We do offer an
**growing library of Cray-specific installation recipes** though.
The whole setup of EasyBuild is done such that you can build on top of the central software stack
and such that **your modules appear in your module view** without having to add directories by hand
to environment variables etc. You only need to point to the place where you want to install software
for your project as we cannot automatically determine a suitable place. 

**We do offer some help to set up
Spack also but it is mostly offered "as is" and we will not do bug-fixing or development in Spack
package files.** Spack is very attractive for users who want to set up a personal environment with
fully customised versions of the software rather than the rather fixed versions provided by EasyBuild
for every version of the software stack. It is possible to specify versions for the main packages
that you need and then let Spack figure out a minimal compatible set of dependencies to install 
those packages.


### Software policies

<figure markdown style="border: 1px solid #000">
  ![Software policies](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/SoftwareStacksPolicies.png){ loading=lazy }
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
-   And lastly, **we don't have an infinite budget**. There was a questionnaire sent out to 
    some groups even before the support team was assembled and that contained a number of packages that
    by themselves would likely consume our whole software budget for a single package if I look at the 
    size of the company that produces the package and the potential size of their industrial market. 
    So we'd have to make choices and with any choice for a very specialised package you favour a few 
    groups. And there is also a political problem as without doubt the EuroHPC JU would prefer that we
    invest in packages that are developed by European companies or at least have large development
    teams in Europe.

!!! Note "Some restrictions coming from software licenses"

    -   Anaconda cannot be used legally on LUMI, neither can you use Miniconda to pull
        packages from the Anaconda Public Repository. You have to use alternatives such as
        [conda-forge](https://conda-forge.org/).

        See point 2.1 of the 
        ["Anaconda Terms of Service"](https://legal.anaconda.com/policies/en?name=terms-of-service#terms-of-service).

    -   The LUMI support team cannot really help much with VASP as most people in the support 
        team are not covered by a valid VASP license. VASP licenses typically even contain a list
        of people who are allowed to touch the source code, and one person per license who can
        download the source code.


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

Also, the LUMI user support team is **too small to do all software installations** which is why we currently
state in our policy that a LUMI user should be capable of installing their software themselves or have
another support channel. We cannot install every single piece of often badly documented research-quality
code that was never meant to be used by people who don't understand the code.

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
  ![Organisation: Software stacks](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/SoftwareStacksOrganisation.png){ loading=lazy }
</figure>

On LUMI we have several software stacks.

**CrayEnv** is the minimal software stack for users who only need the 
**Cray Programming Environment** but want a **more recent set of build tools etc** 
than the OS provides. We also take care of a few issues that we will discuss
on the next slide that are present right after login on LUMI.

Next we have the **stacks called "LUMI"**. Each one corresponds to a **particular release of the HPE Cray
Programming Environment**. It is the stack in which we install software using that programming environment
and mostly EasyBuild. **The Cray Programming Environment modules are still used, but they are accessed through
a replacement for the PrgEnv modules that is managed by EasyBuild**. We have **tuned versions for the 3 types
of hardware in the regular LUMI system**: zen2 CPUs in the login nodes and large memory nodes, zen3 for the 
LUMI-C compute nodes and zen3 + MI250X for
the LUMI-G partition. We were also planning to have a fourth version for the visualisation nodes with 
zen2 CPUs combined with NVIDIA GPUs, but that may never materialise and we may manage those differently.

We also have an extensible software stack based on **Spack** which has been pre-configured to use the compilers
from the Cray PE. This stack is offered as-is for users who know how to use Spack, but we don't offer much
support nor do we do any bugfixing in Spack.

Some partner organisations in the LUMI consortium also provide pre-installed software on LUMI.
This software is not manages by the LUMI User Support Team and as a consequence of this, support
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

In the far future we will also look at **a stack based on the common EasyBuild toolchains as-is**, but we do expect
problems with MPI that will make this difficult to implement, and the common toolchains also do not yet support
the AMD GPU ecosystem, so we make no promises whatsoever about a time frame for this development.


### 3 ways to access the Cray Programming environment on LUMI.

#### Bare environment and CrayEnv

<figure markdown style="border: 1px solid #000">
  ![Accessing the Cray PE: BAre and CrayEnv](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/SoftwareStacksAccessingCrayPE_1.png){ loading=lazy }
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
  ![Accessing the Cray PE: LUMI stack](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/SoftwareStacksAccessingCrayPE_2.png){ loading=lazy }
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
And we sometimes use this to work around problems in Cray-provided modules that we cannot change. 

This is also the environment in which we install most software, and from the name of the modules you can see which
compilers we used.


#### LUMI stack module organisation

<figure markdown style="border: 1px solid #000">
  ![The LUMI software stack](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/SoftwareStacksAccessingCrayPE_3.png){ loading=lazy }
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


## Lmod on LUMI


### Exploring modules with Lmod

<figure markdown style="border: 1px solid #000">
  ![Exploring modules with Lmod](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODExploringModulesLMOD.png){ loading=lazy }
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

    On LUMI, we had to restrict the search space of `module spider`. By default, `module spider`
    will only search in the Cray PE modules, the CrayEnv stack and the LUMI stacks. This is done 
    for performance reasons. However, as we shall discuss later, you can load a module or set an
    environment variable to enable searching all installed modules. The behaviour is also not
    fully consistent. Lmod uses a cache which it refreshes once every 24 hours, or after manually
    clearing the cache. If a rebuild happens while modules from another software stack are available,
    that stack will also be indexed and results for that stack shown in the results of 
    `module spider`. It is a price we had to pay though as due to the large number of modules
    and the many organisations managing modules, the user cache rebuild time became too long
    and system caches are hard to manage also.


### Module spider command

***Demo moment 1 (when infrastructure for a demo is available)***

<figure markdown style="border: 1px solid #000">
  ![module spider](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleSpiderOverview.png){ loading=lazy }
</figure>

(The content of this slide is really meant to be shown in practice on a command line.)

There are three ways to use `module spider`, discovering software in more and more detail.
All variants however will by default only check the Cray PE, the CrayEnv stack and the
LUMI stacks, unless another software stack is loaded through a module or `module use`
statement and the cache is regenerated during that period.

1.  `module spider` by itself will show a list of all installed software with a short description.
    Software is bundled by name of the module, and it shows the description taken from the default
    version. `module spider` will also look for "extensions" defined in a module and show those also
    and mark them with an "E". Extensions are a useful Lmod feature to make clear that a module offers
    features that one would not expect from its name. E.g., in a Python module the extensions could be
    a list of major Python packages installed in the module which would allow you to find `NumPy` if
    it were hidden in a module with a different name. This is also a very useful feature to make
    tools that are bundled in one module to reduce the module clutter findable.

2.  `module spider` with the name of a package will show all versions of that package installed on
    the system. This is also case-insensitive. It works both for packages and for the names
    of extensions. There is a subtlety though: If a match in the exact case is found, it will
    no longer look for extensions that may have the same name but in a different case.

3.  The third use of `module spider` is with the full name of a module. 
    In this case, we get the full information on how the module can be made available
    for loading if it is not yet available, and for packages also some help information
    about the package if the module includes this information. 
  
???+Demo "Demo module spider"

    Try the following commands:

    ```bash
    module spider
    module spider gnuplot
    module spider CMake
    module spider gnuplot/5.4.10-cpeGNU-24.03
    module spider CMake/3.29.3
    ```

    <figure markdown style="border: 1px solid #000">
      ![module spider demo slide 1](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleSpiderCommand_1.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module spider demo slide 2](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleSpiderCommand_2.png){ loading=lazy }
    </figure>

    In the above display, the `ARMForge` module is currently available in only one version.
    The `Autoconf` package is offered in two versions, but in both cases as an extension of another
    module as the blue `(E)` in the output shows. The `Blosc` package is available in many versions,
    but they are not all shown as the `...` suggests.

    After a few more screens, we get the last one:

    <figure markdown style="border: 1px solid #000">
      ![module spider demo slide 3](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleSpiderCommand_3.png){ loading=lazy }
    </figure>
    
    Let's now try for instance `module spider gnuplot`. 

    <figure markdown style="border: 1px solid #000">
      ![module spider demo slide 4](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleSpiderGnuplot_1.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module spider demo slide 5](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleSpiderGnuplot_2.png){ loading=lazy }
    </figure>

    This shows 18 versions of GNUplot. There are 4 installations of GNUplot 5.4.3, five of 5.4.6,
    6 of 5.4.8 and 
    and 4 of 5.4.10 at the moment the slide was made. The 
    remainder of the name shows us with what compilers gnuplot was compiled. The reason to have 
    versions for two or three compilers is that no two compiler modules can be loaded simultaneously,
    and this offers a solution to use multiple tools without having to rebuild your environment for
    every tool, and hence also to combine tools.

    Now try `module spider CMake`. 

    <figure markdown style="border: 1px solid #000">
      ![module spider demo slide 6](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleSpiderCMake_1.png){ loading=lazy }
    </figure>

    We see that there were four versions at the moment this slide was made,
    3.24.0, 3.25.2, 3.27.7 and 3.29.3, 
    that are shown in blue with an "E" behind the name. That is because these are not provided 
    by a module called
    `CMake` on LUMI, but by another module that in this case contains
    a collection of popular build tools and that we will discover shortly.
    
    <!-- You may also see a couple of regular modules called `cmake` that come from software installed
    differently.-->
    
    Noe try `module spider gnuplot/5.4.10-cpeGNU-24.03`. 

    <figure markdown style="border: 1px solid #000">
      ![module spider demo slide 7](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleSpiderGnuplotVersion_1.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module spider demo slide 8](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleSpiderGnuplotVersion_2.png){ loading=lazy }
    </figure>

    This now shows full help information for
    the specific module, including what should be done to make the module available. For 
    this GNUplot module we see that there are three ways to load the module: By loading `LUMI/24.03` 
    combined with `partition/C`, by loading `LUMI/23.03` combined with `partition/G`
    or by loading `LUMI/24.03` combined with `partition/L`. So use only
    a single line, but chose it in function of the other modules that you will also need. In this case
    it means that that version of GNUplot is available in the `LUMI/24.03` stack which we could already
    have guessed from its name, with binaries for the login and large memory nodes and the LUMI-C compute
    partition. This does however not always work with the Cray Programming Environment modules.

    Finally, try `module spider CMake/3.29.3` (remember this was an extension of a module):

    <figure markdown style="border: 1px solid #000">
      ![module spider demo slide 9](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleSpiderCMakeVersion_1.png){ loading=lazy }
    </figure>

    This now shows us that this tool is in the `buildtools/24.03`
    module (among others) and gives us 4 different options to load that module as it is provided in the `CrayEnv`
    and the `LUMI/24.03` software stacks and for all partitions (basically because we don't do
    processor-specific optimisations for these tools).


### Module keyword command

<figure markdown style="border: 1px solid #000">
  ![module keyword command](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleKeyword.png){ loading=lazy }
</figure>

Lmod has a second way of searching for modules: `module keyword`. It searches 
in some of the information included in module files for the
given keyword, and shows in which modules the keyword was found.

We do an effort to put enough information in the modules to make this a suitable additional way
to discover software that is installed on the system.

???+Demo "Demo module keyword"

    Try the following command:

    ```bash
    module keyword https
    ```

    <figure markdown style="border: 1px solid #000">
      ![module keyword demo slide 1](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleKeywordHTTPS_1.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module keyword demo slide 2](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleKeywordHTTPS_2.png){ loading=lazy }
    </figure>

    `cURL` and `wget` are indeed 
    two tools that can be used to fetch files from the internet.


### Sticky modules and module purge

<figure markdown style="border: 1px solid #000">
  ![Sticky modules and module purge](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODStickyModules.png){ loading=lazy }
</figure>

On some systems you will be taught to avoid `module purge` as many HPC systems do their default user
configuration also through modules. This advice is often given on Cray systems as it is a common
practice to preload a suitable set of target modules and a programming environment.
On LUMI both are used. A default programming environment and set of target modules suitable for the
login nodes is preloaded when you log in to the system, and next the `init-lumi` module is loaded
which in turn makes the LUMI software stacks available that we will discuss in the next session.

Lmod however has a trick that helps to avoid removing necessary modules and it is called sticky modules.
When issuing the `module purge` command these modules are automatically reloaded. It is very important to
realise that those modules will not just be kept "as is" but are in fact unloaded and loaded again as
we shall see later that this may have consequences. It is still possible to force unload all these modules
using `module --force purge` or selectively unload those using `module --force unload`.

The sticky property is something that is defined in the module file and not used by the module files
ot the HPE Cray Programming Environment, but we shall see that there is a partial workaround for this in
some of the LUMI software stacks. The `init-lumi` module mentioned above though is a sticky module, as are
the modules that activate a software stack so that you don't have to start from scratch if you have already
chosen a software stack but want to clean up your environment.


???+Demo "Demo"

    Try the following command immediately after login:

    ```bash
    module av
    ```

    <figure markdown style="border: 1px solid #000">
      ![module av slide 1](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_1.png){ loading=lazy }
    </figure>

    Note the very descriptive titles in the above screenshot.

    The letter "D" next to a name denotes that this is the default version,
    the letter "L" denotes that the module is loaded, but we'll come back to 
    that later also. The letter "S" denotes a sticky module.

    Note also the two categories for the PE modules. The target modules get their own block
    which will be shown further down in the output.

    <figure markdown style="border: 1px solid #000">
      ![module av slide 2](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_2.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module av slide 3](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_3.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module av slide 4](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_4.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module av slide 5](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_5.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module av slide 6](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_6.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module av slide 7](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_7.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module av slide 8](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_8.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module av slide 9](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_9.png){ loading=lazy }
    </figure>

    The screen above also shows `(5.0.2:5.1.0:5.2.0:5.2.3:5.5.1:5.7.0:6.0.0)` 
    next to the `rocm` module. This shows that the `rocm/6.0.3` module can also 
    be loaded as `rocm/5.0.2` or any of the other versions in that list.
    Some of them were old versions that have been removed from the system in later updates,
    and we now load the newer version as often binaries of programs will still run that way.
    Others are versions that are hard-coded some of the Cray PE modules and other
    files, but have never been on the system as we had an already patched version.
    (E.g., the 24.03 version of the Cray PE will sometimes try to load `rocm/6.0.0` 
    while we have immediate had `rocm/6.0.3` on the system which corrects some bugs).

    The `D` next to modules that have multiple versions, denotes which version is 
    currently the default. It is the version that will be loaded if you don't specify a 
    module version. The default version may differ depending on which other modules 
    are loaded already.

    <figure markdown style="border: 1px solid #000">
      ![module av slide 10](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_10.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![module av slide 11](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_11.png){ loading=lazy }
    </figure>

    On the screen we also see the list of target modules.
    This screenshot was taken at login in the login environment, when those modules that are
    irrelevant to LUMI or to the chosen variant of the LUMI software stack are not yet hidden.

    The above screen also shows the modules for the software stack that we have discussed earlier in this text.

    <figure markdown style="border: 1px solid #000">
      ![module av slide 12](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_12.png){ loading=lazy }
    </figure>

    And the screen above shows some extensions of modules (but the list is short at this point as
    most modules containing extensions only become available after loading one of the software
    stacks).

    <figure markdown style="border: 1px solid #000">
      ![module av slide 13](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODModuleAvail_13.png){ loading=lazy }
    </figure>

    At the end of the output we also get some information about the meaning of the 
    letters used in the display.

    Try the following commands and carefully observe the output:

    ```bash
    module load LUMI/24.03 buildtools
    module list
    module purge
    module list
    module --force unload ModuleLabel/label
    module list
    module av
    ```

The sticky property has to be declared in the module file so we cannot add it to for instance the
Cray Programming Environment target modules, but we can and do use it in some modules that we control
ourselves. **We use it on LUMI for the software stacks themselves and for the modules that set the
display style of the modules**. 

-   In the `CrayEnv` environment, `module purge` will clear the target
    modules also but as `CrayEnv` is not just left untouched but reloaded instead, the load of `CrayEnv`
    will load a suitable set of target modules for the node you're on again. But any customisations that
    you did for cross-compiling will be lost. 
-   Similarly in the LUMI stacks, as the `LUMI` module itself
    is reloaded, it will also reload a partition module. However, that partition module might not be the 
    one that you had loaded but it will be the one that the LUMI module deems the best for the node you're
    on, and you may see some confusing messages that look like an error message but are not.


### Changing how the module list is displayed

<figure markdown style="border: 1px solid #000">
  ![Changing how the module list is displayed](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/LMODChangingModuleListDisplay.png){ loading=lazy }
</figure>

You may have noticed already that by default you **don't see the directories in which the module
files reside** as is the case on many other clusters. Instead we try to show **labels that tell you
what that group of modules actually is**. And sometimes this also combines modules from multiple
directories that have the same purpose. For instance, in the default view we collapse all modules
from the Cray Programming Environment in two categories, the target modules and other programming
environment modules. But you can **customise this by loading one of the `ModuleLabel` modules**.
One version, the `label` version, is the default view. But we also have `PEhierarchy` which 
still provides descriptive texts but unfolds the whole hierarchy in the Cray Programming 
Environment. And the third style is called `system` which shows you again the module directories.

???+Demo "Demo"

    Try the following commands:

    ```bash
    module list
    module avail
    module load ModuleLabel/PEhiererachy
    module avail
    module load ModuleLabel/system
    module avail
    module load ModuleLabel/label
    ```

We're also very much aware that the default colour view is not good for everybody. So far we are not 
aware of an easy way to provide various colour schemes as one that is OK for people who like a black 
background on their monitor might not be OK for people who prefer a white background. But it is possible
to turn colour off alltogether by loading the `ModuleColour/off` module, and you can always turn it
on again with `ModuleColour/on`.

???+Demo "Demo"

    Try the following commands:

    ```bash
    module avail
    module load ModuleColour/off
    module avail
    module list
    module load ModuleColour/on
    ```

As the module extensions list in the output of `module avail` could potentially become very long
over time (certainly if there would be Python or R modules installed with EasyBuild that show
all included Python or R packages in that list) you may want to hide those. You can do this by
loading the `ModuleExtensions/hide` module and undo this again by loading
`ModuleExtensions/show`.

???+Demo "Demo"

    Try the following commands:

    ```bash
    module avail
    module load ModuleExtensions/hide
    module avail
    module load ModuleExtensions/show
    module avail
    ```

There are two ways to tell `module spider` to search in all installed modules. One is more meant as a 
temporary solution: Load

```bash
module load ModuleFullSpider/on
```

and this is turned off again by force-unloading this module or loading

```bash
module load ModuleFullSpider/off
```

The second and permanent way is to set add the line

```bash
export LUMI_FULL_SPIDER=1
```

to your `.profile` file and from then on, `module spider` will index all modules on the system.
Note that this can have a large impact on the performance of the `module spider` and
`module avail` commands that can easily "hang" for a minute or more if a cache rebuild is
needed, which is the case after installing software with EasyBuild or once every 24 hours.

We also **hide some modules from regular users** because we think they are not useful at all for regular
users or not useful in the context you're in at the moment. For instance, when working in the `LUMI/24.03`
stack we prefer that users use the Cray programming environment modules that come with release 24.03 of that
environment, and cannot guarantee compatibility of other modules with already installed software, so
we hide the other ones from view.
You can still load them if you know they exist but 
you cannot see them with `module available`. It is possible though to still show most if not all of 
them by loading `ModulePowerUser/LUMI`. Use this at your own risk however, we will not help you to make
things work or to use any module that was designed for us to maintain the system.

Another way to show hidden modules also, is to use the `--show_hidden` flag of the module command
with the `avail` subcommand: `module --show_hidden avail`. 

With `ModulePowerUser`, all modules will be displayed as if they are regular modules, while
`module --show_hidden avail` will still grey the hidden modules and add an `(H)` to them
so that they are easily recognised.

???+Demo "Demo"

    Try the following commands:

    ```bash
    module load LUMI/24.03
    module avail
    module --show_hidden avail
    module load ModulePowerUser
    module avail
    ```

    Note that we see a lot more Cray PE modules with `ModulePowerUser`!


## EasyBuild to extend the LUMI software stack

### Installing software on HPC systems

<figure markdown style="border: 1px solid #000">
  ![Installing software on HPC systems](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildInstallingSoftwareHPC.png){ loading=lazy }
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
  ![Extending the LUMI stack with EasyBuild](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildExtendingLUMIStack.png){ loading=lazy }
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
  ![EasyBuild recipes - easyconfigs](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildEasyConfig.png){ loading=lazy }
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
  ![The toolchain concept](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildToolchain_1.png){ loading=lazy }
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
| `PrgEnv-cray` | `cpeCray`      | Cray Compiling Environment                      |
| `PrgEnv-gnu`  | `cpeGNU`       | GNU C/C++ and Fortran                           |
| `PrgEnv-aocc` | `cpeAOCC`      | AMD CPU compilers (login nodes and LUMI-C only) |
| `PrgEnv-amd`  | `cpeAMD`       | AMD ROCm GPU compilers (LUMI-G only)            |


<figure markdown style="border: 1px solid #000">
  ![The toolchain concept 2](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildToolchain_2.png){ loading=lazy }
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
  ![easyconfig names and module names](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyConfigModuleNames.png){ loading=lazy }
</figure>

There is a convention for the naming of an EasyConfig as shown on the slide. This is not
mandatory, but EasyBuild will fail to automatically locate easyconfigs for dependencies 
of a package that are not yet installed if the easyconfigs don't follow the naming
convention. Each part of the name also corresponds to a parameter in the easyconfig 
file.

Consider, e.g., the easyconfig file `GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb`.

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

4.  The final part, `-PLUMED-2.9.2-noPython-CPU`, is the version suffix and used to provide
    additional information and distinguish different builds with different options
    of the same package. It is specified in the `versionsuffix` parameter of the
    easyconfig.

    This part is optional.

The version, toolchain + toolchain version and versionsuffix together also combine
to the version of the module that will be generated during the installation process.
Hence this easyconfig file will generate the module 
`GROMACS/2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU`.


### Installing software

#### Step 1: Where to install

<figure markdown style="border: 1px solid #000">
  ![Step 1: Where to install](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildInstallingStep1.png){ loading=lazy }
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
  ![Step 2: Configure the environment](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildInstallingStep2_1.png){ loading=lazy }
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
a different partition module than the one that is auto-loaded by the `LUMI` module. It works 
correctly for a lot of CPU-only software, but fails more frequently for GPU software as the
installation scripts will try to run scripts that detect which GPU is present, or try to run
tests on the GPU, even if you tell which GPU type to use, which does not work on the login nodes.

**Note that the `EasyBuild-user` module is only needed for the installation process. For using
the software that is installed that way it is sufficient to ensure that `EBU_USER_PREFIX` has
the proper value before loading the `LUMI` module.**

<figure markdown style="border: 1px solid #000">
  ![Step 2: Configure the environment - Demo](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildInstallingStep2_2.png){ loading=lazy }
</figure>


#### Step 3: Install the software.

<figure markdown style="border: 1px solid #000">
  ![Step 3: Install the software](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildInstallingStep3_partial_1.png){ loading=lazy }
</figure>

Let's look at GROMACS as an example. I will not try to do this completely live though as the 
installation takes 15 or 20 minutes.

First we need to figure out for which versions of GROMACS we already have support.
The easy way is to check the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
which lists all software that we manage via EasyBuild and make available either pre-installed on
the system or as an EasyBuild recipe for user installation.
A command-line alternative is to use `eb -S` or `eb --search` for that. So in our example this is

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
      ![GROMACS in the LUMI Software Library](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSSoftLib.png){ loading=lazy }
    </figure>

    `eb --search GROMACS` produces:

    <figure markdown style="border: 1px solid #000">
      ![eb --search GROMACS](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSSearch_1.png){ loading=lazy }
    </figure>

    while `eb -S GROMACS` produces:

    <figure markdown style="border: 1px solid #000">
      ![eb -S GROMACS](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSSearch_2.png){ loading=lazy }
    </figure>

    The information provided by both variants of the search command is the same, but `-S` presents the information in a more
    compact form.

<figure markdown style="border: 1px solid #000">
  ![Step 3: Install the software](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildInstallingStep3_partial_2.png){ loading=lazy }
</figure>

Now let's take the variant `GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb`. 
This is GROMACS 2024.3 with the PLUMED 2.9.2 plugin, built with the GNU compilers
from `LUMI/24.03`, and a build meant for CPU-only systems. The `-CPU` extension is not
always added for CPU-only system, but in case of GROMACS there already is a GPU version
for AMD GPUs in active development so even before LUMI-G was active we chose to ensure
that we could distinguish between GPU and CPU-only versions.
To install it, we first run 

```bash
eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb –D
```

The `-D` flag tells EasyBuild to just perform a check for the dependencies that are needed
when installing this package.

!!! Demo "The output of this command looks like:"

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb –D](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSDep_01.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb –D (2)](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSDep_02.png){ loading=lazy }
    </figure>

Looking at the output we see that EasyBuild will also need to install `PLUMED` for us.

<figure markdown style="border: 1px solid #000">
  ![Step 3: Install the software](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildInstallingStep3_partial_3.png){ loading=lazy }
</figure>

To install GROMACS and also automatically install missing dependencies (only PLUMED
in this case), we run

```bash
eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb -r
```

The `-r` argument tells EasyBuild to also look for dependencies in a preset search path
and to install them. The installation of dependencies is not automatic
since there are scenarios where this is not desired and it cannot be turned off as easily as
it can be turned on.


!!! Demo "Running EasyBuild to install GROMACS and dependency"
    The command

    ```bash
    eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb -r
    ```

    results in:

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb -r](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSInst_01.png){ loading=lazy }
    </figure>

    EasyBuild detects PLUMED is a dependency and because of the `-r` option, it first installs the
    required version of PLUMED.

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb -r (2)](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSInst_02.png){ loading=lazy }
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
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb -r (3)](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSInst_03.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb -r (4)](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSInst_04.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb -r (5)](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSInst_05.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![eb GROMACS-2024.3-cpeGNU-24.03-PLUMED-2.9.2-noPython-CPU.eb -r (6)](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildGROMACSInst_06.png){ loading=lazy }
    </figure>


<figure markdown style="border: 1px solid #000">
  ![Step 3: Install the software](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildInstallingStep3.png){ loading=lazy }
</figure>

This takes too long to wait for, but once it finished the software should be available
and you should be able to see the module in the output of

```bash
module avail
```


#### Step 3: Install the software - Note

<figure markdown style="border: 1px solid #000">
  ![Step 3: Install the software - Note](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildInstallingStep3Note.png){ loading=lazy }
</figure>

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
  ![More advanced work](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildAdvanced_1.png){ loading=lazy }
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
directory run EasyBuild, for instance for VASP 6.4.2 with the GNU compilers:
```bash
eb VASP-6.4.2-cpeGNU-23.09-build02.eb –r . 
```


### More advanced work (2): Repositories

<figure markdown style="border: 1px solid #000">
  ![More advanced work (2)](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildAdvanced_2.png){ loading=lazy }
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
  ![More advanced work (3)](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildAdvanced_3.png){ loading=lazy }
</figure>

EasyBuild also takes care of a **high level of reproducibility of installations**.

It will **keep a copy of all the downloaded sources** in the `$EBU_USER_PREFIX/sources`
subdirectory (unless the sources are already available elsewhere where EasyBuild can find them,
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


### EasyBuild tips & tricks

<figure markdown style="border: 1px solid #000">
  ![EasyBuild additional tips&tricks](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildTipsTricks.png){ loading=lazy }
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
  ![EasyBuild training](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/EasyBuildTraining.png){ loading=lazy }
</figure>

I also want to give some pointers to more information in case you want to learn a lot more
about, e.g., developing support for your code in EasyBuild, or for support people who want
to adapt our EasyConfigs for users requesting a specific configuration of a package.

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


## Containers on LUMI

<figure markdown style="border: 1px solid #000">
  ![Containers on LUMI](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersIntro.png){ loading=lazy }
</figure>

Let's now switch to using containers on LUMI. 
This section is about using containers on the login nodes and compute nodes. 
Some of you may have heard that there were plans to also have an OpenShift Kubernetes container cloud
platform for running microservices but at this point it is not clear if and when this will materialize
due to a lack of personpower to get this running and then to support this.

In this section, we will 

-   discuss what to expect from containers on LUMI: what can they do and what can't they do,

-   discuss how to get a container on LUMI,

-   discuss how to run a container on LUMI,

-   and discuss some enhancements we made to the LUMI environment that are based on containers or help
    you use containers.

Remember though that the compute nodes of LUMI are an HPC infrastructure and not a container cloud!

### What do containers not provide

<figure markdown style="border: 1px solid #000">
  ![What do containers not provide](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersNotProvide.png){ loading=lazy }
</figure>

What is being discussed in this subsection may be a bit surprising.
Containers are often marketed as a way to provide reproducible science and as an easy way to transfer
software from one machine to another machine. However, containers are neither of those and this becomes 
very clear when using containers build on your typical Mellanox/NVIDIA InfiniBand based clusters with
Intel processors and NVIDIA GPUs on LUMI.

First, computational results are almost never 100% reproducible because of the very nature of how computers
work. You can only expect reproducibility of sequential codes between equal hardware. As soon as you change the
CPU type, some floating point computations may produce slightly different results, and as soon as you go parallel
this may even be the case between two runs on exactly the same hardware and software.

But full portability is as much a myth. Containers are really only guaranteed to be portable between similar systems.
They may be a little bit more portable than just a binary as you may be able to deal with missing or different libraries
in the container, but that is where it stops. Containers are usually built for a particular CPU architecture and GPU
architecture, two elements where everybody can easily see that if you change this, the container will not run. But 
there is in fact more: containers talk to other hardware too, and on an HPC system the first piece of hardware that comes
to mind is the interconnect. And they use the kernel of the host and the kernel modules and drivers provided by that
kernel. Those can be a problem. A container that is not build to support the SlingShot interconnect, may fall back to
TCP sockets in MPI, completely killing scalability. Containers that expect the knem kernel extension for good 
intra-node MPI performance may not run as efficiently as LUMI uses xpmem instead.

Even if a container is portable to LUMI, it may not yet be performance portable. E.g., without proper support for the
interconnect it may still run but in a much slower mode. But one should also realise that speed gains in the x86
family over the years come to a large extent from adding new instructions to the CPU set, and that two processors
with the same instructions set extensions may still benefit from different optimisations by the compilers. 
Not using the proper instruction set extensions can have a lot of influence. At my local site we've seen GROMACS 
doubling its speed by choosing proper options, and the difference can even be bigger.

Many HPC sites try to build software as much as possible from sources to exploit the available hardware as much as 
possible. You may not care much about 10% or 20% performance difference on your PC, but 20% on a 160 million EURO
investment represents 32 million EURO and a lot of science can be done for that money...


### But what can they then do on LUMI?

<figure markdown style="border: 1px solid #000">
  ![But what can they then do on LUMI?](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersCanDoOnLUMI.png){ loading=lazy }
</figure>


*   A very important reason to use containers on LUMI is reducing the pressure on the file system by software
    that accesses many thousands of small files (Python and R users, you know who we are talking about).
    That software kills the metadata servers of almost any parallel file system when used at scale.

    As a container on LUMI is a single file, the metadata servers of the parallel file system have far less 
    work to do, and all the file caching mechanisms can also work much better.

*   Software installations that would otherwise be impossible. 
    E.g., some software may not even be suited for installation in
    a multi-user HPC system as it uses fixed paths that are not compatible with installation in 
    module-controlled software stacks.
    HPC systems want a lightweight `/usr` etc. structure as that part of the system
    software is often stored in a RAM disk, and to reduce boot times. Moreover, different users may need
    different versions of a software library so it cannot be installed in its default location in the system
    library. However, some software is ill-behaved and cannot be relocated to a different directory,
    and in these cases containers help you to build a private installation that does not interfere with other
    software on the system.

*   As an example, Conda installations are not appreciated on the main Lustre file system.

    On one hand, Conda installations tend to generate lots of small files (and then even more due to a linking
    strategy that does not work on Lustre). So they need to be containerised just for storage manageability.

    They also re-install lots of libraries that may already be on the system in a different version. 
    The isolation offered by a container environment may be a good idea to ensure that all software picks up the
    right versions.

*   Another example where containers have proven to be useful on LUMI is to experiment with newer versions
    of ROCm than we can offer on the system. 

    This often comes with limitations though, as (a) that ROCm version is still limited by the drivers on the 
    system and (b) we've seen incompatibilities between newer ROCm versions and the Cray MPICH libraries.

Remember though that whenever you use containers, you are the system administrator and not LUST. We can impossibly
support all different software that users want to run in containers, and all possible Linux distributions they may
want to run in those containers. We provide some advice on how to build a proper container, but if you chose to
neglect it it is up to you to solve the problems that occur.


### Managing containers

<figure markdown style="border: 1px solid #000">
  ![Managing containers](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersManaging_1.png){ loading=lazy }
</figure>

On LUMI, we currently support only one container runtime.

Docker is not available, and will never be on the regular compute nodes as it requires elevated privileges
to run the container which cannot be given safely to regular users of the system.

Singularity is currently the only supported container runtime and is available on the login nodes and
the compute nodes. It is a system command that is installed with the OS, so no module has to be loaded
to enable it. We can also offer only a single version of singularity or its close cousin AppTainer 
as singularity/AppTainer simply don't really like running multiple versions next to one another, 
and currently the version that
we offer is determined by what is offered by the OS. Currently we offer 
[Singularity Community Edition 4.1.3](https://docs.sylabs.io/guides/4.1/user-guide/).

To work with containers on LUMI you will either need to pull the container from a container registry,
e.g., [DockerHub](https://hub.docker.com/), or bring in the container by copying the singularity `.sif` file.

Singularity does offer a command to pull in a Docker container and to convert it to singularity format.
E.g., to pull a container for the Julia language from DockerHub, you'd use

```bash
singularity pull docker://julia
```

Singularity uses a single flat sif file for storing containers. The `singularity pull` command does the 
conversion from Docker format to the singularity format.

Singularity caches files during pull operations and that may leave a mess of files in
the `.singularity` cache directory. This can lead to exhaustion of your disk quota for your
home directory. So you may want to use the environment variable `SINGULARITY_CACHEDIR`
to put the cache in, e.g,, your scratch space (but even then you want to clean up after the
pull operation so save on your storage billing units).

???+demo "Demo singularity pull"

    Let's try the `singularity pull docker://julia` command:

    <!-- Used a 105x23 window size -->
    <figure markdown style="border: 1px solid #000">
      ![Demo singularity pull slide 1](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExamplePull_1.png){ loading=lazy }
    </figure>

    We do get a lot of warnings but usually this is perfectly normal and usually they can be safely ignored.

    <figure markdown style="border: 1px solid #000">
      ![Demo singularity pull slide 2](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExamplePull_2.png){ loading=lazy }
    </figure>

    The process ends with the creation of the file `jula_latest.sif`. 

    Note however that the process has left a considerable number of files in `~/.singularity ` also:

    <figure markdown style="border: 1px solid #000">
      ![Demo singularity pull slide 3](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExamplePull_3.png){ loading=lazy }
    </figure>


<figure markdown style="border: 1px solid #000">
  ![Managing containers (2)](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersManaging_2.png){ loading=lazy }
</figure>

There is currently limited support for building containers on LUMI and I do not expect that to change quickly.
Container build strategies that require elevated privileges, and even those that require fakeroot or user namespaces, cannot
be supported for security reasons (with user namespaces in particular a huge security concern as the Linux implementation
is riddled with security issues). 
Enabling features that are known to have had several serious security vulnerabilities in the recent past, or that
themselves are unsecure by design and could allow users to do more on the system than a regular user should
be able to do, will never be supported.

So you should pull containers from a container repository, or build the container on your own workstation
and then transfer it to LUMI.

There is some support for building on top of an existing singularity container using what the SingularityCE user guide
calls "unprivileged proot builds". This requires loading the `proot` command which is provided by the `systools` module
in CrayEnv or LUMI/23.09 or later. The SingularityCE user guide
[mentions several restrictions of this process](https://docs.sylabs.io/guides/4.1/user-guide/build_a_container.html#unprivilged-proot-builds).
The general guideline from the manual is: "Generally, if your definition file starts from an existing SIF/OCI container image, 
and adds software using system package managers, an unprivileged proot build is appropriate. 
If your definition file compiles and installs large complex software from source, 
you may wish to investigate `--remote` or `--fakeroot` builds instead." But as we just said,
on LUMI we cannot yet
provide `--fakeroot` builds due to security constraints.

<!-- TODO: Do not forget to correct the link above to a new version of singularity. -->

We are also working on a number of base images to build upon, where the base images are tested with the
OS kernel on LUMI (and some for ROCm are already there).


### Interacting with containers

<figure markdown style="border: 1px solid #000">
  ![Interacting with containers](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersInteracting.png){ loading=lazy }
</figure>

There are basically three ways to interact with containers.

If you have the sif file already on the system you can enter the container with an interactive shell:

```
singularity shell container.sif
```

???+demo "Demo singularity shell"

    <figure markdown style="border: 1px solid #000">
      ![Demo singularity shell](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExampleShell.png){ loading=lazy }
    </figure>

    In this screenshot we checked the contents of the `/opt` directory before and after the
    `singularity shell julia_latest.sif` command. This shows that we are clearly in a different
    environment. Checking the `/etc/os-release` file only confirms this as LUMI runs SUSE Linux
    on the login nodes, not a version of Debian.


The second way is to execute a command in the container with `singularity exec`. E.g., assuming the 
container has the `uname` executable installed in it,

```
singularity exec container.sif uname -a
```

???+demo "Demo singularity exec"

    <figure markdown style="border: 1px solid #000">
      ![Demo singularity exec](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExampleExec.png){ loading=lazy }
    </figure>

    In this screenshot we execute the `uname -a` command before and with the
    `singularity exec julia_latest.sif` command. There are some slight differences in the
    output though the same kernel version is reported as the container uses the host kernel.
    Executing

    ```
    singularity exec julia_latest.sif cat /etc/os-release
    ```

    confirms though that the commands are executed in the container.


The third option is often called running a container, which is done with singularity run:

```
singularity run container.sif
```

It does require the container to have a special script that tells singularity what 
running a container means. You can check if it is present and what it does with `singularity inspect`: 

```
singularity inspect --runscript container.sif
```

???+demo "Demo singularity run"

    <figure markdown style="border: 1px solid #000">
      ![Demo singularity run](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExampleRun.png){ loading=lazy }
    </figure>

    In this screenshot we start the julia interface in the container using
    `singularity run`. The second command shows that the container indeed
    includes a script to tell singularity what `singularity run` should do.



You want your container to be able to interact with the files in your account on the system.
Singularity will automatically mount `$HOME`, `/tmp`, `/proc`, `/sys` and `dev` in the container,
but this is not enough as your home directory on LUMI is small and only meant to be used for
storing program settings, etc., and not as your main work directory. (And it is also not billed
and therefore no extension is allowed.) Most of the time you want to be able to access files in
your project directories in `/project`, `/scratch` or `/flash`, or maybe even in `/appl`.
To do this you need to tell singularity to also mount these directories in the container,
either using the 
`--bind src1:dest1,src2:dest2` 
flag or via the `SINGULARITY_BIND` or `SINGULARITY_BINDPATH` environment variables.


### Running containers on LUMI

<figure markdown style="border: 1px solid #000">
  ![/running containers on LUMI](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersRunning.png){ loading=lazy }
</figure>

Just as for other jobs, you need to use Slurm to run containers on the compute nodes.

For MPI containers one should use `srun` to run the `singularity exec` command, e.g,,

```
srun singularity exec --bind ${BIND_ARGS} \
${CONTAINER_PATH} mp_mpi_binary ${APP_PARAMS}
```

(and replace the environment variables above with the proper bind arguments for `--bind`, container file and
parameters for the command that you want to run in the container).

On LUMI, the software that you run in the container should be compatible with Cray MPICH, i.e., use the
MPICH ABI (currently Cray MPICH is based on MPICH 3.4). It is then possible to tell the container to use
Cray MPICH (from outside the container) rather than the MPICH variant installed in the container, so that
it can offer optimal performance on the LUMI SlingShot 11 interconnect.

Open MPI containers are currently not well supported on LUMI and we do not recommend using them.
We only have a partial solution for the CPU nodes that is not tested in all scenarios, 
and on the GPU nodes Open MPI is very problematic at the moment.
This is due to some design issues in the design of Open MPI, and also to some piece of software
that recent versions of Open MPI require but that HPE only started supporting recently on Cray EX systems
and that we haven't been able to fully test.
Open MPI has a slight preference for the UCX communication library over the OFI libraries, and 
until version 5 full GPU support requires UCX. Moreover, binaries using Open MPI often use the so-called
rpath linking process so that it becomes a lot harder to inject an Open MPI library that is installed
elsewhere. The good news though is that the Open MPI developers of course also want Open MPI
to work on biggest systems in the USA, and all three currently operating or planned exascale systems
use the SlingShot 11 interconnect, so work is going on for better support for OFI in general and 
Cray SlingShot in particular and for full GPU support.


### Enhancements to the environment

<figure markdown style="border: 1px solid #000">
  ![Environment enhancements](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersEnvironmentEnhancement_1.png){ loading=lazy }
</figure>

To make life easier, LUST with the support of CSC did implement some modules
that are either based on containers or help you run software with containers.


### Bindings for singularity

The **`singularity-bindings/system`** module which can be installed via EasyBuild
helps to set `SINGULARITY_BIND` and `SINGULARITY_LD_LIBRARY_PATH` to use 
Cray MPICH. Figuring out those settings is tricky, and sometimes changes to the
module are needed for a specific situation because of dependency conflicts
between Cray MPICH and other software in the container, which is why we don't
provide it in the standard software stacks but instead make it available as
an EasyBuild recipe that you can adapt to your situation and install.

As it needs to be installed through EasyBuild, it is really meant to be 
used in the context of a LUMI software stack (so not in `CrayEnv`).
To find the EasyConfig files, load the `EasyBuild-user` module and 
run

```
eb --search singularity-bindings
```

You can also check the 
[page for the `singularity-bindings` in the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/s/singularity-bindings/).

You may need to change the EasyConfig for your specific purpose though.
E.g., the singularity command line option `--rocm` to import the ROCm installation
from the system doesn't fully work (and in fact, as we have alternative ROCm versions
on the system cannot work in all cases) but that can also be fixed by extending
the `singularity-bindings` module 
(or by just manually setting the proper environment variables).


### VNC container

The second tool is a container that we provide with some bash functions
to start a VNC server as temporary way to be able to use some GUI programs
on LUMI until the final setup which will be based on Open OnDemand is ready.
It can be used in `CrayEnv` or in the LUMI stacks through the
[**`lumi-vnc`** module](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumi-vnc/). 
The container also
contains a poor men's window manager (and yes, we know that there are sometimes
some problems with fonts). It is possible to connect to the VNC server either
through a regular VNC client on your PC or a web browser, but in both cases you'll
have to create an ssh tunnel to access the server. Try

```
module help lumi-vnc
```

for more information on how to use `lumi-vnc`.

For most users, the Open OnDemand web interface and tools offered in that interface will
be a better alternative.


### cotainr: Build Conda containers on LUMI

<figure markdown style="border: 1px solid #000">
  ![Environment enhancements (2)](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersEnvironmentEnhancement_2.png){ loading=lazy }
</figure>

The third tool is [**`cotainr`**](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/c/cotainr/), 
a tool developed by DeIC, the Danish partner in the LUMI consortium.
It is a tool to pack a Conda installation into a container. It runs entirely in user space and doesn't need
any special rights. (For the container specialists: It is based on the container sandbox idea to build
containers in user space.)

Containers build with `cotainr` are used just as other containers, so through the `singularity` commands discussed
before.


### Container wrapper for Python packages and conda

The fourth tool is a container wrapper tool that users from Finland may also know
as Tykky. It is a tool to wrap Python and conda installations in a container and then
create wrapper scripts for the commands in the bin subdirectory so that for most
practical use cases the commands can be used without directly using singularity
commands. 
Whereas cotainr fully exposes the container to users and its software is accessed
through the regular singularity commands, Tykky tries to hide this complexity with
wrapper scripts that take care of all bindings and calling singularity.
On LUMI, it is provided by the **`lumi-container-wrapper`**
module which is available in the `CrayEnv` environment and in the LUMI software stacks.
It is also [documented in the LUMI documentation](https://docs.lumi-supercomputer.eu/software/installing/container-wrapper/).

The basic idea is that you run the tool to either do a conda installation or an installation
of Python packages from a file that defines the environment in either standard conda
format (a Yaml file) or in the `requirements.txt` format used by `pip`. 

The container wrapper will then perform the installation in a work directory, create some
wrapper commands in the `bin` subdirectory of the directory where you tell the container
wrapper tool to do the installation, and it will use SquashFS to create as single file
that contains the conda or Python installation. So strictly speaking it does not create a 
container, but a SquashFS file that is then mounted in a small existing base container. 
However, the wrappers created for all commands in the `bin` subdirectory of the conda or
Python installation take care of doing the proper bindings. If you want to use the container
through singularity commands however, you'll have to do that mounting by hand.

We do strongly recommend to use the container wrapper tool or cotainr for larger conda and Python installation.
We will not raise your file quota if it is to house such installation in your `/project` directory.

???+demo "Demo lumi-container-wrapper"

    Create a subdirectory to experiment. In that subdirectory, create a file named `env.yml` with
    the content:

    ```
    channels:
      - conda-forge
    dependencies:
      - python=3.8.8
      - scipy
      - nglview
    ```

    and create an empty subdirectory `conda-cont-1`.

    Now you can follow the commands on the slides below:

    <figure markdown style="border: 1px solid #000">
      ![demo lumi-container-wrapper slide 1](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExampleWrapper_1.png){ loading=lazy }
    </figure>

    On the slide above we prepared the environment.

    Now lets run the command 

    ```
    conda-containerize new --prefix ./conda-cont-1 env.yml
    ```

    and look at the output that scrolls over the screen.
    The screenshots don't show the full output as some parts of the screen get overwritten during
    the process:

    <figure markdown style="border: 1px solid #000">
      ![demo lumi-container-wrapper slide 2](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExampleWrapper_2.png){ loading=lazy }
    </figure>

    The tool will first build the conda installation in a tempororary work directory
    and also uses a base container for that purpose.

    <figure markdown style="border: 1px solid #000">
      ![demo lumi-container-wrapper slide 3](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExampleWrapper_3.png){ loading=lazy }
    </figure>

    The conda installation itself though is stored in a SquashFS file that is then
    used by the container.

    <figure markdown style="border: 1px solid #000">
      ![demo lumi-container-wrapper slide 4](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExampleWrapper_4.png){ loading=lazy }
    </figure>

    <figure markdown style="border: 1px solid #000">
      ![demo lumi-container-wrapper slide 65](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExampleWrapper_5.png){ loading=lazy }
    </figure>

    In the slide above we see the installation contains both a singularity container
    and a SquashFS file. They work together to get a working conda installation.

    The `bin` directory seems to contain the commands, but these are in fact scripts 
    that run those commands in the container with the SquashFS file system mounted in it.

    <figure markdown style="border: 1px solid #000">
      ![demo lumi-container-wrapper slide 6](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersExampleWrapper_6.png){ loading=lazy }
    </figure>

    So as you can see above, we can simply use the `python3` command without realising
    what goes on behind the screen...

The wrapper module also offers a pip-based command to build upon the Cray Python modules already present on the system

The final tool is [**`cotainr`**](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/c/cotainr/), 
a tool developed by DeIC, the Danish partner in the LUMI consortium.
It is another tool to pack a Conda installation into a container, but it does so in a more container-like
way (so no wrapper scripts). Just as `lumi-container-wrapper`, it runs entirely in user space and doesn't need
any special rights. (For the container specialists: It is based on the container sandbox idea to build
containers in user space.)


### Pre-built AI containers

<figure markdown style="border: 1px solid #000">
  ![Environment enhancements (3): Prebuilt AI containers](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersEnvironmentEnhancement_3.png){ loading=lazy }
</figure>

LUST with the help of AMD is also building some containers with popular AI software.
These containers contain a ROCm version that is appropriate for the software,
use Conda for some components, but have several of the performance critical components
built specifically for LUMI for near-optimal performance. Depending on the software they
also contain a RCCL library with the appropriate plugin to work well on the Slingshot 11
interconnect, or a horovod compiled to use Cray MPICH. 

The containers are provided through a module which sets the `SINGULARITY_BIND` environment variable
to ensure proper bindings (as they need, e.g., the libfabric library from the system and the proper
"CXI provider" for libfabric to connect to the Slingshot interconnect). The module will also provide
an environment variable to refer to the container (name with full path) to make it easy to refer to
the container in job scripts.

These containers can be found through the
[LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/) and are marked
with a container label.


### Conclusion: Container limitations on LUMI-C

<figure markdown style="border: 1px solid #000">
  ![Container limitations on LUMI](https://462000265.lumidata.eu/4day-20241028/img/LUMI-4day-20241028-software/ContainersLimitations.png){ loading=lazy }
</figure>

To conclude the information on using singularity containers on LUMI,
we want to repeat the limitations:

*   Containers use the host's operating system kernel which is likely different and
    may have different drivers and kernel extensions than your regular system.
    This may cause the container to fail or run with poor performance.
    Also, containers do not abstract the hardware unlike some virtual machine solutions.

*   The LUMI hardware is almost certainly different from that of the systems on which
    you may have used the container before and that may also cause problems.

    In particular a generic container may not offer sufficiently good support for the 
    SlingShot 11 interconnect on LUMI which requires OFI (libfabric) with the right 
    network provider (the so-called Cassini provider) for optimal performance.
    The software in the container may fall back to TCP sockets resulting in poor 
    performance and scalability for communication-heavy programs.

    For containers with an MPI implementation that follows the MPICH ABI the solution
    is often to tell it to use the Cray MPICH libraries from the system instead.

    Likewise, for containers for distributed AI, one may need to inject an appropriate
    RCCL plugin to fully use the SlingShot 11 interconnect.

*   The support for building containers on LUMI is currently very limited due to security
    concerns. Any build process that requires elevated privileges, fakeroot or user namespaces
    will not work.
