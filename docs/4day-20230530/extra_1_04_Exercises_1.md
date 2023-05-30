# Exercise session 1

No materials available at the moment.

-   Exercise materials in 
    `/project/project_465000524/exercises/HPE/day1/ProgrammingModels`.

    See `/project/project_465000524/exercises/HPE/day1/ProgrammingModelExamples_SLURM.pdf`


## Q&A

1.  sprun command in the very end of the exercise pdf, is that a typo ?
 
        **Answer** Yes

1.  I have following modules loaded on a GPU node:

    ```
    Currently Loaded Modules:
      1) init-lumi/0.2     (S)   4) cce/15.0.0         7) libfabric/1.15.2.0  10) cray-libsci/22.12.1.1    13) rocm/5.2.3
      2) lumi-tools/23.04  (S)   5) craype/2.7.19      8) craype-network-ofi  11) PrgEnv-cray/8.3.3
      3) ModuleLabel/label (S)   6) cray-dsmml/0.2.2   9) cray-mpich/8.1.23   12) craype-accel-amd-gfx90a
    ```

    When I compile the `pi_hip` target, I get a warning:
    ```
    No supported cpu target is set, CRAY_CPU_TARGET=x86-64 will be used.
    ```
    Is this ok, am I missing a module to set this variable, or should it be set manually?

    **Answer** Can you try with a fresh shell? I've just tried and it works:
    ```
    > module load craype-accel-amd-gfx90a rocm
    > make acc
    cc -o pi_openmp_device pi_openmp_device.c -fopenmp
    CC -xhip -o pi_hip pi_hip.cpp
    In file included from pi_hip.cpp:9:
    ```
    Ignore the warnings...

7.  With `lumi_c.sh, PrgEnv-cray, craype-x86-milan, craype-accel-host`: C_timers/pi_mpi compiles, but running it results in:
    ```
    MPICH ERROR [Rank 0] [job id 3605521.0] [Tue May 30 12:41:09 2023] [nid002042] - Abort(-1) (rank 0 in comm 0): MPIDI_CRAY_init: GPU_SUPPORT_ENABLED is requested, but GTL library is not linked
    (Other MPI error)

    aborting job:
    MPIDI_CRAY_init: GPU_SUPPORT_ENABLED is requested, but GTL library is not linked
    ```
    (serial and openmpi tests worked fine)
    
    **Answer** Could you list your modules? You should not use `craype-accel-host` if you are running a CPU code on LUMI_c.
   
8.  With `PrgEnv-amd, craype-x86-milan, rocm/5.2.3`: compilation fails because `CC --cray-print-opts=libs` returns a string which includes, among others, `-lsci_amd -lsci_amd,-lflangrti,-lflang,-lpgmath -ldl` (note the commas and missing spacs between flags) and this is seen in the error `ld.lld: error: unable to find library -lsci_amd,-lflangrti,-lflang,-lpgmath`. A workaround is to set `HIPCC_LINK_FLAGS_APPEND` manually and call `hipcc` directly, but the `CC` call should be fixed for this combo.

    **Answer** [Alfio HPE] I cannot reproduce this problem, could you provide the list of modules? This is what I get:
    ```
    > CC --cray-print-opts=libs
    -L/opt/cray/pe/mpich/8.1.23/ofi/amd/5.0/lib -L/opt/cray/pe/mpich/8.1.23/gtl/lib 
    -L/opt/cray/pe/libsci/22.12.1.1/AMD/4.0/x86_64/lib -L/opt/rocm/lib64 -L/opt/rocm/lib -L/opt/rocm/rocprofiler/lib 
    -L/opt/rocm/rocprofiler/tool -L/opt/rocm/roctracer/lib -L/opt/rocm/roctracer/tool -L/opt/rocm/hip/lib 
    -L/opt/cray/xpmem/2.5.2-2.4_3.20__gd0f7936.shasta/lib64 -L/opt/cray/pe/dsmml/0.2.2/dsmml//lib -lamdhip64 
    -Wl,--as-needed,-lsci_amd_mpi,--no-as-needed -Wl,--as-needed,-lsci_amd,--no-as-needed -ldl -Wl,
    --as-needed,-lmpi_amd,--no-as-needed -lmpi_gtl_hsa -Wl,--as-needed,-ldsmml,--no-as-needed -lxpmem
    ```

