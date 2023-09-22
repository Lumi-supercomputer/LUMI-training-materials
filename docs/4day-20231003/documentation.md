# Documentation links

Note that documentation, and especially web based documentation, is very fluid. Links change rapidly and
were correct when this page was developed right after the course. However, there is no guarantee that they
are still correct when you read this and will only be updated at the next course on the pages of that
course.

This documentation page is far from complete but bundles a lot of links mentioned during the presentations,
and some more.

## Web documentation

-   [HPE Cray Programming Environment web documentation](https://cpe.ext.hpe.com/docs/) has only become available in
     May 2023 and is a work-in-progress. It does contain a lot of HTML-processed man pages in an easier-to-browse
     format than the man pages on the system.

     The presentations on debugging and profiling tools referred a lot to pages that can be found on this web site.
     The manual pages mentioned in those presentations are also in the web documentation and are the easiest way
     to access that documentation.

-   [Cray PE Github account](https://github.com/PE-Cray) with whitepapers and some documentation.

-   [Cray DSMML - Distributed Symmetric Memory Management Library](https://pe-cray.github.io/cray-dsmml/)

-   [Cray Library previously provides as TPSL build instructions](https://github.com/Cray/pe-scripts)

-   [Clang latest version documentation](https://clang.llvm.org/docs/index.html) (Usually for the latest version)

    -   [Clang 13.0.0 version](https://releases.llvm.org/13.0.0/tools/clang/docs/index.html) (basis for aocc/3.2.0)
       
    -   [Clang 14.0.0 version](https://releases.llvm.org/14.0.0/tools/clang/docs/index.html) (basis for rocm/5.2.3 and amd/5.2.3)
  
    -   [Clang 15.0.0 version](https://releases.llvm.org/15.0.0/tools/clang/docs/index.html) (cce/15.0.0 and cce/15.0.1 in 22.12/23.03)

-   [AMD Developer Information](https://www.amd.com/en/developer.html)

    -    [AOCC 4.0 CompilerOptions Quick Reference Guide](https://www.amd.com/content/dam/amd/en/documents/developer/compiler-options-quick-ref-guide-amd-epyc-9xx4-series-processors.pdf)
         (Version 4.0 compilers will come when the 23.05 or later CPE release gets installed on LUMI)

    -    [AOCC 4.0 User Guide](https://www.amd.com/content/dam/amd/en/documents/pdfs/developer/aocc/aocc-v4.0-ga-user-guide.pdf)

-   [ROCm<sup>TM</sup>](https://github.com/RadeonOpenCompute/ROCm/) [documentation overview](https://rocm.docs.amd.com/en/latest/)

    -   [rocminfo](https://github.com/RadeonOpenCompute/rocminfo) application for reporting system info.

    -   [rocm-smi](https://github.com/RadeonOpenCompute/rocm_smi_lib/tree/master/python_smi_tools)

    -   [HIP porting guide](https://github.com/ROCm-Developer-Tools/HIP/blob/master/docs/markdown/hip_porting_guide.md)

    -   [ROCm Software Platform GitHub repository](https://github.com/ROCmSoftwarePlatform)

    -   Libraries:

        -   BLAS: [rocBLAS](https://rocblas.readthedocs.io/en/latest/) and [hipBLAS](https://github.com/ROCmSoftwarePlatform/hipBLAS/wiki/Exported-functions)

        -   FFTs: [rocFFT](https://rocm.docs.amd.com/projects/rocFFT/en/latest/) and [hipFFT](https://rocm.docs.amd.com/projects/hipFFT/en/latest/)

        -   Random number generation: [rocRAND](https://rocmdocs.amd.com/projects/rocRAND/en/latest/)

        -   Sparse linear algebra: [rocSPARSE](https://rocm.docs.amd.com/projects/rocSPARSE/en/latest/) and [hipSPARSE](https://rocm.docs.amd.com/projects/hipSPARSE/en/latest/)

        -   Iterative solvers: [rocALUTION](https://rocm.docs.amd.com/projects/rocALUTION/en/latest/)

        -   Parallel primitives: [rocPRIM](https://rocm.docs.amd.com/projects/rocPRIM/en/latest/) and [hipCUB](https://rocm.docs.amd.com/projects/hipCUB/en/latest/)

        -   Machine Learning Libraries: [MIOpen (similar to cuDNN)](https://rocm.docs.amd.com/projects/MIOpen/en/latest/), 
            [Tensile (GEMM Autotuner)](https://github.com/ROCmSoftwarePlatform/Tensile),
            [RCCL (ROCm analogue of NCCL)](https://rocmdocs.amd.com/projects/rccl/en/latest/) and 
            [Horovod (Distributed ML)](https://github.com/ROCmSoftwarePlatform/horovod)

        -   Machine Learning Frameworks: [Tensorflow](https://github.com/ROCmSoftwarePlatform/tensorflow-upstream),
            [Pytorch](https://github.com/ROCmSoftwarePlatform/pytorch) and
            [Caffe](https://github.com/ROCmSoftwarePlatform/hipCaffe)

        -   Machine Learning Benchmarks:
            [DeepBench](https://github.com/ROCmSoftwarePlatform/DeepBench) and 
            [MLPerf](https://mlperf.org)

    -   Development tools:

        -   rocgdb resources:

            -   [AMD documentation](https://rocm.docs.amd.com/projects/ROCgdb/en/latest/index.html)

            -   [2021 presentation by Justin Chang](https://www.olcf.ornl.gov/wp-content/uploads/2021/04/rocgdb_hipmath_ornl_2021_v2.pdf)

            -   [2021 Linux Plumbers Conference presentation](https://lpc.events/event/11/contributions/997/attachments/928/1828/LPC2021-rocgdbdemo.pdf)
                with [youTube video](https://youtu.be/IGWFph4SlpU) with a part of the presentation

        -   [rocprof profiler](https://rocm.docs.amd.com/projects/rocprofiler/en/latest/rocprof.html)

        -   [OmniTrace](https://amdresearch.github.io/omnitrace/index.html)

        -   [Omniperf](https://amdresearch.github.io/omniperf/)


-   [HDF5 generic documentation](https://hdfgroup.github.io/hdf5/)

-   Mentioned in the Lustre presentation: The 
    [ExaIO project](https://www.exascaleproject.org/research-project/exaio/) paper
    ["Transparent Asynchronous Parallel I/O Using Background Threads"](https://doi.org/10.1109/TPDS.2021.3090322).



## Man pages

A selection of man pages explicitly mentioned during the course:

-   Compilers

    | PrgEnv                 | C            | C++          | Fortran        |
    |------------------------|--------------|--------------|----------------|
    | PrgEnv-cray            | `man craycc` | `man crayCC` | `man crayftn`  |
    | PrgEnv-gnu             | `man gcc`    | `man g++`    | `man gfortran` |
    | PrgEnv-aocc/PrgEnv-amd | -            | -            | -              |
    | Compiler wrappers      | [`man cc`](https://cpe.ext.hpe.com/docs/craype/cc.html) | [`man CC`](https://cpe.ext.hpe.com/docs/craype/ccpp.html) | [`man ftn`](https://cpe.ext.hpe.com/docs/craype/ftn.html) |

-   OpenMP in CCE

    -   [`man intro_openmp`](https://cpe.ext.hpe.com/docs/cce/man7/intro_openmp.7.html)

-   OpenACC in CCE

    -   [`man intro_openacc`](https://cpe.ext.hpe.com/docs/cce/man7/intro_openacc.7.html)

-   MPI:

    -   MPI itself: [`man intro_mpi`](https://cpe.ext.hpe.com/docs/mpt/mpich/intro_mpi.html) or [`man mpi`](https://cpe.ext.hpe.com/docs/mpt/mpich/intro_mpi.html)

    -   libfabric: `man fabric`

    -   CXI: `man fi_cxi'

-   LibSci

    -   `man intro_libsci` and `man intro_libsci_acc`

    -   `man intro_blas1`,
        `man intro_blas2`,
        `man intro_blas3`,
        `man intro_cblas`

    -   `man intro_lapack`

    -   `man intro_scalapack` and `man intro_blacs`

    -   `man intro_irt`

    -   `man intro_fftw3`

-   DSMML - Distributed Symmetric Memory Management Library 
    -   `man intro_dsmml`

-   Slurm manual pages are also all [on the web](https://slurm.schedmd.com/archive/slurm-22.05.8/man_index.html) 
    and are easily found by Google, but are usually those for the latest version.

    -   [`man sbatch`](https://slurm.schedmd.com/archive/slurm-22.05.8/sbatch.html)

    -   [`man srun`](https://slurm.schedmd.com/archive/slurm-22.05.8/srun.html)

    -   [`man salloc`](https://slurm.schedmd.com/archive/slurm-22.05.8/salloc.html)

    -   [`man squeue`](https://slurm.schedmd.com/archive/slurm-22.05.8/squeue.html)

    -   [`man scancel`](https://slurm.schedmd.com/archive/slurm-22.05.8/scancel.html)

    -   [`man sinfo`](https://slurm.schedmd.com/archive/slurm-22.05.8/sinfo.html)

    -   [`man sstat`](https://slurm.schedmd.com/archive/slurm-22.05.8/sstat.html)

    -   [`man sacct`](https://slurm.schedmd.com/archive/slurm-22.05.8/sacct.html)

    -   [`man scontrol`](https://slurm.schedmd.com/archive/slurm-22.05.8/scontrol.html)


## Via the module system

Most HPE Cray PE modules contain links to further documentation. Try `module help cce` etc.


## From the commands themselves

| PrgEnv            | C                      | C++                    | Fortran                  |
|-------------------|------------------------|------------------------|--------------------------|
| PrgEnv-cray       | `craycc --help`        | `crayCC --help`        | `crayftn --help`         |
|                   | `craycc --craype-help` | `crayCC --craype-help` | `crayftn --craype-help`  |
| PrgEnv-gnu        | `gcc --help`           | `g++ --help`           | `gfortran --help`        |
| PrgEnv-aocc       | `clang --help`         | `clang++ --help`       | `flang --help`           |
| PrgEnv-amd        | `amdclang --help`      | `amdclang++ --help`    | `amdflang --help`        |
| Compiler wrappers | `cc --help`            | `CC --help`            | `ftn --help`             |

For the PrgEnv-gnu compiler, the `--help` option only shows a little bit of help information, but mentions
further options to get help about specific topics.

Further commands that provide extensive help on the command line:

-   `rocm-smi --help`, even on the login nodes.


## Documentation of other Cray EX systems

Note that these systems may be configured differently, and this especially applies to the scheduler.
So not all documentations of those systems applies to LUMI. Yet these web sites do contain a lot of useful
information.

-   [Archer2 documentation](https://docs.archer2.ac.uk/). 
    Archer2 is the national supercomputer of the UK, operated by EPCC. It is an AMD CPU-only cluster.
    Two important differences with LUMI are that (a) the cluster uses AMD Rome CPUs with groups of 4 instead
    of 8 cores sharing L3 cache and (b) the cluster uses Slingshot 10 instead of Slinshot 11 which has its
    own bugs and workarounds.

    It includes a [page on cray-python](https://docs.archer2.ac.uk/user-guide/python/)
    referred to during the course.

-   [ORNL Frontier User Guide](https://docs.olcf.ornl.gov/systems/frontier_user_guide.html) and 
    [ORNL Crusher Qucik-Start Guide](https://docs.olcf.ornl.gov/systems/crusher_quick_start_guide.html).
    Frontier is the first USA exascale cluster and is built up of nodes that are very similar to the
    LUMI-G nodes (same CPA and GPUs but a different storage configuration) while Crusher is the
    192-node early access system for Frontier. One important difference is the configuration of
    the scheduler which has 1 core reserved in each CCD to have a more regular structure than LUMI.

-   [KTH Dardel documentation](https://www.pdc.kth.se/support). Dardel is the Swedish "baby-LUMI" system.
    Its CPU nodes use the AMD Rome CPU instead of AMD Milan, but its GPU nodes are the same as in LUMI.

-   [Setonix User Guide](https://support.pawsey.org.au/documentation/display/US/Setonix+User+Guide).
    Setonix is a Cray EX system at Pawsey Supercomputing Centre in Australia. The CPU and GPU compute
    nodes are the same as on LUMI.