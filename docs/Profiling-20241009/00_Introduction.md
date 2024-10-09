# Introduction

<em>Presenters: Jørn Dietze (LUST) and Harvey Richardson (HPE)</em>

<!--
<video src="https://462000265.lumidata.eu/profiling-20241009/recordings/00_Introduction.mp4" controls="controls">
</video>

-   The video is also available as `/appl/local/training/profiling-20241009/recordings/00_Introduction.mp4`
-->


## Q&A

1.  We have trouble creating our container on LUMI. Is it expected that it is in place before 
    the Hackathon starts, or can we get help to do this in the beginning of the Hackathon. 
    Preferrable, we would like to get some help before the Hackathon.

    -   Did your LUST mentor contact you? They may offer some help. The more of those things are 
        done before the hackathon, the more time can actually be spent on the goals of the hackathon.

    -   There are also updated container images (prebuilt by us) at: ` /appl/local/containers/sif-images/`

    Okay, nice. How do we load one of these images to look what packages are available inside them?

    -   They use a conda installation internally. So `singularity shell <path to the .sif file>` and then at the command prompt `$WITH_CONDA`. The latter is an environment variable that contains the commands that should be executed to activate the conda environment. Then you can just look around in the container and use the usual tools to, e.g., get a list of python packages (`conda list`).

    -   In case, some packages are missing, also check out 
        [this presentation on how to extend our containers](https://lumi-supercomputer.github.io/LUMI-training-materials/ai-20240529/extra_07_VirtualEnvironments/)
    

