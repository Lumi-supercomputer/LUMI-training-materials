# Extending containers with virtual environments for faster testing

*Presenter:* Gregor Decristoforo (LUST)

<video src="https://462000265.lumidata.eu/ai-20240529/recordings/07_VirtualEnvironments.mp4" controls="controls">
</video>


## Extra materials

-   [Presentation slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-07-Extending_containers.pdf)

-   [Examples](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-202405291/07_Extending_containers_with_virtual_environments_for_faster_testing)

-   The [additional training materials mentioned in the "Running containers" page](extra_05_RunningContainers.md#extra-materials)
    are relevant for this presentation also.


## Q&A

1.  Maybe it will be discusses later, but what would then be a good workflow to develop a package? Build a container with necessary packages, then install (with `-e` option) your under-development package in the venv. Then you could develop on the login node and then test it in the container?

    -   (Christian) Doing editable installs in a read-only container doesn't make much sense. If you need to do something like this, you can/should probably use the venv method, yes. I haven't tried it myself, though, so I don't know if it works or not.


    -   (Kurt) My suggestion would be to actually create another bindmount in the container to the directory where you are doing development work, but indeed use the venv method if it is for Python packages. By using an additional bindmount you can even move your development installation around in your directories without breaking anything in the container. And this definitely works, I've used it already to install software that used PyTorch but could not be simply installed via conda or pip.

        The problem you may have is to install proper development tools in the container as using those on LUMI would be problematic
        as they may not be fully compatible with software installed through conda. If the packages are provided by conda, you can 
        try to build your own container. If these are regular SUSE packages, it is possible to extend the container via
        the "unprivileged proot build process" supported by Singularity CE. It is something I have also done already and 
        it worked for me. There is some discussion in the 
        [course material of the "Containers on LUMI-C and LUMI-G" talk of the Amsterdam course]()
        in the ["Extending the containers" section of the notes](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/09_Containers/#extending-the-containers).
    
