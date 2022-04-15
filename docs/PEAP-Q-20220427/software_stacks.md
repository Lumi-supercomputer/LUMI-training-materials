# LUMI Software Stacks

In this part of the training, we cover:

-   Software stacks on LUMI
-   Advanced Lmod use to make the best out of the software stacks
-   Creating your customised environment with EasyBuild, the tool that we use to install
    most software.

## The software stacks on LUMI

### Design considerations

LUMI is a rather experimental and also a inhomogeneous machine. It uses a novel interconnect 
which is an extension of Ethernet rather than being based on InfiniBand, and that interconnect
has a different software stack of your typical Mellanox InfiniBand cluster. It also uses a
relatively new GPU architecture, AMD CDNA, with an immature software ecosystem. The GPU nodes
are really GPU-first, with the interconnect cards connected directly to the GPU packages and only
one CPU socket, and another feature which is relatively new: a fully cache-coherent unified memory
space between the CPU and GPUs, though of course very NUMA. This is a feature that has previously
only been seen in some clusters with NVIDIA P100 and V100 GPUs and IBM Power 8 and 9 CPUs used
for some USA pre-exascale systems, and of course in the Apple M1 but then without the NUMA character.
LUMI is also inhomogeneous because some nodes have zen2 processors while the two main compute partitions
have zen3-based CPUS, and the compute GPU nodes have AMD GPUs while the visualisation nodes have
NVIDIA GPUs. Given the novel interconnect and GPU we do expect that both system and application
software will be immature at first and evolve quickly, hence we needed a setup that enables us
to remain very agile, which leads to different compromises compared to a software stack for a more
conventional and mature system as a x86 cluster with NVIDIA GPUs and Mellanox InfiniBand.

Users also come to LUMI from 11 different channels, not counting subchannels as some countries have
multiple organisations managing allocations, and those channels all have different expectations about
what LUMI should be and what kind of users should be served. For our major stakeholder, the EuroHPC JU,
LUMI is a pre-exascale system meant to prepare users and applications to make use of future even large
systems, while some of the LUMI consortium countries see LUMI more as an extension of their tier-1 or
even tier-2 machines.

The central support team of LUMI is also relatively small compared to the nature of LUMI with its
many different partitions and storage services and the expected number of projects and users. 
Support from users coming in via the national channels will rely a lot on efforts from local organisations
also. So we must set up a system so that they can support their users without breaking things on
LUMI, and to work with restricted rights. And in fact, LUST team members also have very limited additional
rights on the machine compared to regular users or support people from the local organisations.
LUST is currently 9 FTE. Compare this to 41 people in the Jülich Supercomputer Centre for software
installation and support only... (I give this number because it was mentioned in a recent talk in an
EasyBuild user meeting.)

The Cray Programming Environment is also a key part of LUMI and the environment for which we get
support from HPE Cray. It is however different from more traditional environments such as a typcial
Intel oneAPI installation of a typical installation build around the GNU Compiler Collection and Open MPI
or MPICH. The programming environment is installed with the operating system rather than through the
user application software stack hence not managed through the tools used for the application software
stack, and it also works differently with its universal compiler wrappers that are typically configured
through modules. 

We also see an increasing need for customised setups. Everybody wants a central stock as long as their
software is in there but not much more as otherwise it is hard to find, and as long as software is 
configured in the way they are used to. And everybody would like LUMI to look as much as possible 
as their home system. But this is of course impossible. Moreover, there are more and more conflicts
between software packages and modules are only a partial solution to this problem. The success of
containers, conda and Python virtual environments is certainly to some extent explained by the 
need for more customised setups and the need for multiple setups as it has become nearly impossible
to combine everything in a single setup due to conflicts between packages and the dependencies they need.

### The LUMI solution

We tried to take all these considerations into account and came up with a solution that may look a
little unconventional to many users.

In principle there should be a high degree of compatibility between releases of the HPE Cray Programming
Environment but we decided not to take the risk and build our software for a specific release of the 
programming environment, which is also a better fit with the typical tools used to manage a scientific 
software stack such as EasyBuild and Spack as they also prefer precise versions for all dependencies and
compilers etc. We also made the stack very easy to extend. So we have many base libraries and some packages
already pre-installed but also provide an easy and very transparant way to install additional packages in
your project space in exactly the same way as we do for the central stack, with the same performance but the
benefit that the installation can be customised more easily to the needs of your project. Not everybody needs
the same configuration of GROMACS or LAMMPS or other big packages, and in fact a one-configuration-that-works-for-everybody
may even be completely impossible due to conflicting options that cannot be used together.

For the module system we could chose between two systems supported by HPE Cray. They support 
Environment Modules with module files based on the TCL scripting language, but only the old version
that is no longer really developed and not the newer versions 4 and 5 developed in France, and Lmod,
a module system based on the LUA scripting language that also support many TCL module files through a
translation layer. We chose to go with Lmod as LUA is an easier and more modern language to work with
and as Lmod is much more powerful than Environment Modules 3.

