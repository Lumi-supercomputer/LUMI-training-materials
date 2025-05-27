# Using the LUMI web interface

*Presenters:* Mats Sjöberg (CSC) and Oskar Taubert (CSC)

Content:

-   Introduction to the Open OnDemand web interface
-   Using PyTorch in JupyterLab on LUMI
-   Limitations of the web-based interactive interface and the CLI interface
  
A video recording will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250527/recordings/02_Webinterface.mp4" controls="controls"></video>
-->


## Extra materials

More materials will become available during and shortly after the course

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-02-Using_LUMI_web_UI.pdf)

-   [Hands-on exercises](E02_Webinterface.md)

-   [Direct link to the LUMI web interface](https://www.lumi.csc.fi/)


## Q&A

1.  How are the latest PyTorch versions updated on this environment and how do you maintain different version for different users ?

    -   We will get to this in one of the later lectures. In general, using containers (*apptainer* or *singularity*) are the way to go here. That way you can decide on the PyTorch version you need. And if you need different PyTorch versions for different projects you can have different containers. We provide base containers with different PyTorch versions. But we will also cover how to build your own containers with conda or venv environments. 

    -   Regarding the *latest* PyTorch version, Lumi is in general a bit behind a bleeding edge system as the system isn't on a rolling release. The underlying system drivers are more stable, this means that ROCm is not the latest version out there and that also means that PyTorch isn't always the latest version. 

    - Currently we can only support PyTorch versions that run on versions of ROCm between and including 5.6 and 6.2. There is an update planned in late summer which will take the ROCm driver to 6.3 or 6.4 so from then on some of the older PyTorch versions will not be useable anymore (as they require a too old ROCm) but some of the newer ones should become useable. The latest container we provide at the moment is with PyTorch 2.6.

    - Different versions of software for different users is explained in our regular intro course, in the presentations on [Modules](https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/M104-Modules/) and on [Software Stacks](https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/M105-SoftwareStacks/). There is a new edition of this course next Monday and Tuesday. Software installation on an HPC system is very different from a workstation and is never done in the default locations. If that is not possible, or if the installation consists of too many small files, containers come in to help.

