# Hands-on: Advancing your own project and general Q&A

Bring your own AI code, you want to run on LUMI, and spent some time applying what 
you have learned during the workshop - with on-site support from LUST/AMD.


## General Q&A

1.  ROCm 6.3 came out yesterday. What improvements can we expect for AI, and is there any chance to get it on LUMI?

    -   I am actually unsure if has been officially released. It has been made available for testing but the actual release should come with 
        [release notes](https://rocm.docs.amd.com/en/latest/about/release-notes.html).

    -   ROCm 6.3 has to be tested as it is getting out of expected driver support. Hopefully, it can be made available in a container to start with.

    Looks like someone at AMD has been a bit uncareful then: 
    [This article in an AMD blog](https://community.amd.com/t5/ai/unlocking-new-horizons-in-ai-and-hpc-with-the-release-of-amd/ba-p/726434) 
    was picked up by a lot of press last night.


1.  Is Megatron-LM a possibility on LUMI?

    -   I think TurkuNLP group (University of Turku, Finland) and Silo AI have been using that for training large language models on LUMI. So, yes, although it might not work out-of-the-box, they might be using a version that has been ported to LUMI.

    -   Megatron-Deepspeed is supported in AMD GPUs. There are hipified version of Megatron-LM that have been succesfully hipified for LUMI.

2.  Is ONNX supported?

    -   I haven't tested it myself on LUMI, but I don't see why it wouldn't work.

    -   ONNX runtime should be supported.

3.  If we use accelerate, do we still need to set the torch thread strategy to spawn in our script?

    -   Yes


6.  Does it make sense / any advantage to using torch compile with FSDP?

    -   It's difficult to give general guidance around this. It may make sense to your application - is a matter of testing and see if it works as expected.


7.  I am using a dynamic batch data collator and am seeing 100% VRAM on some GPUs in rocm-smi, will i be fine? Is there a reasonably involved way i can attribute what part of VRAM is used by which part of my pytorch script to understand better how datasets affect the memory requirements?

     -   Maybe having a look at PyTorch's [Understanding CUDA Memory Usage](https://pytorch.org/docs/stable/torch_cuda_memory.html) will help you -Lukas


8.  When using FSDP with accelerate and fsdp_cpu_ram_efficient_loading: true i still get an oom at the end of training, when setting the full state dict to save the model, despite the model only being 70B (~140GB with bpw=2), any ideas what to try?
logs:
    ```
    slurmstepd: error: Detected 1 oom_kill event in StepId=8538204.0. Some of the step tasks have been OOM Killed.
    slurmstepd: error: Failed to destroy CXI Service ID 5 (cxi0): Device or resource busy
    slurmstepd: error: Failed to destroy CXI Service ID 5 (cxi0): Device or resource busy
    slurmstepd: error: Failed to destroy CXI Service ID 5 (cxi0): Device or resource busy
    slurmstepd: error: Failed to destroy CXI Service ID 5 (cxi0): Device or resource busy
    slurmstepd: error: Failed to destroy CXI Service ID 5 (cxi0): Device or resource busy
    slurmstepd: error: switch_g_job_postfini: Device or resource busy
    srun: error: nid006024: task 0: Out Of Memory
    srun: Terminating StepId=8538204.0
    srun: error: nid006900: task 1: Terminated
    srun: error: nid007125: task 2: Terminated
    srun: error: nid007405: task 3: Terminated
    srun: Force Terminated StepId=8538204.0
    Finished at: 2024-11-27T15:37:59 EET
    ```

    -   It looks like it runs out of CPU memory (not GPU memory). It's hard to say what is the problem. If your program puts a lot of files in `/tmp`, keep in mind that that is a ramdisk so it also uses up CPU memory.