To manage the software installations we could chose between EasyBuild, which is mostly developed in
Europe and hence a good match with a EuroHPC project as EuroHPC wants to develop a European HPC technology stack
from hardware to application software, and Spack, a package developed in the USA national labs.
We chose to go with EasyBuild as our primary tool for which we also do some development. 
However, as we shall see, our EasyBuild installation is not your typical EasyBuild installation
that you may be acustomed with from clusters at your home institution. It uses toolchains
specifically for the HPE Cray programming environment so recipes need to be adapted. We do offer an
increasing library of Cray-specific installation recipes though.
The whole setup of EasyBuild is done such that you can build on top of the central software stack
and such that your modules appear in your module view without having to add directories by hand
to environment variables etc. You only need to point to the place where you want to install software
for your project as we cannot automatically determine a suitable place. We do offer some help so set up
Spack also but activating Spack for installation is your project directory is not yet automated.


### Software policies

As any site, we also have a number of policies about software installation, and we're still further
developing them as we gain experience in what we can do with the amount of people we have and what we
cannot do.

LUMI uses a bring-your-on-license model except for a selection of tools that are useful to a larger
community. This is partly caused by the distributed user management as we do not even have the necessary
information to determine if a particular user can use a particular license, so we must shift that 
responsibility to people who have that information, which is often the PI of your project.
You also have to take into account that up to 20% of LUMI is reserved for industry use which makes 
negotiations with software vendors rather difficult as they will want to push us onto the industrial
rather than academic pricing as they have no guarantee that we will obey to the academic license
restrictions. And lastly, we don't have an infinite budget. There was a questionaire send out to 
some groups even before the support team was assembled and that contained a number of packages that
by themselves would likely consume our whole software budget for a single package if I look at the 
size of the company that produces the package and the potential size of their industrial market. 
So we'd have to make choices and with any choice for a very specialised package you favour a few 
groups. And there is also a political problem as without doubt the EuroHPC JU would prefer that we
invest in packages that are developed by European companies or at least have large development
teams in Europe.

The LUMI User Support Team tries to help with installations of recent software but porting or bug
correction in software is not our task. As a user, you have to realise that not all Linux or even
supercomputer software will work on LUMI. This holds even more for software that comes only as
a binary. The biggest problems are the GPU and anything that uses distributed memory and requires
high performance from the interconnect. Software that use NVIDIA proprietary programming models and
libraries needs to be ported. Binaries that do only contain NVIDIA code paths, even if the programming
model is supported on AMD GPUs, will not run on LUMI. The final LUMI interconnect requires libfabric
using a specific provider for the NIC used on LUMI, so any software compiled with an MPI library that
requires UCX, or any other distributed memory model build on top of UCX, will not work on LUMI, or at
least not work efficiently as there might be a fallback path to TCP communications. Even intro-node
interprocess communication can already cause problems as there are three different kernel extensions
that provide more efficient interprocess messaging than the standard Linux mechanism. Many clusters
use knem for that but on LUMI xpmem is used. So software that is not build to support xpmem will
also fall back to the default mechanism or fail. Also, the MPI implementation needs to collaborate
with certain modules in our Slurm installation to start correctly and experience has shown that this
can also be a source of trouble as the fallback mechanisms that are often used do not work on LUMI. 
Containers solve none of these problems. There can be more subtle compatibility problems also. 
As has been discussed earlier in the course, LUMI runs SUSE Linux and not Ubuntu which is popular on 
workstations or a Red Hat-derived Linux popular on many clusters. Subtle differences between Linux 
versions can cause compatibility problems that in some cases can be solved with containers. But the 
compute nodes also lack some Linux daemons that may be present on smaller clusters. HPE Cray use an
optimised Linux version called COS or Cray Operating System on the compute nodes. It is optimised to
reduce OS jitter and hence to enhance scalability of applications as that is after all the primary
goal of a pre-exascale machine. But that implies that certain Linux daemons that your software may 
expect to find are not present on the compute nodes. D-bus comes to mind.

Also, the LUNMI user support team is too small to do all software installation which is why we currently
state in our policy that a LUMI user should be capable of installing their software themselves or have
another support channel. We cannot install every single piece of often badly documented research-quality
code that was never meant to be used by people who don't understand the code.

