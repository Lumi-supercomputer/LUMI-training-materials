# Introduction to Python on Cray EX

*Presenter: Alfio Lazzaro (HPE)*

-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-4_02_Introduction_to_Python_on_Cray_EX.pdf`
    -   `/project/project_465000524/slides/HPE/13_Python_Frameworks.pdf` (temporary, for the lifetime of the project)
-   Recording available on LUMI as:
    `/appl/local/training/4day-20230530/recordings/4_02_Introduction_to_Python_on_Cray_EX.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

## Q&A

1.  Are Pytorch and Tensorflow installed on LUMI, or users shall install those themselves? I couldn't find any related modules with "module spider pytorch" or "module keyword pytorch". 

    - https://docs.lumi-supercomputer.eu/software/packages/pytorch/
    - Most users want PyTorch with additional packages anyway so need a customised installation.
    - (Christian) I would highly recommend to use a [Singularity/Apptainer container](https://docs.lumi-supercomputer.eu/software/containers/singularity/). Take a look at the [ROCm dockerhub containers](https://hub.docker.com/u/rocm) to see if they fit your needs. If you need a more customized container and are used to conda/pip environments, have a look at [cotainr](https://https://cotainr.readthedocs.io/en/latest/user_guide/conda_env.html) which makes it very easy to build a container based on your conda/pip environment (just remember that you have make your conda/pip environment compatible with LUMI, e.g. installing a ROCm-enabled PyTorch wheel). On LUMI cotainr is available via `module load LUMI`, `module load cotainr`.
    - (Christian) You may also use the container based modules from the [local CSC software stack](https://docs.lumi-supercomputer.eu/software/local/csc/). Just be aware that these are primarily intended for the CSC users. Support for this local software stack is provided by CSC - the LUMI User Support Team can only provide very limited support.
