# Introduction to LUMI

*Presenter:* Jørn Dietze and Gregor Decristoforo (LUST)

Content:

-   How LUMI differs from other clusters
-   AMD GPUs instead of NVIDIA
-   Slingshot Interconnect

A video recording will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250204/recordings/01_Lumi_Introduction.mp4" controls="controls"></video>
-->


## Extra materials

More materials will become available during and shortly after the course

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250204/files/LUMI-ai-20250204-01-Lumi_intro.pdf)


## Q&A

1.  What is Slingshot ?

    - Slingshot is the name that HPE Cray gives to the network technology that is used in LUMI. It is based on Ethernet but with some non-standard extras for better performance in an HPC context.b


2.  Is communication between GCDs within the same MI250X GPU faster than between GCDs from different nodes.

    -   Yes, but still too slow. In fact, all links between GCDs in a node run at the same speed, 
        whether they stay in the package or go to a different package, but there are 4 channels 
        between two GCDs in a single package while there are at most 2 between GCDs in different 
        packages and sometimes even no direct path.

        -   There is an [interesting AMD lab note]( https://gpuopen.com/learn/amd-lab-notes/amd-lab-notes-gpu-aware-mpi-readme/) 
            about speed of connection between GCDs in the same node. It is possible to "disable" the protocol 
            that makes the speed the same intra-node, but you get both advantages and disadvantages. 
            It is an interesting read if you want to deepen the topic.

    -   But all links between GCDs on the same node are faster than connecting across different nodes.

        -   You cannot compare those as they have totally different protocols. 
            Inter-node requires message passing or RDMA while intra-node actually supports memory access semantics. 
            The inter-node links do not support all ways of communication that the (x)GMI connections between GCDs support. 
            The interconnect between GCDs uses the same technology as AMD uses to connect CPU sockets in a 2-socket server.

    -   You can see this illustrated on [this page in our documentation](https://docs.lumi-supercomputer.eu/hardware/lumig/)

3.  To avoid the many files issue (for software), would be a good approach to create a docker image locally, and convert them to SIF (in the context of a Julia user)

    -   See later today. For software installations, containers are indeed the solution. We demand that all Python installations are done in containers. For data, you need to look at better ways to store your data set than just a bunch of small files. E.g., HDF5, ..., but even just storing a read-only dataset in a SquashFS file and mount that in the container can already be a solution.

    -   If your data set is fixed and will not change, you could potentially also bake it directly into your container, but that's quite inflexible in case you ever want to change your input data.

    -   Also, not clear from the comments, but it is really the number of processes that matter and not the number of users. E.g., if you run a PyTorch distributed across 100 nodes with 8 PyTorch instances per node (one per GCD), then you really have 800 process almost at the same time hammering the metadata server to open the same set of files and you're not opening, e.g., if you're loading a Python code consisting of1000 files, you're really opening 80000 files from the point of view of the metadata server, 1000 per process. Put the distribution in containers, and from a metadata server point of view you're only opening a single file process, and all the files you open internally in the container are done by the file system in the container and access to the object servers only.


