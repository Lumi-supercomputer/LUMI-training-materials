# Notes from the HedgeDoc page

These are the notes from the LUMI-G training,
11.01.2023, 9:00--17:00 (CET) on Zoom.


[TOC]

## General information

### Exercises

The exercise files are on lumi at `project/project_465000320/exercises`.Copy the files into your home directory and work from there.


### LUMI user coffee break

**25.1.23, 13:00-13:45 (CET), 14:00--14:45(EET)**
Meet the LUMI user support team, discuss problems, give feedback or suggestions on how to improve services, and get advice for your projects.

Every last Wednesday in a month.
[Join via Zoom](https://cscfi.zoom.us/j/68857034104?pwd=UE9xV0FmemQ2QjZiQVFrbEpSSnVBQT09)


## Slides and other material

Slides from HPE are available on LUMI at `project/project_465000320/slides`
You need to join the training project via the link you received in the email on Monday.
Slides from the LUST talks are available [on these pages](index.md)


## Q&A of the sessions


### Questions regarding organisation or LUMI in general

1. I was on the waiting list for the training, and didn't seen to recieve the invitation link to the project. Any way to get the slides? (I have access to LUMI)

    **Answer**

    - This training was heavily overbooked, so it wasn't possible for everyone to get access.
    - We will share the AMD slides on https://lumi-supercomputer.github.io/LUMI-training-materials/
    - We are still debating on how to share the HPE slides with all LUMI users (everyone who joined the training project can access the slides on LUMI at `/project/project_465000320/slides`.
    - I tried to see the slides at /project/project_465000320/slides, but permission denied.
    - I managed to `cp` the presentation slides to my ~/user/slides and then `scp` to my base PC with no problem.
    - Still can not access: cp: cannot stat '/project/project_465000320/slides': Permission denied
        - same for me "permission denied"

2. Will the recorded training available after? I did not get the link and could join after 20 minutes.
 
    **Answer**

    - We are still debating on how to best share but we will definitely upload them to LUMI at `/project/project_465000320/recordings`.
        - it will be unavailable for people with "permission denied"

### Introduction to the Cray EX Hardware and Programming Environment on LUMI-G

Presenter: Harvey Richardson (HPE)

!!! info
    The slides for this session are available on LUMI at `01_Intro_EX_Architecture_and_PE.pdf`.
    There are also optional exercises on LUMI at `/project/project_465000320/exercises/HPE`

5. What's the topology of Slingshot in Lumi?

    **Answer**

    - Dragonfly, more later

    **Question**

    - Do we have about 50 GPUs per switch?

    **Answer**

    - It's a bit more difficult than this as every board (with two nodes per board) is connected to multiple switches on the first level of switches, and I believe this actually results in multiple switches per node also. But the number is much less than 50 per switch. I'm not sure but I believe it is 16 at the first level, the other connections on those switches are used to build the dragonfly with some ports for in-group connections and others for connections between the groups.
    - (Harvey) I will try to address this in future training, I still need to understand this myself as it varies by system and node type.
 
    **Question**

    - Is Slurm aware? Will it but tasks in one job to the same electric group?

    **Answer**

    - Not always as this would dramatically raise waiting times for jobs in the queue. Network groups are available as a Slurm feature of the compute node: `scontrol show node nid00XXXX` -> "ActiveFeatures=AMD_EPYC_7A53,x1101. In this example, `x1101` is the identifier of the network group. User can request that a job use a particular group by using the Slurm `--constraint=<feature>` option.
    - (Harvey) You can configure slurm to be aware of the switch topology, I just checked and I don't think this is currently enabled but this is something we should consider.

1. How does SHMEM work with GPU memory? is there something similar to NVSHMEM?
 
    **Answer**

    - I don't think so, I don't think there is a GPU support. Good question for AMD people though... 
    - See [ROC_SHMEM](https://github.com/ROCm-Developer-Tools/ROC_SHMEM). 
      It requires UCX so, it may not work on LUMI that relies on libfabric for   communication.

1.  What is the module name for the Cray Scientific and Math Libraries
    I can't find out how to load LAPACK and BLAS on LUMI
 
    **Answer**

    - `module load cray-libsci`. This might be discussed later in the course and is part of our introductory courses. It is linked automatically when cray-libsci is loaded but there is more to it that is discussed in our "big" course like the one we had in November in Brussels or the online one we will have in February. All those modules also come with manual pages. In this case it is `man intro_libsci` (after `module load cray-libsci`) that is a good starting point.
 
    **Question**

    - Thank you! And then I can probably use `module show cray-libsci` to locate the header files.
 
    **Answer**

    - The compiler wrappers should add the necessary `-I` options automatically. But the mdoule does define 
      a number of environment variables that point to the installation directory of the libraries, so you can
      develop Makefiles etc. that adapt to new releases on the system

2. Where can I get more information about GPU accelerated Sci libraries?
  
    **Answer**

    - Need to load the module first (cray-libsci_acc) and then you have a man page: `man -l /opt/cray/pe/libsci_acc/default/man/man3/intro_libsci_acc.3s`

1.  how can I check my project ID (I have two projects)?
 
    **Answer**

    - `groups` command will tell your projects
    - `lumi-workspaces` with `module load lumi-workspaces` will print all your projects with their directories. 

1.  Does LUMI support installation of software via Anaconda/conda?
 
    **Answer**

    - Yes but not directly. You can create conda environments in a container: https://docs.lumi-supercomputer.eu/software/installing/container-wrapper/ 
    - It is not supported in the sense that we also solve problems with Conda. We have no control whatsoever over the binaries that Conda installs nor how they are build, so we cannot solve problems with those either. And just as with regular containers, as is discussed in the full courses, you can expect problems with, e.g., MPI which may not recognize the SlingShot network correctly and use it in the appropriate way.

1.  I have a Finnish/CSC based Lumi account, and now also the myaccessid/puhuri based one. Is there way to combine or something?
 
    **Answer**

    - A solution is being rolled out (but still somewhat in a test phase). It is a direct result of the choice to use the myCSC system that is familiar to Finnish users to manage Finnish project on LUMI without integrating it with Puhuuri and use the authentication mechanisms that Puhuuri uses.
    - I have managed to (**No guarantees that you will be able to**): https://docs.csc.fi/accounts/how-to-manage-user-information/. in myCSC you can link your myCSC account to myAccessID. So my access to the LUMI-G course is attached to myCSC account.
        - I don't dare to push that before end of course to not to break anything with the existing dual accounts :-)
            - Yes. No guarantees it works! 
            - Linking in My CSC worked for me nicely, can access the training directory with me regular CSC account.

1.  Is mpi4py available in python? if so, which python module has mpi4py available?
 
    **Answer**

    - cray-python

1.  Can I use cray compilers outside of LUMI? 
  
    **Answer**

    - Cray compiler (CCE) is part of the HPE Cray Environment, so it is available only on HPE Cray systems
    - If you are using the Cray C/C++ compiler it is very similar to Clang, which is freely available. The Fortran compiler, though, is HPE/Cray-specific.

    **Question**

    - Are there online docs to view cray specific compile flags and options? Or is it safe to assume that they are very similar to clang and that cray compiler are simply optimized versions
 
    **Answer**

    - There are online PDF documents which are very hard to find and not very enlighting. The Cray PE is mostly documented through man pages accessible via the man command on the system. That is also why man pages are mentioned throughout the talk of Harvey.
    - The man pages to use are actually mentioned in our documentation at https://docs.lumi-supercomputer.eu in the relevant pages (though I note that those for the GPU compiler of AMD should still be added).
    - (Harvey) We cover compilers in a lot of detailed in the longer training courses. There is a Fortran manual but for clang the manpage is just showing the additions, there is comprehensive clang documentation online.

1.  Why do I have to export following to get the ROCm-aware MPI support not to error? I am running on AMD GPUs and MPI via Julia and need to explicitly export the following if I use ROCm-aware MPI features in the code. Thus I load following:
    ```
    export LD_PRELOAD=${CRAY_MPICH_ROOTDIR}/gtl/lib/libmpi_gtl_hsa.so
    ```
    ```
    module load CrayEnv
    module load craype-accel-amd-gfx90a # MI250x
    module load cray-mpich
    module load rocm
    ```
 
    **Answer**

    - Could you give more details? GTL is the GPU-Transfer-Library used by cray-mpich for GPU to GPU communications. MPI links with this library whenever the module `craype-accel-amd-gfx90a` is loaded.
    - OK, so you are not using the compiler wrappers, therefore you have link with the GTL library to get MPI GPU-aware. 
  
    **User answer**

    - Thanks for the info. Indeed, I am not using the wrapper indeed, as just launching Julia via `srun julia my_prog.jl`

1.  What do I need to load in order to get working OpenCL support?
 
    **Answer**

    - I have no tried it, but I would assume the standard modules just like any GPU compilation. eg.
      ```
      module load craype-accel-amd-gfx90a
      module load rocm
      ```
  
    **User remark**

    - This makes libOpenCL.so and include files available (so things compile), but OpenCL depends on dynamically loading drivers that are normally listed in /etc/OpenCL/vendors.  This dir does not exist on the GPU nodes.  I can create my own in my home directory and set OCL_ICD_VENDORS environment variable to point at it (which libOpenCL picks up), but this seems rather hacky.  Note that all this "vendors" directory contains is a file "amdocl64_50002.icd" containing the string "libamdocl64.so".

1.  The compute nodes have rocm 5.1,while the log in nodes 5.0. This makes some problems with some compilations. Is there a plan to have the 5.1 available on the log in nodes as well?
 
    **Answer**

    - The official ROCm versions are actually 5.0 on login and 5.1 on compute nodes, and this is a configuration error of the system so it should be solved at some point. But currently the GPU nodes are still in the hands of HPE so we cannot yet do whatever we like. This is also why the current phase is called "extended beta". The 5.1 is a module that we build ourselves and that may not fully integrate with the HPE Cray PE.

    **Question**

    - Follow up: can/should the 5.1 module be used with hipcc? (Trying to build Jax..., I got a container for my app already, this was just an attempt to get a native build flying)
 
    **Answer**

    - I'm not sure building Jax on LUMI is a good idea at the moment since the more recent versions require ROCm 5.3 or newer and the code for AMD in the older versions of Jax is even more immature. Some users use a container with ROCm 5.3 and a prebuilt Jax in it. ROCm 5.3 should still work fine on the driver version that we have on LUMI. And in any case I would build on a compute node and use 5.1 instead. 
    
    - You can try to use prebuild wheels of jax:

      ```
      wget https://a3s.fi/swift/v1/AUTH_ac5838fe86f043458516efa4b8235d7a/lumi-wheels/jaxlib-0.3.25-cp39-cp39-manylinux2014_x86_64.whl
      wget https://a3s.fi/swift/v1/AUTH_ac5838fe86f043458516efa4b8235d7a/lumi-wheels/jax-0.3.25-py3-none-any.whl
      module load cray-python
      module load rocm
      python -m venv --system-site-packages jaxenv
      source jaxenv/bin/activate
      pip install absl-py etils opt_einsum wheel typing_extensions
      pip install --no-deps jax*.whl
      ```

    **Question**

    - Thanx, that receipe worked, as far as building and loading libraries. However, it doesn't seem to see the GPUs (I'm on dev-g):
   
      ```
      Python 3.9.12 (main, Apr 18 2022, 21:29:31)
      [GCC 9.3.0 20200312 (Cray Inc.)] on linux
      Type "help", "copyright", "credits" or "license" for more information.
      >>> import jax
      >>> import jaxlib
      >>> jax.device_count()
      2023-01-11 11:50:57.816391: E  external/org_tensorflow/tensorflow/compiler/xla/stream_executor/rocm/rocm_driver.cc:302] failed call to hipInit: HIP_ERROR_InvalidDevice
      WARNING:jax._src.lib.xla_bridge:No GPU/TPU found, falling back to CPU. (Set TF_CPP_MIN_LOG_LEVEL=0 and rerun for more info.)
      1           
      ```
    
    **Answer**

    - The only way I can reproduce your result is by not requesting a GPU. Did you request a GPU when you submitted your job? Here is what I get:
    
      ```
      $ srun -pdev-g --gres=gpu:1 --pty -t30:00 $SHELL
      srun: job 2420138 queued and waiting for resources
      srun: job 2420138 has been allocated resources
      ❄️ (12:32) nid007565 [~/sandbox] $ source jaxenv/bin/activate
      (jaxenv) ❄️ (12:32) nid007565 [~/sandbox] $ python
      Python 3.9.12 (main, Apr 18 2022, 21:29:31)
      [GCC 9.3.0 20200312 (Cray Inc.)] on linux
      Type "help", "copyright", "credits" or "license" for more    information.
      >>> import jax
      >>> jax.device_count()
      1
      >>> jax.devices('gpu')
      [StreamExecutorGpuDevice(id=0, process_index=0, slice_index=0)]
      ```
              
    - We also have a container with a JAX installation: https://a3s.fi/swift/v1/AUTH_ac5838fe86f043458516efa4b8235d7a/lumi-experimental-containers/jax/jax-0.3.25-rocm-5.3.sif
    
1.  In the MI250x EAP phase the compiler names were not yet wrapped with "CC" etc, yet? Right? I've not been using wrong commands, have I? (Say, september 2022) (OpenMP)
     
    **Answer**

    - If you mean the MI100 EAP phase: the wrappers where there also but not OK.
    - Once users where allowed on the MI250X everything was there. In September the wrappers where there already, and in fact this is also what HPE was using for the acceptance tests. The wrappers were actually explained in the course for Pilot users in August.
     
    **User remark**

    - I was just reading the web pages. I have "amdclang" as a compiler in my Makefile with `-fopenmp-targets=amdgcn-amd-amdhsa`  etc.
     
    **Answer**

    - Using the compilers without wrappers is possible but you have to know better what to do then to, e.g., ensure that MPI works properly (as shown in one of the questions above). The wrappers are just a convenience, not an absolute requirement. With older versions of some of the PE compilers the compiles sometimes had trouble finding their own include files though. 

1.  Does cray-libsci_acc work transparently with GPU pointers?
     
    **Answer**

    - Yes, in that case it will push the computation on the GPU. With CPU pointers, the library will apply some heuristics to check if it worth to move data to the GPU and do the computation there. Check the man page for more info.

1.  Is it allowed to use Jupyter notebooks on Lumi GPUs? and if yes, how to log in to the allocated node and forward the port?
    
    **Answer**

    - In the (hopefully not too distant) future this will be possible with OpenOnDemand (see question 23)
    - The prefered scenario, also with OpenOnDemand, will be though that the Jupyter notebooks are used to launch jobs and process what they return on resources reserved for interactive use, and that they are not used to block access to regular nodes for interactive work for a long time as having those expensive nodes idle waiting for user input is not what you want, and as you never can be sure that your allocation will actually start at a time that you will be available to use it. LUMI does have nodes that are set apart for interactive use and will be used by Open On Demand, but these are not the AMD GPU nodes.

1.  Is there a prebuilt tensorflow & pytorch available that's optimized for the GPU architecture?
     
    **Answer**

    - AMD has optimized versions in containers that seem to work well but it is nearly impossible to build these packages from scratch ourselves as they have build environments that are developed for a totally different environment than an HPC cluster (even more so for TensorFlow than for PyTorch) and as build procedures and dependencies are not well documented, so expect that pre-built containers and/or wheels will be the way to go for a very long time.

1.  Is there anything similar to PyCuda available?
    
    **Answer**

    - CuPY has some AMD GPU support. https://docs.cupy.dev/en/stable/install.html?highlight=AMD#using-cupy-on-amd-gpu-experimental

1.  This may be linked to question #20 above: Harvey mentioned at the begining (interactive?) nodes for vizualisation, are these in production and where can we find more information?
    
    **Answer**

    - No, they are not in production yet. 
    - (Harvey) Sorry for any confusion but I was talking in general terms at that point and not being specific about node types on LUMI.
    - CSC is working a OpenOnDemand solution to allow quick and easy access to LUMI-D (visualisation partition with Nvidia GPUs). We are hoping for a production phase in Q2 2023. This would also allow direct in browser Jupyter and R notebook access.
    
    **User remark**

    - Ok, thanks, so no interactive nodes with Radeon GPUs then?
    
    **Answer**

    - Maybe. As far as I know OpenOnDemand should also allow access to LUMI-G for calculations.
    - (Kurt): As far as I know it will allow to launch jobs on all partitions, but there is no partition on LUMI-G with a job policy optimised for interactive work.

1.  I used to have access to the eap partition. How can I see all partitions that I am allowed to use?
     
    **Answer**

    - All users of lumi have now access to the new partitions (standard-g, small-g, dev-g) but you will need allocated GPU hours
    - Talk to your allocator to get GPU resources


### First steps for running on LUMI-G

!!! info
    The slides for this session are available on LUMI at `/project/project_465000320/slides/HPE/02_Running_Applications_and_Tools.pdf`.
    There are also optional exercises on LUMI at `/project/project_465000320/exercises/HPE`

25. Is the famous `slurm` command available on Lumi?
     
    **Answer**

    - It is! A wrapper for e.g. sinfo.

26. In all theses examples the exact format of the "project" is omitted. Is it just the number or with "project_nnnn" format?
     
    **Answer**

    - project_XXXXXXX
    - You can quickly see your projects by running the `groups` command. It is the names as used in SLURM.

27. Is there any guarantee that the GPUs land on the same node?
     
    **Answer**

    - With `--gres` yes. Using `--gpus=<n>` on the `dev-g` and `small-g` partitions no.

28. If I have an sbatch job running on a node e.g. nid012, is it possible to log in to that node and check e.g. rocm-smi status? It seems that slurm somehow isolates the GPUs of other jobs (e.g. via srun, requesting nid012) that land on the same node, so I can't check the status of the GPUs allocated to the first job. 
     
    **Answer**

    - This would allow you to go into a given node but no GPU visibility: `srun --pty --jobid <your job id> -w <your node> --mem=0 --oversubscribe --gpus-per-task=0 -N 1 -n 1 -c 16  /usr/bin/bash -l`
    - This would allow you to go to the first node of a given allocation with GPU visibility: `srun --jobid <your job id> --interactive --pty /bin/bash`
    - Unfortunately the previous version ignores -w option to specify any node. There is a ticket on that.
    - Our sysadmins are also working on allowing ssh access to allocated nodes. But this is still in the future.


29. What is the difference between `--gres=gpu:N` and e.g. `--gpus=N`. When should either be used
     
    **Answer**

    - The outcome will be similar. Also, using --gpus should instruct SLURM to allocate the specified number of GPUs. E.g. `-N $N --gpus $((N*8))`


30. `seff` isn't on LUMI AFAIK. Why?
     
    **Answer**

    - This is not a standard Slurm command but something that has to be installed separately, and also requires certain rights to certain data in Slurm. We currently use a Slurm instance as pre-configured by HPE Cray that does not contain `seff`. It is likely that it will be installed in the future as many people are requesting it.
    - Note also that `seff` is no replacement for a decent profiler when you want to assess the efficiency of your job/code. E.g., so-called busy waiting is common in MPI implementations and OpemMP runtimes and `seff` would still give the impression that those jobs are efficient.

31. Why is SMT not enabled by default in Slurm?
     
    **Answer**

    - SMT is typically not faster for most HPC workloads.

32. Are the GPU interrupts something not bound to the computation? I just wonder because CPU0 is reserverd for system AND gpu interrupts of 
     
    **Answer**

    - (Harvey) I'm not an expert on this but I think the interrupts relate to the driver and are in kernel space so not clear to me how this interacts with the 'computation'. You could ask this again later today as I think hardware will be covered again.

33. Is it possible to disable the low-noise mode?
     
    **Answer**

    - (Peter) No, not as a user.
    - (Harvey) I expect we might see future developments here as we learn more and implement more features.  I think that disabling 0 was a pretty recent change felt to be of benefit based on experience of running applications. It would be useful to get feedback on this.
    - (Kurt) My guess is that it is probably needed for applications that scale over many nodes as any kind of OS jitter can them completely break scalability, but it is an annoyance for single node jobs. But since LUMI is build as a pre-exascale system that should accomodate huge jobs, it is a reasonable thing to have.
    - (Kurt) If AMD is reading this: I know what you are doing for MI300 from the hints at the investor's day and CES, but for MI400 please give as yet another CPU die to run those processes, with quick access to some on-package LPDDR5 memory so that all OS code can be in a different part of memory from the user GPU application. An "accelerator" to run the OS code without interfering with user applications... Cloud companies can then use these cores to run the hypervisor.
    
34. Can I run examples/exercises using the LUMI-G training project? 
     
    **Answer**

    - You can use it for the exercises this afternoon but not for other purposes as the amount of resources allocated to the project is very minimal.
    - I just want to run the `xthi` example :). I copied the files to my `$HOME` dir. 
    - `xthi` hardly consumes any resources. I believe you can actually try the program first on the login nodes.
    - And if you do `module spider lumi-CPEtools` it will actually tell you about a module that contains a similar program that gives even a bit more information. I'm not sure it is there already for the GPU nodes though.

35. Shouldn't SLURM be doing this NUMA-GPU-CPU-NIC binding for us? At least for the default case? 
     
    **Answer**

    - (Peter) Yes, ideally... Hopefully, it will be added to SLURM eventually.
    - (Harvey) I'm not sure that there is a generic capability to discover all the hardware (maybe hwloc, or at least it was not there for AMD GPus to enable this to be developed in time.)

36. Could you please provide us with the handy script to select the proper GPU id with `ROCR_VISIBLE_DEVICES`?
     
    **Answer**

    - Do you mean the script in the slides?
    - There is something similar in the LUMI user documentation on the page with GPU examples: https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/lumig-job/
    - The `xthi` example talked about in the presentation is available: `/projappl/project_465000320/exercises/HPE/xthi` 

37. Is it faster to MPI transfer data from GPU memory than host memory?
     
    **Answer**

    - Answered in slides. (a bit faster, not really significant.)

38. Does the programmer need to handle manually the communications between gpus on the same nodes or in different node? I mean if the suitable technology is automatically selected.(RDMA vs. peer2peer)
     
    **Answer**

    - The MPI implementation will handle that for you (MPICH_GPU_SUPPORT_ENABLED=1 needs to be set). Other libraries like RCCL will also detect topology and use the best approach for communication between GPUs. Having said that, if you are not planning on using these libs you need to manage the topology yourself.
    - You may wish to take care on which ranks are on each node of course as you would for any MPI application to balance on or off- node traffic.

40. I tried running a simple NCCL example ported to HIP using the RCCL library within rocm. Compilation worked well but I had trouble running it when submitting it to the GPU queue. The first call to a library function, ncclCommInitRank(), returned an error reading "unhandled system error". I suspect something is wrong with my batch script, might be related to some MPI environment variable. Have you got any ideas what the problem could be?
     
    **Answer**

    - RCCL is using the wrong network interface. Please `export NCCL_SOCKET_IFNAME=hsn` to select the slingshot NICs.

41. Can you also profile the energy consumption of GPU jobs? I assumed what was just shown is only for CPU?
     
    **Answer**

    - (Harvey) I have not checked this but the basic information for whole-job GPU energy consumption should be available. I'm not sure if either Slurm or perftools reports that and would have to check.
     
    **User remark**

    - OK, we have a research project where we want to look at the energy consumption of GPU jobs, so this would be very useful. I know with `rocm-smi` we can see the current (at that specific point in time) GPU utilization and consumption, but might be hard to get for the whole job?
     
    **Answer**

    - The files are in `/sys/cray/pm_counters` (on compute nodes). They update at 10Hz. See accel0_energy etc. for example

42. Is it possible to get memory peak on the GPU ?
     
    **Answer**

    - this is something CrayPAT can do for you. (This is actually a question for AMD, you can ask it in the afternoon).

 

### Exercises morning sessions

!!! info
    The exercises can be found on LUMI at `/project/project_465000320/exercises/HPE`

43. Is there a way to get access to the exercices when not on the training project? (This is basically question 1)
     
    **Answer**

    - No, unfortunately at the moment not. We will reevaluate how to publish slides and exercises for future courses.
    - If you have gotten all the emails in the last few days about the course, you should be able tojoin the project and then get access to the project folder on LUMI.
     
    **User remark**

    - I was on the waiting list and apparently didn't recieve a link to get the access. Should I open a ticket like suggested in the next question?
     
    **Answer**

    - It will take a few minutes (~15-30) after you joined for the synchronization to LUMI.

44. What should we do if we get permission denied when trying to access `/project/project_465000320/`? 
     
    **Answer**

    - Check that you are using the right account (the Puhuri one)
     
    **User remark**

    - I see the project listed under the Puhuru portal. Should I sign in with another username than normally?
     
    **Answer**

    - Otherwise join the project or if you have problems with joining the project, please open a ticket at https://lumi-supercomputer.eu/user-support/need-help/generic/

47. Are there some instructions for the exercises? In what order should they be run?
     
    **Answer**

    - No instructions are provided, there are there only to reproduce what we showed in the slides. 
    - We are running ahead of expectation as last time I think we had way more discussion during the morning. Because we are switching to AMD presenters this afternoon I didn't want to suggest moving everything forward.

47. What is the recommended way of running Java code on LUMI? Can the Java Fork/Join framework be used directly or does one need to use something like aparapi?
     
    **Answer**

    - Question remained unanswered due to the lack of Java experts. After all, this is not a popular HPC tool...
  

48. I am trying to compile the implementation of BabelStream ("ocl").  After doing `module load craype-accel-amd-gfx90a` and `module load rocm` I try `cmake -Bbuild -H. -DMODEL=ocl`, but this fails with `Could NOT find OpenCL (missing: OpenCL_LIBRARY) (found version "2.2")`.  The OpenCL libraries are certainly somewhere in /opt/rocm, but apparently not made available to cmake.  What am I missing?
     
    **Answer**

    - This seem to work: ` cmake -DMODEL=ocl -DOpenCL_LIBRARY=/opt/rocm-5.1.0/opencl/lib/libOpenCL.so ../`. Built in the compute node. However the resulting binary fails with:
      ```
      >  ./ocl-stream                      
      BabelStream                                                                                                
      Version: 4.0                                                                                               
      Implementation: OpenCL  
      Running kernels 100 times                                                                                  
      Precision: double                                                                                          
      Array size: 268.4 MB (=0.3 GB)
      Total size: 805.3 MB (=0.8 GB)                                                                             
      terminate called after throwing an instance of    'cl::Error'                                                                                                                                                            
        what():  clGetPlatformIDs
      Aborted (core dumped)
      ```
      This may require further investigation.
    - (Alfio) There was a discussion about missing OpenCL files on the compute nodes (see a question above), namely the files under `/etc/OpenCL/vendors`. I'm not an expert, but it appears that the suggested solution is to copy those files in the home to make them available on the compute nodes too.
    
49. Any news on hipSYCL on Lumi?
     
    **Answer**

    - We have an EasyConfig for it, see the link to the LUMI software Library in the LUMI documentation: https://docs.lumi-supercomputer.eu/software/#the-lumi-software-library

50. Do we need to load modules in slurm batch script or set variables ? hello_jobstep after compilation (modified Makefile to use flags like frontier) during execution - error while loading shared libraries: libomp.so cannot open shared object file: No such file or directory
     
    **Answer**

    - If you use anyting other then default modules at build time then it is best to load those modules in the batch script (or check if the environment at the point you submit the job has been exported to the job (that is a site dependent configuration))
    - On a fresh connection to LUMI, I set:
      ```
      module load rocm
      module load craype-accel-amd-gfx90a
      
      CC -std=c++11 -fopenmp  -x hip -c hello_jobstep.cpp
      CC -fopenmp hello_jobstep.o -o hello_jobstep
      ```
      Then I run on sbatch (using a script used in the slides).
    - The various scenarios for using the Cray PE on LUMI is a part of the introductory courses e.g., the full 4-day course on GPU computing in February or the course we had in November). As this was a LUST talk, some of the material is available on https://lumi-supercomputer.github.io/LUMI-training-materials/
    - There is a problem with the installation fo PrgEnv-amd (which may in fact be an HPE packaging error in 22.08). Is that what you were using? It does cause certain libraries not to be found at runtime.
     
    **User remark**

    - Problem solved- do not change PrgEnv-cray during compilation to PrgEnv-amd for hello_jobstep. Only modification is in Makefile - there is no lumi, but flags from frontier worked
     
    **Answer**

    - Well, the problem is that libomp is under `/opt/rocm/llvm/lib`, while the PrgEnv-amd module (5.0.2) is using `/opt/rocm-5.0.2/llvm/lib` and the 5.0.2 is not available on the compute nodes (only 5.1.0). You can do `export LD_LIBRARY_PATH=/opt/rocm/llvm/lib:$LD_LIBRARY_PATH`.
 
