# Scaling AI training to multiple GPUs

*Presenters:* Mats Sjöberg (CSC) and Lukas Prediger (CSC)

Content:

-   PyTorch DDP on LUMI
-   Setting up the experiment as a SLURM batch job
-   Setting the correct CPU-GPU bindings


<video src="https://462000265.lumidata.eu/ai-20241126/recordings/08_MultipleGPUs.mp4" controls="controls"></video>


## Extra materials

-   [Presentation slides](https://462000265.lumidata.eu/ai-20241126/files/LUMI-ai-20241126-08-Scaling_multiple_GPUs.pdf)

-   [Hands-on exercises](E08_MultipleGPUs.md)


## Q&A

1.  Do you have experience of setting cpu affinity for Pytorch Lightning? Is it automatically taken care of?

    -   I don't have experience with Lightning in particular, but I'm pretty sure it doesn't work automatically as the specific setup differs from system to system and there's no easy way to automatically detect it.



