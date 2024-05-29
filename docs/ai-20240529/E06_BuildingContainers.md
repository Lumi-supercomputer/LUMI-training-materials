# Hands-on: Creating a conda environment file and building a container using cotainr

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/06_Bulding_containers_from_conda_pip_environments).


## Q&A

1.  I get the following error `ValueError: Invalid command cmd='bash conda_installer.sh -b -s -p /opt/conda' passed to Singularity resulted in the FATAL error: FATAL:   container creation failed: mount /appl->/appl error: while mounting /appl: destination /appl doesn't exist in container` when running `cotainr build python312.sif --system=lumi-c --conda-env=python312.yml`

    -   Try logging in and out of LUMI. I have feeling that you have too many conflicting variables/modules set.

    -   (Christian) It looks like you are trying to build a container using cotainr while having the `singularity-userfilesystems` module loaded. Unfortunately, this doesn't currently work because you try to bind mount a path inside the container during the build that isn't already in the container directory tree which results on a FATAL error. It's a bug in cotainr.

