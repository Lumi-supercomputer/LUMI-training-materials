# The HPE Cray EX Architecture

*Presenter: Harvey Richardson (HPE)*

-   Slides available on LUMI as:
    -   `/project\project_465000524/slide/HPE/01_EX_Architecture.pdf`
    -  Permanent location when available:  `/project/project_465000524/slides/HPE/1_01_HPE_Cray_EX_Architecuture.pdf`

These materials can only be distributed to actual users of LUMI (active user account).

## Q&A

1.  Could you elaborate what memory coherency between GPUs and CPUs means?

    **Answer** [**Kurt**] I'll ask the AMD people to comment a bit more on it during their presentation as it is something that is even unclear to the support team at the moment. There is a difference between what the hardware can do and what can be done with good performance. As the GPUs are connected through xGMI/InfinityFabric to the CPU full cache coherency is in theory possible but in practice there is a bandwidth problem so I don't think any user of LUMI has fully exploited this.
    
    **Answer** [**Sam AMD**] Coherency means there are some guarantees provided by the hardware and runtimes when it comes to make memory activity visible to the different resources in the system: CPUs and GPUs, as well as within the resources in each CPU and GPU. It is fair to think as memory being fully coherent accross CPU threads. When it comes to CPU and GPU memory that is still the case, though there are cases when that is true only at the synchroization points between the two devices. 
    It is important to distinguish between the so called coarse-grain memory and fine-grain memory. Coarse-grain memory is provided by default by the HIP runtime through its hipMalloc API whereas fine-grain memory is provided by default by the other memory allocators available on the system. For instance, it is only valid to do a system-wide atomic in fine-grained memory as course-grain memory coherency outside synchronization points is only guaranteed within a GCD (Graphics Compute Die). 
    
    **Followup** [**Juhan Taltech**]: When thinking from the user point of view, e.g. using PyTorch, would there be some additional convenience or is this currently not yet available at 3rd party library level? There are separate instructions for moving tensors from/to differet memories.
    
    **Answer** [**Sam AMD**] There is no real difference in the memories - virtual address space is the same - is just in the allocators which provide different coherency semantics. E.g. if Pytorch allocates a piece of memory it has to work with its semantics. This is not different than what Pytorch has been doing for other GPU vendors. If someone uses the high-level Pytorch interface to control the placement of tensors, he/she  can trust the implementation to do the right thing, e.g. if there is coarse-grained memory being used makes sure a synchroniation or some mechanism of assuring dependencies (stream) is in place. If an implementation is making assumptions on some coherency semantic it has to make sure the allocators are correct. E.g. OpenMP requires the user to indicate unified shared memory to prevent the runtime from creating coarse-grain memory transfers.
    
    For completeness, the coherency mechanism between CPU-GPUs is fueled by the xGMI link hability to force the retry of a memory access in the presence of a page-fault. This is enabled by default and can be disabled per-process by doing `export HSA_XNACK=0`. Doing so will result in a seg-fault if the program tries to access physical memory on a GPU that belongs to the CPU or vice-versa.