51. What exercises can I make public and which ones can I not? For example in a public repo on Github
     
    **Answer**

    - Those from HPE cannot be made public in any way. In fact, they can only be spread to users of LUMI.
    - (Harvey) In some cases those exercises came from elsewhere in which case there is no problem and I migh have been a bit strong in my comments earlier based on examples used in other courses, We will check.
    - I remember seeing an AMD repo in one of their accounts for ROCm that had exercises very similar to those of this afternoon, so I guess you can look up the license that covers that repository. The AMD people will only be around this afternoon.
    - Check the slides, we basically took the slides from the repos, namely:
      - OSU benchmark https://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.9.tar.gz
      - Fortran OpenACC examples https://github.com/RonRahaman/openacc-mpi-demos
      - Fortran OpenMP examples https://github.com/ye-luo/openmp-target
      - Collections of examples in BabelStream https://github.com/UoB-HPC/BabelStream
      - https://code.ornl.gov/olcf/hello_jobstep
      - https://support.hpe.com/hpesc/public/docDisplay?docId=a00114008en_us&docLocale=en_US&page=Run_an_OpenMP_Application.html
      
52. except PrgEnv-xxx, Cray introduced also **cpe** module (Cray Programming environment). when is the cpe module used for compiling? 
      
    **Answer**

    - (Alfio) cpe is a collection, for instance LUMI has 22.08 (year.month version). You can load the cpe, which will load PrgEnv-XXX versions (and all other modules)...
     
    **User remark**

    - but e.g *PrgEnv-cray* is loaded by default, if then load *cpe*, there is not any changed. 
     
    **Answer**

    - Because by default CPE 22.08 is the default
      ```
      > module av cpe
      cpe-cuda/22.06    cpe-cuda/22.08 (D)    cpe/21.12    cpe/22.06    cpe/22.08 (D)
      ```
      Therefore, loading 22.08 will not change the default modules. 
    - (Kurt) cpe is really a module that changes the default versions of the packages and then tries to reload the already modules to switch to the new default versions. With the emphasis on "tries to", sometimes it fails. Also, due to the way LMOD works it should always be loaded in a separate `module load cpe` command. And a workaround for some of the problems is to do that `module load` twice.
            


