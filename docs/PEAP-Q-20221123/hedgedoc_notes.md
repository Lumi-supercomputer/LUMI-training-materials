# Notes from the HedgeDoc page

These are the notes from the LUMI-C training,
23.--24.11.2022, 9:30--17:30 (CET)
Hybrid on Zoom and in person
[HOEK 38, Leuvenseweg 38, 1000 Brussels](https://www.google.be/maps/place/Leuvenseweg+38,+1000+Brussel/@50.8476312,4.3623829,17z/data=!3m1!4b1!4m6!3m5!1s0x47c3c37e01a881f1:0xe65ef60087f5e28b!8m2!3d50.8476278!4d4.3645716!16s%2Fg%2F11c5dh5vwl)


[TOC]

## General information

### Exercises

The exercise files are on lumi at `/project/project_465000297/exercises`.Copy the files into your home directory and work from there.


### LUMI user coffee break

**30.11.22, 13:00-13:45 (CET), 14:00--14:45(EET)**
Meet the LUMI user support team, discuss problems, give feedback or suggestions on how to improve services, and get advice for your projects.

Every last Wednesday in a month.
[Join via Zoom](https://cscfi.zoom.us/j/68857034104?pwd=UE9xV0FmemQ2QjZiQVFrbEpSSnVBQT09)

## Slides and other material

Slides from HPE are available on LUMI at `/project/project_465000297/slides`
You need to join the training project via the link you received in the email on Monday.
Slides from the LUST talks are available [on these pages](index.md)

## Q&A of the sessions on day 1

### Course introduction

*Presenter: Kurt Lust*<br>
*[Slides](https://462000265.lumidata.eu/peap-q-20221123/files/00_LUST_Course_intro.pdf)*

1. Do you know the current allocation per country ? (I wonder how much Belgium contributes to LUMI)
    - Belgium: 7.4% of the total budget.
    - Information about how to contact the Belgian team is [https://www.enccb.be/LUMI](https://www.enccb.be/LUMI)


2. What do you mean the training project? like ssh to lumi? or the puhuri portal?
    - Yes, there is a small allocation on LUMI associated with the course (i.e. yo can log in with SSH and run jobs). We send out an email on Monday with the puhuri link to join the training project. This is a different project from the one you may have from a project from EuroHPC or your national allocation. **Please use this project only for the exercises, not to run your own code or we will run out of our allocation for the course.**
    - The information on how to join was sent out a few days before the course. We will mention the project number and slurm reservation before we start the exercises.

### Introduction to the HPE Cray Hardware and Programming Environment 

*Presenter: Harvey Richardson (HPE)*<br>
*Slide files: `/project/project_465000297/slides/01_EX_Architecture.pdf` and `/project/project_465000297/slides/02_PE_and_Modules.pdf`*

3. What's the expected CPU clock for a heavy all-core job?
    - 2.45 GHz base clock rate (https://www.amd.com/en/product/10906)
    - Don't expect any boost for a really heavy load. The effective clock is determined dynamically by the system depending on the heating/cooling situation. It can be complex, because heavy network/MPI traffic will also affect this, and the node tries to distribute power between the CPU cores, the IO die on the CPU, (the GPUs for LUMI-G), and the network cards on-the-fly to optimize for the best performance.

4. Regarding the CPU cores and threads : you said that the threads are hardware : should we run large runs on the number of threads, rather than the number of nodes ?
    - Could you elaborate a bit more? 
    - My understanding is : a cpu that has 64 cores, shows 128 threads by multithreading, therefore cases that use the cpu 100% load during 100% of the time will be better tu run on 64 core, rather than the 128 threads to eliminate the overhead of the operating system due to scheduling the software threads to the hardware core.
    - There are two sessions about SLURM in the course where it will be explained how to use hyperthreading etc. 
    - In general, hyperthreading doesn't offer much benefits on a good code, rather the contrary. It's really more lack of cache and memory bandwidth stat stops you from using hyperthreading. Hyperthreading is basically a way to hide latency in very branchy code such as databases. In fact there are codes that run faster using a given number of nodes and 75% of the cores than the same number of nodes and all cores per socket, without hyperthreading.
    - OK I will wait for the next parts of the course. Thank you

5. At the ExaFoam summer school I was told that HDF5 parallel I/O does not scale to exa scale applications. Ist that correct Instead the exafoam project is working on an ADIOS-2 based system for parallel I/O in OpenFOAM. Feel free to answer this question at the most appropriate time in the course
    - This is the current understanding, so I would say "yes" (even if I'm not a 100% expert).
    - The HDF5 group had a [BOF at SC22 about their future plans]( https://www.hdfgroup.org/2022/10/hdf5-in-the-era-of-exascale-and-cloud-computing/)
    - I would not rule out HDF5 parallel I/O at large scale on LUMI-C for runs of say 500 nodes or similar. The best approach would be to try to benchmark it first for your particular use case.
    - It depends on what you would exactly need to do. If you need to write to file, I am not sure there are real alternatives. ADIOS would be great for in-situ processing.
    - **[Harvey]** I have heard of some good experience about ADIOS-2 but have not tried it yet myself, on my list of things to do.
    - One of the engines that ADIOS-2 can use is HDF5 so it is not necessarily more scalable. Just as for HDF5, it will depend much on how it is used and tuned for the particular simulation.

6. Will there be, for the exercises, shown on-screen (in the zoom session) terminal session which will show how to use all the commands, how to successfully complete the exercises, or will we be void of visual guide and will we only have to rely on the voice of the person presenting the exercises? What I mean - can we please have the presenter show interactively the commands and their usage and output?
    - You can find exercises at `/project/project_465000297/exercises/` with Readme's. You can copy the directory in your area. Just follow them and let us know if you have questions. We will cover it during the next sessions.
    
7. Julia (language) is installed?
    - No, not in the central software stack available for everyone. It is quite easy to just download the Julia binaries in your home directory and just run it, though. Julia uses OpenBLAS by default, which is quite OK on AMD CPUs. If you want, you can also try to somewhat "hidden" Julia module installed with Spack. `module load spack/22.08; module load julia/1.7.2-gcc-vv`. No guarantees on that one, though (unsupported/untested).
    - Another easy approach is to use existing containers. Unless GPU is used, generic container from DockerHub should work fine.
    - It is not clear though if the communication across nodes is anywhere near optimal on LUMI at the moment. The problem is that Julia comes with very incomplete installation instructions. Both the Spack and EasyBuild teams are struggling with a proper installation from sources and neither seem to have enough resources to also fully test and benchmark to see if Julia is properly tuned. 

9. Paraview is a data postprocessing software that employs a graphical user interface. Is it possible to use it with LUMI?
    Also, as explained in https://www.paraview.org/Wiki/PvPython_and_PvBatch, Paraview functions may be accessed without using the GUI and just using python scripts. Is it feasible to use pvBatch and pvPython in LUMI to postprocess data with Paraview?
    - Yes, you can use Paraview on LUMI. We have an EasyBuild recipe that is not yet present on the system but is available via the [LUMI "contrib" Github](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib/) repository. This easyconfig build the server components only and does CPU rendering via MESA. You need to run a client of the same version of the server on your local machine in order to interact with the server.
    - Actually, the Paraview recipe is still missing in the repository but we will take care of that.

### First steps to running on Cray EX Hardware

*Slide file: `/project/project_465000297/slides/03_Running_Applications_Slurm.pdf`*


1.  I would like to know whether it is possible to run FEM simulation software (e.g., COMSOL Multiphysics) on LUMI?
    - As long as it is installed correctly then I see no reason why not. It has been run on other Cray EX systems. The only complication here will be the commerical license.  LUMI does not have its own license, you would have to provide your own. There might be some complications right now, because the compute nodes do not have internet access, which would block access to the license server. We hope that internet access will be enabled on the compute nodes soon.

2.  Is it something like MC (Midnight Commander) installed?
   - No, and midnight commander specifically has some annoying dependencies so it will not come quickly in a way that integrates properly with all the other software on LUMI.
   - You can see your files and transfer to and from LUMI using tools like [filezilla](https://filezilla-project.org/) and the host `sftp://lumi.csc.fi`
   - And for people on a connection with sufficiently low latency Visual Studio Code also works. The client-server connection seems to fail easily though on connections with a higher latency. It is also more for editing remotely in a user friendly way than browsing files or running commands. But we do understand that mc is awesome for some people.
   - In the future there will also be an [Open OnDemand](https://openondemand.org/) interface to LUMI.
   - MC is ok but Krusader is better

12. and WinSCP?
    - That is client software to run on your PC. It should work. 
    - In general, until we have Open OnDemand, the support for running GUI software on LUMI is very limited. And after that it will not be brilliant either, as an interface such as GNOME is not ideal to run on multiuser login nodes due to the resources it needs but also due to how it works internally.
    
15. Would it be alright to test the building of licensed software such as VASP during the course and the EasyBuild system you have in place? (and benchmark with very small test run of course)
    - Please don't run benchmarks of your own software on the project account. If you already have another project, use that one instead.
    - You can install and run VASP but need to bring your own license file. See also [here](https://docs.lumi-supercomputer.eu/software/guides/vasp/) or the future page in the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/v/VASP/).

!!! exercise
    Exercises are available at `/project/project_465000297/exercises/ProgrammingModels/`
    Copy the files to your home folder before unpacking them.

### Overview of compilers and libraries

*Slide file: `/project/project_465000297/slides/04_Compilers_and_Libraries.pdf`*

16. By default the libraries are shared (dynamic), so isn't it good practice to but the compiling part of the application in the slurm script job ?

    - In general, no. The libraries on the system will not change that often, only after service breaks / upgrades of the Cray Programming Environment. It would also be inefficient to compile using compute node allocation if you have e.g. a wide parallel job with 100 compute nodes.
    - You must also consider that it uses your allocated resources (from your project)

17. Question about the cray fortran compiler: I've been trying to use it now on some private code, and it crashes when it encounters preprocesseor statements like `#ifdef` which gfortran is happy about. Is this expected? Is there a way to handle this?
    - What error does the compiler give?
        - `ftn-100: This statement must begin with a label, a keyword or identifier`, so it just seems to take the statement literally
    - Did you use the right filename extension to activate the preprocessor or the -ep/-ez options shown in the presentation?
    - That is probably the problem, I think I missed that comment, I will go back to the slides to look
    - After loading PrgEnv-cray you can also get extensive help about all the command line options using man crayftn
    - Source file extension needs to start with F and not f to automatically trigger the preprocessor.
    - The other cause might be that sometimes there are subtle differences between wat a C and Fortran preprocessor allows but I believe there is an option for that also. I remember having such a ticket long ago.
    - Thanks, the filename was actually the problem, I wasn't expecting that
    - I may have another advice, just in case: the CCE produces modules with capital letters names (FOO.mod), you can use `-emf` to get lowercase (like gfortran).

!!! exercise
    Try the compiler exercises at `/project/project_465000297/exercises/perftools/compiler_listings` and recompiling the exercises from earlier. You don't need to run any jobs.

### Advanced Application Placement

*Presenter: Jean Pourroy (HPE)*<br>
*Slide file: `/project/project_465000297/slides/05_Advanced_Placement.pdf`*

18. I have a question regarding `srun`: does it forward options to the underlying MPI implementation? with OpenMPI you can get a report of the binding using —report-bindings 
    - Yes, it forwards the options to pmi
    - It is possible to get a report and we will mention tomorrow how to do that. But it can be done by option or environmental variable.

!!! exercise
    Try out the exercises found under `/project/project_465000297/exercises/Binding` and ask questions here.
    All exercises are described in the pdf document there.



## Q&A of the sessions on day 2

### Introduction to Perftools

*Presenter: Alfio Lazarro*<br>
*Slide file: `/project/project_465000297/slides/06_introduction_to_perftools.pdf`*

20. Can `perftools-lite` also be used with the gcc compilers?

    - yes, there is support for all the compilers offered on the machine. 
    - the 'loops' variant only works with CCE as it needs extra information from the compiler.

21. Can `perftools` also output per-MPI-rank timings or only (as shown in the presentation) averaged over all processes?

        * you can get per rank timings in the text output with appropriate options to pat_reoprt. Conversely, you can have a look at apprentice2 which has a nice way of showing per-rank timings.
    * there is an option pe=ALL that will show timings per rank/PE


22. The output of the statistics will tell you the name of the subroutine, line number, will it also tell you the name of the file where this is from ?
    - with the `-O ca+src` option to `pat_report` you can get the source information.

!!! exercise
    The exercise files are on lumi at `/project/project_465000297/exercises/perftools/perftools-lite`. Copy the files into your home directory and work from there.

!!! info "Apprentice2 and Reveal downloads"
    With `perftools-base` loaded (and it is loaded by default), you can also find the Apprentice2 downloads in `$CRAYPAT_ROOT/share/desktop_installers` or 
`$CRAY_PERFTOOLS_PREFIX/share/desktop_installers`.
    Copy them to your local machine and install them there.


### Advanced Performance Analysis I/II

*Presenter: Thierry Braconnier (HPE)*<br>
*Slide file: `/project/project_465000297/slides/07_advanced_performance_analysis_part1.pdf`*

1.  I downloaded and installed "Apprentice2" under Windows. Even if I am able to connect to LUMI via SSH, I am not able to open a remote folder with Apprentice2 (connection failed). Is it something special to configure (I added the ssh keys to pageagent and also added a LUMI section in my ~/.ssh/config)?

    - I think you will have to copy the files to the laptop as Windows has no concept of a generic ssh setup for a user as far as I know.
    - [name=Kurt] I'd have to check when I can get access to a Windows machine (as my work machine is macOS), but Windows 10 and 11 come with OpenSSH and can use a regular config file in the .ssh subdirectory. And that could allow to define an alias with a parameter that points to the keu file. Windows 10 and 11 also have a built-in ssh agent equivalent that Windows Open?SSH can use. 


### Advanced Performance Analysis II/II

*Presenter: Thierry Braconnier (HPE)*<br>
*Slide file: `/project/project_465000297/slides/08_advanced_performance_analysis_part2.pdf`*

25. If perftools runs on CLE/Mac/windows where can we get it/ find install instructions? 

    * Only apprentice2 and reveal are available as clients on mac/windows (basically the user interface components to interpret the collected data). These should be self-installing executables. Like `*.dmg` on a MAC.
    * You can download the apprentice install files from LUMI (look at the info box above question 23)

26. I managed to install apprentice2 on my MAC. How can I connect to Lumi? I need to provide a password, but when connecting to Lumi via the terminal I just pass the local ssh key...
    - There is no password access enabled, you have to setup ssh in a way that it is being picked up by apprentice
    - It should work if you have a ssh config file with the hostname, username and identity file for lumi. Can you connect to lumi with just `ssh lumi`?
        - Yes, I can connect to lumi with just `ssh lumi`. However: apprentice2, open remote with host `username@lumi.csc.fi` prompts for a password

!!! exercise
    The exercise files are on lumi at `/project/project_465000297/exercises/perftools/`.Copy the files into your home directory and work from there.


### Debugging

*Presenter: Alfio Lazarro (HPE)*<br>
*Slide file: `/project/project_465000297/slides/09_debugging_at_scale.pdf`*


### MPI Topics on the HPE Cray EX supercomputer

*Presenter: Harvey Richardson (HPE)*<br>
*Slide file: `/project/project_465000297/slides/11_cray_mpi_MPMD_short.pdf`*


### Optimizing Large Scale I/O

*Presenter: Harvey Richardson (HPE)*<br>
*Slide file: `/project/project_465000297/slides/12_IO_short_LUMI.pdf`*

27. You mentioned that you are using a RAID array to have redundancy of storage (and I read RAID-6 in the slides), have you considered using the ZFS file system ? I don't know too much, but i read it could be more reliable and better performance.
    - in ZFS you also chose a RAID level. I'm not sure what is used on LUMI, and it might be different for metadata and the storage targets. You will not solve the metadata problem with ZFS though. I know H?PE supports two backend file systems for Lustre but I'm not sure which one is used on LUMI.

28. This is really a question about the earlier session on performance tools, but I hope it's still OK to post it: I've tried using `perftools-lite`on my own code, but doing so it does not compile (it does without the modules). The linking seems to fail with 
    `WARNING: cannot acquire file status information for '-L/usr/lib64/libdl.so' [No such file or directory]`
    Is this something that has been seen before? Any tips/hints on what is going on?
    - without checking the code is hard to understand what it the problem. Do you really link with libdl.so in your compilation?
    - Yes, doing ldd on a successful compile gives `libdl.so.2 => /lib64/libdl.so.2 (0x00007f228c3b0000)` The other dl library symlinks to that one.
    - OK, the question is the line `-L/usr/lib64/libdl.so`, I wonder if you are using somewhere in the makefile
    - Yes, this is a large cmake set-up though, but cmake has `CMakeCache.txt:LIBDL_LIBRARY:FILEPATH=/usr/lib64/libdl.so`
    - Then we are hitting a situation where perftools-lite doesn't work... Try perftools, restricting to `-g `
    - OK, thanks! Will try that.


### Lust presentation: LUMI software stack

*Presenter: Kurt Lust*<br>
*[Slides](https://462000265.lumidata.eu/peap-q-20221123/files/L13_LUST_LUMI_Software.pdf) and [notes](software_stacks.md)*

29. `Error: ~/exercises/VH1-io/VH1-io/run> sbatch run_vh1-io.slurm sbatch: error: Invalid directive found in batch script: e.g` Do I need to change something in run_vh1-io.slurm before submitting?
    - Yes, you have to at least adapt the account, partition and reservation. qos has to be deleted (reservation is also optional). 
    - The readme has some quick build instructions. It worked for me :) 
    - Okay, thank you.

30. More information about the python container wrapper can be found in the [documentation](https://docs.lumi-supercomputer.eu/software/installing/container-wrapper/).

33. Is easybuild with AMD compilers on the roadmap for EB? 
    - The AMD AOCC compiler is already available in the Cray and LUMI software stack. Either `PrgEnv-aocc` or `cpeAOCC/22.08`. Additionally the AMD LLVM compiler is available via `PrgEnv-amd`.
    - Ok thanks! I thought one of Kurt's slides showed that EB currently only works with GNU or Intel
    - No, it works with Cray, GNU and AOCC but intel is tricky and not recommended.
    - Thanks!
    - **[Kurt]** Clarification: Standard EasyBuild has a lot of toolchains for different compilers, but only build recipes \9the EasyConfig files) for some specific toolchains, called the common toolchains. And they are based on GNU+OpenMPI+FlexiBLAS with OpenBLAS+FFTW and a few other libraries, or Intel (currently the classic compilers but that will change) with MKL and Intel MPI. This is what I pointed to with GNU and Intel in EasyBuild. For LUMI we build our own toolchain definitions which are an improved version of those used at CSCS and similar toolchains for an older version of the Cray PE included in EasyBuild.
    - **[Kurt]** It is not on the roadmap of the EasyBuilders. They have toolchains for AMD compilers but doe not build specific EasyBuild recipes and don't do much specific testing. I am trying to push them to support at least default clang, but then the Fortran mess will have to be cleaned up first. Regular clang support would at least imply that a number of clang-specific configuration problems would get solved so that changing to the AMD toolchain would be a relatively small effort (and could work with `--try-toolchain`). 
    - Ok thanks again! :D 


### LUST presentation: LUMI support

*Presenter: Jorn Dietze*<br>
*[Slides](https://462000265.lumidata.eu/peap-q-20221123/files/14_LUST_LUMI_Support.pdf)*

34. Will porting calls be available just for academic users? What about (potential) industrial users?
    - There are other EuroHPC inititiaves that specifically aim to support industrial users (like the national competence centres). An industrial project for the LUMI porting program could be considered if it is open research and the software is then publicly available for all (and I think without a big license cost). 
    - Good to know. Thanks for answering. I guess industrial users can always pay for porting if they wish to keep their software private.
    - Indeed, but then the problem on our side would still be personpower. The payment could of course be used to hire additional people on our side, but that is also not always easy. I also don't know how much AMD and/or HPE would charge for their part in the support.


35. If I think I may need level-3 support is it still recommended to go through LUMI service desk? 
    - Hard to tell. At the moment we ourselves have no clear view on all the instances giving Level-3 support. If a ticket would end up with us we would do an effort to refer to the right instance, but the reality is that we hope there is already a lot more than we see. I am pretty sure that some centres are already offering some support to some of the users of their country without much contact with us.
    - I guess to be clearer. Would LUST like to be kept 'in the loop' regarding these problems or is it more effort than necessary for LUST to forward these tickets to local centres?
    - It would be nice for us to be in the loop as we can learn from it, but the reality is that it turned out to be difficult to integrate ticketing systems to make that easy and that the communication with some local teams is decent but is totally absent with others so we cannot efficiently pass things to the local centres. That is a communication problem that LUST and the LUMI project management needs to solve though.


### General Q&A

31. What is the `libfabric` module that is loaded by default upon login?
    - It is the library necessary for the node interconnect (slingshot) to work. It will be automatically loaded if you load `craype-network-ofi` module which is standard if you login or use one of the described Software stacks.

32. I know it is not the object of today course, but may I still ask how launch I a job on LUMI-G ?
    As Kurt said, first:
    reload LUMI/22.08 partition/G
    and then do I have to specify a specific --partition with the sbatch command ?
    - Yes, you have to use `--partition=pilot` but this only works at the moment if you are member of a GPU-pilot project. Alternatively you can use the `eap` partition which is available for everyone on LUMI and consists of the same GPU nodes, but has shorter walltime limits. `eap` is intended for testing only, not for production runs.
    - partition `gpu` is shown but currently not available (it is for the HPE benchmarking) instead `pilot` and `eap` have to be used.
    - Thank you for the precision. My project is mostly GPU oriented, so we did not ask for CPU as we thought a minimum amount of CPU would be included. Will it be possible to launch jobs on LUMI-G without any CPU resources or should I ask for additional CPU resources ?
    - **[Kurt]** In regular operation you will only need GPU billing units to run on the GPUs. However, at the moment, during the pilot, the situation is different:
        - The Early Access Platform (partition `eap`) does not require GPU billing units. It is also not charged, but usage is monitored and should remain reasonable, i.e., development and first benchmarking only. However, to get access to the queue, a minimal CPU allocation is needed.
        - The `pilot` partition is for pilot users only and this one requires GPU billing units but no CPU allocation.  

