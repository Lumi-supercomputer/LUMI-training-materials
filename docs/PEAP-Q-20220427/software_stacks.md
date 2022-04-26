# LUMI Software Stacks

<figure markdown style="border: 1px solid #000">
  ![Slide 2](img/LUMI-PEAPQ-EasyBuild-20220427/Dia2.png){ loading=lazy }
</figure>

In this part of the training, we cover:

-   Software stacks on LUMI, where we discuss the organisation of the software stacks
    that we offer and some of the policies surrounding it
-   Advanced Lmod use to make the best out of the software stacks
-   Creating your customised environment with EasyBuild, the tool that we use to install
    most software.

## The software stacks on LUMI

### Design considerations

<figure markdown style="border: 1px solid #000">
  ![Slide 3](img/LUMI-PEAPQ-EasyBuild-20220427/Dia3.png){ loading=lazy }
</figure>

-   LUMI is a **very leading edge** and also an **inhomogeneous machine**. Leading edge often implies
    **teething problems** and ihomogeneous doesn't make life easier either.

    1.  It uses a **novel interconnect** which is an extension of Ethernet rather than being based on InfiniBand, 
        and that interconnect has a different software stack of your typical Mellanox InfiniBand cluster. 
    2.  It also uses a **relatively new GPU architecture**, AMD CDNA2, with an immature software ecosystem. 
        The GPU nodes are really **GPU-first**, with the **interconnect cards connected directly to the GPU packages** 
        and only one CPU socket, and another feature which is relatively new: a **fully cache-coherent unified memory**
        space between the CPU and GPUs, though of course very NUMA. This is a feature that has previously
        only been seen in some clusters with NVIDIA P100 and V100 GPUs and IBM Power 8 and 9 CPUs used
        for some USA pre-exascale systems, and of course in the Apple M1 but then without the NUMA character.
    3.  LUMI is also **inhomogeneous** because some nodes have zen2 processors while the two main compute partitions
        have zen3-based CPUs, and the compute GPU nodes have AMD GPUs while the visualisation nodes have
        NVIDIA GPUs. 
        
    Given the novel interconnect and GPU we do expect that both system and application
    software will be immature at first and **evolve quickly**, hence we needed a setup that enables us
    to remain very agile, which leads to different compromises compared to a software stack for a more
    conventional and mature system as a x86 cluster with NVIDIA GPUs and Mellanox InfiniBand.

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
    installation and support only... (I give this number because it was mentioned in a recent talk in an
    EasyBuild user meeting.)

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
  ![Slide 4](img/LUMI-PEAPQ-EasyBuild-20220427/Dia4.png){ loading=lazy }
</figure>

We tried to take all these considerations into account and came up with a solution that may look **a
little unconventional** to many users.

In principle there should be a high degree of compatibility between releases of the HPE Cray Programming
Environment but we decided not to take the risk and **build our software for a specific release of the 
programming environment**, which is also a better fit with the typical tools used to manage a scientific 
software stack such as EasyBuild and Spack as they also prefer precise versions for all dependencies and
compilers etc. We also made the stack very easy to extend. So we have **many base libraries and some packages
already pre-installed** but also provide an **easy and very transparant way to install additional packages in
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
that you may be acustomed with from clusters at your home institution. **It uses toolchains
specifically for the HPE Cray programming environment** so recipes need to be adapted. We do offer an
**increasing library of Cray-specific installation recipes** though.
The whole setup of EasyBuild is done such that you can build on top of the central software stack
and such that **your modules appear in your module view** without having to add directories by hand
to environment variables etc. You only need to point to the place where you want to install software
for your project as we cannot automatically determine a suitable place. **We do offer some help so set up
Spack also but activating Spack for installation is your project directory is not yet automated.**


### Software policies

<figure markdown style="border: 1px solid #000">
  ![Slide 5](img/LUMI-PEAPQ-EasyBuild-20220427/Dia5.png){ loading=lazy }
</figure>

As any site, we also have a number of policies about software installation, and we're still further
developing them as we gain experience in what we can do with the amount of people we have and what we
cannot do.

LUMI uses a **bring-your-on-license model except for a selection of tools that are useful to a larger
community**. 

-   This is partly caused by the **distributed user management** as we do not even have the necessary
    information to determine if a particular user can use a particular license, so we must shift that 
    responsibility to people who have that information, which is often the PI of your project.
