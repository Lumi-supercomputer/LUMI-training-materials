# LUMI Software Stacks

*Presenter: Kurt Lust (LUST)*

<!--
<video src="https://462000265.lumidata.eu/4day-20231003/recordings/2_05_LUMI_Software_Stacks.mp4" controls="controls">
</video>
-->

-   [Notes](notes_2_05_LUMI_Software_Stacks.md)
-   [Slides (PDF)](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-2_05_software_stacks.pdf)

<!--
Archive on LUMI:

-   Slides: `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-2_05_software_stacks.pdf`

-   Recording: `/appl/local/training/4day-20231003/recordings/2_05_LUMI_Software_Stacks.mp4`
-->

The information in this talk is also partly covered by the following talks from the 1-day courses:

-   [Modules on LUMI](../1day-20230921/video_03_Modules_on_LUMI.md)
-   [LUMI Software Stacks](../1day-20230921/video_04_LUMI_Software_Stacks.md)


## Q&A

13. `module keyword` was said not to be very practical on LUMI at the moment. In what way its functionality is limited at the moment and are there plans to expand it?

    -   A bug in the Lmod 8.3 version on LUMI is that all extensions are shown in the output of a `module keyword` command while they are irrelevant. The version of Lmod installed on LUMI is something that is outside of LUST responsability. We need to wait an update by Cray.

    -   **KL** That update actually exists and is part of newer distributions of the PE, but it has not yet been installed on LUMI.

14. The speaker mentioned LUMI freezing for a few minutes from time to time. What is the cause?

    -   The two minute freezes are related to a Lustre process getting stuck and the sysadmins suspect that it is related to crashes on nodes. The load on the metadata servers cause severe performance degradation of Lustre, but not complete freezes.

15. Compilation and some post-processing tools are available on the login node, but it's not really clear which jobs can be run on the login node and which should be moved to compute nodes. Are there any guidelines about this?
    - Login nodes are  really meant for compilation and modification to the code and analysis, but not actually running the code. Do you have a concrete example? Using the login nodes to run long scripts consuming a lot of resources, to avoid having to pay for billing units would not be something that is allowed. 
        - Sometimes I process my computed data to extract some results. Scripts are serial and can take around 10 minutes. I would like to run them on login node to get the numbers as soon as I can.
    - That sounds okay. If you could build this into the script that would be good too, but it doesn't sound like a problem. Installing some software probably puts a bigger strain on the system.

16. Do you take requests for [easyconfigs](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib/tree/main/easybuild/easyconfigs) for new software and how long does it typically take to make a new config?

    - Easyconfigs are usually created upon user requests. How long it take us to create a new recipe depends on the complexity of the installation. Most of the time, if we don't have too much on our plate at the time of the request, we provide a recipe in less than 2 days. You might have to wait for a longer period of time for packages that have a lot of dependencies or for packages that do not compile nicely in a Cray environment. It also depend if the softwarte is for CPU or GPU. For CPU softwares, we usually can start from the standard EasyBuild recipes and convert it to cpeGNU, which can be quite fast. For GPU softwares however, we have to start from scratch. 

