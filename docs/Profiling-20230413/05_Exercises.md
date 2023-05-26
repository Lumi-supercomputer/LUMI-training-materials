# Exercises

-   Files for the exercises are available in 
    `/appl/local/training/profiling-20230413/files/exercises-profiling-20230423.tar.gz`

-   Exercises from HPE are available in
    `/appl/local/training/profiling-20230413/files/05_Exercises_HPE.pdf`

-   AMD exercidses are available as an [online text](https://hackmd.io/@gmarkoma/rkPbZqNMn)
    ([local web copy(PDF)](https://462000265.lumidata.eu/profiling-20230413/files/LUMI-G_Pre-Hackathon-AMD.pdf))
    or as `/appl/local/training/profiling-20230413/files/05_LUMI-G_Pre-Hackathon-AMD.pdf`

-   Extra software that was made available by AMD is available in
    `/appl/local/training/profiling-20230413/files/software-profiling-20230423.tar.gz`.
    As the configuration of LUMI is continuously evolving, this software may not work anymore.


## Q&A

!!! info
    __AMD Exercises__

    You can find the instructions in [this HackMD document](https://hackmd.io/@gmarkoma/rkPbZqNMn)

    To run slurm jobs, set the necessary variables for this course by `source /project/project_465000502/exercises/HPE/lumi_g.sh`
    Note however that this script is for the reservation made for the course and needs to be adapted afterwards.


!!! info
    __HPE Exercises__

    -   Exercise notes and files including pdf and Readme with instructions on LUMI are in the `exercises/HPE`
        subdirectory after untarring the files for the exercises.
    -   General examples
    	-   Directories: openacc-mpi-demos, BabelStream
    	–   Try different parallel offload programming models (OpenACC, OpenMP, HIP) and examples
    -   Tests based on the HIMENO benchmark
    	-   Directory: cray_acc_debug
    	-   Directory: compiler_listings

    -   In some exercises you have source additional files to load the right modules necessary, check the README file.

    -   Follow the Readme.md files in each subfolder


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


4.  I'm having a problem with perftools and OpenACC code

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

5.  Can I use the cray compiler with rocprof?

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
                            
6.  Trying out some code of my own I get this error when running "MPIDI_CRAY_init: GPU_SUPPORT_ENABLED is requested, but GTL library is not linked", is this a compile time issue?

    **Answer**

    -   Are you using hipcc? add this:
       
        ```
        module load craype-accel-amd-gfx90a
        export MPICH_GPU_SUPPORT_ENABLED=1

        -I${MPICH_DIR}/include
        -L${MPICH_DIR}/lib -lmpi ${PE_MPICH_GTL_DIR_amd_gfx90a} ${PE_MPICH_GTL_LIBS_amd_gfx90a}
        ```

7.  Perftools information for HIP code is not very useful

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

8.  Omnitrace-instrument seems to take ages to launch for the Jacobi example. Waitng about 10 mins now. Is it normal?

    -   I assume dynamic instrumentation? yes
    -   Do binary rewriting, I think the storage is not performing well
    
    Thanks. Is there somewhere I can read about what this dynamic instrumetation means vs (I guess) static? I am a newbie :-) 
    
    -   In the slides there is a command with `--simulate` that show sall the libraries that access the dynamic instrumentation and they are a lot, so the binary rewriting makes profiling accessing onlyt he required libraries which are minimal.
    
9.  I managed to get a roofline plot using the saxpy example, meaning that i can see the kernel "points" on the plot. However, i can't do the same with the `vcopy` example. I mean, it generates a report, so i guess that it works, but it does not show any point on the plot. Can you think of a reason about it? EDIT: because it doesn't have FP operation i guess... 

    -   Yes, vcopy has 0 FLOPs, check more the other things than roofline for vcopy
    
    I changed it to use dgemm
    
    