### GPU Hardware & Introduction to ROCm and HIP

!!! info
    The slides for this session are available on LUMI at `/project/project_465000320/slides/AMD/`.


53. It seems that whenever I try to run a slurm job, I get the sbatch error AssocMaxSubmitJobLimit - "Batch job submission failed: Job violates accounting/QOS policy (job submit limit, user's size and/or time limits)". I assume this means I need to be allocated more time and resources on LUMI.
      
    **Answer**

    -   Are you submitting with your own project or the training one? (`--account=<project_XXXXXXXXXX> option`)

      
    **User remark**

    -   Thanks. I get the same error whether I use my own project or the trainig project. I am submitting to partition "small" - perhaps I should be submitting to a different partition? Here's the batch file I'n trying to run:
    
        ```
        #!/bin/bash 
        #SBATCH -p small
        #SBATCH -A project_465000320
        #SBATCH --time=00:02:00
        #SBATCH --nodes=1
        #SBATCH --gres=gpu:1
        #SBATCH --exclusive
        srun -n 1 rocm-smi
        ```

    **Answer**

    -   You should use `small-g` but the error message you should get is `sbatch: error: Batch job submission failed: Requested node configuration is not available`. What is your username?
    
    -   You should be able to submit with `project_465000320` and using the `small-g` partition. Your other project has no billing units. Maybe you have the `SBATCH_ACCOUNT` or `SLURM_ACCOUNT` environment variables set to this project as this is something we recommend in the documentation?
      
    **User remark**

    -   Thank you. The problem was that my `SBATCH_ACCOUNT` variable was set to my other project. Thanks for the help!

