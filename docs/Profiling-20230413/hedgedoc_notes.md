# Notes from the HedgeDoc document

## Questions regarding course organisation or LUMI in general

1.  Can I ask for incresing the home directory capacity?

     **Answer**: No. The home directory cannot be extended, not in capacity and not in number of files as it is also the only directory that is not billed. The home directory is only for stricly personal files and typically the type of stuff that Linux software tends to put in home directories such as caches. The project directory is the directory to install software, work on code, etc., and the scratch and flash directory are for temporary data. You can always create a subdirectory for yourself in your project directory and take away the group read rights if you need more personal space.

2.  `/project/project_465000502/slides` is empty now, right? Thanks.

    **Answer** Yes. HPE tends to upload the slides only at the end of the presentation.
               PDF file is now copied.
               
3.  How one can see `/project/project_465000502/` on LUMI?
    When I do `ls` in the terminal, I do not see this folder.

    **Answer** Did you accept the project invite you got earlier this week? And if you have a Finnish user account you will now have a second userid and that is the one you have to use.
    
    Did you try to `cd` into `/project/project_465000502`? That directory is **not** a subdirectory of your home directory!
    
    ```
    cd /project/project_465000502
    ```
    
  
    
## HPE Cray PE tools

4.  Can the tools be used for profiling GPU code which is not directive-based, but written in CUDA/HIP?

    **Answer:** Yes, we provide examples in perftools/perftools-for-hip (and clearly CUDA is supported too) and perftools-lite-gpu. Perftools-lite can give output like this for HIP code:
    ```
    Table 2:  Profile by Function Group and Function

      Time% |     Time | Imb. |  Imb. | Team |    Calls | Group
            |          | Time | Time% | Size |          |  Function=[MAX10]
            |          |      |       |      |          |   Thread=HIDE
            |          |      |       |      |          |    PE=HIDE

     100.0% | 0.593195 |   -- |    -- |   -- | 14,960.0 | Total
    |---------------------------------------------------------------------------
    |  57.5% | 0.341232 |   -- |    -- |   -- |     18.0 | HIP
    ||--------------------------------------------------------------------------
    ||  39.5% | 0.234131 |   -- |    -- |    1 |      3.0 | hipMemcpy
    ||  10.2% | 0.060392 |   -- |    -- |    1 |      2.0 | hipMalloc
    ||   7.2% | 0.042665 |   -- |    -- |    1 |      1.0 | hipKernel.saxpy_kernel
    ||==========================================================================

    ```


