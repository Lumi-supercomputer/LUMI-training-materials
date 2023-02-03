# Exercises 2: Managing software stacks

## Information in the LUMI Software Library  

Explore the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/).

-   Search for information for the package ParaView and quickly read through the page

??? Note "Solution - some remarks"
    [Link to the Paraview documentation](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/ParaView/)

    It is an example of a package for which we have both user-level and some technical information. The page
    will first show some license information, then the actual user information which in case of this package
    is very detailed and long. But it is also a somewhat complicated package to use. It will become easier
    when LUMI evolves a bit further, but there will always be some pain. Next comes the more technical
    part: Links to the EasyBuild recipe and some information about how we build the package.

    We currently only provide ParaView in the cpeGNU toolchain. This is because it has a lot of dependencies
    that are not trivial to compile and to port to the other compilers on the system, and EasyBuild is 
    strict about mixing compilers basically because it can cause a lot of problems, e.g., due to conflicts
    between OpenMP runtimes.


## Installing a simple application with EasyBuild

TODO!