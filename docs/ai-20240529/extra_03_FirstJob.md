# Your first training job on LUMI

*Presenters:* Mats Sjöberg (CSC) and Lukas Prediger (CSC)

## Q&A

9.  Why in --mem-per-gpu=60G it is 60 GB, not 64?

    -   Because the nodes have only 480 GB available per user of the 512 GB, so 1/8th of that is a fair use per GPU. Which gives 60 GB. Note that this is CPU memory and not GPU memory!

        It was actually explained later in the presentation, after this question was asked. 
   

10. Does AMD have some alternative to nvidia ngc? Premade singularity images?

    -   AMD has a [ROCm dockerHub project](https://hub.docker.com/u/rocm) where the latests containers go, e.g. Pytorch.

    -   There is also [InfinityHub](https://www.amd.com/en/developer/resources/infinity-hub.html) but this contains possibly more datated versions, so I recommend using DockerHub for AI-related images.

    -   The other part of the equation here is that the publicly available containers do not (they can't because of license issues) the network related bits, so they are not ready to run efficiently accross nodes. For that, we recommend using the LUMI provided containers under `/appl/local/containers/sif-images`. The containers suggested for this training event are based on those. More details will be given in a later session today.


