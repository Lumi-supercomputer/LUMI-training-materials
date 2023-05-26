# Day 2 General Q&A

1.  What is the `libfabric` module that is loaded by default upon login?
    - It is the library necessary for the node interconnect (slingshot) to work. It will be automatically loaded if you load `craype-network-ofi` module which is standard if you login or use one of the described Software stacks.

2.  I know it is not the object of today course, but may I still ask how launch I a job on LUMI-G ?
    As Kurt said, first:
    reload LUMI/22.08 partition/G
    and then do I have to specify a specific --partition with the sbatch command ?
    - Yes, you have to use `--partition=pilot` but this only works at the moment if you are member of a GPU-pilot project. Alternatively you can use the `eap` partition which is available for everyone on LUMI and consists of the same GPU nodes, but has shorter walltime limits. `eap` is intended for testing only, not for production runs.
    - partition `gpu` is shown but currently not available (it is for the HPE benchmarking) instead `pilot` and `eap` have to be used.
    - Thank you for the precision. My project is mostly GPU oriented, so we did not ask for CPU as we thought a minimum amount of CPU would be included. Will it be possible to launch jobs on LUMI-G without any CPU resources or should I ask for additional CPU resources ?
    - **[Kurt]** In regular operation you will only need GPU billing units to run on the GPUs. However, at the moment, during the pilot, the situation is different:
        - The Early Access Platform (partition `eap`) does not require GPU billing units. It is also not charged, but usage is monitored and should remain reasonable, i.e., development and first benchmarking only. However, to get access to the queue, a minimal CPU allocation is needed.
        - The `pilot` partition is for pilot users only and this one requires GPU billing units but no CPU allocation.  

