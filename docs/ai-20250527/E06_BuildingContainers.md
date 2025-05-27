# Hands-on: Creating a conda environment file and building a container using cotainr

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20250527/06_Bulding_containers_from_conda_pip_environments).
-->

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/06_Bulding_containers_from_conda_pip_environments).

<!--
A video recording of the discussion of the solution will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20250527/recordings/E06_BuildingContainers.mp4" controls="controls"></video>


## Q&A

1.  Is there a LUMI-ready singularity container that has Python 3.8 or greater? It's a bit weird actually.
    ```
    XXXXXXXX@uan01:/project/project_465001958/XXXXXXXX/05_Running_containers_on_LUMI> singularity shell /appl/local/containers/sif-images/lumi-pytorch-rocm-6.1.3-python-3.12-pytorch-v2.4.1.sif
    Singularity> python3 --version
    Python 3.6.15
    ```
    -   Did you initialise the Conda environment in the container with `$WITH_CONDA`? There are often two Pythons: The OS one which is very old and this seems to be the one from SUSE 15, and the actual Python that should be used. Enterprise class OSes keep versions of Python, gcc and some other programs fixed for the entire lifetime of the major release to not break compatibility. Red Hat has a similar policy.