Another soft compatibility problem that I did not yet mention is that software that accesses hundreds
of thousands of small files and abuses the file system as a database rather than using structured
data formats designed to organise data on supercomputers is not welcome on LUMI. For that reason we
also require to containerize conda and Python installations. We do offer a container-based wrapper
that offers a way to install conda packages or to install Python packages with pip on top of 
the Python provided by the `cray-python` module. The link to the documentation of the tool that we call
[lumi-container-wrapper](https://docs.lumi-supercomputer.eu/software/installing/container_wrapper/)
but may by some from CSC also be known as Tykky is in the handout of the slides that you can get
after the course.

### Organisation of the software in software stacks

On LUMI we have several software stacks.

CrayEnv is the software stack for users who only need the Cray Programming Environment but want a more
recent set of build tools etc than the OS provides. We also take care of a few issues that we will discuss
on the next slide that are present right after login on LUMI.

Next we have the stacks called "LUMI". Each one corresponds to a particular release of the HPE Cray
Programming Environment. It is the stack in which we install software using the that programming environment
and mostly EasyBuild. The Cray Programming Environment modules are still used, but they are accessed through
a replacement for the PrgEnv modules that is managed by EasyBuild. We have tuned versions for the 4 types
of hardware in the regular LUMI system: zen2 CPUs in the login nodes and large memory nodes, zen3 for the 
LUMI-C compute nodes, zen 2 combined with NVIDIA GPUs for the visualisation nodes and zen3 + MI250X for
the LUMI-G partition. There is also some support for the early access platform which has zen2 CPUs combined
with MI100 GPUs but we don't pre-install software in there at the moment except for some build tools and
some necessary tools for ROCm as these nodes are not meant to run codes on and as due to installation 
restrictions we cannot yet use the GPU compilers with EasyBuild the way we should do that on the final system.

In the far future we will also look at a stack based on the common EasyBuild toolchains as-is, but we do expect
problems with MPI that will make this difficult to implement, and the common toolchains also do not yet support
the AMD GPU ecosystem, so we make no promises whatsoever about a time frame for this development.


### 3 ways to access the Cray Programming environment on LUMI.

Right after login you have a very bare environment available with the Cray Programming Environment
with the PRgEnv-cray module loaded. It gives you basically what you can expect on a typical Cray system.
There aren't many tools avialable, basically mostly only the tools in the base OS image and some tools that
we are sure will not impact software installed in one of the software stacks.
The set of target modules loaded is the one for the login nodes and not tuned to any particular node type.
As a user you're fully responsible for managing the target modules, reloading them when needed or loading the
appropriate set for the hardware you're using or want to cross-compile for.

The second way to access the Cray Programming Environment is through the CrayEnv software stack. This stack
offers an "enriched" version of the Cray environment. It takes care of the target modules: Loading or reloading
CrayEnv will reload an optimal set of target modules for the node you're on. It also provides some additional 
tools like newer build tools than provided with the OS. They are offered here and not in the bare environment to be
sure that those tools don't create conflicts with software in other stacks. But otherwise the Cray Programming 
Environment works exactly as you'd expect from this course.

The third way to access the Cray Programming Environment is through the LUMI software stacks, where each stack
is based on a particular release of the HPE Cray Programming Environment. We advise against mixing with modules
that came with other versions of the Cray PE, but they remain accessible although they are hidden from the default
view for regular users. It ia also better to not use the PrgEnv modules, but the equivalent LUMI EasyBuild 
toolchains instead as indicated by the following table:

| HPE Cray PE   | LUMI toolchain | What?                                |
|:--------------|:---------------|:-------------------------------------|
| `PrgEnv-cray` | `cpeCray`      | Cray Compiler Environment            |
| `PrgEnv-gnu`  | `cpeGNU`       | GNU C/C++ and Fortran                |
| `PrgEnv-aocc` | `cpeAOCC`      | AMD CPU compilers                    |
| `PrgEnv-amd`  | `cpeAMDy`      | AMD ROCm GPU compilers (LUMI-G only) |

The cpeCray etc modules also load the MPI libraries and Cray LibSci just as the PrgEnv modules do.
This is also the environment in which we install most software, and from the name of the modules you can see which
compilers we used.

To manage the hetergeneity in the hardware, the LUMI software stack uses two levels of modules

First there are the LUMI/21.08 and LUMI/21.12 modules. Each of the LUMI modules loads a particular
version of the LUMI stack.

The second level consists of partition modules. There is partition/L for the login and large memory nodes,
partition/C for the regular compute nodes, partition/EAP for the early access platform and in the future
we will have partition/D for the visualisation nodes and partition/G for the AMD GPU nodes.
There is also a hidden partition/common module in which we install software that is available everywhere, 
but we advise you to be careful to install software in there in your own installs as it is risky to rely on
software in one of the regular partitions, and impossible in our EasyBuild setup.

The LUMI module will automatically load the best partition module for the current hardware whenever it
is loaded or reloaded. So if you want to cross-compile, you can do so by loading a different partition 
module after loading the LUMI module, but you'll have to reload every time you reload the LUMI module.

Hence you should also be very careful in your job scripts. On LUMI the environment from the login nodes
is used when our job starts, so unless you switched to the suitable partition for the compute nodes,
your job will start with the software stack for the login nodes. If in your job script you reload the 
LUMI module it will instead switch to the software stack that corresponds to the type of compute node
you're using and more optimised binaries can be available. If for some reason you'd like to use the
same software on LUMI-C and on the login or large memory nodes and don't want two copies of locally
installed software, you'll have to make sure that after reloading the LUMI module in your job script you
explicitly load the partition/L module.


## Lmod on LUMI