17. I have encountered troubles in OpenMP thread placement of MPI/OpenMP program on cluster with Intel CPUs. It has EasyBuild system for building. What system can you advice for recompiling everything by myself including compiler, MPI, BLAS, FFT, GSL? Spack, EB? Something else? I have written  bash scripts for compilation, but it is not especially nice way if I try many versions with different compile options. I tried to learn EB, Spack. I miss real simplicity of buildroot like configuring many things in menu. Which of build automation systems should I choose?

    -   That is most likely not a problem with the compilers, EasyBuild or Spack but it may be a problem with the MPI library and is more likely a problem with the resource manager on that cluster. There are subtle differences in the OpeMP environment variables between different compilers (some are standard but every implementation offers some additional ones). It may be that the sysadmins are not aware enough of the importance of binding and have the resource manager configured in a way that it makes it impossible to fully control it.

        Basically the task binding with MPI has to be done by the process starter. One of the reasons to use `srun` on LUMI and not some `mpirun` is that `srun` fully understands the allocation and hence can do a better job of process binding. `mpirun`/`mpiexec` will sometimes internally recognise that `srun` is available and use it, but this may require setting enviornment variables. 
        
        OpenMP binding really only works within the limits set by the CPU affinity mask, and the latter is also set by the resource manager/process starter. So that may also explain problems.
        
        The source code of the tools that we include in `lumi-CPEtools` is publicly available and in fact we use some of those tools also on my home cluster in Antwerp which is mixed AMD and Intel with CentOS instead of SUSE. See the links in the lumi-CPEtools page in the LUMI Software Library for the GitHub repository.
        
    Thank you very much for providing useful hints. Actually I and admins started with OpenMPI through mpiexec .... Now I understand that OpenMPI is the first thing to try to change, as despite good binding maps something screws up with thread binding.

18. You have touched the issue that Lustre reacts too slow on lots of small files. What do you think about filesystem images on lustre like ext4 image or squashfs image?

    -   Some of the tools we provide, like lumi-container-wrapper uses squashfs images to bundle pip and conda installations. This squashfs image is subsequently used, by mounting it with singularity. This improves the situation but is still not optimal. The file is opened and closed only once, so that is as good for the Lustre metadata server as it can be. But those file systems often work with a block size of 4kB so every file access to data in the container will translate into 4kB accesses of the Lustre file system. No problem there, but it will not give you the performance you expect from Lustre. What is not clear to me is how it works with caching mechanisms that all file systems have.

    -   Regarding the Lustre freeze issue, I'm suprised by the response of my colleague as there is, as far as I know, no proven link between these freezes and a lot of small file operations. I have experienced these freezes during maintenace breaks when the system was completely idle and with no user connected.

    -   The complete freezes are very likely not related to the use of lots of small files. They occur when a Lustre process freezes and seem to be related to nodes crashing. However, if you notice slow performance but no freezing, then that seems to be caused by a too high load on the metadata server which would typically be caused by users working in directories with thousands of files (and then it doesn't always matter if they are small or big) or indeed by users working with lots of small files.
    
        -   Thank you very much for the answer. I experienced such freezes on other cluster - Ares in Cracow. Now I am kinda surprized that it may not be connected with I/O or directory traversing.

    - Yes, it might be or I/O but also network related. It has been way worst in the past and a network stack upgrade improved the situation

    - In case of Ares is related with I/O not the network. Some users overburden the Lustre FS there and Lustre unfortunaltely does not have reliable QoS. 

        -   Ok, thanks a lot for the clarification.

     - Note that if a Lustre client crashes or becomes uncommunicative while holding locks it can cause all processes on other clients(nodes) accessing the same resouce (directory) to hang for a significant time until those locks get released.

19. What are the pros and cons of using EasyBuild instead of containers such as lumi-container-wrapper and singularity?

    -   EasBuild will compile most software so that it is exploits the system as much as possible, at least if the compiler options are chosen well (and EasyBuild tries to enforce good ones).
    -   EasBuild software installs directly on the system so you can use all debugger tools etc., that often don't work with containers due to the isolation that containers provide.
    -   But containers on LUMI can solve the problem of software that uses lots of small files and puts such a strain on the metadata servers that other users also suffer.
    -   And Python installations with lots of dependencies can be so complex that even if we could allow it for the metadata, it may still be a problem to develop the EasyBuild recipes. That is also why I would like to be able to use the standard EasyBuild recipes at least for non-GPU software as they have put a lot of effort into recipes for Python packages.


20. How are the PrgEnv-cray and cpeCray (for example) different?

    -   PrgEnv-cray works slightly differently internally in the way it loads particular versions of software. Basically there are `cpe` modules to set the version but that module is extremely buggy. `cpeCray` is a module installed by EasyBuild that EasyBuild can fully understand and that works around the problems of the `cpe` + `PrgEnv-*` modules.

