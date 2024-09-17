# Exercise session 1: Running applications

Exercises are in `Exercises/HPE/day1/ProgrammingModels`.`

See `Exercises/HPE/day1/ProgrammingModels/ProgrammingModelExamples_SLURM.pdf`
Run on the system and get familiar with Slurm commands.


## Materials

<!--
No materials available at the moment.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   See the exercise assignments in
    `/project/project_465001098/Slides/HPE/Exercises.pdf`

-   Exercise materials in 
    `/project/project_465001098/Exercises/HPE/day1/ProgrammingModels` 
    for the lifetime of the project and only for project members.

    See `/project/project_465001098/Exercises/HPE/day1/ProgrammingModels/ProgrammingModelExamples_SLURM.pdf`

Temporary web-available materials:

-    Overview exercise assignments day 1 temporarily available on
     [this link](https://462000265.lumidata.eu/4day-20240423/files/LUMI-4day-20240423-1_Exercises_day1.pdf)

-    Exercise notes (ProgrammingModelExamples_SLURM.pdf) on
     [this link](https://462000265.lumidata.eu/4day-20240423/files/LUMI-4day-20240423-1_04a-ProgrammingModelExamples_SLURM.pdf).
-->

Archived materials on LUMI:

-   Exercise assignments in `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-Exercises_HPE.pdf`

-   Exercises as bizp2-compressed tar file in
    `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-Exercises_HPE.tar.bz2`

-   Exercises as uncompressed tar file in
    `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-Exercises_HPE.tar`


## Q&A


2.  Instead of slurm I would be interested in using [myqueue](https://myqueue.readthedocs.io/en/latest/) 
    to submit my scripts. Do you know if this is possible? https://myqueue.readthedocs.io/en/latest/

    -   We do not recommend it but you can try it yourself. It may be tricky to configure properly 
        and we do not offer support fot the tool. Remember you will be charged for automatically 
        (re)submitted jobs which can run out of your control if the myqueue instance is not properly configured. 

3.  I'm trying to compile the pi_hip.cpp `CC -xhip -o test.hip pi_hip.cpp`, BUT I am getting 26 warnings. e.g. 

    ```
    In file included from /opt/rocm/hip/include/hip/amd_detail/texture_fetch_functions.h:26:
    In file included from /opt/rocm/hip/include/hip/amd_detail/../../../../include/hip/amd_detail/texture_fetch_functions.h:28:
    /opt/rocm/hip/include/hip/hip_texture_types.h:25:9: warning: This file is deprecated. Use file from include path /opt/rocm-ver/include/ and prefix with hip [-W#pragma-messages]
    #pragma message("This file is deprecated. Use file from include path /opt/rocm-ver/include/ and prefix with hip”)
    ```

    How to get rid of those warnings ? 

    -   This is the Cray compiler wrapper including the old (deprecated) path. This is harmless and can be ignored. 
        If it really bother you, you can use the `-Wno-#pragma-messages` compiler flag to silence the warning. 

4.  How to launch one simple command with srun, which partition and command to use?

    -   You need to specify partition with `-p` option, `standard-g` for GPU nodes and `standard` for CPU only

    -   Project account is also mandatory with `-A` option, `project_465001098` is for the training purpose

    -   You can also use reservation to use extra reserved resources, `--reservation=LUMItraining_G` or `LUMItraining_G`; this is only valid for this training

    -   To get actual GPU devices allocated, use `--gpus=` from `1` to `8`  for per node allocation

    -   Use `--exclusive` to get the node(s) allocated for your job exclusively, if you submit to `small(-g)` or `dev-g` partitions

5.  What if I get this error when trying to utilize GPU resources?
 
    ```
    salloc -p dev-g -A project_465001098 -n 1 --gpus=8
    salloc: Pending job allocation 6925988
    salloc: job 6925988 queued and waiting for resources
    salloc: job 6925988 has been allocated resources
    salloc: Granted job allocation 6925988
    piangate@uan01:~/prova1> rocm-smi 
    cat: /sys/module/amdgpu/initstate: No such file or directory
    ERROR:root:Driver not initialized (amdgpu not found in modules)
    ```
    
    -   `salloc` gives you the reserved node, then you need srun to run on it 
        (you see in the prompt that you are still on uan after the salloc). 
        You can even open a bash on the compute node via `srun -n1 --pty bash` 
        (best is to specify allocation time on salloc)

    -   Try `srun rocm-smi`


