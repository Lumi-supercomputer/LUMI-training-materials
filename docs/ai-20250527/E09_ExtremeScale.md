# Demo/Hands-on: Using multiple nodes

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20250527/09_Extreme_scale_AI).
-->

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/09_Extreme_scale_AI).

<!--
A video recording of the discussion of the solution will follow.
-->

<!--
<video src="https://462000265.lumidata.eu/ai-20250527/recordings/E09_ExtremeScale.mp4" controls="controls"></video>
-->


## Q&A

8.  With this command:
  
    ```
    srun -N 1 -n 1 \
    --pty \
    --jobid <jobid> \
    -w <target_node> \
    --overlap \
    /usr/bin/bash
    ```
    How do I find the `<target_node>`
    
    -   `squeue --me` shows your jobs and the nodes they run on.

    -   If you want to check "just a node", you can also omit the `-w` and only use the `--jobid`. 
        In that case you will run on the first node of the allocation.
