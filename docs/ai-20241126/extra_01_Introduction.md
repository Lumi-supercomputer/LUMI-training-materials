# Introduction to LUMI

*Presenter:* Jørn Dietze (LUST)

Content:

-   How LUMI differs from other clusters
-   AMD GPUs instead of NVIDIA
-   Slingshot Interconnect

<!-- 
<video src="https://462000265.lumidata.eu/ai-20241126/recordings/01_Introduction.mp4" controls="controls"></video>
-->


## Extra materials

More materials will become available during and shortly after the course

-   [Presentation slides](https://462000265.lumidata.eu/ai-20241126/files/LUMI-ai-20241126-01-Lumi_intro.pdf)


## Q&A

1.  Why we don't use docker?
  
    -   Docker requires root privileges to run. This is a no-go on a shared infrastructure as it is completely unsafe and could allow you to easily hack into the system and access data from other users. If you want docker, you need to use a cloud infrastructure where you can use docker in a virtual machine as that is the only way to give root privileges safely to a user.

        HPC clusters are primarily built for bare metal access, for users who need the lowest software overhead possible in network access etc. to be able to develop and run extremely scalable applications. 

        In fact, even many other container runtimes and ways to build containers in singularity/AppTainer cannot be used because certain required features are not enabled because of security concerns. E.g., (technical): User namespaces cannot be used on LUMI because there are too often severy security issues with it. Unless all users would agree that LUMI would be taken down for everyone and without prior warning when a security issue arises... 

2.  Does LUMI support DeepSpeed?

    -   Some users have been running DeepSpeed and it is in one of the containers. The [docs in the LUMI software library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/) still lack the newest containers though. As with every AI package on an HPC, some cloud-related features may not work on HPC and vice-versa. Typically there are restrictions on how trainings are started. This is in fact not LUMI-specific, but will be the case on most large HPC systems.

3. What interface/technology AMD uses to enable GPU to GPU interconnect while skipping PCI?

    -   The connections are made with InfinityFabric, sometimes also called xGMI. It is the same technology that they also use to link CPU sockets in a shared memory machine, and the same technology is actually also used to connect the chiplets in a CPU or the two GCDs in a MI250X GPU. Note though that MI300 (which we don't have in LUMI) uses a different technology to link the chiplets (well, it may still be based on InfinityFabric but the connections between chiplets are so different that the speed of the connections is very different and dies appear much more as a single chip).

4. So is it more recommended to use something like one large HDFS instead of a lot of smaller files during training?

    - Yes (if the file format is suitable for your setup/problem setting).

    - There is a talk tomorrow focusing more on this topic

5.  So if I am looking to fine-tune or pre-train from a ~100GB .loom file, should it go in scratch or flash? Flash is only needed if one benchmarks on scratch and it finds it slow?

    -   If your code is I/O bound it probably can make sense to use flash. Otherwise, using scratch is the better option as it is cheaper (flash's billing rate is 10x higher than the billing rate of scratch)

6.  What about uploading data to LUMI.. Is there any "limit"? If I have let say 10TB what is optimal way (time wise and bandthwith wise). (I'm using several rsync now to do it.. My question is about if there is some recommended limit not to overload something :) ).

    -    Your project has a limit or disk quota (and also to the number of files). You can check the quota with `lumi-workspaces`. On all file systems except your home directory, you can get additional volume, but getting additional inodes (number of files and directories) is refused if the reason is to quickly read or write lots of small files.

    -   Uploading large data sets is done best via LUMI-O. I'm not sure how much there will be in this training, but it will be discussed in the upcoming 2-day training. Basically, any protocol that works via a single connection, such as sftp, will be bandwidth-limited by latency: Every now and then the TCP/IP protocol waits to see if all data has arrived well, so the longer the latency, the more time will be spent waiting for confirmations rather than transferring data. The solution is to open multiple TCP/IP streams that each are bandwidth-limited, but the combined bandwidth will be a lot higher. Tools like rclone for object storage do that for you, at least if there are multiple objects to transfer. (They can do it for a single large object also but then a bit more setup is needed.)

        So it would be better to go via LUMI-O then to use multiple rsyncs...

    -   If you get your data from the internet, you can also directly download it to the LUMI (scratch) filesystem using command-line tools like wget, curl, etc.. instead of downloading it to your own computer and then moving it to LUMI. However, the bandwidth that these tools can obtain is limited by what the server from which you download allows and by the latency as these tools make just a single TCP connection. But that is not a LUMI thing, but universal, wherever you download to from such data services.

7.  Is there reference IO bandwidth for the different file storage options?

    -   240 GB/s for LUMI-P, on the order of 2 TB/s on LUMI-F, but these are really meaningless numbers as 

        1.  File storage is shared so the bandwidth is shared,

        2.  The bandwidth you can obtain depends a lot on how you access files. To get the optimal bandwidth, you need large transfers and access the storage in parallel from multiple nodes. One node can never read more than its own network interface allows. And it also depends on how others are accessing the storage. One misbehaving user can kill performance for all other users on that filesystem.
        
        If you get 30-50GB/s on LUMI-P then you are doing very, very well.

8.  Is there going to be some introduction/training later on about the software module? So that we know what's going on when I run something like `module load ...`

    -   This is covered in great detail in the more HPC-oriented LUMI courses, if it becomes relevant during this course then raise the question again.

9.  (a) The computing budget we obtained for LUMI includes storage (used/allocated), such as 226/1000 (22.6%) TB/hours.  What does this storage specifically refer to? Is it the total storage, or does it specifically refer to flash storage? 

    (b) Is there a separate budget application channel for this AI usage, or is it applied together with the normal LUMI computing budget?
   
    -   This storage budget are TB/hours. So for each terabyte you incur a cost per hour for storing it. This is different from your filesystem quota, which limits the maximum amount of TB you can store at the same time.

    -   for b): there is no difference between AI and other usage in terms of computing budget/billing on LUMI

10. Do we normally use /tmp when submitting computing tasks? I didn’t fully understand the explanation on the previous slide. Could you clarify how to use /tmp effectively and how to adjust memory allocation for it?...
 
    -   Most users will be using the shared file systems. I know some users who first load data onto `/tmp` (by uncompressing a tar or zip file) and then load from there as it is very fast for small files. However, it is a RAM disk, so all memory you use as `/tmp`, is not available as CPU-attached RAM.



