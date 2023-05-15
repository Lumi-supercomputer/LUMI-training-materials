# LUMI-G Pilot Training
23.8.2022 9:00--17:30 (CEST)


[TOC]

## General Information

### Next public HPC coffee break

**31.8.22, 13:00-13:45 (CEST), 14:00--14:45(EEST)**
Meet the LUMI user support team, discuss problems, give feedback or suggestions on how to improve services, and get advice for your projects.

Every last Wednesday in a month.
[Join via Zoom](https://cscfi.zoom.us/j/68857034104?pwd=UE9xV0FmemQ2QjZiQVFrbEpSSnVBQT09)

### Schedule

- **9:00-9:10**: Introduction
    - Course organisation
    - Demonstration of how to use hackmd
- **9:10-10:15**: Introduction to the Cray EX Hardware and Programming Environment on LUMI-G ([name=Harvey])
    - HPE Cray EX hardware architecture and software stack
    - The Cray programming environment and compiler wrapper scripts
    - An introduction to the compiler suites for GPUs
- **10:15-10:45**: Break
- **10:45-12:00**: First steps for running on LUMI-G
    - Examples of using the Slurm Batch system, launching jobs on the front end and basic controls for job placement (CPU/GPU/NIC)
    - MPI update for GPUs/SS11 (GPU-aware communications)
    - Profiling tools
- **12:00-14:00: Lunch break**
- **14:00-15:45**: AMD topics ([name=George] & [name=Samuel])
    - GPU Hardware intro
    - Introduction to ROCm and HIP
    - Porting Applications to HIP
    - ROCm libraries
    - Profiling 
    - Debugging
- **15:30-16:00**: Break
- **16:00-16:45**: Continuation of AMD topics + examples & hands-on exercises
- **16:45-17:30**: General Questions & Answers

### Slides and other material (temporary location)
- HPE slides and excercises on lumi at `/users/lazzaroa/hackathon` 
- AMD slides: https://www.dropbox.com/s/umcjwr6hhn06ivl/LUMIG_training_AMD_ecosystem_23_08_2022.pdf?dl=0
- AMD excersises on lumi at `/users/gmarkoman/training` The README contains basic instructions


## Q&A

### Ice breaker: What is the most important topic you want to learn about today?
- I want to learn how to bind GPUs to CPU cores
- Profiling and Debugging +6
- AMD GPU Unified Memory performance, Page Migration Mechanism, memory prefetching (eg. hipMemPrefetchAsync), comparison of differences between the newest AMD and NVIDIA archs with respect to Unified Memory
- General use of the system
- Any significant ROCm issues known? +1
- GPU aware MPI on LUMI. +2 
- How to compile my application for CPU/GPU execution
- How to build software in user's space under different software stacks?
- What are the problems with LUMI-G that lead to the postponing of the pilot phase? Appart from hardware issues, can these issues impact users running in rocm containers?

1. How to edit this document (without logging in)?
    - You can click the "Pencil" button in the top left.


### Introduction to the Cray EX Hardware and Programming Environment on LUMI-G 

1. Will pilots be restricted to a max of 100 nodes/run or is larger possible?
    - For the CPU pilots there were special arrangements for very big runs towards the end of the pilot phase so I guess that could be arranged
        - Great, thanks, we (UTU) are very interested in very large runs

2. How are the MI250X seen in a program? 1 or 2 GPUs?
    - 2, more description in the next lecture
        - So a program will have to be multi-gpu to use it at maximum?
            - Not sure I understand the question, let's discuss this in the next lecture. There are 4 Mi250X on the node, a total of 8 GCDs. From the software point of view these are 8 GPUs. You can use ranks attached to each gpu or use multi-gpu within the same process.

3. Benchmarks vs NVIDIA (node vs node & gpu vs gpu // fundamental ops & application ie pytorch)
    - One of the purposes of the pilot phase is actually that you establish such benchmarks. We do not have much numbers yet.  

4. Is Simultaneous Multi-Threading enabled on CPU
    - Yes, there are 128 hardware threads
    - You need to use the slurm option `--threads-per-core=2

5. Does slurm schedule multi-node jobs on nodes which have the lowest node to node latency in the dragonfly network?
    - I doubt. It is not the case on the CPU nodes, so I doubt it will be the case on the GPUs. In fact, every dual GPU node blade connects to 4 switches but it is not clear to me if every node already connects to 4 swithces or if both nodes each connect to two switches. SLURM does try to give nodes that are close in the numbering which means that they are in one so-called group (within a rack). There are still other problems with the Slurm configuration though.
    - You can configure Slurm to try to keep workloads to 'switches' (a Slurm concept). So you can associate a switch to a group of physical switches.

6. debugger: what's the maximum job size of ddt's license ?
    - 256 MPI ranks (each rank can use 1 GPU), i.e. max 32 nodes. There is also the gdb4hpc debugger from HPE Cray, which has no limit
    - We don't have a version that is ready for AMD GPUs though at the moment.

7. Known issues with ROCm / HIP complex numbers? What version of ROCm?
    - Any issue in particular that you are referring to here?

8. What version of ROCm? 
    - Currently 5.0.2 but it changes all the time. We're still figuring out why 5.1 did not get installed as that should be supported on the version of the OS that we have.  

9. Does the GPU-aware MPI do packing and unpacking for derived datatypes on the GPU? Does it support Unified Memory (passing pointers to UM)?
    - The system has an unified memory pool - GPU memory pointer can not only be used in MPI but also in your CPU code.
    - HPE is beeter position to answer how that packing/unpacking is implemented - not sure if that is offloaded to the GPU.
        - (HPE) I will ask to MPI experts..
        - Thanks! My experience is that for example with OpenMPI and MVAPCIH2-GDR with NVIDIA archs, the packing and unpacking for derived data types is not done on the GPUs. This means that with Unified Memory, recurring page faults occur (because packing/unpacking is done on the CPU, and requires CPU accessing the data from the GPU). This can make derived MPI datatypes very slow, and we actually had to move back to continuous MPI datatypes (eg. MPI_BYTE), this gave a huge performance increase (3x whole program performance) with CUDA and NVIDIA cards. But it would be good to know whether things are different with AMD cards and cray MPI implementation?
        - [HPE] Can you provide a little more detail about the datatypes involved, are they vector constructions for example.
        - MPI_Type_create_struct and MPI_Type_create_hvector are used at least I think, I don't remember the exact details anymore, the code is here: https://github.com/parflow/parflow/blob/master/pfsimulator/amps/mpi1/amps_pack.c
            - (HPE) MPI expert reply: we currently do not offload datatype pack/unpact to the GPU. Users can allocate memory via hipMallocManaged or cudaMallocManaged and pass those pointers to MPI.  Users need to set MPICH_GPU_MANAGED_MEMORY_SUPPORT_ENABLED=1  for such codes (check `man mpi` for details).
                - Thanks, Will there be page faults, or is the data prefetched to the CPU without page faults for packing/unpacking? Does it crash if hipMalloc is used instead of hipMallocManaged when using those derived datatypes?
                    - Sorry, you have to try, we don't have performance numbers...


10. Maybe I mis - what is the difference between cray-python and python?
    - cray-python is a just an installation that is linked to the cray libsci library for numpy/scipy/pandas
    - System python should never be used, it comes with a miminum of packages and is not meant to be build upon.
    - cray-python can be loaded with the module system

11. Will there be multiple rocm modules available? 
    - Likely through different versions of the programming environment, the Cray compilers and Cray MPICH require specific versions. 
    - (Kurt for LUST) I checked what the current rocm/5.0.2 module does and it actually does not even support multiple versions of ROCm on the system as it uses `/opt/rocm` rather `/opt/rocm-5.0.2` which in turn may have to do with a ROCm problem, i..e., hard-coded paths in the ROCm code that don't support installing in other directories. Now if tomorrow the sysadmins would install ROCm 5.2.0 and then use `/etc/alternatives` to make that version the default, the 5.0.2 module would actually be loading 5.2.0 instead...

12. What is the preferred way to monitor GPU usage and memory across multiple nodes?
    - See later sessions, this is more a question for the end
    - Usually `rocm-smi` is how you go about this, or you can instrument your application to collect stats. I used to do monitoring by SSHing to the allocated nodes but that is not available on LUMI. A possibility is to create a script such as (rocm-monitor) :
      ```
      #!/bin/bash

      while true ; do
         date > ~/rocm-smi-$(hostname)
       rocm-smi >> ~/rocm-smi-$(hostname)
       sleep 1
      done
      ``` 
      then you can use in your submission script:
      ```
      mpids=''
      if [ $SLURM_LOCALID -eq 0 ] ; then
        rocm-monitor &
        mpids=$!
      fi

      ... do your thing

      for p in $mpids ; do
        kill $p
      done
      ```
      And in a login node you can `watch -n1 cat ~/rocm-smi-*`

13. Is there a difference between `hipMalloc` and `hipMallocManaged` for LUMI environment? 
    If I remember right, the pointer to hipMalloc'd memory can be used in host code as well 
    with AMD GPUs (this is different from NVIDIA archs).

    -   One difference is that with hipMallocManaged the migration happens with the declaration while 
        with hipMalloc the migration will happen on demand. On the dev, the first access could be 
        slighlty slower than the next ones.

    *Follow-up question:* Can you confirm that with `hipMalloc` the migration happens only when the data is needed? 
    This would be the opposite of how it works with NVIDIA archs.

    -   Yes, not every time, just the first time, then no need to migrate again
    
    *Insisting:*  Are you 100% sure you did not mix the hipMalloc and hipMallocManaged functions? 
    With NVIDIA archs they work the other way around.
    
    -   Trying to clarify:
        -   `hipmalloc` - page lives in the GPU and is migrated to main memory on demand
        -   `hiphostalloc` - page lives in main memory and is migrated to the GPU on demand
        -   `hipmallocmanaged` - page is migrated when it is touch and then resides in the destination memory

    -   I think what is meant is that the first time you touch memory allocated in the GPU in the GPU, 
        you have a small hit in BW to have the shared memory system to workout the consistency logic. 
        
    -   Just for completion - unified memory is on by default on the nodes. If you disable it (HSA_XNACK=0)
        then a page fault will result in segfault in the first two cases. That could be useful if you want 
        to make sure you are not relying on the unified memory by mistake, i.e you are not using a main memory 
        pointer on the GPU or vice-versa. 
 
14. `craype-x86-rome`: are the cpus of the cn zen3/milan cpus ? would you recommend to load `craype-x86-milan` instead ?
 
    -    Actually, there is `craype-x86-trento`. More in the next slides

16. Will complete start to finish tutorials be available (i.e. MNIST JAX example including loading modules / installing packages / running)? 

    -   Likely not, except probably for very specific packages. It is impossible to maintain such documentation 
        with a small team as we are a small team and with the rapid rate of compiler updates that we can expect 
        in the next year. We do try to develop EasyBuild recipes for software though, and offer Spack for those 
        who know how to use it (but do not intend to implement packages in Spack ourselves). The reality is that 
        given the very new technology on LUMI, it will be a rapidly changing system initially and not one for 
        those who expect an environment that is stable for a longer period of time. 


### First steps for running on LUMI-G

1.  How to profile python programs?

    -   (HPE) I'm not sure about this, `pat_run` might tell you something, we plan to have a discussion about Python 
        support in the CoE/LUST team so I will keep this in mind.


2.  How to do MPI allreduce on pure GPUs and hybrid case?

    -    Copy data to GPU, then allreduce will be handled on GPU, also in hybrid case 
         (if some data is in main memory)

3.  About gpu_bind.sh: is there a reason why gpus are not attached to the numa nodes in a friendler way (gpu0 to numa0, etc...) ? because of the nic ?
  
    -    I guess hardware design and routing issues may have created this mess...

5.  When I run the following simple test found in https://github.com/csc-training/summerschool/blob/master/gpu-hip/memory-prefetch/solution/prefetch.cpp 
    on the NVIDIA-based system, I always get more or less the following kind of timings:
    ```
    Mahti timings (NVIDIA A100)
    The results are OK! (0.990s - ExplicitMemCopy)
    The results are OK! (0.744s - ExplicitMemPinnedCopy)
    The results are OK! (0.040s - ExplicitMemNoCopy)
    The results are OK! (2.418s - UnifiedMemNoPrefetch)
    The results are OK! (1.557s - UnifiedMemPrefetch)
    The results are OK! (0.052s - UnifiedMemNoCopy)
    ```
    However, on the LUMI with AMD GPUs, everything else looks good, but I don't understand why the 
    latter two cases are so slow. For example, putting a `hipMemPrefetchAsync` (that should speed up things), 
    looks to make it much slower in the second last case. In the last case, using `hipMemset` for a pointer to 
    a Unified Memory appears extremely slow:
    ```
    LUMI timings
    The results are OK! (0.748s - ExplicitMemCopy)
    The results are OK! (0.537s - ExplicitMemPinnedCopy)
    The results are OK! (0.044s - ExplicitMemNoCopy)
    The results are OK! (0.609s - UnifiedMemNoPrefetch)
    The results are OK! (3.561s - UnifiedMemPrefetch)
    The results are OK! (18.889s - UnifiedMemNoCopy)
    ```
    Any explanation?
    
    -   (AMD) I'm looking into it - not have an explanation ready to go as of now.

    -   (LUST) could an environment variable such as `HSA_XNACK=1` be needed here?

        -   Setting `HSA_XNACK=1` makes things worse:
            ```
            The results are OK! (3.357s - ExplicitMemCopy)
            The results are OK! (0.547s - ExplicitMemPinnedCopy)
            The results are OK! (0.070s - ExplicitMemNoCopy)
            The results are OK! (3.373s - UnifiedMemNoPrefetch)
            The results are OK! (3.950s - UnifiedMemPrefetch)
            The results are OK! (21.824s - UnifiedMemNoCopy)
            ```


7.  Do any modules need to be loaded to run `rocm-smi`? I get the following error:
    ```
    ERROR:root:Driver not initialized (amdgpu not found in modules)
    ```

    - (HPE) Are you running on the compute node?
    
        - R: Yes, but I think it should also run on the login node. I used to be able to run this both on compute nodes and login nodes. 
    
    -   (HPE) Login do not have GPUs and drivers. I'm running this (use your project ID):
        ```
        srun --nodes=1 --ntasks-per-node=1 -p pilot -A project_462000031 -t "00:10:00" --ntasks=1 --gres=gpu:8 rocm-smi
        ```
        On the login you can get the help though.

    Ok thank you. But why do I need to run this with `srun`? 
    
    -  The `srun` command gets you to the compute node.
    
    Ok sorry for the confusion. My question is why doesn't this work with `salloc`? 
    I ask for an interactive session, then cannot run rocm-smi there.
    
    -   So, `salloc` does reserves nodes for you, but you are still on the login node. 
        You need `srun` to "access" the compute nodes. Example:
        ```
        [13:21:26] ≈≈XXXXXX@uan04:~ > salloc --nodes=1 --ntasks-per-node=1 -p pilot -A project_XXXXXXXX -t "00:10:00" --ntasks=1 --gres=gpu:8 
        salloc: Pending job allocation 1442086
        salloc: job 1442086 queued and waiting for resources
        salloc: job 1442086 has been allocated resources
        salloc: Granted job allocation 1442086
        ho[13:21:29] XXXXXXXX@uan04:~ > hostname
        uan04
        [13:21:30] XXXXXXXX@uan04:~ > srun hostname
        nid005015    
        ```
        Does it make clear? Uan is the login node, nodes with nidXXX are compute nodes.
    
    Yes that is clear, thank you. On other clusters, salloc usually gives a shell on a compute node in my 
    experience. But I assume this is not the case here because ssh is not enabled.

    -   You can connect via srun shell, just in case... I think the difference in salloc is because the 
        login nodes are shared between LUMI-C and LUMI-G...

    -   (Someone from LUST) `salloc` on LUMI behaves as I am used from other clusters and a SLURM training 
        we got from SchedMD at my home university so I am not that surprised. It has nothing to do with ssh. 
        On the contrary, the reason why ssh is not enabled is that it does not necessarily take to the right 
        CPU set and the resources that are controlled by SLURM.

    -   (HPE) I think the salloc behaviour is site configurable.
    
6. I am wondering if the GPUDirect RDMA is supported on LUMI-G?
 
    -   I think the osu device to device copy that Alfio showed indicates this is the case.
    -   (HPE) Yes, it is supported.
 

7.  Are containers supported on lumi-g? With rdma ?
  
    -   [HPE] this is something we are looking at, but I don't think we have checked on the current software stack.

#### Remarks for this section

- There are xthi-like programs in the `lumi-CPEtools` modules. Load the module and check `man lumi-CPEtools` for more information.


### Introduction to the AMD ROCm<sup>(TM)</sup> Ecosystem

1.  **(Q)**: Is there a GPU memory pool allocator (that uses either hipMalloc or hipMallocManaged) for AMD GPUs?
 
    **(A)**: Can you clarify what exactly you are looking for - you mean an allocator for a given language or runtime?            
        
    **(Q)**: The point of pool allocator is to allocate a large memory pool which is reused. 
    So that recurrent alloc and free-calls do not recurrently allocate and free memory at 
    the system level, but instead just reuse the memory pool. I think CUDA recently added 
    memory pools (cf. cudaDeviceSetMemPool and cudaMallocAsync), but I have not used these yet. 
    Previously I have used Rapids Memory Manager with NVIDIA cards. This is really important 
    with applications which do recurring allocations and deallocations in a loop. For example 
    in the paper ["Leveraging HPC accelerator architectures with modern techniques - huydrologic modeling on 
    GPUs with ParFlow"](https://link.springer.com/content/pdf/10.1007/s10596-021-10051-4.pdf), 
    simply using GPU memory pool allocator gave additional 5x speed-up for the whole program 
    performance (instead of allocating and freeing things recurringly with cudaMallocManaged and cudaFree).

    **(Q)**: I see, you have hipDeviceSetMemPool but that is in 
    [rocm 5.2.0](https://docs.amd.com/bundle/HIP_Supported_CUDA_API_Guide_v5.2/page/CUDA_Runtime_API_functions_supported_by_HIP.html), 
    unfortunately that is not the version on LUMI but it is possible to install in user space 
    and have it to work with the existing driver. Apart from that there are many runtimes that 
    do similar things, I don't have an exaustive list. There are many libraries and portability 
    layers that come up with their own memory management - if there is one in particular you think 
    is worth us to look at I (Sam) am happy to do so.

    **(Q)**: Is that rocm5.2 also supporting memory pools for AMD GPUs, or only for NVIDIA GPUs? 
    The whole point is really to avoid having to write your own memory manager and using an 
    existing one, preferably one that is directly offered by HIP.

    **(A)**: Didn't try it but if it goes in HIP should be supported on AMD Instinct GPUs.
    
    **(Q)**: Do you know any libraries which would provide hipMallocManaged pool allocator for 
    AMD GPUs? I am not sure if the CUDA/HIP pools in rocm5.2 support Unified Memory.
    
    **(A)**:Just found Umpire (https://computing.llnl.gov/projects/umpire) which appears to support HIP+Unified Memory pool allocation

        
3.  Will tools like GPUFORT be available on LUMI?
 
    -   We strive to provide many development tools on LUMI-G, but in the beginning, 
        during the pilot phase, you are expected to install some of the tools that you need 
        by yourself. GPUFORT seems like a research project, so might not want to "officially" 
        support itif it is difficult to use. Regarding OpenACC in general (the use case for 
        GPUFORT?), Cray's Fortran compiler does support OpenACC offloading to the AMD GPUs, 
        so this might be a better approach.
     
4.  If there performance difference hipforrtran vs fortran + hip ?

     - There should not - hipfortran is awrapper exactly for fortran + hip.

5.  Question for HPE: Does the gcc that comes with the PE support OpenMP offload on AMD?

    -   No, the first version with Mi250X will be GCC 13. I do expect support in the PE when GNU will support the GPU.

6.  **(Q)**: Is there JAX support / tests? 

    **(A)**: I'm not familiar with this or the XLA dependencies,  else might be able to answer.
  
    **(Q)**: There is [a known issue on AMD](https://github.com/google/jax/issues/2012), seems to be unstable.

7. Does any AMD profiling app give backtrace for Unified Memory page fault locations?
 
    -   Unfortunatly, I am not aware of a way for one to do that with the profile. You can 
        try disabling unified memory (`export HSA_XNACK=0`) and see where code crashes and get the backtrace then.

9.  Is Perfetto available as a desktop application? Or can I look at AMD profiles offline somehow?
  
    -   Even though Perfetto runs on the browser, it does run locally. If you want to have your instance 
        served locally you can use a docker container, this is the image I use:
        ```
        FROM eu.gcr.io/perfetto-ci/sandbox

        RUN set -eux ; \
        cd /opt ; \
        git clone -b v20.1 https://github.com/google/perfetto

        WORKDIR /opt/perfetto
        RUN set -eux ; \
        tools/install-build-deps --ui

        RUN set -eux ; \
        ui/build

        RUN set -eux ; \
        sed -i 's/127\.0\.0\.1/0.0.0.0/g' ui/build.js

        EXPOSE 10000
        ENTRYPOINT []
        CMD ["./ui/run-dev-server", "-n"]
        ```
        build with
        ```
        #!/bin/bash

        docker network rm \
        lan-restricted

        docker network create \
        -o "com.docker.network.bridge.enable_ip_masquerade"="false" \
        lan-restricted

        docker run -p 10000:10000 --name myperfetto --network  lan-restricted myperfetto
        ```
        This will create a local server for Perfetto

10.  Is the following warning expected when running rocm-smi?
    ```
    ======================= ROCm System Management Interface =======================
    ================================= Concise Info =================================
    GPU  Temp   AvgPwr  SCLK    MCLK     Fan  Perf  PwrCap  VRAM%  GPU%  
    0    39.0c  88.0W   800Mhz  1600Mhz  0%   auto  560.0W    0%   0%    
    1    45.0c  N/A     800Mhz  1600Mhz  0%   auto  0.0W      0%   0%    
    2    43.0c  85.0W   800Mhz  1600Mhz  0%   auto  560.0W    0%   0%    
    3    41.0c  N/A     800Mhz  1600Mhz  0%   auto  0.0W      0%   0%    
    4    44.0c  82.0W   800Mhz  1600Mhz  0%   auto  560.0W    0%   0%    
    5    41.0c  N/A     800Mhz  1600Mhz  0%   auto  0.0W      0%   0%    
    6    41.0c  83.0W   800Mhz  1600Mhz  0%   auto  560.0W    0%   0%    
    7    40.0c  N/A     800Mhz  1600Mhz  0%   auto  0.0W      0%   0%    
    ================================================================================
    WARNING:                 One or more commands failed
    ============================= End of ROCm SMI Log ==============================
    ```
    -   The warning likely comes from SLURM because `rocm-smi` returns non-zero exit codes?

9.  What is the timeline of the pilot phase? When exactly does it start and when does it end?
  
    -   It will start on September 26th and last for a month.

###  AMD hands-on exercises

Files for  excersises on lumi are [available for download (tar file, 56k)](https://462000265.lumidata.eu/lumi-g-20220823/files/LUMI_G-AMD-Exercises.tar).
The README contains basic instructions

### General Q&A

1.  How to bind correctly mpi-rank <-> gpu-id?
    select_gpu.sh
    ```
    #!/bin/bash

    GPUSID="4 5 2 3 6 7 0 1"
    GPUSID=(${GPUSID})
    if [ ${#GPUSID[@]} -gt 0 -a -n "${SLURM_NTASKS_PER_NODE}" ]; then
        export ROCR_VISIBLE_DEVICES=${GPUSID[$((SLURM_LOCALID / ($SLURM_NTASKS_PER_NODE / ${#GPUSID[@]})))]}
    fi

    exec $*

    ```

    ```
    #SBATCH --job-name=NAME          # <--- SET 
    #SBATCH --output="NAME.%J.out"   # <--- SET
    #SBATCH --error="NAME.%J.err"    # <--- SET
    #SBATCH --nodes=2                # <--- SET: Number of nodes, each noode has 8 GPUs
    #SBATCH --ntasks=16              # <--- SET: Number of processes you want to use, MUST be nodes*8 !!!
    #SBATCH --gpus=16                # <--- SET: MUST be the same as ntasks !!!
    #SBATCH --time=15:00             # <--- SET: Walltime HH:MM:SS
    #SBATCH --mail-type=ALL
    #SBATCH --mail-user=your@email   # <--- SET: if you want to get e-mail notification
    #SBATCH --partition=eap 
    #SBATCH --account=project_465000150 
    #SBATCH --cpus-per-task=1        # Do not modify
    #SBATCH --ntasks-per-node=8      # Do not modify

    # Set environment
    export MPICH_GPU_SUPPORT_ENABLED=1 

    # the simple call
    srun -n 16 ./td-wslda-3d input.txt

    # I mapping provided above.

    --------------------------------------------------------------------
    # START OF THE MAIN FUNCTION
    # CODE: TD-WSLDA-3D
    # PROCESS ip=6 RUNNING ON NODE nid005100 USES device-id=6
    # PROCESS ip=1 RUNNING ON NODE nid005100 USES device-id=1
    # PROCESS ip=7 RUNNING ON NODE nid005100 USES device-id=7
    # PROCESS ip=5 RUNNING ON NODE nid005100 USES device-id=5
    # PROCESS ip=4 RUNNING ON NODE nid005100 USES device-id=4
    # PROCESS ip=3 RUNNING ON NODE nid005100 USES device-id=3
    # PROCESS ip=2 RUNNING ON NODE nid005100 USES device-id=2
    # PROCESS ip=12 RUNNING ON NODE nid005104 USES device-id=4
    # PROCESS ip=13 RUNNING ON NODE nid005104 USES device-id=5
    # PROCESS ip=15 RUNNING ON NODE nid005104 USES device-id=7
    # PROCESS ip=8 RUNNING ON NODE nid005104 USES device-id=0
    # PROCESS ip=14 RUNNING ON NODE nid005104 USES device-id=6
    # PROCESS ip=10 RUNNING ON NODE nid005104 USES device-id=2
    # PROCESS ip=11 RUNNING ON NODE nid005104 USES device-id=3
    # PROCESS ip=9 RUNNING ON NODE nid005104 USES device-id=1
    # PROCESS ip=0 RUNNING ON NODE nid005100 USES device-id=0
    ...
    ```

2.  What has changed over the past 2 weeks (software and or hardware) ? I was running PyTorch code 
    using [this container](https://hub.docker.com/r/rocm/pytorch) more or less reliably at the beginning of the pre pilot phase using rccl backend. I haven't touched it since and tried again today and I seem to have network issues:

    ```
    nid005000:30599:30731 [0] /long_pathname_so_that_rpms_can_package_the_debug_info/data/driver/rccl/src/include/socket.h:415 NCCL WARN Net : Connect to 10.120.24.10<52061> failed : No route to host
    ```

    Any ideas?
    
    -   (AMD): Try `export NCCL_SOCKET_IFNAME=hsn0,hsn1,hsn2,hsn3` let RCCL focus on the right 
        network interfaces. Also `export NCCL_DEBUG=INFO` to get more info. `export NCCL_DEBUG_SUBSYS=INIT,COLL`.

