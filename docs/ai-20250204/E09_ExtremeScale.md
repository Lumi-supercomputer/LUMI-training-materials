# Demo/Hands-on: Using multiple nodes

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20250204/09_Extreme_scale_AI).
-->
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/09_Extreme_scale_AI).

<!--
A video recording of the discussion of the solution will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20250204/recordings/E09_ExtremeScale.mp4" controls="controls"></video>


## Q&A

1.  In the PyTorch exercise, how to enable compiling pytorch during the runtime ? - Does it require MiOpen lib ?
    
    -   Can you clarify what you mean (or hope to achieve) with compiling Pytorch?

    -   If you mean just-in-time compile there might happen at different levels. 
        MIOpen uses that (and should be available for you when you install ROCm), but you can also see that through the Triton module and others.

    -   I think it should work out-of-the-box usually? It doesn't work for you? 


2.  Can you provide some information on how to call the [wrapper script](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/09_Extreme_scale_AI/reference_solution) for the LLM example ?

    -   That is exactly what is [here](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/09_Extreme_scale_AI):

    -   Yes, you simply put the script before the actual command you want to execute
        ```
        MASTER_ADDR=$(scontrol show hostname "$SLURM_NODELIST" | head -n1) \
        srun -N1 -n8 --gpus 8 \
            --cpu-bind=mask_cpu=0x00fe000000000000,0xfe00000000000000,0x0000000000fe0000,0x00000000fe000000,0x00000000000000fe,0x000000000000fe00,0x000000fe00000000,0x0000fe0000000000\
            singularity exec \
            -B .:/workdir \
            /appl/local/containers/sif-images/lumi-pytorch-rocm-6.1.3-python-3.12-pytorch-v2.4.1.sif  \
            /workdir/run.sh \
                python -u /workdir/GPT-neo-IMDB-finetuning-mp.py \
                    --model-name gpt-imdb-model \
                    --output-path /workdir/train-output \
                    --logging-path /workdir/train-logging \
                    --num-workers 7
        ```

3.  About the hands-on exercise for 09 Extreme scale AI work, after running the code on 2 nodes, how can monitor the GPU utilization?

    -   You can add `-w <target_node>` to the srun call that runs `rocm-smi` to get the GPU utilization for the individual nodes.

4.  About the hands-on exercise for 09 Extreme scale AI work, after running the code on 2 nodes, how can monitor the GPU utilization?

    -   You can add -w <target_node> to the srun call that runs rocm-smi to get the GPU utilization for the individual nodes.
  
    
