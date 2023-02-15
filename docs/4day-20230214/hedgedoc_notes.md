# Notes from the HedgeDoc page

These are the notes from the LUMI training,
1114-17.02.2023, 9:00--17:30 (CET) on Zoom.

## Day 1


### Other questions regarding organisation or LUMI in general

1. I managed to log onto Lumi, but after a few minutes everything "freezes" and I have to use a different terminal to log in again: is it normal? That already happened several times since this morning, even using different login nodes).
    - It depends. If it freezes forever than it may be your terminal application or unstable connection. Shorter freezes that can still last 30 seconds or more are currently unfortunately a common problem on LUMI and caused by file system issues for which the technicians still haven't found a proper solution. There's only two of the four login nodes operating at the moment I think (one down for repair and one crashed yesterday evening and is not up again yet, at least not when I checked half an hour ago) the load on the login nodes is also a bit higher than usual.
        - uan02 seems to work a bit better

3. Will we find material in the /scratch/project_465000388 folder?
    - The location of the files will be posted on here and later appear in https://lumi-supercomputer.github.io/LUMI-training-materials/4day-20230214/schedule/

4. Is LUMI up? I am not able to connect at all.
     - One of the login nodes has crashed but is unfortunately still in lumi.csc.fi. Try lumi-uan01.csc.fi or lumi-uan02.csc.fi.

5. Is LUMI planning to introduce MFA at some point in the near future?
    -   No such plans for ssh so far, it is already complicated enough and we already have enough "connot log on tickets"... But identity providers may require it independently of LUMI when you log in to MyAccessID.

6. I read about a Lumi partition for "visualization", with Nvidia GPUs, is that meant for instance to use Jupyter notebooks?
    -   That service will be offered later via Open OnDemand. No date set yet, but hopefully before the summer. The nodes have only just become available and still need to be set up. Be aware though that you have to use Jupyter in a proper way or other people can break into your account via Jupyter, and that it is not meant for large amounts of interactive work, but to offer an interface to prepare batch jobs that you can then launch to the cluster. LUMI-G is the most important part of the LUMI investment so it is only normal that getting that partition working properly has the highest priority.
        -   That makes perfect sense
        -   Looking forward to it


### Introduction to HPE Cray Hardware and Programming Environment

11. Once a job starts on a particular node, can we get direct access to this node (I mean while the job is running, can we interact with it, for monitoring purposes for example)?
    -   https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/interactive/
    -   See the sessions on Slurm. Currently only with `srun`, not with `ssh`, as `srun` is the only command that can guarantee your session would end up in the CPU sets of your job.


12. Why was LUSTRE chosen as the FileSystem? What others were considered?
    -   Almost all really big clusters run Lustre. Spectrum Scale is very expensive and BeeGFS probably doesn't have the maturity for such a cluster. And it is actually not a choice of CSC but a choice made by vendors when answering the tender. HPE Cray only offers Lustre on clusters the size of LUMI, with their own storage system which is actually a beautiful design.
    -   There is an ongoing discussion in the supercomputing community whether the whole concept of a global parallel file system will work in the future. There might be a scale, when it simply does not work any longer.
    -   I agree. And it is part of the reason why the main parallel file system is split in four. But there is currently no other affordable and sufficiently scalable technology that can also run on affordable hardware. I know a flash based technology that claims to scale better, but just the hardware cost would be 10 times the hardware cost of the current main storage. There is a reason why we bill storage on the flash file system at ten times the rate of the disk based storage, as that is also the price difference of the system. And HPE is working on local buffers that are rumoured to be used in El Capitan, but even that is still a system that integrates with Lustre. Google for "Rabbit storage HPE" or something like that.

13. Can you use MPI MPMD to run one program on LUMI-C and another on LUMI-G including communication between the two programs?
    -   Yes, it is possible, but not so well tested yet. We are interested in your experiences if you try this!
        There is a known problem with the scheduler if you do this across partitions though. In trying to make life easier for "basic" users a decision was taken that makes MPMD more difficult. So the LUMI-C + LUMI-G scenario is currently difficult basically because those jobs have difficulties getting scheduled.
        -    That's too bad. Are there plans to improve it?
    -   If you can convince the sysadmins and technical responsible of the project... It would mean that every user has to change the way they work with LUMI so I'm afraid it is rather unlikely and will require a lot of discussion. I'm in favour though as this is also the model EuroHPC promotes via the DEEP series of projects.
        -   Indeed and it is one of the advantages of having two or more separate partitions.
    -   If you look at the EuroHPC supercomputers, they are all designed with different specialised partitions. The problem is probably that a select group of researchers and compute centres directly involved in the projects that explored this design are very aware of this but many other centres or in the case of LUMI also other groups involved in the decision process on scheduler policies are not enough aware of this way of designing applications. We do see it used by climate scientists already with codes where simulation, I/O and in-situ visualisation are collaborating but different programs, but I'm only aware of one project which asked this for LUMI-C and LUMI-G so my answer is based on what the technical responsible of the LUMI project answered about the problems that can be expected.
        -   Ok. Thanks alot for the answers. I will try it in the near future so perhaps you will see another request soon :) In my case it is for multiscale molecular dynamics simulations (computational chemistry).
    -   I've added the request to the items to be discussed with sysadmins and technical responsibles of the project.
        -   Thanks!

14. Is there any difference between Trento and Milan that the user should care about?
    - The only difference I know is the link to the GPUs. From the ISA point-of-view they are the same.
    - The main difference seems to be in the I/O die as now all 128 lanes coming out of the chip support xGNI/Infinity Fabric rather than only 64 of them while the other 64 only supported PCIe. I wouldn't expect much more changes as this is a really low production part, only used in HPE Cray systems with MI250x.

15. Is it possible to use RStudio Server (for interactive programming with R) on LUMI (probably as a singularity container)?
    -   Singularity is installed, so if you have a container, it should run.
    -   It might also come in Open OnDemand, a service that is still under development, but in that case it might be more to simply prepare data for a job that would then be launched or to postprocess data. 

16. When will be the recordings available?
    -   Some days after the course. We don't have a pipeline yet to upload them immediately after the training.
    -   It takes some postprocessing and this requires time. We are all busy with the course so this is basically evening work and work for after the course. The place where they are stored will be announced in https://lumi-supercomputer.github.io/LUMI-training-materials/4day-20230214/schedule/

17. It seems that the On Demand service will provide things like Rstudio, Jupyter, etc. but most users do not need the "basic" Rstudio or Jupyter but a lot of various packages with them: how will that be managed?
    -   Not clear as we don't have the personpower to install everything for everybody so we focus on the main components that have a lot of users. I guess local support teams will have to develop containers that we can then fit in the setup. 
        -   Will this On Demand service allow users to run their own containers with all they need inside? (because nobody really uses bare Jupyter or Rstudio, do they?)
    -   We cannot answer these questions yet as the service is not being set up by us but offered by one of the LUMI partners (in this case CSC) who will do the main setup.  

18. What is the typical daily KWh of LUMI?
    -   It has rarely run at full load I think but from what I remember its design power is around 6 MW.