-   You also have to take into account that up to 20% of LUMI is reserved for industry use which makes 
    negotiations with software vendors rather difficult as they will want to push us onto the industrial
    rather than academic pricing as they have no guarantee that we will obey to the academic license
    restrictions. 
-   And lastly, **we don't have an infinite budget**. There was a questionaire send out to 
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
-   The final LUMI interconnect requires **libfabric**
    using a specific provider for the NIC used on LUMI, so any software compiled with an MPI library that
    requires UCX, or any other distributed memory model build on top of UCX, will not work on LUMI, or at
    least not work efficiently as there might be a fallback path to TCP communications. 
-   Even intro-node interprocess communication can already cause problems as there are three different kernel extensions
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

Also, the LUNI user support team is **too small to do all software installations** which is why we currently
state in our policy that a LUMI user should be capable of installing their software themselves or have
another support channel. We cannot install every single piece of often badly documented research-quality
code that was never meant to be used by people who don't understand the code.

Another soft compatibility problem that I did not yet mention is that software that **accesses hundreds
of thousands of small files and abuses the file system as a database** rather than using structured
data formats designed to organise data on supercomputers is not welcome on LUMI. For that reason we
also require to **containerize conda and Python installations**. We do offer a container-based wrapper
that offers a way to install conda packages or to install Python packages with pip on top of 
the Python provided by the `cray-python` module. The link to the documentation of the tool that we call
[lumi-container-wrapper](https://docs.lumi-supercomputer.eu/software/installing/container_wrapper/)
but may by some from CSC also be known as Tykky is in the handout of the slides that you can get
after the course.

### Organisation of the software in software stacks

<figure markdown style="border: 1px solid #000">
  ![Slide 6](img/LUMI-PEAPQ-EasyBuild-20220427/Dia6.png){ loading=lazy }
</figure>

On LUMI we have several software stacks.

**CrayEnv** is the software stack for users who only need the **Cray Programming Environment** but want a **more
recent set of build tools etc** than the OS provides. We also take care of a few issues that we will discuss
on the next slide that are present right after login on LUMI.

Next we have the **stacks called "LUMI"**. Each one corresponds to a **particular release of the HPE Cray
Programming Environment**. It is the stack in which we install software using the that programming environment
and mostly EasyBuild. **The Cray Programming Environment modules are still used, but they are accessed through
a replacement for the PrgEnv modules that is managed by EasyBuild**. We have **tuned versions for the 4 types
of hardware in the regular LUMI system**: zen2 CPUs in the login nodes and large memory nodes, zen3 for the 
LUMI-C compute nodes, zen 2 combined with NVIDIA GPUs for the visualisation nodes and zen3 + MI250X for
the LUMI-G partition. There is also some support for the early access platform which has zen2 CPUs combined
with MI100 GPUs but we don't pre-install software in there at the moment except for some build tools and
some necessary tools for ROCm as these nodes are not meant to run codes on and as due to installation 
restrictions we cannot yet use the GPU compilers with EasyBuild the way we should do that on the final system.

In the far future we will also look at **a stack based on the common EasyBuild toolchains as-is**, but we do expect
problems with MPI that will make this difficult to implement, and the common toolchains also do not yet support
the AMD GPU ecosystem, so we make no promises whatsoever about a time frame for this development.


### 3 ways to access the Cray Programming environment on LUMI.

#### Bare environment and CrayEnv

<figure markdown style="border: 1px solid #000">
  ![Slide 7](img/LUMI-PEAPQ-EasyBuild-20220427/Dia7.png){ loading=lazy }
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
  ![Slide 8](img/LUMI-PEAPQ-EasyBuild-20220427/Dia8.png){ loading=lazy }
</figure>

The **third way** to access the Cray Programming Environment is through the **LUMI software stacks**, where each stack
is **based on a particular release of the HPE Cray Programming Environment**. We advise against mixing with modules
that came with other versions of the Cray PE, but they **remain accessible** although they are hidden from the default
view for regular users. It ia also better to **not use the PrgEnv modules, but the equivalent LUMI EasyBuild 
toolchains** instead as indicated by the following table:

| HPE Cray PE   | LUMI toolchain | What?                                |
|:--------------|:---------------|:-------------------------------------|
| `PrgEnv-cray` | `cpeCray`      | Cray Compiler Environment            |
| `PrgEnv-gnu`  | `cpeGNU`       | GNU C/C++ and Fortran                |
| `PrgEnv-aocc` | `cpeAOCC`      | AMD CPU compilers                    |
| `PrgEnv-amd`  | `cpeAMDy`      | AMD ROCm GPU compilers (LUMI-G only) |

The cpeCray etc modules also load the MPI libraries and Cray LibSci just as the PrgEnv modules do.

This is also the environment in which we install most software, and from the name of the modules you can see which
compilers we used.

#### LUMI stack mmodule organisation

<figure markdown style="border: 1px solid #000">
  ![Slide 9](img/LUMI-PEAPQ-EasyBuild-20220427/Dia9.png){ loading=lazy }
</figure>

To manage the hetergeneity in the hardware, the LUMI software stack uses **two levels of modules**

First there are the **LUMI/21.08 and LUMI/21.12 modules**. Each of the LUMI modules loads a particular
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

## Lmod on LUMI


### Exploring modules with Lmod

<figure markdown style="border: 1px solid #000">
  ![Slide 10](img/LUMI-PEAPQ-EasyBuild-20220427/Dia10.png){ loading=lazy }
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


### Module spider command

***Demo moment 1***

<figure markdown style="border: 1px solid #000">
  ![Slide 11](img/LUMI-PEAPQ-EasyBuild-20220427/Dia11.png){ loading=lazy }
</figure>

(The content of this slide is really meant to be shown in practice on a command line.)

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


### Module keyword command

<figure markdown style="border: 1px solid #000">
  ![Slide 12](img/LUMI-PEAPQ-EasyBuild-20220427/Dia12.png){ loading=lazy }
</figure>

`module keyword` will search for a module using a keyword but it is **currently not very useful on
LUMI** because of a bug in the current version of Cray Lmod which is solved in the more recent versions.
Currently the output contains a lot of irrelevant modules, basically all extensions of modules
on the system.

What `module keyword` really does is search in the **module description and help** for the word that 
you give as an argument. Try for instance `module keyword https` and you'll see two relevant tools,
`cURL` and `wget`, two tools that can be used to download files to LUMI via several protocols in use
on the internet.

On LUMI **we do try to put enough information in the module files** to make this a suitable additional
way to discover software that is already installed on the system, more so than in regular EasyBuild
installations.


### Sticky modules and module purge

<figure markdown style="border: 1px solid #000">
  ![Slide 13](img/LUMI-PEAPQ-EasyBuild-20220427/Dia13.png){ loading=lazy }
</figure>

You may have been taught that `module purge` is a command that unloads all modules and on some
systems they **might tell you in trainings not to use it because it may also remove some basic 
modules that you need to use the system**. On LUMI for instance there is an `init-lumi` module that
does some of the setup of the module system and should be reloaded after a normal `module purge`.
On Cray systems `module purge` will also unload the target modules while those are typically not
loaded by the `PrgEnv` modules so you'd need to reload them by hand before the `PrgEnv` modules
would work.

Lmod however does have the concept of **"sticky modules"**. These are not unloaded by `module purge`
but are re-loaded, so unloaded and almost immediately loaded again, though you can always
force-unload them with `module --force purge` or `module --force unload` for individual modules.

The sticky property has to be declared in the module file so we cannot add it to for instance the
Cray Programming Environment target modules, but we can and do use it in some modules that we control
ourselves. **We use it on LUMI for the software stacks themselves and for the modules that set the
display style of the modules**. 

-   In the `CrayEnv` environment, `module purge` will clear the target
    modules also but as `CrayEnv` is not just left untouched but reloaded instead, the load of `CrayEnv`
    will load a suitable set of target modules for the node you're on again. But any customisations that
    you did for cross-compiling will be lost. 
-    Similary in the LUMI stacks, as the `LUMI` module itself
    is reloaded, it will also reload a partition module. However, that partition module might not be the 
    one that you had loaded but it will be the one that the LUMI module deems the best for the node you're
    on, and you may see some confusing messages that look like an error message but are not.


### Changing how the module list is displayed

<figure markdown style="border: 1px solid #000">
  ![Slide 14](img/LUMI-PEAPQ-EasyBuild-20220427/Dia14.png){ loading=lazy }
</figure>

You may have noticed already that by default you **don't see the directories in which the module
files reside** as is the case on many other clusters. Instead we try to show **labels that tell you
what that group of modules actually is**. And sometimes this also combines modules from multiple
directories that have the same purpose. For instance, in the default view we collapse all modules
from the Cray Programming Environment in two categories, the target modules and other programming
environment modules. But you can **customise this by loading one of the `ModuleLabel` modules**.
One version, the `label` version, is the default view. But we also have `PEhierarchy` which 
still provides descriptive texts but unfolds the whole hierarchy in the Cray Programming 
Environment. And the third style is calle `system` which shows you again the module directories.

We're also very much aware that the default colour view is not good for everybody. So far I don't
know an easy way to provide various colour schemes as one that is OK for people who like a black 
background on their monitor might not be OK for people who prefer a white background. But it is possible
to turn colour off alltogether by loading the `ModuleColour/off` module, and you can always turn it
on again with `ModuleColour/on`.

We also **hide some modules from regular users** because we think they are not useful at all for regular
users or not useful in the context you're in at the moment. For instance, when working in the `LUMI/21.12`
stack we prefer that users use the Cray programming environment modules that come with release 21.12 of that
environment, and cannot guarantee compatibility of other modules with already installed software, so
we hide the other ones from view.
You can still load them if you know they exist but 
you cannot see them with `module available`. It is possible though to still show most if not all of 
them by loading `ModulePowerUser/LUMI`. Use this at your own risk however, we will not help you to make
things work or to use any module that was designed for us to maintain the system.


## EasyBuild to extend the LUMI software stack

### Installing software on HPC systems

<figure markdown style="border: 1px solid #000">
  ![Slide 15](img/LUMI-PEAPQ-EasyBuild-20220427/Dia15.png){ loading=lazy }
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
  ![Slide 16](img/LUMI-PEAPQ-EasyBuild-20220427/Dia16.png){ loading=lazy }
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
    with the MKL math library and also failures some versions of Intel MPI, 
    and you need to be careful selecting compiler options and not use `-xHost`
    or the Intel compiler will simply optimize for a two decades old CPU.

Instead we make our **own EasyBuild build recipes** that we also make available in the 
[LUMI-EasyBuild-contrib GitHub repository](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib).
The EasyBuild configuration done by the EasyBuild-user module will find a copy of that repository
on the system or in your own install directory. The latter is useful if you always want the very
latest, before we deploy it on the system. 
We're also **working on presenting a list of supported software in the documentation**.

### Step 1: Where to install

<figure markdown style="border: 1px solid #000">
  ![Slide 17](img/LUMI-PEAPQ-EasyBuild-20220427/Dia17.png){ loading=lazy }
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
user modules are included in the module search path. You can do this in your `.bash_profile` or
`.bashrc`. 
This variable is not only **used by EasyBuild-user** to know where to install software, but also 
by the `LUMI` - or actually **the `partition` - module to find software** so all users in your project
who want to use the software should set that variable.

Once that environment variable is set, all you need to do to activate EasyBuild is to load
the `LUMI` module, load a partition module if you want a different one from the default, and 
then load the `EasyBuild-config` module. In fact, if you switch to a different `partition` 
or `LUMI` module after loading `EasyBuild-config` EasyBuild will still be correctly reconfigured 
for the new stack and new partition. 
Cross-compilation which is installing software for a different partition than the one you're
working on does not always work since there is so much software around with installation scripts
that don't follow good practices, but when it works it is easy to do on LUMI by simply loading
a different partition module than the one that is auto-loaded by the `LUMI` module.


### Step 2: Install the software.

***Demo moment 2***

<figure markdown style="border: 1px solid #000">
  ![Slide 18](img/LUMI-PEAPQ-EasyBuild-20220427/Dia18.png){ loading=lazy }
</figure>

Let's look at GROMACS as an example. I will not try to do this completely live though as the 
installation takes 15 or 20 minutes.
First we need to figure out for which versions of GROMACS we already have support.
At the moment we have to use `eb -S` or `eb --search` for that. So in our example this is
``` bash
eb --search GROMACS
```
This process is not optimal and will be improved in the future. We are developing a system that
will instead give an overview of available EasyBuild recipes on the documentation web site.

Now let's take the variant `GROMACS-2021.4-cpeCray-21.12-PLUMED-2.8.0-CPU.eb`. 
This is GROMACS 2021.4 with the PLUMED 2.8.0 plugin, build with the Cray compilers
from `LUMI/21.12`, and a build meant for CPU-only systems. The `-CPU` extension is not
always added for CPU-only system, but in case of GROMACS we do expect that GPU builds for
LUMI will become available early on in the deployment of LUMI-G so we've already added
a so-called version suffix to distinguish between CPU and GPU versions.
To install it, we first run 
```bash
eb –r GROMACS-2021.4-cpeCray-21.12-PLUMED-2.8.0-CPU.eb –D
```
The `-D` flag tells EasyBuild to just perform a check for the dependencies that are needed
when installing this package, while the `-r` argument is needed to tell EasyBuild to also 
look for dependencies in a preset search path. The search for dependencies is not automatic
since there are scenarios where this is not desired and it cannot be turned off as easily as
it can be turned on.

Looking at the output we see that EasyBuild will also need to install `PLUMED` for us.
But it will do so automatically when we run
```bash
eb –r GROMACS-2021.4-cpeCray-21.12-PLUMED-2.8.0-CPU.eb
```

This takes too long to wait for, but once it finished the software should be available
and you should be able to see the module in the output of
```bash
module avail
```

***End of demo moment 2***

### Step 2: Install the software - Note

<figure markdown style="border: 1px solid #000">
  ![Slide 19](img/LUMI-PEAPQ-EasyBuild-20220427/Dia19.png){ loading=lazy }
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
  ![Slide 20](img/LUMI-PEAPQ-EasyBuild-20220427/Dia20.png){ loading=lazy }
</figure>

You can also install some EasyBuild recipes that you got from support. For this it is best to
create a subdirectory where you put those files, then go into that directory and run 
something like
```bash
eb -r . my_recipe.eb
```
The dot after the `-r` is very important here as it does tell EasyBuild to also look for 
dependencies in the current directory, the directory where you have put the recipes you got from
support.

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
eb –r . VASP-6.3.0-cpeGNU-21.12.eb
```

### More advanced work (2): Repositories

<figure markdown style="border: 1px solid #000">
  ![Slide 21](img/LUMI-PEAPQ-EasyBuild-20220427/Dia21.png){ loading=lazy }
</figure>

It is also possible to have your own clone of the `LUMI-EasyBuild-contrib` GitHub repository
in your `$EBU_USER_PREFIX` subdirectory if you want the latest and greates before it is in
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
  ![Slide 22](img/LUMI-PEAPQ-EasyBuild-20220427/Dia22.png){ loading=lazy }
</figure>

EasyBuild also takes care of a **high level of reproducibility of installations**.

It will **keep a copy of all the downloaded sources** in the `$EBU_USER_PREFIX/sources`
subdirectory, and use that source file again rather than downloading it again. Of course
in some cases those "sources" could be downloaded tar files with binaries instead
as EasyBuild can install downloaded binaries or relocatable RPMs.
And if you know the structure of those directories, this is also a place where
you could manually put the downloaded installation files for licensed software.

Moreover, EasyBuild also keeps **copies of all installed easconfig files in two locations**.

1.  There is a **copy in `$EBU_USER_PREFIX/ebrepo_files`**. And in fact, EasyBuild will use this version
    first if you try to re-install and did not delete this version first. This is also a policy
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


### EasyBuild training for support team members

<figure markdown style="border: 1px solid #000">
  ![Slide 22](img/LUMI-PEAPQ-EasyBuild-20220427/Dia23.png){ loading=lazy }
</figure>

Since there were a lot of registrations from local support team members, I want to dedicate one slide
to them also.

Pointers to all information about EasyBuild can be found on the EasyBuild web site 
[easybuild.io](https://easybuild.io/). This
page also includes links to training materials, both written and as recordings on YouTube, and the
EasyBuild documentation.

Generic EasyBuild training materials are available on 
[easybuilders.github.io/easybuild-tutorial](https:/easybuilders.github.io/easybuild-tutorial/).
The site also contains a LUST-specific tutorial oriented towards Cray systems.

Lastly we are organising a training for CSC staff also open to other local support organisations
on May 9 and 11, from 12:30 to 15:30 CEST. Notes from that training will likely also become available
on the EasyBuilders training web site, or we will post them via a separate GitHub pages web site or so.
If you want to join, contact [LUMI support](https://lumi-supercomputer.eu/user-support/need-help/generic/).

