# Extending containers with virtual environments for faster testing

*Presenter:* Gregor Decristoforo (LUST)

Contents:

-   Using pip venvs to extend existing containers
-   Create a SquashFS file for venv
-   Pros, cons and caveats of this approach


<!--
<video src="https://462000265.lumidata.eu/ai-20241126/recordings/07_VirtualEnvironments.mp4" controls="controls"></video>
-->


## Extra materials

-   [Presentation slides](https://462000265.lumidata.eu/ai-20241126/files/LUMI-ai-20241126-07-Extending_containers.pdf)

-   [Examples](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/07_Extending_containers_with_virtual_environments_for_faster_testing)

-   The [additional training materials mentioned in the "Running containers" page](extra_05_RunningContainers.md#extra-materials)
    are relevant for this presentation also.


## Q&A

1.  Can I somehow figure out that I am doing something wrong and causing a huge file traffic?

    -   Problem is that the Lustre statistics that we get, are not on a per-user or per-job basis, so it is really hard to figure out what is going on, especially on shared nodes.

    -   Some common sense helps a lot though. If you're trying to read 10s or 100s of files per second, you know you're causing trouble if you do so from multiple processes simultaneously. If you notice that your Python job is at times sluggish compared to your PC, the filesystem is the reason. If you profile and you see a lot of time spent at startup and when doing I/O, you may also have a problem. We've had tickets with users complaining that these steps were 10-50 times slower than on their PC, which exactly pointed out that they have an issue with file system access.
       
        One user I know from the support work that I did in Belgium when I was only part-time in LUST, needed to install his software first on the filesystem to check if it worked before he could try to package it in a container, and he just compared the time on `/project` and on `/flash` to quickly realise that the software did indeed put a heavy load on the filesystem and that he could only run small tuning experiments before containerising everything (it was one of those users combining machine learning with JAX and PyTorch with classical simulation, so building the container was way more complicated then just calling `cotainr` as a lot of software needed to be compiled by hand).

2.  I am not quite sure whether I understand conclusion of the last talk. We are not allowed to create venv on LUMI. We can do it within container but only to do tests and then reinstall the whole container? or can I actually just load container, create venv there and do everything with pip install?

    -   A small virtual environment will do no harm, one with 1000s of files could. So make a virtual environment that reuses the packages already installed in the container. One of the techniques in the talk to deal with the remaining files in the virtual environment (the Option 2), is to generate the virtual environment, then pack it in a SquashFS file and then bind that file to the container so that from a filesystem point of view the virtual environment becomes part of the container, which solves filesystem issues.

        It is in fact a technique that we have even automated in some of the [PyTorch modules that we offer for user installation](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/).
        
        And for Option 1, it may still be a good idea to first experiment with a virtual environment on a small problem before updating a container definition for `cotainr`. It might be a good idea though to do that on `/flash`. It looks like our flash filesystem can handle metadata operations a bit better. The reason is likely that even though the metadata servers on both the disk based and flash based filesystems use flash to store the metadata, several metadata operations require the metadata server to also get information from the object servers that store the file, and that information is delivered a lot faster on the flash filesystem than on the disk based filesystems.
        
    -   But there is the issue that a virtual environment will only be valid for the container for which it is created. It may or may not work with other containers, so if you use multiple containers there is some housekeeping to do to make sure that you always activate the right virtual environment.