54. Are these advanced features like Matrix cores and packed FP32 already ported to libraries like PyTorch and TensorFlow (as they already have official ROCm ports)? 
      
    **Answer**

    - Yes, these libs/frameworks leverage BLAS and MiOpen libs that comprise support for matrix ops.
    
55. When running multi-GPU (but single node, so up to 8 logical GPUs) batch ML training jobs using basic Keras/Tensorflow with ROCm, I'm noticing that it's quite unstable, often but not always the training crashes after a few steps. This does not occur (or occurs much more rarely) when using a single (logical) GPU. There are no useful messages in the log. Any ideas how to debug this?
      
    **Answer**

    - Any backtrace dumped when the crash happens? Several users have managed to run training on multiple GPUs and multiple nodes each using multiple GPUs. 

56. If I need to synchronize only a subset of my threads, similar to what I'd do with a `__syncwarp`, should I abandon the optimization and do a `__syncthreads`, or is there an implicit wavefront-wide synchronisation?
      
    **Answer**

    - Cooperative groups are supported in recent ROCm versions. However on Instinct GPUs all threads in a wave front always execute in lock step. So cooperative groups is mostly a portability feature as on instinct GPUs threads do not diverge. 

57. Why isn't there a HIP equivalent to CUDA fortran? (Out of curiosity)
      
    **Answer**

    - There is not, you have to call the HIP runtime through the C interface and launch kernels separately. There is a library with wrappers to facilitate this: https://github.com/ROCmSoftwarePlatform/hipfort