8. Completely unrelated to this course, but, is it possible to use all 128GB of GPU memory on the chip from a single GCD? i.e. have processes running on one GCD access memory on the other GCD.
    
    **Answer** Not sure if this is allowed. We never investigated since the performance will be really, really bad. The inter-die bandwidth is low compared to the memory bandwidth. BAsically 200 GB/s read and write (theoretical peak) while the theoretical memory bandwidth of a single die is 1.6 TB/s. 
    
    ***Follow up*** Yes, I appreciate it will be slow, but probably not as slow as swapping back and forwards with main memory? i.e. if I need the full 128GB I can just swap out stuff with DRAM, but that's really, really, really, really bad performance ;). So it'd be 8x slower than on a die, but 8x isn't really really bad. Anyway, I assumed it wasn't supported, just wanted to check if I'd missed something
    
    **Peter**: but if you already have the data in memory on the other GCD, would it not make more sense to do the compute there in-place, rather than waiting for the kernel to finish on GCD 1 and then transfer the data to GCD 2? It is supported in the sense that it will work with managed memory. The kernel on GCD 1 can load data automatically from GCD 2 with decent bandwidth, typically 150 GB/s (see [this paper](https://arxiv.org/pdf/2302.14827.pdf)).
    
    **George**: some of the above are true if you use both GCDs, in your case is like you use only one.
   


## AMD ROCM profiling tools


### ROCProf

10. Can the PyTorch profiler be used without any specific things to take into account, 
    see [link](https://pytorch.org/docs/stable/profiler.html)?  
 
    **Answer**: 
    
    That is correct. Let us know if you come across any problems.


11. Could you give a rough estimate on the overhead in terms of percentage?

    **Answer**
    
    - Generally very low, but can be high in unusual cases.
    - Hard to say exactly what the overhead is, depends usually on the ammount of data being collected. A code with a lot of smaller chunks of GPU activity are usually more pronoe to show more overhead.

### Omnitrace

12. Since there is support for OpenCL, does it support also SYCL? Or it will in the future?

    **Answer**
    
    -   There currently no plans to support the SYCL programming models in the AMD tools. For SYCL you'd have to rely on the HIP/HSA activity it generates.
    -   **Peter:** I have tested HipSYCL code with rocprof, and you can see the kernels launching.
    -   OpenSYCL uses HIP for AMD GPUs, so it should be able to track.

13. On LUMI ROCm is only available on LUMI-G, correct? What about onmitrace/perf? Is this available on LUMI-C?

    **Answer**
    
    -   Omnitrace could eventually be used to sample CPU code - omniperf is useless in no-GPU systems. 
        These tools are not generally available but can be easily installed as indicated in the presentations.
    -   The AMD μProf tool is used for the AMD CPUs. 
    -   The ROCm modules are available on LUMI-C and the login nodes also, but there was a problem with versions 
        before the maintenance. If these tools connect to GPU-specific device drivers though they will fail on non-GPU nodes.

14. What is a reasonable maximum number of mpi processes for omnitrace/perf to deal with?

    **Answer**
    
    -   Omniperf needs application replaying to collect multiple counters so the application would have to be replayed equally in all ranks. Omnitrace as MPI trace features and can use wil multiple ranks. In general, you'd be interested in profiling at the scale that is relevant for you and then maybe focus on more problematic/representative ranks, i.e. activate profile on only a given rank or set of ranks while using multiple ranks.
    -   A related question is how many MPI ranks to use per GPU - this depends but usually a rank por GCD is the choice for many apps. You can use more and the runtime/driver is ready for it without any requires wrapping. My recommendation however is to use ROCm 5.4+ if the intent is to overpopulate the GCDs with ranks.
    -   Omniperf requires 1 MPI process only. Omnitrace, can be large, not sure what limit except how to analyze the data.

15. Can you track memory usage with these tools? Thanks, will it give you maximum memory usage and where the memory is allocated in the code? Thanks

    **Answer**
    
    - Yes, omnitrace samples memory usage. 
    

### Omniperf

16. Not related to omniperf. On `tranining/exercises/HPE/openacc-mpi-demos` after doing `sbatch job.slurm`.
    ```
    srun: error: CPU binding outside of job step allocation, allocated CPUs are: 0x01FFFFFFFFFFFFFE01FFFFFFFFFFFFFE.
    srun: error: Task launch for StepId=3372350.2 failed on node nid007281: Unable to satisfy cpu bind request
    srun: error: Application launch failed: Unable to satisfy cpu bind request
    ```
    
    **Answer**
    
    -   let me fix it, I will report here when it is done (for the record, this is due to the today's change in Slurm)... done, please check.
        -   what change in slurm happened today?
        -   LUMI admins somehow reverted a change in Slurm that came in with the update where SLURM no longer propagates cpus-per-task if set in an SBATCH job comment into the srun. The old behaviour was restored but we tested the scripts yesterday. There was a user email this morning.

17. Slide 43, the kernels performance are good or not? There is a threshold in terms of distance from boundaries?

    **Answer**
    
    Will be in the recording. The performance is not very good (and take into account the scales are logarithmic so the dots are very far from the boundary).


!!! warning
    For security reasons it is best to run `omniperf analyze` on a single user machine that 
    is protected by a firewall (which is why we do not want to install it visibly on LUMI). 
    It opens an unprotected port to a webserver so everybody with access to LUMI can easily 
    guess the port number and get access to some of your data that way.


## Exercises

!!! info
    __AMD Exercises__

    You can find the instructions in [this HackMD document](https://hackmd.io/@gmarkoma/rkPbZqNMn)

    To run slurm jobs, set the necessary variables for this course by `source /project/project_465000502/exercises/HPE/lumi_g.sh`
    Note however that this script is for the reservation made for the course and needs to be adapted afterwards.


!!! info
    __HPE Exercises__
    -   Exercise notes and files including pdf and Readme with instructions on LUMI at `/project/project_465000502/exercises/HPE/`
    -   General examples
    	-   Directories: openacc-mpi-demos, BabelStream
    	–   Try different parallel offload programming models (OpenACC, OpenMP, HIP) and examples
    -   Tests based on the HIMENO benchmark
    	-   Directory: cray_acc_debug
    	-   Directory: compiler_listings

    -   Copy the files to your home or project folder before working on the exercises.
    -   In some exercises you have source additional files to load the right modules necessary, check the README file.

    -   __Follow the Readme.md files in each subfolder__

    -   To run slurm jobs, set the necessary variables for this course by `source /project/project_465000502/exercises/HPE/lumi_g.sh`.
        Note however that this script is for the reservation made for the course and needs to be adapted afterwards.


1.  I am stuck on the first AMD one.
    -   I can compile the nbody-orig, and it runs without srun. With srun, it dies with `"hipErrorNoBinaryForGpu: Unable to find code object for all current devices!"`
    -   What does the `-DSHMOO` flag mean for the hip compiler?
    -   If I run `rocprof --stats nbody-orig 65536` (no srun), it dies with `Exception: Could not run command: "rocminfo"`

    **Answer**

    -   Please add `--offload-arch=gfx90a` in the compilation. 
      
        ```
        hipcc --offload-arch=gfx90a -I../ -DSHMOO nbody-orig.cpp -o nbody-orig
        ```
    
    -   `-D` is the compiler flag for a C language family compiler to define a symbol for the preprocessor.

2.  I did not get if Omnitrace is available from a module on LUMI or not, sorry! Should I install it?

    **Answer**
    
    No official module currently that fits nicely in the software stack, but for the exercises you can use

    ```
    module use /project/project_465000502/software/omnitrace192/share/modulefiles/
    module load omnitrace/1.9.2
    ```

3.  How can i get access to omniperf on LUMI?

    **Answer**

    ```
    module use /project/project_465000502/software/omnitrace192/share/modulefiles/
    module load omnitrace/1.9.2
    ```
    ```
    module load cray-python
    module use /project/project_465000502/software/omniperf108/modules
    module load omniperf
    export ROOFLINE_BIN=/project/project_465000502/software/omniperf108/bin/utils/rooflines/roofline-sle15sp3-mi200-rocm5
    ```
    
    No plans to have it officially available due to the security issues mentioned earlier in this document.


21. I'm having a problem with perftools and OpenACC code

    ```
    Instrumented code exits with "pat[WARNING][0]: abort process 72108 because of signal 6 ..."
    ```

    This happens both with "perftools-lite-gpu" as well as with "perftools" + "pat_build". Uninstrumented code works fine.
        
    -   Can you try the latest perftools modules. You will have to unload them (including perftools-base) and reload the newer ones 

    Same with perftools-base/23.03.0
     
    -   Could you share the code? 

    Simple heat-equation toy code: https://github.com/cschpc/heat-equation
    I was using the "3d/openacc/fortran" version

    -   I've tried with the following steps:

        ```
        git clone https://github.com/cschpc/heat-equation
        cd heat-equation/3d/openacc/fortran
        module load PrgEnv-cray
        module swap cce cce/15.0.1 # better use always the newest compiler
        module load craype-accel-amd-gfx90a rocm
        module load perftools-lite-gpu
        make COMP=cray
        srun -n 1 --gres=gpu:8 ./heat_openacc
        ```
        
        And got the error... 

    -   I will file a ticket for that...
  
    -   **(Harvey)** Started to look at this, need to be sure the Fortran is valid first (checked: looks fine, the USEs have no circular chain). I'm sure I will run out of time so please put in the ticket.

22. Can I use the cray compiler with rocprof?

    -   I tried with an example and it works, I assume it could depend on what you want to do.
    
    I would like to trace my application; I tried in the past but I did not manage to produce a .csv file for PERFETTO. I am trying again, 
    
    I used:
    
    ```
    module load craype-accel-amd-gfx90a
    CC -x hip -o vcopy vcopy.cpp -L/opt/rocm/lib/ -lamdhip64
    srun -n 1 rocprof --hip-trace ./vcopy 1048576 256
    ```

    I get some errors I can not understand, regarding a HSA table already existing. I added -t ${PWD} to use the current directory, I see the temporary directories created but I get the same error and the directories contain only some .txt files

    ```
    Traceback (most recent call last):
        File "/pfs/lustrep3/appl/lumi/SW/LUMI-22.08/G/EB/rocm/5.3.3/libexec/rocprofiler/tblextr.py", line 833, in <module>
        hsa_trace_found = fill_api_db('HSA', db, indir, 'hsa', HSA_PID, COPY_PID, kern_dep_list, {}, 0)
        File "/pfs/lustrep3/appl/lumi/SW/LUMI-22.08/G/EB/rocm/5.3.3/libexec/rocprofiler/tblextr.py", line 406, in fill_api_db
        table_handle = db.add_table(table_name, api_table_descr)
        File "/pfs/lustrep3/appl/lumi/SW/LUMI-22.08/G/EB/rocm/5.3.3/libexec/rocprofiler/sqlitedb.py", line 48, in add_table
        cursor.execute(stm)
    sqlite3.OperationalError: table HSA already exists 
        Profiling data corrupted: ' /users/bellenta/work_dir/rocm/rpl_data_230413_165341_47398/input_results_230413_165341/results.txt 
    ```
    I deleted a results.db present in the directory, and now I see a results.csv file together with others (however still errors in the logfile).. maybe there is a flag to overwrite

    
    -   This seems like rocprof get killes, can you provide the used command?

    `srun -N ${SLURM_NNODES} -n 4 rocprof -t ${PWD} --hip-trace --hsa-trace ./pw.x -i atom.in > atom.out.${SLURM_JOBID} 2>&`
            
    - Do you have the slides, you need to use a wrapper for multiple processes, could you try with 1 process?
    
    Before I was using the wrapper, and it wasn't working as well but I'll try again. However, now without the wrapper I see a different folder for each mpi rank and it reports an error regarding profiling data corruption, maybe something in the code... 
    
    -   Yes it is because is more than 1 process, if you try 1 process, it works, right? 
       
    yes! by launching with one process only, so no MPI distribution
    
    -   It needs the wrapper, I believe.

        ```
        WORK_DIR=${PWD}
        if [[ "$SLURM_PROCID" == 0 ]]; then
            rocprof -t ${WORK_DIR} --hsa-trace --hip-trace \
                    ./pw.x -i atom.in
        else
                    ./pw.x -i atom.in
        fi
        ```
         
    -   This will isntrument only process 0, it depends on what you want to do.

    This worked, thank you very much! I want to see data movements which should be the same for each MPI rank. Is it feasible to see all the GPUs together with rocprof?

    -   Omnitrace would be better 
                            
23. Trying out some code of my own I get this error when running "MPIDI_CRAY_init: GPU_SUPPORT_ENABLED is requested, but GTL library is not linked", is this a compile time issue?

    **Answer**

    -   Are you using hipcc? add this:
       
        ```
        module load craype-accel-amd-gfx90a
        export MPICH_GPU_SUPPORT_ENABLED=1

        -I${MPICH_DIR}/include
        -L${MPICH_DIR}/lib -lmpi ${PE_MPICH_GTL_DIR_amd_gfx90a} ${PE_MPICH_GTL_LIBS_amd_gfx90a}
        ```

24. Perftools information for HIP code is not very useful

    I was playing with simple C++ heat-equation toy code https://github.com/cschpc/heat-equation (3d/hip version), which launches kernels asynchronously. Pat_report shows all the time being spent in hipDeviceSynchronize, instead of the actual kernels:
    ```
    ||  56.9% |  7.172922 |   -- |    -- |    500.0 | hipDeviceSynchronize
    ...
    ||   0.0% |  0.001363 |   -- |    -- |    500.0 | hipKernel.evolve_interior_kernel
    ||   0.0% |  0.001353 |   -- |    -- |    500.0 | hipKernel.evolve_z_edges_kernel
    ||   0.0% |  0.001325 |   -- |    -- |    500.0 | hipKernel.evolve_x_edges_kernel
    ||   0.0% |  0.001306 |   -- |    -- |    500.0 | hipKernel.evolve_y_edges_kernel
    ```

    Is there way to get the time actually spent in kernels?
    
    -   Is this tracing? (`-w` flag for pat_build) You can also decide to mask a function (`-T` flag). Check man pat_build for more info.
    -   You can collect timeseries data (PAT_RT_SUMMARY=0) and view a timeline in apprentice2 and this can show kernels. 

    Thanks, with tracing and timeseries apprentice2 does not show Time Line but gives "Data server terminated" error

25. Omnitrace-instrument seems to take ages to launch for the Jacobi example. Waitng about 10 mins now. Is it normal?

    -   I assume dynamic instrumentation? yes
    -   Do binary rewriting, I think the storage is not performing well
    
    Thanks. Is there somewhere I can read about what this dynamic instrumetation means vs (I guess) static? I am a newbie :-) 
    
    -   In the slides there is a command with `--simulate` that show sall the libraries that access the dynamic instrumentation and they are a lot, so the binary rewriting makes profiling accessing onlyt he required libraries which are minimal.
    
26. I managed to get a roofline plot using the saxpy example, meaning that i can see the kernel "points" on the plot. However, i can't do the same with the `vcopy` example. I mean, it generates a report, so i guess that it works, but it does not show any point on the plot. Can you think of a reason about it? EDIT: because it doesn't have FP operation i guess... 

    -   Yes, vcopy has 0 FLOPs, check more the other things than roofline for vcopy
    
    I changed it to use dgemm
    
    