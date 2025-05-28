# Introduction to LUMI

*Presenter:* Jørn Dietze (LUST)

Content:

-   How LUMI differs from other clusters
-   AMD GPUs instead of NVIDIA
-   Slingshot Interconnect

<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20250527/recordings/01_Lumi_Introduction.mp4" controls="controls"></video>

## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-01-Lumi_intro.pdf)


## Q&A

1.  Regarding storage, don't we have even scratch or tmp on compute nodes ?

    -   The compute nodes have tmp storage, the tmp storage resides in memory. So it eats from the CPU-attached RAM for your job. There are no physical disks. Most storage is provided by the different parallel filesystems (see also: https://docs.lumi-supercomputer.eu/storage/) 

    -   There is a scratch, but it is not local. It is on a shared file system (so you see your files on all nodes) which comes with a different performance profile from a local disk. Basically, it is not very good ar working with lots of small files but can be extremely fast, much faster than any local disk, if you work with big files.

        For AI it means that it is important to think about how you store your data. Dumping a dataset as tons of small files is a very bad idea on a supercomputer. There will be more about this in this course, and there is more information in the LUMI AI guide also.

    Is this tmp/ on node cleaned when my job is finished?

    -   Yes.

2. What is the difference between Object storage in Lustre and LUMI-O?

    -   There is [a lecture about this in the regular intro course](https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/M204-ObjectStorage/). 
  
        Lustre is not an object storage system. Object server is just a terminology that is used in Lustre for the servers that store parts of a file,
        that are sometimes called objects.


3.  I have exactly that question with thousands (4000-5000) of small image files (in test, train, valid -folders) for object detection model training. I also have a script that uses Ultralytics YOLO, for training, and ultralytics package is not installed in the LUMI.

    -   You have to think about data formats in which you can store multiple images in a single file. There are plenty of those and the AI guide contains some information. Some of it will also be discussed in the course.
    
    Ah, I get it, I could combine multiple images into one image, and have a script to separate them on runtime?

    -   You don't need to manually merge images, you can use file formats like hdf5 or squashfs that can store multiple images in a single file, see [this chapter in the LUMI AI Guide](https://github.com/Lumi-supercomputer/LUMI-AI-Guide/tree/main/3-file-formats)

        There are also libraries that can read directly from, e.g., zip files. Another example is the [MNIST dataset](https://huggingface.co/datasets/ylecun/mnist) in the version that is shown in the [PyTorch page in the "LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/#distributed-learning-example) that comes as just 4 files: 2 files with labels and 2 files with data,
        and used directly by the training scripts.


4.  I have a 35 gb embedding data. Just one file. But it exceeded the limits. 

    (Some discussion deleted)

    -   You cannot use the web interface to upload such big files to LUMI. 
        If you use the web interface, you first upload to a web server that then uploads to LUMI, 
        and that web interface has finite capacity. You should use proper tools as we discuss in the regular intro course, 
        sections["Getting Access"](https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/M103-Access/) and 
        ["LUMI-O Object Storage"](https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/M204-ObjectStorage/) 
        (As LUMI-O is often the highest performance way of transfering big files, but for 35 GB sftp should be fine)

5.  Is it possible to run Tensorflow based training as well?

    -   There are containers that have TF installed and you can also create your own. PyTorch tends to be better supported. It is not used a lot on LUMI so we have less experience and the containers are not as often updated.
    
    Thank you!
    
    -   You can install Tensorflow via pip. Instead of `pip install tensorflow` you do `pip install tensorflow-rocm`. 
        How to install python packages **properly** will be covered in lecture 6 & 7. 
        You can also look for the tensorflow + ROCm versions in the [TensorFlow on ROCm AMD GitHub](https://github.com/ROCm/tensorflow-upstream/blob/develop-upstream/rocm_docs/tensorflow-rocm-release.md). 
        So you could for example install `tensorflow-rocm=2.14.0.600`. This would use tensorflow 2.14.0 with ROCm 6.0.0.

6.  How are quotas for projects determined? Is there a priority system?

    -   What quotas do you mean and what priority? For storage we use standard quotas, if you have a valid reason you can send a request to LUST to increase the quota within certain limits. You can find the standard limits and the possible extensions in our documentation: https://docs.lumi-supercomputer.eu/storage/#lumi-network-file-system-disk-storage-areas. 
    
    Thank you. I meant for the number of running hours in the cluster. For example, if I submit too many jobs, consuming many computation hours, at what point would I be stopped? How could I see this limit and if it is attached to the project or determined in another way?
    
    -   There are ]some commands on LUMI you can run to check the budget you have available for your projects](https://docs.lumi-supercomputer.eu/runjobs/lumi_env/billing/). This page also explains how the billing is computed. When you run out of billing units, you cannot submit jobs anymore. 
 
    -   For the jobs: There are limits to how many jobs you can submit simultaneously. There is also a fair share mechanism that will lower your priority if you got a lot of CPU time in recent days. And you get a number of compute hours allocated to your project. There might be more in this course, or there is the [Slurm session in our regular intro course for all users](https://lumi-supercomputer.github.io/LUMI-training-materials/2p3day-20250303/M201-Slurm/). And of course in the LUMI documentation.
    
        And it is up to your resource allocator to decide how many compute hours you get (CPU or GPU). Each participating country and EuroHPC have their own system to do that. Each of them got a number of CPU hours, GPU hours and storage billing units to distribute among their users.

