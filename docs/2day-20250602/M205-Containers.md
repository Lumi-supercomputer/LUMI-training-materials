# Containers on LUMI-C and LUMI-G

*Presenter: Kurt Lust (LUST)*

Containers are a way on LUMI to deal with the too-many-small-files software
installations on LUMI, e.g., large Python or Conda installations. They are also a 
way to install software that is hard to compile, e.g., because no source code is
available or because there are simply too many dependencies.


## Materials

<!--
Materials will be made available after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20250602/recordings/205-Containers.mp4" controls="controls"></video>

<!--
-   A video recording will follow.
-->

-   [Slides](https://462000265.lumidata.eu/2day-20250602/files/LUMI-2day-20250602-205-Containers.pdf)

-   [Course notes](205-Containers.md)

There are two demos illustrating material from this talk:

-   [Demo 1](Demo1.md): Installing Fooocus on top of an existing container provided by LUST.
    This demo installs additional SUSE packages via the unprivileged proot build process and 
    then also adds a number of Python packages through a virtual environment stored outside 
    the container in a SquashFS file.

-   [Demo2](Demo2.md) shows how the EasyBuild modules for containers can make life easier
    when working with the AI containers provided by LUST (with the help from AMD). 

The videos of the demos are older ones, but the material in the notes was correct at the time of
the course.

Archived materials on LUMI:

-   Slides: `/appl/local/training/2day-20250602/files/LUMI-2day-20250602-205-Containers.pdf`

-   Recording: `/appl/local/training/2day-20250602/recordings/205-Containers.mp4`


## Q&A

1.  For a software that has pytorch and mpi4py as dependencies, the best option then is to use the optimized pytorch container, correct? (one of the older versions with MPI?)

    -   Yes. But you can get relatively new containers. For example: `EasyConfig PyTorch-2.6.0-rocm-6.2.4-python-3.12-singularity-20250326.eb, will provide PyTorch/2.6.0-rocm-6.2.4-python-3.12-singularity-20250326` You can search for `mpi4py` on [the PyTorch page in the LUMI Software Librare](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/).

    -   (KL) The issue with the new containers is that they use a new libfabric which doesn't work well with Cray MPICH so `mpi4py` is no longer included.
