# Moving your AI training jobs to LUMI workshop - Copenhagen, May 29-30 2024

## Course organisation

-   Location: [NORDUNets, Kastruplundgade 22, DK-2770 Kastrup, Denmark](https://maps.app.goo.gl/nD6Q3ZRFU5st9Gk76)

-   [Schedule](schedule.md)

-   [HedgeDoc for questions](https://md.sigma2.no/lumi-ai-workshop-may24?both)

-   There are two Slurm reservations for the course. One for each day:

    -   First day: `AI_workshop` (on the `small-g` Slurm partition)
    -   Second day: `AI_workshop_2` (on the `standard-g` Slurm partition)



## Setting up for the exercises

If you have an active project on LUMI, you should be able to make the exercises in that project.
To reduce the waiting time during the workshop, use the SLURM reservations we provide (see above).

You can find all exercises on our [AI workshop GitHub page](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop)


## Course materials

**Note:** Some links in the table below will remain invalid until after the course when all
materials are uploaded.

| Presentation | Slides | recording |
|:-------------|:-------|:----------|
| [Introduction to LUMI](extra_01_Introduction.md) | [slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-01-Lumi_intro.pdf) | [video](extra_01_Introduction.md) |
| [Using the LUMI web-interface](extra_02_Webinterface.md) | [slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-02-Using_LUMI_web_UI.pdf) | [video](extra_02_Webinterface.md) |
| [Hands-on: Run a simple PyTorch example notebook](E02_Webinterface) | / | / |
| [Your first AI training job on LUMI](extra_03_FirstJob.md) | [slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-03-First_AI_job.pdf) | [video](extra_03_FirstJob.md) |
| [Hands-on: Run a simple single-GPU PyTorch AI training job](E03_FirstJob.md) | / | / |
| [Understanding GPU activity & checking jobs](extra_04_Workarounds.md) | [slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-04-Understanding_GPU_activity.pdf) | [video](extra_04_Workarounds.md) |
| [Running containers on LUMI](extra_05_RunningContainers.md) | [slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-05-Running_containers_on_LUMI.pdf) | [video](extra_05_RunningContainers.md) |
| [Building containers from Conda/pip environments](extra_06_BuildingContainers.md) | [slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-06-Building_containers_from_conda_pip_environments.pdf) | [video](extra_06_BuildingContainers.md) |
| [Extending containers with virtual environments for faster testing](extra_07_VirtualEnvironments.md) | [slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-07-Extending_containers.pdf) | [video](extra_07_VirtualEnvironments.md) |
| [Scaling AI training to multiple GPUs](extra_08_MultipleGPUs.md) | [slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-08-Scaling_multiple_GPUs.pdf) | [video](extra_08_MultipleGPUs.md) |
| [Hyper-parameter tuning using Ray](extra_09_Ray.md) | [slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-09-Hyperparameter_tuning_ray.pdf) | [video](extra_09_Ray.md) |
| [Extreme scale AI](extra_10_ExtremeScale.md) | [slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-10-Extreme_scale_AI.pdf) | [video](extra_10_ExtremeScale.md) |
| [Loading raining data from Lustre and LUMI-O](extra_11_LUMIO.md) | / | [video](extra_11_LUMIO.md) |
| [Coupling machine learning with HPC simulation](extra_12_Coupling.md) | / | [video](extra_12_Coupling.md) |


## Web links

-   LUMI documentation

    -   [Main documentation](https://docs.lumi-supercomputer.eu/)

    -   [Shortcut to the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/)