19. Is there a way for users to get accurate figures about the actual electrical power consumption of particular jobs, on CPUs
    -   Not at the moment and I doubt this will appear soon. It is also largely impossible as measurements are on the node level so it doesn't make sense for shared nodes. And on exclusive nodes you only get data for the node as a whole, so if you use only one core you'd likely still see 80W or 100W basically because of all the power consumed by the I/O die and network interface, even wehn idle.
        -   even at that level electrical consumption information would be useful, to compare several simulations, etc.
    -   I don't know what your experiences are with it, but I have used it on one PRACE cluster and the results were totally worthless as a comparison as there was too much background power consumption. So I don't think this has a high level of priority for LUMI. Profiling an application and getting an idea of how well it uses the cache hierarhcy and how much bandwidth it requires to memory would be a much better comparison. But unfortunately even that is limited on LUMI at the moment I believe. Hardware counter monitoring by users had to be turned off due to security problems in the Linux kernel.
       -   I was thinking about comparisons between a single run on Lumi using thousands of CPUs vs. a similar run on a smaller machine with less CPUs during a longer time
    -   I hope you realise how much power is consumed by, e.g., the network? Every switch blade in LUMI actually has a power consumption of up to 250W (and is therefore also water cooled), about as much as a processor socket, so any measurement would still have a very large error margin. And in fact, the answer is obvious. The run wil less CPUs on a smaller cluster will always consume less assuming the cluster has a similar design with respect to efficiency, as with more CPUs for the same problem you always loose parallel efficiency and as the bigger the network becomes the more power you consume. The latter is also nicely shown in the Green500 list, You'll see there bunches of similar machines together with the smaller one always on top since the network power is less. Which is whey the Frontier TDS (which is not Frontier but just its test system) is in that list ahead of Adastra, Frontier itself and LUMI even though these are all systems with the same design. I guess the reason why Frontier is above LUMI in that list is probably because they seemed to have access to a different version of some software for their Top500 run as they also get better scalability than LUMI despite using the same node and network design.