58. What are some good resources for running python code (torch/CUDA) on LUMI GPUs? The documentation does not have anything on it.
      
    **Answer**

    - https://docs.csc.fi/apps/pytorch/ has some comments on using pytorch on LUMI. 
      
    **User remark**

    - Ok, so the package is available, but if changes in the code regarding running it on AMD GPUs are needed I cannot find that in the docs, right?
      
    **Answer**

    - You can run the same Python/PyTorch code on AMD.
    - There are some AI/ML modules on LUMI (for AMD GPUs) created by CSC: `module use /appl/local/csc/soft/ai/modulefiles/`, if you have any questions about this you can send a ticket to csc service desk (email: servicedesk@csc.fi).

59. There was at some point a HIP implementation that runs on the CPU (https://github.com/ROCm-Developer-Tools/HIP-CPU), which would be useful for portability, but it doesn't seem maintained. Is the project dead?
      
    **Answer**

    - Being a header only project I'd expect it to work in most cases as HIP standard didn't shift much. However, this is maintained on best effort and not officially supported. Having said that, we encourage users to file tickets if they are facing issues using it. 

60. Can you obtain the information provided by rocminfo (CUs etc.) from an API simply useable in an OpenMP offload program?
      
    **Answer**

    - Yes, there is library which provides the `rocm-smi` information: https://github.com/RadeonOpenCompute/rocm_smi_lib
    - Actually, if you look at the source of rocminfo, it's quite a small utility (~1K LoC). You can have a look and extract the part that you are interested in and include it in your application.

61. When I run Alfio's example on slide 8 of his slides, I get an output similar to that on his slide 9, but this is followed by the following errors:

    ```
    srun: error: nid007244: task 0: Exited with exit code 2
    srun: launch/slurm: _step_signal: Terminating StepId=2422727.0
    ```
    
    Does anyone know what this is due to?
      
    **Answer**

    -   rocm-smi is exiting with a return code of 2 which slurm interprets as a failure.
    
        ```
        harveyri@nid007307:~/workshop/2023_01> rocm-smi


        ======================= ROCm System Management Interface     =======================
        ================================= Concise Info =================================
        GPU  Temp   AvgPwr  SCLK    MCLK     Fan  Perf  PwrCap  VRAM%  GPU%
        0    40.0c  91.0W   800Mhz  1600Mhz  0%   auto  560.0W    0%   0%
        ================================================================================
        ============================= End of ROCm SMI Log ==============================
        harveyri@nid007307:~/workshop/2023_01> echo $?
        2
        ```
      
    **User remark**

    -   OK. Thanks. I assume rocm-smi is supposed to exit with code 2. At least, not something I need to worry about!
       
    **Answer**

    -   (Harvey) I don't know but there is an issue reported on the return code in github for an invocation with -a so I expect this is not expected. It is not something to worry about in any case.

62. I am interested in running distributed trainings using pytorch, as we have a very large dataset. I am using the official Docker container for Pytorch with ROCm support. The communication between nodes/GPUs works at this moment. But, I get this error `MIOpen Error: /long_pathname_so_that_rpms_can_package_the_debug_info/data/driver/MLOpen/src/sqlite_db.cpp:220: Internal error while accessing SQLite database: locking protocol` for the trainings. I can set `MIOPEN_DEBUG_DISABLE_FIND_DB=1`, `MIOPEN_DISABLE_CACHE=1`, and `MIOPEN_FIND_ENFORCE=5` to eliminate this issue. Any comments would be great.
      
    **Answer**

    -   This can be fixed if you add to each process instance something like:
        ```
        export MIOPEN_USER_DB_PATH="/tmp/sam-miopen-cache-$SLURM_PROCID"
        export MIOPEN_CUSTOM_CACHE_DIR=$MIOPEN_USER_DB_PATH

        rm -rf $MIOPEN_USER_DB_PATH
        mkdir -p $MIOPEN_USER_DB_PATH
        ```

        the FS doesn't cope with the locks, so moving the DB to /tmp fixes the problem.
        
    -   Please do some cleanup at the end of your job if you use this solution, i.e., remove the files `rm -rf $MIOPEN_USER_DB_PATH` as `/tmp` is a RAM disk and, at the moment, is not cleaned at the end of the job execution. As a consequence, leftover files may endup consuming the entire node memory.
    
    -   Not sure which ROCm users space you use but you might be interested in enabling the libfabric plugin. Here's a module I maintain that provides that - not sure if there a generally available build:

        ```
        module use /pfs/lustrep2/projappl/project_462000125/samantao-public/mymodules
        module load aws-ofi-rccl/sam-rocm-5.3.3.lua
        ```
        
        this will boost your internode BW.
    
      
    **Question**

    -   Thank you for this answer. I get another error `nid007564:5809:6364 [6] /long_pathname_so_that_rpms_can_package_the_debug_info/data/driver/rccl/src/misc/rocm_smi_wrap.cc:38 NCCL WARN ROCm SMI init failure An error occurred during initialization, during monitor discovery or when when initializing internal data structures` if `MIOPEN_FIND_ENFORCE=5` is not set. Is this also related? 
      
    **Answer**

    -   Does it help if you set `export NCCL_SOCKET_IFNAME=hsn0,hsn1,hsn2,hsn3`?
      
    **User remark**

    -   Unfortunately not -- `NCCL_SOCKET_IFNAME=hsn` is already set. Only thing seems to help is the enforce level 5, which seems to be related to this DB. 
      
    **Answer**

    -   RCCL attempts to initilaize all interfaces but the ones other than slingshot can't be initialized properly.


63. Is there a mechanism to profile shared libraries that use the GPUs? (My application is a python package, so everything is in a `.so`)
      
    **Answer**

    - rocprof will follow linked libraries, so the profiling method is not different than a regular map. `rocprof python ...` is what you should be running.
    - for omnitrace with instrumentation you'd have to instrument the libraries you care about.

64. Using omniperf with Grafana is definitely interesting! So could we take this debugging and profiling information back locally and analyse on our own Grafana servers? Granted this is more advanced due to having your own Grafana server. 
      
    **Answer**

    - Copying the information locally: According to AMD, yes.
    - (Kurt from LUST) But no hope that LUST will offer omniperf in one way or another for now. I just heard from a colleague that there is a serious security problem which has to do with the basic concepts that omniperf uses, making it not suitable for a shared infrastructure as LUMI. We cannot stop you from installing yourself but be aware that you put your data at risk. We are working on omnitrace though.

65. If you had a working program ("black box"), how would you start profiling the program and what metrics would you first focus on to see if the program utilizes the GPUs correctly?
      
    **Answer**

    - Using plain `rocprof` with your app is a good starting point - that will produce a list of the kernels ran on the GPU and that could give one hints if that is what one would expect. While running you can also monitor rocm-smi and see what PIDs use which GPUs and have an overview of the activity: memory being used and compute (which correlates to the GPU drawn power - up to 560W).

66. This is very heavy with lots of info. Is there a "poor man" way to use it. Like getting start it with something simple?
      
    **Answer**

    - Our more introductory 4-day course...

67. As an excercise I'm running rocgdb for my openMP offload code. Could someone interpret the general lines:
    ```
    (gdb) run
    The program being debugged has been started already.
    Start it from the beginning? (y or n) y
    Starting program: /pfs/lustrep2/users/---/prw/parallel_random_walk
    [Thread debugging using libthread_db enabled]
    Using host libthread_db library "/lib64/libthread_db.so.1".
    OMP: Warning #234: OMP_NUM_THREADS: Invalid symbols found. Check the value "".
    [New Thread 0x1554aae22700 (LWP 61357)]
    Markers 1000000 Steps 320000 Gridsize 10240.
    [New Thread 0x1554a37ff700 (LWP 61358)]
    [GPU Memory Error] Addr: 0x155673c00000 Reason: No Idea!
    Memory access fault by GPU node-4 (Agent handle: 0x3d4160) on address 0x155673c00000. Reason: Unknown.
    ```
    Specifically 

    -   `[GPU Memory Error] Addr: 0x155673c00000 Reason: No Idea!`
    -   `Memory access fault by GPU node-4 (Agent handle: 0x3d4160) on address 0x155673c00000. Reason: Unknown.`
      
    **Answer**

    -   This is a memory access problem - some data not being accessed properly. Are you assuming unified memory?
      
    **User remark/question**

    -   openMP...so no. The same code works with other compliler versions in Lumi. 
    -   What's this: `OMP: Warning #234: OMP_NUM_THREADS: Invalid symbols found. Check the value "".`?
      
    **Answer**

    -   Have you tried OMP_NUM_THREADS=1? How do you declare it btw?

    **User remark/question**

    -   That was a good question. Forgot to remove it from the script to bring the code to the debugger.
      
    **Answer**

    -   Here's an example from Babelstream that runs to completion:
        ```
        module purge
        module load CrayEnv
        module load PrgEnv-cray/8.3.3
        module load craype-accel-amd-gfx90a
        module load amd/5.1.0
        cmake -DMODEL=omp ../
        make
        rocgdb ./omp-stream 
        ```

1.  Can I submit tickets regarding what George discussed to LUST? In-depth questions about profiling, debugging etc in case I would like some support on roctrace, omniperf etc?
      
    **Answer**

    - Yes you can. When you submit a ticket it's also visible to AMD and HPE LUMI center of excellence members. So, either LUST or the vendors can answer depending on the complexity of your question




### General Q&A

71. What is the status of LUMI? has it now being handed over to CSC/EuroHPC?

    **Answer**

    - LUMI-G is still owned by HPE and hasn't been handed over. 
      That's also the reason why we are not in full production but in an extended beta phase.

72. What software will be first hand supported?

    **Answer**

    - We don't know yet. SW has to be quite stable for us to be supportable
    - LUST is a very small team so we don't have much resources except for providing SW installation (easybuild) recipes.
    - Medium term goal to produce some guide lines for most used SW packages.
    - Long term goal to involve local consortium countries (centers and universities) to help support and tune 
      software packages and write application guidelines.


