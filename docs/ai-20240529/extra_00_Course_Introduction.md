# Welcome and course introduction

*Presenters:* Jørn Dietze (LUST) and Christian Schou Oxvig (LUST & DeiC)


## Q&A

Questions asked before the start of the course or in the wrong section of the HedgeDoc:

1.  Is headless rendering supported on AMD/LUMI inside containers?

    -   (Christian) If you mean rendering of graphics and visualizations, the AMD MI250X GPUs do not really support this. However, LUMI does a few [LUMI-D](https://docs.lumi-supercomputer.eu/hardware/lumid/) nodes that features Nvidia A40 GPUs specifically designed for rendering and visualization.

    -   (Kurt) But you can use pure software rendering of course.

2.  Which container images are recommended for using Pytorch with rocm, i.e. can standard Docker containers be used?`docker pull rocm/pytorch:rocm6.1.1_ubuntu22.04_py3.10_pytorch_release-2.1.2`

    -   (Christian) Yes, you can use standard Docker containers, **but** they need to based on a ROCm version that is compatible with LUMI and you may not get optimal performance when using more than a single LUMI-G node. This will be covered in more detail in sessions throughout the workshop - including recommendations for which PyTorch containers to use with LUMI.

3.  Do containers need to be built on your laptop and then uploaded or can the containers be built on LUMI itself?

    -   (Christian) On LUMI you can do rootless container builds, so you don't necessarily have to build containers on your laptop. More details will be given in the workshop sessions covering running and building containers on LUMI.

4.  Are there specific driver versions for rocm which MUST to be used with the GPU hardware of LUMI?

    -   (Christian) Yes, you have to use versions of ROCm that are compatible with the version of the AMD GPU driver installed on LUMI. More details will be given in the workshop sessions.

