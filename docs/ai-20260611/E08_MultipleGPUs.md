# Hands-on: Converting the PyTorch single GPU AI training job to use all GPUs in a single node via DDP

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20251009/08_Scaling_to_multiple_GPUs).

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/08_Scaling_to_multiple_GPUs).
-->

<!--
A video recording of the discussion of the solution will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20251008/recordings/E08_MultipleGPUs.mp4" controls="controls"></video>


## Q&A

1.  Does `cotainr` set `SINGULARITY_CACHEDIR` and `_TMPDIR` internally?

    -   Is your question essentially where the container is build? If yes, 
        then `cotainr` creates a singularity sandbox in the `/tmp` folder. 
        It uses the `tempfile` module built into python to determine the folder. 


