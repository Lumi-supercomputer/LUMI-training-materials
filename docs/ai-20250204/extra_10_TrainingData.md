# Loading training data on LUMI

*Presenter:* Harvey Richardson (HPE)

<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20250204/recordings/10_TrainingData.mp4" controls="controls"></video>

## Extra materials

<!--
More materials will become available during and shortly after the course
-->\

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250204/files/LUMI-ai-20250204-10-Training_Data_on_LUMI.pdf)

-   Links from the "More Information" slide:

    -   [LUMI-O in the LUMI documentation](https://docs.lumi-supercomputer.eu/storage/lumio/)

    -   [Generic Tutorial on reading large datasets](https://www.kaggle.com/code/rohanrao/tutorial-on-reading-large-datasets)

    -   [Best Practice for Data Formats in Deep Learning (SURF)](https://servicedesk.surf.nl/wiki/display/WIKI/Best+Practice+for+Data+Formats+in+Deep+Learning)

    -   [Ray data loading](https://docs.ray.io/en/latest/train/user-guides/data-loading-preprocessing.html)

    -   [Pytorch Tutorial on pre-defined datasets/dataloaders](https://pytorch.org/tutorials/beginner/basics/data_tutorial.html)

    -   Example of keeping training data in memory: 
        [“Scaling Out Deep Learning Convergence Training on LUMI”, Diana Moise & Samuel Antao](https://linklings.s3.amazonaws.com/organizations/pasc/pasc23/submissions/stype119/jvCyu-msa152s2.pdf)

-   [Training materials from the most recent LUMI introductory training in December 2024](../2day-20241210/index.md)

    -   The ["LUMI-O Object Storage" talk](../2day-20241210/M10-ObjectStorage.md)
        discusses using LUMI-O and the differences with a parallel file system such as Lustre..


## Nice-to-knows

### LUMI-O

Two nice things to know about LUMI-O

-   We actually use it during this course to serve you the slides and the videos. Though it is not meant to be a web server.

-   As the LUMI-O software is done by a different team at CSC and not by HPE, it is often still up when LUMI is down. We cannot give a guarantee, but when a long downtime is announced, in the past LUMI-O was still available almost the whole downtime. So you may still be able to access data on LUMI-O, but not on the Lustre file systems when LUMI is down for maintenance.

But it is not meant for long-time data archiving. Storage on LUMI-O also disappears 90 days after your project ends. For long-term archiving and data publishing you need to use specialised services.

### Auto-cleanup of /scratch and /flash

Clean-up is not yet implemented on LUMI because until now there hasn't been a need to do so as the storage is empty enough.

The limited size of /project is also because CSC wants to avoid that LUMI is used for long-term data storage.

The idea is indeed that data is stored longtime on LUMI-O and transported to /scratch or /flash as needed as the assumption was that the whole dataset is rarely needed at the same time.

Note that asking for more quota doesn't make sense if your project doesn't have the necessary storage billing units.
Storing 20TB for one year on /scratch or /project would cost you 175,200 TB hours, so make sure you have enough storage
billing units. There is enough storage on LUMI that resource allocators can grant decent amounts of storage, but it is
not infinite. LUST cannot grant you storage billing units, that is something you need to negotiate with the instance that granted you your project on LUMI.


## Q&A

1.  Why is the LUMI-O access key only valid for 72 hours (if I recall correctly)? This is a strong cutoff and makes use of it very limited to manual operations, making automation redundant.

    -   It is 168 hours, but it is limited for security reasons. If someone gets hold of your key, they can do anything with your storage until you revoke the key. You can extend the lifetime of a key, but this is indeed a manual process as this is when you need to authenticate and prove that you are a valid LUMI user.
   
    Have you considered bucket level keys like with MinIO?
    
    -   We are not responsible for LUMI-O, CSC is, so nobody here can answer that. However, given the budget to manage the system and to support users is very low, I'm pretty sure they chose to have something that they can do with little administration work and not too much support work. E.g., it is a more limited solution than the object storage solution they have for Finnish users.

        LUMI-O is not meant to be a complete object storage solution for everybody with all possible bells and wistles, but really something that is mostly meant as a system for getting data in and out of LUMI as some of the cloud storage tools perform better on high latency, long distance network connections than sftp or rsync over ssh.
        
    -   That being said, I did suggest once to extend the key lifetime to 192 hours so that you could book a fixed time in your agenda once a week to extend all the keys.

2.  Is the stripe count specific to LUMI? Or could, for example, striping a zipped file 
    (yet deflated) of images with a stripe count equal to #OST potentially be faster than 1000+ files. Assuming also parallel FS

    -   Stripe count is something that depends on how a file is being used. If you don't have multiple parallel reads or writes in a file from different threads or processes, having a higher stripe count will not help you as you will only be talking to a single OST at a time anyway.

    -   And the zip file with 1000+ images is not to save work for the object storage servers, but for the metadata server that cannot handle all those qicl accesses.
   
    But assuming multiple workers accessing the same file? Does not have to be ZIP, any packed data format

    -   Not sure about the tools to access zip files, if they would properly deal with that. But in "traditional" HPC, HDF5 and netCDF are popular formats for such work and they are well supporting parallel access. 

    HDF5 is not efficiently applicable to variable-length datasets :( like untokenized text

4.  Is /tmp on the compute nodes physically on disk or mapped in memory? I guess a 1GB file in /tmp is accounted against my memory allocation. Can you confirm? 

     -   This was answered yesterday. Regular compute nodes are all diskless as disks wear out quickly and cause node failures and on a pre-exascale machine you want your node to be as reliable as possible. Appart from the fact that on shared nodes it would also be problematic to clean the disk properly.

     -   Something to think about: If nodes failures would be independent and one node would have a failure once every three years, then the chance that a parallel job running on 1000 nodes runs for 24 hours without crash, is less than 40%... Just to show you that you need extreme node reliability on a machine as LUMI. I'm not a great fan of Elon Musk, but there is one thing that he says that is all too true for supercomputing: the best part is no part if you want reliability.

     -   And of course it is counted against your memory allocation. Otherwise you could crash other jobs on the node by using all memory.


62. in "#files<#OSTs" what exactly is OSTs? Number of CPUs/GPUs trying to access data or something else?

    -   `#OSTs` refers to the number of actual storage servers in the filesystem. 
        For LUMI on /project, /scratch and the user directories, this is 32. (cf. [LUMI storage documentation](https://docs.lumi-supercomputer.eu/storage/parallel-filesystems/lumip/)). 
        For /flash, there are 72. - Lukas

63. Is GPUDirect storage technology enabled by default on LUMI-F/P/O, or how to enable it ?

    -   Sorry, but LUMI is not an NVIDIA machine so GPUDirect does not apply to LUMI. 
        This is something that NVIDIA needs because they lack some elements that AMD has in their hardware and software stack. GPUDirect basically is extra software to realise things that are default on LUMI. It is basically to transfer data over DMA or RDMA to devices (like the network) without first copying to CPU memory and instead exploit network cards that are close to the GPU (e.g., on the same PCIe switch). AMD does not need extra software for that.

    -   Now specifically for the storage: I checked some GPU Direct documentation and 
        as far as I can see, GPUDirect storage is not compatible with Lustre, so on your NVIDIA cluster it will not work either with data on Lustre. It is meant to create a direct path to storage via DMA or RDMA, and that is not how Lustre works. It is meant to be used with local NVMe storage, or technologies such as NVMe-over-Ethernet, and this is a type of storage that we do not have on LUMI. So the topic is irrelevant for LUMI.
        

