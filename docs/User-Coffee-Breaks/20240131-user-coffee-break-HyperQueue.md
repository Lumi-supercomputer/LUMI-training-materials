# Open OnDemand: A web interface for LUMI (January 31, 2024)

*Presenters:* Jakub Beránek and Ada Böhm (IT4Innovations)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20240131-user-coffee-break-HyperQueue.mp4" controls="controls">
</video>


## Q&A

[Full archive of all LUMI Coffee Break questions](https://hackmd.io/@lust/coffeearchive#). This page only shows the 
questions from the HyperQueue session.


### HyperQueue-specific questions

1.  How does HyperQueue compare to other workflow managers such as Nomad (by Hashicorp)?

    -   The question was briefly touched in the presentation but without a full answer.


### Other questions

1.  Any progress regarding how to work with sensitive data on LUMI?

    - "An architecture draft will be reviewed in week 5. Implementation is planned for Spring/Summer 2024."

2.  I am porting a code to run on LUMI-G, and encountered a strange data transfer issue (CPU-GPU) 
    which I can't understand. The code is calling "hiprandGenerateUniformDouble" at this point and 
    out of 8 MPI processes only RANK 0 is able to show the device generated random numbers on host 
    after updating them from device. Rest of the ranks fail (Memory access fault message with C
    RAY_ACC_DEBUG variable) while updating data back to host from their respective devices. 
    The data transfer is managed by OpenMP pragmas. I have verified (with omp_get_default_device() & 
    hipGetDevice()) that  all MPI ranks are well running on their own devices. I have  
    this short test ready to quickly go through the issue. Would it be possible for someone to have a
    look at this issue with me during this coffee break session? Thanks   

    -    It is not obvious for me what might be causing this. What comes to mind is a mismatch of set 
         device IDs in the OpenMP runtime and the hipRAND handler. To narrow down the issues search 
         space I'd make sure that each rank only sees a single GPU with ROCR_VISIBLE_DEVICES. 
         For instance one can use: ROCR_VISIBLE_DEVICES=$SLURM_LOCALID. I'll (Sam from AMD) be in 
         the coffee break and we can take a closer look.

3.  We have recently undertaken the task of porting URANOS, a Computational Fluid Dynamics code, to AMD GPUs. 
    While the code using the OpenACC standard. it was predominantly optimized for NVIDIA machines, so we have 
    encountered some performance challenges on AMD cards. 
    We are reaching out to inquire whether there are individuals within the LUMI staff who can share some 
    pieces of kwnoledge in optimizing code performance specifically for AMD GPUs. 
    We would greatly appreciate any assistance or guidance 
   
    -   We may need HPE people to also chime in here. My experience with OpenACC comes from very flat codes. 
        Here, the performance implications are a mix of runtime overheads and kernel performance. The former can 
        be assessed with a trace of the GPU activity and the later can be done with a comparison of kernel 
        execution time with other vendors. I've seen the Cray Compiler OpenACC runtime being a bit conservative
        on how to control dependencies with some redundant runtime calls that can be lifted. Other things might 
        come from register pressure and some device specific tunning (loop tilling for example). The register 
        pressure is connected with the setting of launch bounds - unfortunatelly setting the number threads 
        is not sufficient and a thread limit clause needs to be used instead. Tilling requires change a bit the code. 
        We can discuss further during the coffee break.

4.  We try to understand why we don't the performance we exepct from the GPUs on LUMI-G but our software 
    is too complicated to trace itself. So I'm looking for much simpler examples, to measure individual 
    functionallities, such as data transfers, FFTs, bandwidth, etc. Is there a repository of simple to 
    complex examples for GPU execution on LUMI-G? 

    -   Not sure if it will cover everything needed but AMD has some examples used for training: 
        https://github.com/amd/HPCTrainingExamples. There are also the AMD blog notes that can help with 
        some trimmed down examples https://gpuopen.com/learn/amd-lab-notes/amd-lab-notes-readme/. 
        These are not really benchmarks and not meant for performance assessment but could be helpful 
        for testing along those lines.