20. Is see that there are plans for a Container Orchestration Platform - LUMI-K. What will be the purpose of this partition?

    -   It will likely never appear due to lack of personpower to implement the service. The idea was to have a platform for microservices (the Galaxy's etc. of this world)

21. What is the average waiting time until a SLURM job get submitted to LUMI [I understand this may vary depeding on the requested RAM/time/etc, but I mean is it a matter of hours or days...]? How the priority of jobs is determined?
    -   Generally speaking, LUMI, like many HPC clusters, is optimized for throughput and not short waiting times. It is not really meant for "interactive" use like this. That being said, there are special queues for short interactive jobs and debugging, where the waiting time is short, but you cannot run large jobs there.
    -   We don't know ourselves what goes in the priority system. Currently the waiting time is often very low but that will change when LUMI becomes used a lot more.
    -   The maximum walltime in the standard queue is 2 days, meaning that if your job has top priority (for example, if you have run very little in your project), it will start within 2 days. It will often be a lot faster than that.
        -   Is it possible to have walltime more than 2 days for specific jobs expected to need more time?
            -   Unfortunately not. You have to use so-called "checkpointing", i.e. saving intermediate results to disk, so that your job can be restarted. Even if you have a lot of data in RAM, this should be possible to do using e.g. flash file system. Also given the general instability seen on LUMI now, it is not advisble to try to run very long jobs, hardware may break... This is not necessarily a "fault" in the LUMI design, as clusters grow larger, with many components, some nodes in your jobs will eventually fail if you run e.g. a 1000-node job.
            -   LUMI is meant for scalable applications. Also on big clusters you can expect a lot of failures so it is not wise to have long running jobs that you cannot restart. Longer jobs also make maintenance difficult. And they lead to monopolisation of resources by a single user.
        -   is it possible to request an extension for already running job, if it is expected to be finished in longer time?
            -   No.

22. Is it possible to provide some hints on the role of containers and its possible role in LUMI ?
    -   We will discuss containers tomorrow. But we expect more and more workloads to use containers. But be aware that containers need to be optimized/adapted to run efficiently (or at all) on LUMI. Usually, MPI is the problem.

23. When will GCC 12 become available on LUMI?
    -   In a future version of the Cray programming environment. We do not know the exact date yet. Which special feature of GCC 12 do you need?
        -   We need it just because it makes the installation of our software dependencies, especially ExaTensor, much easier. We have recently HIPified this but it's not easy to tune for the new supercomputer https://github.com/ORNL-QCI/ExaTENSOR (distributed tensor library)
    -   There is a chance that the CPE 23.02 will be installed during the next maintenance period as it contains some patches that we really need in other compilers also, and that one contains 12.2. The next maintenance period is currently expected in March but may need to shift if the software contained in it turns out to be too immature.

25. Which visualization software will be available on the nvidia-visualization nodes? ParaView? VisIT? COVISE? VISTLE?
    -   Partly based on user demand and partly based on what other support organisations also contribute as we are too small a team to do everything for everybody. The whole LUMI project is set up with the idea that all individual countries also contribute to support. More info about that in a presentation tomorrow afternoon. Just remember the visualisation team at HLRS is as big as the whole LUMI User Support Team so we cannot do miracles. We already have a ParaVeiwe server build recipe with software rendering so I guess you can expect that one to be adapted.

26. Looking at the software list, is distributed computing/ shared computing supported/ have been tested? https://en.wikipedia.org/wiki/Folding%40home
    -   It would normally not make sense to use LUMI for workloads which could run in a distributed setup, like e.g. Folding at Home. The whole point with a supercomputer system like LUMI is to have a very fast network that connects the different servers in the system.
    -   LUMI is in the first place a capability computing system, build to run jobs that require lots of compute power with very low latency and very high bandwidth between the processing elements to be able to scale applications. Using it for stuff that could run on simple servers like Folding@Home that can do with much cheaper hardware is a waste of money.

27. Regarding Python: What do I have to consider to run Python code in an optimised way? We have heard about cray-python before.
    -   See tomorrow, and some other presentations that may mention cray-python which is really mostly a normal Python with some pre-installed packages carefully linked to optimised math libraries from Cray. The bigger problem is the way Python uses the file system but that will be discussed tomorrow afternoon.
    -   Please note that we hope to include more content related to Python in future (HPE) presentations.

28. On Lumi-G is there Tensorflow and Pytorch available?
    -   Not preinstalled as there are really too many combinations with other Python packages that users may want and as due to the setup of LUMI there is currently even only some GPU software that we can install properly but you can use containers or download wheels yourself and there is actually info on how to run it in the docs.
    -   Again, available software is discussed in its own presentation tomorrow afternoon.
    -   TF and PyTorch are available in the CSC local software collection https://docs.lumi-supercomputer.eu/software/local/csc/ (*not* maintained/supported by LUST)
    
29. Which ROCm version is the "most" compatible with what is on Lumi-G?
     -   The only ones that we can truly support are the ones that come with the Cray PE (so not the 5.2.5 and 5.3.3). HPE Cray tested the version of the software that is on LUMI with ROCm 5.0, 5.1 and 5.2. The driver should be recent enough to run 5.3.x but no guarantee that it will work together with, e.g., Cray MPICH (though it seems to work in the testing we have done so far but that can never be exhaustive)
    

30. Why for some modules (e.g. python) there are several options with the same version number (3.9.12-gcc-n7, 3.9.12-gcc-v4, etc.). Are there any differences? How could we tell?
    -   The modules with the "funny names" in the end "-n7", "-v4" are generated by Spack. These are shortened hash codes identifying the version. You will normally not see them unless you load the Spack module. You will have to check the complete Spack "spec" of the module to determine exactly how they were built. You can use the command `spack find -lv python`, for example.
    - And for those installed through EasyBuild (which have things like cpeGNU-22.08 etc. in their name): see tomorrow afternoon.
        - I checked and they are exactly the same :/.

31. Nob question: I'm confused on what is PrgEnv and modules such as PerfTools. What is the difference between them?
    - PrgEnv sets modules for a given env (i.e. compiler base: gnu, amd, aocc, cray). This is the entry point of the Programming Environment (PE). Given that, all other modules will be set to that PE. Therefore, you can have PrgEnv-cray and then perftools module will be set for the cray environment. We discuss more on the next lectures (and hands-on).
    - There are separate presentations on all that is in perftools coming over the next days.

32. Follow up question: I'm interested in working with AMD developement tools. How do I set my PrgEnv to use the AMD compilers and compatible libs?
    -   We will discuss that in the Compiler session. But yes, you can use PrgEnv-amd for that (if you want GPU support) or PrgEnv-aocc (CPU support only). Just do `module swap PrgEnv-cray PrgEnv-amd`. More on the next lectures.
    -   KL: No need for `module swap` on LUMI as Lmod is configured with auto-swap. So `module load PrgEnv-amd` would also do.

34. What is the minimal environment I have to load to run a singularity container on Lumi-G (with GPUs mainly)?
    -   https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/container-jobs/ 
    -   Depends on what part of the environment is already in the container...
        -   Assuming it is an "official" rocm-tensorflow image (so with the drivers, python, etc), which Lumi modules do I need to load?
        -   We only have a longer description for PyTorch, right now: https://docs.lumi-supercomputer.eu/software/packages/pytorch/
    -   Very likely none at all as you then only need singularity which is installed in the OS. Unless you need the RCCL plugin for better communication. It should not be that different for Tensorflow as it is for PyTorch.

35. Is the environment firewall set as DENY for all outgoing (internet) TCP. i guess reverse proxy is not recommended
    ```
    ping  google.com
    PING google.com (142.250.179.174) 56(84) bytes of data 
    ``` 
    ..hangs

    -   Internet access from the compute nodes should be enabled soon if not enabled yet. Some nodes might still need a reboot for that.
    -   Ping is never a good test as that is blocked on many systems nowadays.


### First steps for running on Cray EX Hardware

36. Is that possible to change cpu numbers per task in one slurm script to optimize the CPU utilization?
    -   You mean different number of CPUs for each task, e.g. first task 2 cores, second task 8 cpus? 
        -   Yes, exactly, and these tasks are running in order
    -   You can request the total number of tasks and then start the individual programs with `srun -n N`

37. When I execute `sinfo`, I get almost 40 lines of output. For example, I see 20 lines that start with `standard-g`. What is the meaning of that?
    -   use `sinfo -s` or pipe it through `less` or `head`
    -   `sinfo` reports a line for each status of the nodes, e.g. standard-g for drained nodes, idle, resv... (check the 5th column). `man sinfo` for more details.

38. Is it possible to pass arguments to #SBATCH parameters in the jobscript?(not possible with PBS e.g.)
    -   I am not sure that I understand what you mean, but if it is what I think the answer is no. But instead of using #SBATCH lines you can also pass those settings via environment variables or via command line parameters. Typing `man sbatch` may bring you quickly to the manual page of `sbatch` if you need more information (for me it is the first hit but that is probably because I've used it soo often). 
        -   environment variables would work fine I guess, thanks

39. Sometimes `srun` knows what you asked for (#SBATCH) and then it is enough to just run `srun` without, e.g., the `-n` option. Is that not the case on LUMI?
    -   It is the case on LUMI also. 
    -   There are some defaults but it is always better to be explicit in your job script.

40. Sometimes I need to download large satellite images (~200 GB), it only use one CPU in login node, however, considering the I/O issues recently, should I move downloading in compute node or can I continue in login node?

    -   The I/O problem to the outside world was a defective cable and has been repaired. 
    -   It might be better to chose for a push strategy to move data onto LUMI rather than a pull strategy from LUMI. Soon there will be the object file system also which will likely be the prefered way to use as an intermediate for large files.
    -   Given the slow speeds of single stream downloads/uploads from and to LUMI doing this in a compute job seems like a waste of billing units and it won't help with the reliability problem.

41. is --gres per node or total number of GPUs?
    -   per each node

42. I think it was mentioned but I didn't catch if all jobs get exclusive node access, i.e., `--exclusive`? Ok, it was just answered. Since it is not exclusive by default, I guess one should also specify memory?
    -   It depends on the partition, see https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/partitions/

43. Is it possible to see the std/err output of the running batch job?
    -   each job will dump a file for stdout and a file for stderr. Just answered in the presentation.
        -   But I mean when job is still running
    - Yes. There is some buffering so output is not always immediate but it is not stored elsewhere first and only copied to your account at the end of the job as on some other systems.
        -   perfect, thanks
        -   Is it possible to define the size of that buffer, to minimise the time it takes for the contents of the stdout/stderr files to be updated?
    - Yes, there is an option to activate unbuffered output with srun. `srun --unbuffered ..`. But this in not adviced as it increases the load on the file system if your program does lots of small writes.
        -   OK, thank you.

#### Exercise setup 

!!! info
    Copy the exercises to your home or project folder  `cp /project/project_465000388/exercises/HPE/ProgrammingModels.tar $HOME`
    Unpack it with `tar xf ProgrammingModels.tar` and read the `README` file or better transfer the pdf to your local machine with `scp` (run it from your local machine).
    To set the necessary environment variables, source `lumi_c.sh` with  `source /project/project_465000388/exercises/HPE/lumi_c.sh` (or `lumi_g.sh` equivalent for GPU nodes)

50. Should we copy the exercise to the scratch directory?
    -   I'd suggest copying to your home directory, and if you would use the scratch of project_465000388 then keep in mind that there are many people in that project so create a directory with your login name. But doing this in you home directory will give you more privacy.


52. Is there a scratch area ? Or should run in home ? (bit slow at times)

    -   scratch, project and home are really on the same four file systems so there is no speed difference between them, What differs is the policy: Number of files allowed, maximum capacity allowed, how long does data remain before it is cleaned automatically, ... Yes, we know we have file system problems and that sometimes the file systems are slow and we do not yet know to which extent this is caused by hardware problems that are not yet discovered, by software problems (for example with VASP or simply in the file system software) or simply by users abusing the file systems and causing a slowdown for everybody. It is very likely that there is more than one factor that plays a role.

53. I still failed to get my account of my new csc account (I had an old csc account). When I applied it via MyAccessID, it prompted that "The level of assurance provided by your home organization for you does not meet the required level when logging in to the service. From March 1, 2023, you will not be able to access the service."
    -   Just ignore that. It is just a warning about future changes in the background.
    -   So what I need is just to fill in the registration? It needs the project number 465000388 and project manager email, what should I fill in for the project manager email?
    -   I link MyAccessID with my csc account now, but the project 4659000388 is not shown on the list of projects.

54. sbatch: error: Batch job submission failed: Requested node configuration is not available
    from sbatch pi.slurm
    -   Have you run `source lumi_c.sh`?
    -   no, sorry, did lumi_g
    -   Is there a job script for lumi_g trial ? 
        -   In the next lectures, but yes, you can use one of the GPU examples or adjust the existing job launcher (this is pi_acc.slurm)
        -   okay, but for now lumi_c is intended for ALL scripts ( without adjusting anything) ? Then I do that.
        -   but also with source lumi_c.sh + make clean + make and sbatch pi.slurm same error for me
    -   yes, standard works; thanks
    -   I have got the same error, although I sourced lumi_c. Do I need to fill something into the job account area within the script?
        -   Could you check you have the right partition in the file? I've changed the scripts, so you maybe using an old version?
        -   May I ask you, what you entered for these options? For SBATCH -p I am not sure what to fill in. 
            -   `standard` or `standard-g`. Please check the lumi_g.sh and lumi_c.sh for the updated version.
        -   Thank you! That helped me! I am new in this area, so it is still a bit confusing, but now I get a clue.

55. How to compile pi_hip (in C)? Tried make clean & source lumi_g.sh & make but that fails
    -   Use source ../setup_modules/setup_LUMI-G.sh (also change in job submission script) and check loaded modules:
        ```
          1) libfabric/1.15.0.0       4) xpmem/2.4.4-2.3_9.1__gff0e1d9.shasta   7) cray-dsmml/0.2.2       10) PrgEnv-cray/8.3.3      13) init-lumi/0.1           (S)  16) rocm/5.0.2
          2) craype-network-ofi       5) cce/14.0.2                             8) cray-mpich/8.1.18      11) ModuleLabel/label (S)  14) craype-x86-trento
          3) perftools-base/22.06.0   6) craype/2.7.17                          9) cray-libsci/22.08.1.1  12) lumi-tools/23.01  (S)  15) craype-accel-amd-gfx90a
        ```


57. I managed to Unpack it with `tar xf ProgrammingModels.tar`, but where are lumi_g.sh and lumi_c.sh?
    -   It is in the main directory (`/projappl/project_465000388/exercises/HPE/`) since it is common to all exercises.
    -   So, the instructions to do the excercises are in the PDF file?
    -   yes and README too

58. pi_hip with 8 GPUs takes about 2.3s whereas it is faster with only 8 MPI ranks (and marginally slower with 2 MPIs), is it normal? I expected the GPU version to be much faster than the CPU...
    -   the example is not really using multiple gpus... BTW, it is not using MPI...
    -   First, yes it is using one GPU, secondly some of these examples are really just there so you can see what that example looks like in the programming model chosen. The HIP example in a way is an outlier because it needs a reduction ( add up all the counts) and I want the example to do everything on the GPU, it is doing this by a simple method (atomic addition). If we cared about performance we would do that in another way but it would really complicate the example. If you run the HIP example on 8 tasks it will run the single-GPU example eight times.  I have not yet created an MPI/HIP version.



### Overview of compilers and Parallel Programming Models

62. Are there any SYCL implementation available on LUMI? For example hipSYCL with HIP backend.

    -   Not installed by default and without any guarantee that they work in all cases, but we do have a build recipe for hipSYCL (which actually renamed to Open SYCL a couple of days ago) and someone has also succeeded in building the open-sourced version of DPC++. No guarantee though that it works for all cases or always plays nice with Cray MPICH. See tomorrow afternoon about how to expand the LUMI software stack. https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib/tree/main/easybuild/easyconfigs/h/hipSYCL or even better https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/h/hipSYCL/
    -   I'd wish though that HPE Cray and AMD would offer proper support as this is a good model to be able to target all three main HPC GPU families and even more exotic hardware.
    -   (Harvey) We have built SYCL at another site but I'm not sure of the status. As for officially supporting it, I don't know of any plans but you could equally argue that Raja or Kokkos could be supported as an alternative higher-level framework.

64. Apologies if this was explained while I was away, are there any plans / roadmap for moving the Cray Fortran compiler to be LLVM-based, or is it expected it will remain based on Cray's proprietary backend? 
    -   No. The Fortran compiler has always been extremely good, The C++ compiler specifically was not keeping up with standards and had very long compilation times and these were some of the drivers to make the change there. I think open source Fortran is also a moving target, the new Flang (f18) seems a work in progres.
        -   (user comment) OK, thank you (Intel also moved their C compiler backend to LLVM and they seem to be now following the same path with their Fortran compiler, so we were wondering if Cray's strategy would be the same; really happy to hear it's not, since this gives us access to a wider range of implementations).
    -   (Harvey) Best I don't comment on Intel. I'm interested to see how the classic Intel compilers and the OneAPI ones develop, particularly for Fortran.
    -   (Kurt) I keep wondering what Intel is actually doing with Fortran. Are they indeed fully moving to a new flang (and contributing to it) or did they really just port their frontend to an LLVM backend?
        -   [I think they re-built their frontend on top of an LLVM backend](https://community.intel.com/t5/Blogs/Tech-Innovation/Tools/The-Next-Chapter-for-the-Intel-Fortran-Compiler/post/1439297) (sorry for the off-topic)

65. Is (or will) HIP also be compatible with Intel Habana GPUs?
    -   I have no idea, but I assume hipSYCL can work for that...
    -   (Kurt) Habana is not a GPU but an AI accelerator with a different architecture. Or do you mean the XE line (Ponte Vecchio, Rialto Bridge, Falcon Shores)?
       
        But even there the answer is no. AMD will not do it. The way they also can support CUDA is because it is only an API translation. And Intel will not do it either, their preferred programming models for XE are Data Parallel C++ which is their SYCL implementation and OpenMP offload.
        
        - (User comment) Project to enable HIP applications to run on Intel hardware exists. See [here](https://www.alcf.anl.gov/news/argonne-s-brice-videau-prepares-hip-applications-aurora) as well as this [presentation](https://www.oneapi.io/event-sessions/hip-on-aurora-bringing-hip-to-oneapi-isc-2022/). No idea if it will run on a specialized hardware like the Habana AI processors.
    
    - (Kurt) I really doubt HIP can do anything on Habana when I check their web site. I suspect it is more of a matrix processor and not a vector processing and they even say very little about programming on their web site. It doesn't really look like hardware that fits the CUDA/HIP programming model. I hadn't heard about the ANL project to port HIP yet. The only one I had seen already was a project that did something similar as HIP but was basically a one person effort that had died already.


#### Exercise

!!! Info
    1.  Copy the exercises to your home or project folder  `cp /project/project_465000388/exercises/HPE/ProgrammingModels.tar $HOME`
    2.  Unpack it with `tar xf ProgrammingModels.tar` and read the `README` file or the pdf at `doc/ProgrammingModelExamples.pdf`.
    3.  To set the necessary environment variables, source `lumi_c.sh` with  `source /project/project_465000388/exercises/HPE/lumi_c.sh` (or `lumi_g.sh` equivalent for GPU nodes)
    4.  Try out different compilers (by switching compiler environments, e.g. `module swap PrgEnv-gnu`) either manually e.g. `cc C/pi_mpi.c` or use `make Makefile.allcompilers`


66. is there a simple command to restore the default module configuration? 
    -   People more expert than me can give better advice here: I do `module purge` and then `module load PrgEnv-cray`
    -   But note that that does not load the target modules! We'll see a LUMI-specific way tomorrow afternoon.
    -   If you have loaded the GPU modules then the longhand way is:
        ```
        module unload rocm
        module unload craype-accel-amd-gfx90a
        module swap craype-x86-trento craype-x86-rome
        ```
67.   How does the compilation of the acceleration example work? I have been trying some modules, but it did not work.
    -   See pi/setup_modules, there is a script setup_LUMI-G.sh that you can source to load the modules that Alfio talked about. You need to load the new environment variables from lumi_g.sh or put the right options in the batch script to select partition and request gpus. The standard Makefile has a target acc that should build those examples with CCE.
    -   For non-pi examples you would need to check any relevant instructions
    -   `source /project/project_465000388/exercises/HPE/lumi_g.sh`
    -   Please share error messages or explain more if you are still stuck.
    -   Thanks for your help! I will try to implement.

68. I tried to use the pi_acc.slurm script, but sbatch says the requested node configuration is not available. The changes I did was add -A project_465000388
    -   could you update your `lumi_g_sh` script? We udpated it with the new partition.
        - I copied lumi_g just now, but looks like it's the same as lumi_c.sh
    - It runs through, but there is a complaint in the out file that `/var/spool/slurmd/job2843827/slurm_script: line 33: ../../setup_acc.sh: No such file or directory`
     
    - You need to point it to a script that sets up the gpu modules, so the file in the setup_modules, I should have fixed that so it did not need editing.
        - so `setup-LUMI-G.sh`?
   - yes
        - I'd already done the setup manually, so it still worked
    - Finally works for me
    - Sorry for the incovenient...
    
70. I still try to run exercise one, but not success? "No partition specified or system default partition"
    -   please, source lumi_c.sh or lumi_g.sh first.
        -   is there a way to check if the sourcing process worked?
    -   `echo $SLURM_ACCOUNT` should report `project_465000388`
        -   still got error should I remove some arguments?
    -   pi.slurm?
    -   Also please copy those two files again as they were updated (lumi_c.sh, lumi_g.sh)
        - I did, my I have the content of pi.slurm to be excuted?
        - I still can't excute pi.slurm!!! 
    -   via `sbatch pi.slurm`?
    - I just change the content
        -   SBATCH -A project_465000388
        -   is this correct or #SBATCH -A y11?
        -   this the error ".........../ProgrammingModels/jobscripts/../C/pi_serial: No such file or directory"
        -   should i set the directory?
            

71. I'm trying to run my own application with MPI+gpus following the explaination in the slides, but I either get the error`MPIDI_CRAY_init: GPU_SUPPORT_ENABLED is requested, but GTL library is not linked`
    if I set `MPICH_GPU_SUPPORT_ENABLED=1` or
    ```
    MPICH ERROR [Rank 0] [job id 2843791.3] [Tue Feb 14 16:11:55 2023] [nid007564] - Abort(1616271) (rank 0 in comm 0): Fatal error in PMPI_Init: Other MPI error, error stack:
    MPIR_Init_thread(171).......: 
    MPID_Init(506)..............: 
    MPIDI_OFI_mpi_init_hook(837): 
    create_endpoint(1382).......: OFI EP enable failed (ofi_init.c:1382:create_endpoint:Address already in use)
    ```
    if I set `MPICH_GPU_SUPPORT_ENABLED=0`
    
    -   Is the GPU target module loaded? You need the GPU target (and recompile) to tell MPI to use the GPU. It will discussed tomorrow. 
        -   ok, thanks! And I believe so, I do `module load craype-accel-amd-gfx90a`
    -   Then you have to recompile. Did you?
        -   Yes, everything was compiled with that line already loaded
    -   can you show the `module list` output?
        -    Here:
        ```
        Currently Loaded Modules:
          1) ModuleColour/on                      (S)  
          2) LUMI/22.08                           (S)  
          3) libfabric/1.15.0.0                        
          4) craype-network-ofi                        
          5) xpmem/2.4.4-2.3_9.1__gff0e1d9.shasta      
          6) partition/G               (S)  
          7) cce/14.0.2                     
          8) perftools-base/22.06.0         
          9) cpeCray/22.08                  
         1)  METIS/5.1.0-cpeCray-22.08      
         2)  buildtools/22.08     
         3)  craype/2.7.17        
         4)  cray-dsmml/0.2.2     
         5)  cray-libsci/22.08.1.1
         6)  PrgEnv-cray/8.3.3    
         7)  cray-python/3.9.12.1
         8)  cray-mpich/8.1.18
         9)  craype-x86-trento
         10) craype-accel-amd-gfx90a
         11) rocm/5.0.2
        ```
    -   OK, what's the `ldd <exe>` output? We just need to check if the gtl library (used by MPI) is linked in. Just grep for gtl.
        -   Do you want the complete version or should I grep something?
            ```
            ldd ./libslim4.so | grep mpi
                libmpi_cray.so.12 => /opt/cray/pe/lib64/libmpi_cray.so.12 (0x00007fd88af32000)
                libmpi_gtl_hsa.so.0 => /opt/cray/pe/lib64/libmpi_gtl_hsa.so.0 (0x00007fd88accf000)
            ```
    -   OK, it is there... Can you run within the jobscript? 
        -     What does that mean?
    - Put ldd command in the job script just before the srun of your executable. It would be better to have ldd of your executable. Somehow the gtl library is not present when you run, so I can assume you have to load the module in the jobscript.
        - It's a python package, so I don't have an executable
    -   OK, then, can you do `export LD_LIBRARY_PATH=$CRAY_LD_LIBRARY_PATH:$LD_LIBRARY_PATH`? Please note that the wrappers does the magic for you, but here you have python... (actually it is `export LD_LIBRARY_PATH=/opt/cray/pe/lib64/:$LD_LIBRARY_PATH`)
        -   I still get the same two outcomes, depending on `MPICH_GPU_SUPPORT_ENABLED` (everything being recompiled on a fresh environment)
    
72. Are the timings correct? In the previous exercise, it claimed the serial code took 6 seconds, but it was done almost instantly
    -    Are you saying that if you time the srun or srun time ... that the time reported is shorter than that reported by the program?
         -   I ran the Fortran_timings programs and it seemed to claim that pi_serial took six seconds, but the job was done almost instantly. I didn't have a watch and autocomplete struggles, so it took some time to open the file, but my impression was that it was much faster than it claimed in the output file
    -   It might be just that you see all the output at once so when you see it start it is really finishing
        ```
        harveyri@uan04:~/workshop/2023_02/ProgrammingModels/Fortran_timing> time srun -n 1 time ./pi_serial
        srun: job 2843939 queued and waiting for resources
        srun: job 2843939 has been allocated resources
        PI approximation by serial program
        PI = 3.141592653589793120
        myPI = 3.141592647959183800
        diff = 0.00000018%
        Elapsed time was 6.02s
        6.02user 0.01system 0:06.05elapsed 99%CPU (0avgtext+0avgdata 6884maxresident)k
        48inputs+0outputs (0major+446minor)pagefaults 0swaps

        real    0m7.002s
        user    0m0.037s
        sys     0m0.001s

        sys     0m0.020s
        ```


1.  You wrote in hints for the 2nd exercise: "Try out different compilers (by switching compiler environments, e.g. module swap PrgEnv-gnu) either manually e.g. cc C/pi_mpi.c or use make Makefile.allcompilers", but the variant - make Makefile.allcompilers, does not work properly `make: Nothing to be done for 'Makefile.allcompilers'`
    - `make clean`
    - `make -f Makefile.allcompilers`
    - It won't build binaries that are already there.


### Cray Scientific Libraries

*No questions during the session.*

#### Exercises

!!! Info
    1. Copy the exercises to your home or project folder  `cp /project/project_465000388/exercises/HPE/ProgrammingModels.tar $HOME`
    2. Unpack it with `tar xf ProgrammingModels.tar` and read the `README` file or the pdf at `doc/ProgrammingModelExamples.pdf`.
    3. To set the necessary environment variables, source `lumi_c.sh` with  `source /project/project_465000388/exercises/HPE/lumi_c.sh` (or `lumi_g.sh` equivalent for GPU nodes)

    4. Directory `libsci_acc`: Test with LibSci_ACC, check the different interfaces and environment variables

74. Just to clarify? for the 3rd exercise, to copy from /project/project_465000388/exercises/HPE/libsci_acc ? The file called "ProgrammingModels.tar" does not contain dir "libsci_acc"
    -   Yes, this is another example. Need to copy it.
    -   The slide being shared at the moment is tying to convey that these are different directories.

75. This is rather a compilers/packages question. I compile the software using cmake on the login node using ftn (Cray Fortran : Version 14.0.2). In the submission script I do "module load CrayEnv" and the following is printed on the *.e file: `Lmod is automatically replacing "craype-x86-rome" with "craype-x86-milan"`. My question is if the `milan` architecture was indeed taken into account during compilation, since this was done on the login node 
    -   If you didn't load the `craype-x86-milan` module on the login node before compilation, then your binary is optimized for Rome. See the slides of the morning session about cross-compilation for more information.
    -   We'll discuss `CrayEnv` tomorrow. It always loads the most suitable target module for the node on which you execute the load (or the `module purge` which causes an automatic reload), though there is currently a bug that manifests on the `dev-g` partition (basically because there were some nodes added to the system that I did not know about so did not adapt the code). So to compile with zen3 optimizations on the login nodes you'd still have to make sure `craype-x86-milan` is loaded as that is not what `CrayEnv` will do for you.
    -   Also note that cross-compilation does not always work as some programs come with configuration scripts that think it is wise to add a `-march=native`(or `-xHost` for Intel) to the command line which may overwrite options that the Cray wrapper passes to cross-compile.
        -   I see, thanks. So would it make sense to compile on a compute nodes to make sure everything is setup correctly without me having to load the appropriate modules?
    -   Yes, it is always safer to do so. Though so far for our software stack we do compile on a login node. For most programs so far this seems OK. It is most often "research code quality" applications that I have trouble with.


### Q&A day 1

76. I have a program writting with cuda module, for optimization purpose and getting it run on AMD GPU on LUMI. Based on what I learned today, first, I need to convert my code with hip (or something else?), then compile it with proper enviroment, am I right?
     -   AMD presentations will cover the hipification tools that can be used for this.


77. Not a question but I am working on Python and so far using Pytorch Lightning works, not sure if optimized though, so it's nice to see that we have some abstraction without fiddling too much with the code.
      -   https://docs.amd.com/bundle/ROCm-Deep-Learning-Guide-v5.3/page/Frameworks_Installation.html. The relevant bit is how to instruct pip to get the right wheels: `--extra-index-url https://download.pytorch.org/whl/nightly/rocm5.2/`
          -   Yup, it is also important to do some `export` to use more than 1 GPU. CSC has a modules for pytorch that sets it right. https://docs.lumi-supercomputer.eu/software/local/csc/

78. Are the python libraries _global_ or are libraries supposed to be local venv
    -   Users should manage their libraries but can ellect a given python instalation to use it directly or to create virtual environments. Special care should be given to not have many files in the virtual environments. More details on what users can do will be explained tomorrow.

79. Are tools to synchronize between local and remote supported and advisable to use? (e.g. Synchting) Can a user continously run a single-core job to keep alive the server?
    -   No. That is a waste of your billing units and you should also not do it on the login nodes. Use a more clever way of synching that doesn't need to be running all the time.
        -   Any suggestions for a cleverer way?
    -   It depends what it is for. E.g., my development directories are synchronised but for that I simply use Eclipse as the IDE. 
    -   check VS code remote plugin
    -   (Kurt) That one is for remote editing, you still have to synch via another plugin or in another way. I did notice the visual studio remote can be a bit unreliable on a high latency connection so take that into account.
    -   And of course I just use rsync from time to time but start it only when I need it.

80. Is there a list of essential modules that we should have to run jobs both for CPU and GPU particions? I accidentaly purged a lot of them and now is too difficult to add them 1-1.
    -   It depends on the PrgEnv. You can use a script to put your modules so that you can source it. CPU is out-of-the-box. For GPU you need: `module load craype-accel-amd-gfx90a rocm`
    -   We'll talk about another solution also that is implemented on LUMI.

81. If you require a specific name for mpi compilation (e.g. mpifort), do you recommend using alias or update-alternatives to change the name? 
    -   If you can set an alias it implies you can change the command I think? If this was hardcoded I would write a wrapper script in your path.
    -   (Kurt) The wrapper script might be the better alternative as you need to do something in a bash script to be able to use aliases. By default they are not available in shell scripts.
    

83. About VS Code, are you aware of any way that allows it to run on compute nodes and not on the login node?
    -   We have not tested this yet. 
    -   There should be a way to just start vscoded server and use it via a web browser. But I've never tried it, and you'd still need to create an ssh tunnel from the machine on which you run the browser to a login node which then forwards all data to the compute node (the way one would also use the `lumi-vnc` module to contact a VNC server) 

84. Will SSHing into allocated compute nodes be allowed?
    -   Not clear if they will ever allow it. It does make it more difficult to clean up a node. So far the only solution is to go to the node with an interactive srun, which sometimes needs an option to overlap with tasks that are already on the node.
        -   Precisely, rocm-smi or some other monitoring tool (e.g. htop).


## Day 2

### OpenACC and OpenMP offload with Cray Compilation Environment

1.  Can you have both OpenMP and OpenACC directives in a code (assuming you only activate one of them)?
  
    -   Yes. This is quite common to mix OpenMP for multithreading on  the host and OpenACC for the device. For OpenMP and OpenACC, both on the device, yes you can selectively select one of the other using macros. Note that OpenACC is enabled by default for the Cray Fortran compiler so if you don't want to use OpenACC you have to explicitly disable it. OpenMP need to be enabled explicitly.

2.  Are there features in OpenACC that are not available (and not planned) in OpenMP?
    -   I will raise this at the end of the talk.
        -   Thanks for the answer. Very useful.
    -   In practice, we have seen that people only stay with OpenACC if they already have in their (Fortran) code (i.e. from previous work with enabling Nvidia GPU support), new porting projects tend to choose OpenMP offloading. 
        -   Follow-up question: How is the support of OpenACC vs OpenMP in compilers. I would maybe expect that OpenMP would be more widely supported, now and especially in the future?
    -   The assumption is correct, OpenMP is the target for most compilers. As far I know, GNU will target Mi250 in GCC 13. I'm not aware of a real OpenACC in GNU. NVIDIA is supporting OpenACC for their compilers.

3.  What gives better performance on LUMI-G OpenMP offloading or OpenACC offloading? (C/C++)
    -   There is no OpenACC support for C/C++.
    -   Hypothetically speaking, there is no big performance difference between OpenACC and OpenMP offload in theory, sometimes they even share the same back-end. In practice, OpenMP offers somewhat more control at the programmer level for optimizations, whereas in OpenACC, they compiler has more freedom in optimizing.

4. T his is not related to the presented topic, but every time I login to Lumi I get this message: "/usr/bin/manpath: can't set the locale; make sure $LC_* and $LANG are correct", how can I fix it?
    -   I think I saw that on Mac ssh consoles
        -   I am using a Mac, so that is probably related
    -   I have had the same problem before and fixed it by adding `SendEnv LANG LC_*` in my SSH config file.
        -   Will try that - No difference
            -   Did you simply add a line in the .ssh/config with `SendEnv LANG LC_*`?
    -   The other problem that I have also had on a Mac was that it had sent a locale that was not recognized by the system I was logging on to.
        -   Nothing seems to fix it, I will leave it like that for now since it does not affect anything else

6.  Working on a Fortran+OpenACC+hipBlas/hipFFT code which has currently a CPU and a GPU version. The two versions have become very different: CPU version has lots of function calls inside the OpenMP loop. GPU version has all the parallelism at the lowest level. Looking for ways to get back to one code base. Any chance to use craype-accel-host to get good performance on CPU and GPU targets?!
    -   the host is not meant to be for performance, for instance it will likely use a single thread. Check the man page intro_openmp for more details.
    -   How to (best) organize the code to support multiple GPU architectures is still an open question. Before, you could "get away" with only having support for 1 type of GPUs, and have that as a special branch of compilation, but with several types of GPUs and/or accelerators in the future (at least Nvidia, Intel, AMD...) it will become more difficult to do it like that. I have seen a few projects with successful support of several kinds of accelerators, what they typically do is to abstract it to a common matrix/vector library in the application (a "matrix class" or similar) and then have this module support different GPU/accelerator backends (including pure CPU execution).
        -   Yes, this a common issue. Moreover, it you have multiple libraries accessing to the GPU, they don't talk each other (even worse for a multi-gpu case), so memory pooling is quite difficult. 

7.  Can we print out some of the slides from yesterday, for personal use? "Programming Environment and Modules"
    -   Sure, but please do not redistribute the digital form.
        -   Ok, thank you.
    -   The HPE slides and exercises can be copied for personal use by people attending the course. Some of the exercise examples are open source and were downloaded from the relevant repositories.

#### Exercises

!!! info "Exercise"
    -   Exercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -   Directories for this exercise: `openmp-target`, `openacc-mpi-demos`, `BabelStream`
    -   Copy the files to your home or project folder before working on the exercises.
    -   In some exercises you have source additional files to load the right modules necessary, check the README file.
    - T  o run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_g.sh` (GPU) or `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU)

    Try different parallel offload programming models (openACC, OpenMP, HIP) and examples.



1.  Has anything changed in the exercise files since yesterday, i.e., should we update our copy?
    -   Probably no changes to these folders but better copy again. Some other files for later changed.

2.  Are there job scripts available for today's exercise or I make them myself ?
    -   they are available (follow the readme)
    -   readme says Execute ... srun -n1 ... 
    -   yes, correct. If you would like to submit (they are quite short runs), you can use one of the yesterday batch script.
    -   sorry, in my build/ there is no file ctest; nto sure I understand what to submit +1
        -   ctest is a command, it will run the tests produced by cmake. If you are interested in the single binaries, then they are in the directories `build/tests/bin`. Otherwise ctest will execute all.
    -   test all worked; thanks
    -   Might be an easy one, sorry: I got the return that No partition was specified. Has anyone experience with that?
        -   Need to source the lumi_g.sh file to get SLURM configurtion.
    -   is there a useful sequence in which to study the tests/*/.cpp s ? Seem many of those
        -   So, check the original code at https://github.com/ye-luo/openmp-target. The idea is to check OpenMP offload functionalities and check if they are supported by Compilers. If the tests are OK, then the assumption is that the compile is working.
        -   The exercise is not to understand the workings of the source files ? but to apply this comprehensive test then ? (tests were all passed according to job output)
            -   It depends if you want to understand how OpenMP works, then you are welcome to check the code, sure. Otherwise the exercises is to give examples on how to use the Offload OpenMP with CCE.
            -   okay, got it, thanks.

3.  In openmp-target exercise I got the following error after the last make command "An accelerator module must be loaded for the compiler to support "target" related directive !$OMP TARGET"
    -   Have you loaded the GPU module? (`source setup_modules/setup_LUMI-G.sh`)
    -   I use the command "source /project/project_465000388/exercises/HPE/lumi_g.sh"
        -   This one is to set SLURM, you need to set the modules for the GPU (a different file)

4.  Modules were loaded, but `make` couldn't find the compiler - BabelStream
    -   Which example are you trying to run? 
    -   What's the error? could check the modules too? 
        -   `Currently Loaded Modules:1) libfabric/1.15.0.0   3) xpmem/2.4.4-2.3_9.1__gff0e1d9.shasta       5) LUMI/22.08        (S)   7) craype-accel-amd-gfx90a 2) craype-network-ofi   4) partition/L`
        -   You are missing PrgEnv-cray...

6.  Inside the `makefile` of `/exercises/HPE/openacc-mpi-demos/src/`, there are some comments after FC and FFLAGS. Are they meant as a guide for something?
    -   Those examples are taken from https://github.com/RonRahaman/openacc-mpi-demos which uses the NVIDIA compiler as baseline. I agree that I can remove the comments... Sorry for the confusion.
        -   Thanks, actually I find those comments useful, I might try in a machine with NVIDIA. Some comment that these are for NVIDIA would clarify things.
    -   Then you are welcome to use the original code. Note, it requires the nvidia compiler (previously PGI).

7.  In BabelStream example, the OpenMP compilation (with `make`) gives an error:
    ```
    CC -fopenmp -O3 -DOMP src/main.cpp src/omp/OMPStream.cpp -I src/ -I src/omp -DOMP_TARGET_GPU -o omp.x
    warning: src/omp/OMPStream.cpp:108:3: loop not vectorized: the optimizer was unable to perform the requested transformation; the transformation might be disabled or specified as part of an unsupported transformation ordering [-Wpass-failed=transform-warning]
    ```
    The HIP compilation works fine.
    -   this is a warning. It says that it cannot vectorize the loop (O3 enables vectorization), but this is fine since we are running on the GPU anyway. BTW, if you want to inspect more, I suggest to add the listing flag (-fsave-loopmark) to get more info.
        -   I added the flag in Makefile (CC -fopenmp -O3 -fsave-loopmark -DOMP src/main.cpp src/omp/OMPStream.cpp -I src/ -I src/omp -DOMP_TARGET_GPU -o omp.x) but the output is the same as before
    -   It will generate a file .lst that you can inspect and get more info.
        -   Ah, ok, thanks
                
8.  In BabelStream, the OpenMP code OMPStream.cpp, there is #pragma omp target enter data map... I assume this defines mapping of data onto devices. Where is the device list for OMP further defined in the code? or is this all?
    -   This is an OpenMP question, actually. With the call `pragma omp target enter data map(alloc: a[0:array_size], b[0:array_size], c[0:array_size])` (line 31) you map those data to the GPUs (it does allocate them). Then there will be an `#pragma omp target exit data map(release: a[0:array_size], b[0:array_size], c[0:array_size])` (line 46) to release the data. Then, the way OpenMP offload works is that if you do another map for the same data, OpenMP will check that data exists already on the device and it will reuse those allocations.
        -   Thanks! Could you please clarify where is the device list itself defined in the code, so that OMP knows which devices it should map the data to?
    -   This the default device, i.e. device_id 0.
        -   Ahh, ok, thanks. I saw this device_id 0, but I thought it can't be so easy :)
    -   Yeah, it is done via `omp_set_default_device(device);` (line 26). You can also use the clause `device` (this is for multi-gpus, actually).
        -   the id 0 means graphic card 0 on a multi-card node?
    -  It is part of the current talk. It is GPU 0, but then you can set `HIP_VISIBLE_DEVICES=2` and OpenMP will have GPU_ID=0 for the device 2 (maybe I'm confusing you). The point is that OpenMP uses at runtime the available GPUs, provided by ROCM. But then you can change the GPU order via `HIP_VISIBLE_DEVICES=1,0`. Wait for this afternoon exercises...
        -   perfect, thanks!


### Advanced Application Placement

16. I was a bit confused by this definition of CPU. Can it be repeated and expanded?
    -   I have uploaded the talk
    -   We will try to use cpu in this talk to mean what Linux calls a cpu which is a hardware thread in a core - so 2 per core. 

17. Could it be the case that when a thread needs to access data in a remote cache (different core), OS rather migrates the thread instead of accessing (or even copying) the data? I'm suspecting such a behavior since sometimes pinning threads is slower than allowing OS to migrate them inside a NUMA domain. Any suggestions what to check?
    -   Well, this is definitely the case. Within the same NUMA can be a good trade-off. This is a bit experimental, you have to try which affinity is best for you.

18. Any possibility to identify who did a binding (the different SW components)?
    -   You can get various components to report what they did (Slurm/MPI/OpenMP) but in general anything can override the binding or at least further constrain it. This is why it is good to run an application (as a proxy for your own) from your job script to double check this.
    -   It is not obvious when it comes to frameworks and applications that do their own thing to set the binding. We are covering MPI, MPI/OpenMP as they are the most common. We can at least use Slurm to set the binding of any process it starts and as long as that keeps within the binding it was given that at least gives us some control.
    -   In general, there is no trace on what is setting the binding...
 

#### Exercises

!!! Info "Exercises"
    -   xercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -   Directories for this exercise: `XTHI` (try out application) and `ACHECK` (pdf doc & application similar to xthi but nicer output)
    -   Copy the files to your home or project folder before working on the exercises.
    -   In some exercises you have source additional files to load the right modules necessary, check the README file. __Check that you don't have unnecessary (GPU) modules loaded.__
    -   To run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU)

    Try different parallel different binding options for CPU execution (look at slides and use envars to change and display the order

19. Is it common to use different bindings depending on the size of the computations? 
    -   No sure I understand the question on what you mean by "different". Usually you have to check the best match for your application. For example, if you are memory bound, then you may decide to spread your threads such that they will use multiple memory channels.
    -   The most common situation at scale is just to fill up multiple nodes using cores in sequence and if you use threads then choose OMP_NUM_THREADS so tasks fit nicely in NUMA regions and don't span them. It is when you want to do something special where other options come into play.

20. While compiling xthi.c I got the following error
    ```
    ld.lld: error: undefined symbol: omp_get_thread_num
    >>> referenced by xthi.c
    >>>               /tmp/xthi-c56fa1.o:(main)
    clang-14: error: linker command failed with exit code 1 (use -v to see invocation)
    ```
    -   Sorry, the readme is missing `-fopenmp`.
        -   I'm a bit confused, the Cray cc wasn't supposed to have openmp ON by default?
    -   Only OpenACC is the default.
    -   Not anymore, but it was before yes !

21. I'm trying the example ACHECK and I get `./acheck-cray: error while loading shared libraries: libamdhip64.so.5: cannot open shared object file: No such file or directory`. I have done `source /project/project_465000388/exercises/HPE/lumi_c.sh`. What am I missing here ?
    -   I think you will need to `source /project/project_465000388/exercises/HPE/lumi_g.sh` instead to get the relevant modules for the GPUs.
    -   Those modules are setting the SLURM environment. I assume you have the GPU modules loaded. Please, unload them, recompile and run.
    -   I suggest you do the exercise on LUMI-C for this session.  Perhaps you built it with gpu modules and are running on LUMI-C.  (it would work on LUMI-G if you have LUMI-G Slurm and modules setup but there is no need to)

22. Why? -> slurmstepd: error: execve(): xthi.c: Permission denied!!!
    -   are you using the provided job.slurm?
        -   yes
    -   I have the following there:
        ```
        #!/bin/bash

        #SBATCH -t 1

        export OMP_NUM_THREADS=1

        echo srun a.out
        srun a.out | sort
        ```
        then ou have to run via `sbatch job.slurm`. Is it what you are doing?
        -   a.out I have change it to xthi.c as the above script cause an error "execve(): xthi: No such file or directory"
    -   Put it back to a.out...
        -   Error: execve(): xthi: No such file or directory
    -   OK, you compile and it will produce a.out, do you have it? Then, `sbatch job.slurm` will submit it. The job.slurm above doesn't mention any `xthi`, so I don't know where you error is coming from...

        ```      
        #!/bin/bash

        #SBATCH -t 1

        export OMP_NUM_THREADS=1

        echo srun a.out
        srun a.out | sort
        ```        

        -   Sorry, this is the error : 
            ```
            srun a.out
            slurmstepd: error: execve(): a.out: No such file or directory
            srun: error: nid005032: task 0: Exited with exit code 2
            srun: launch/slurm: _step_signal: Terminating StepId=2876961.0
            ```

    -   Then you have to compile first...
        -   when i try to compile i got 
        -   ld.lld: error: undefined symbol: omp_get_thread_num
    -   Need to add -fopenmp flag. I've update the Readme.
        -   I cant see the update letme try copy it again
        -   Done, thank you

23. I tried "cc -fopenmp xthi.c " but got many errors like "xthi.c:65:27: error: use of undeclared identifier 'hnbuf'
            rank, thread, hnbuf, clbuf);
            "
    -   Need to set for LUMI_C. Unload the GPU modules and recompile.
        -   Yes.. I use "source /project/project_465000388/exercises/HPE/lumi_c.sh"..still the same error.
    -   This is for setting SLURM stuff. Do you hav ethe modules `rocm` and `craype-accel-amd-gfx90a`? If so, please unload them and recompile.
        -   Now I got the error "fatal error: mpi.h: No such file or directory"..
    -   Which modules do you have? I suggest to open a new and fresh terminal connection...
        -   Got it ..working now

24. Run make on _openmp-target_ and it went well. Next ran
    ```
    srun -v -n1 --gres=gpu:8 ctest
    srun: error: Unable to allocate resources: Requested node configuration is not available
    ```
    What node configuration was it looking for or is there a way to see what is required there.
    should we swap back to rome for that use case : _swap craype-x86-rome craype-x86-trento_
    -   openmp-target example is usig GPU. Are you setting SLURM for the GPU nodes (script lumi_g.sh)?


25. Is the Lumi-D partition mentionned yesterday accessible now to try, or should we make a new application for that?
    -   There is a session this afternoon describing the LUMI environment in detail, suggest you ask again if this is not covered there.
    -   LUMI-D is two things:
        -   The large memory nodes that are available and have the same architecture as the login nodes
        -   The visualisation nodes. They were releases again on February 13 but have hardly any software installed at the moment.
            Given the relative investment in LUMI-G, LUMI-C and the visualisation nodes it is clear that they won't get too much
            attention anytime soon.

26. Bit Mask: Slurm Script -> sbatch: error: Batch job submission failed: Requested node configuration is not available, why?
    -   is the SLURM setting done? (script lumi_c.sh)
        -   Yes, i will do it again
    -   Could post the job.slum script?
        -   I just copy and paste from slides, am I correct? page 50
    -   let me try... Works for me. 
        -   please share job.slum.
    -   There are other problems that I'm investigating. but at least I can submit it. Check at `/pfs/lustrep1/projappl/project_465000388/alfiolaz/training_exercises/XTHI/mask.slurm`




