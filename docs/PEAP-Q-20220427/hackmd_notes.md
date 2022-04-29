# Shared notes for course "Detailed introduction to LUMI-C architecture and environment (April 27/28)"

[TOC]

# Useful info

## Zoom
+ Link distributed via email

## Slides and Exercises
+ Links, info on how to access them will be provided directly to participants

+ Slides from the LUST presentations are on [lumi-supercomputer.github.io/LUMI-training-materials](https://lumi-supercomputer.github.io/LUMI-training-materials/), and in particular on [this page](https://lumi-supercomputer.github.io/LUMI-training-materials/PEAP-Q-20220427/).

Slides will appear here during the day but expect them to move to be web accessible to attendees after the training:
   `/users/richards/workshop/slides`
   
Exercise materials will be available at
 `/users/richards/workshop/exercises`
and for the performance tools sessions at
 `/users/anielloesp/exercises`

In the jobscripts please add `#SBATCH --reservation=lumi_course` and use one of your project accounts, e.g., `project_46{2,5}0000xx` (`#SBATCH -A project_46{2,5}000xyz`). Remove/comment out `#SBATCH -p standard` and `#SBATCH -q standard`).

## Accessing the reservation for hands-on exercises
Please, add the parameter `--reservation=lumi_course` to Slurm commands when submitting a job. The purpose of the reservation is to mitigate long queueing times during the course. Please, be nice to other participants by freeing unused resources and by only requesting short runtimes.

# Notes, questions & answers per session

## April 27 (all times CEST)
### 09:00	Welcome, introduction to the course
+ Q & A
+ Q: 1.5h in a row is rather long (both morning and afternoon sessions) in one go. Will there be some excercises or other breaks in between? Just 5mins or so to stretch a bit.
    + A: not planned, sorry (we will take this into account for a future course)

### 09:10	How the LUMI User Support Team works
+ Q & A

- Q: who are the dedicated Experts in Sweden? 
    + A: Peter Larsson at KTH, Stockholm, is the LUST member for Sweden; but the idea behind LUST is not that the person from your country should answer your questions, but the person who has most experience with the topic.

### 09:20	Introduction to the HPE Cray Hardware and Programming Environment
*Session info: Focus on the HPE Cray EX hardware architecture and software stack.
Tutorial on the Cray module environment and compiler wrapper scripts.*

#### HPE Cray EX hardware talk

+ Q: are you supporting or will you support interactive notebooks on compute nodes? (moving question to software session tomorrow)
    + A: It is not yet supported now but part of the planned Open OnDemand service that will be rolled out after the summer. It may use just a few nodes meant specifically for data analysis and visualisation (LUMI-D), with the option to launch regular jobs from your notebooks. 

+ Q: Is the AMD CPU on LUMI-G nodes the same as the one on LUMI-C nodes?
    + A: no, GPU nodes have AMD Trento CPUs (more details at https://www.lumi-supercomputer.eu/lumis-full-system-architecture-revealed/ ... also https://docs.olcf.ornl.gov/systems/crusher_quick_start_guide.html#crusher-quick-start-guide may provide some insights about GPU nodes, but final design remains to be seen). Both CPUs are zen3 though, but with a special I/O die for the one on LUMI-G to provide the InfinityFabric connection to the GPUs for the unified cache coherent memory architecture.

+ Q: on the AMD GPUs, how will you handle the situation of commercial software extensively used MATLAB for instance (just one example) that don't have a version for that?
   + A: As every machine in the world, not all software is compatible with all hardware and that is why EuroHPC has multiple clusters. There is in fact more than just the GPU that could cause compatibility problems with MATLAB. LUMI has specific requirements for MPI also that may not be met by software only available as binaries.  

+ Q: Do you know what other EuroHPC cluster offers NVIDIA GPUs?
   + A: Leonardo (pre-exascale), Meluxina (petascale), Vega (petascale), Karolina (petascale), Deucalion (when ready, petascale). An overview is on [the EuroHPC JU web site, "Discover EuroHPC JU" page](https://eurohpc-ju.europa.eu/discover-eurohpc-ju#ecl-inpage-211).

+ Q: Does the slingshot network handle IPMI (iLO and OOB management) as well?
   + A: There is a separate network for system management as far as I know.
   + A(Harvey) This is the answer I got from a colleague, don't shoot the messenger: https://www.slideshare.net/eurolinux/ipmi-is-dead-long-live-redfish#:~:text=Redfish%20is%20an%20IPMI%20replacement,is%20scalable%2C%20discoverable%20and%20extensible
   + 

+ Q: How is the boost of CPU's configured at Lumi-c by default.
    + A: Slurm has the `--cpu-freq` flag to control   the CPU frequency (see [here]([--cpu-freq](https://slurm.schedmd.com/sbatch.html#OPT_cpu-freq=))). In general you can expect boosting to be enabled on compute nodes but core boost policy is quite complex.  

#### Programming environment talk

+ Remark 1: There is not only the CMake integration, but pkg-config is also Cray-specific. If you try to replace it with your own version the compiler wrappers may fail.

+ Remark 2: On licenses, LUMI has a license for ARM Forge but we are still struggling with the installation, so some patience required.

+ Remark 3: The AMD compiler modules on the system do not all work. AOCC 2.2 that came with the 21.05 version of the system works but will be removed at one of the next maintenance intervals. 3.0 has a module on the system but no binaries, and the module of 3.1.0 is broken. That can be dealt with by instead using the LUMI/21.12 software stack and then the cpeAOCC module (see a presentation on the second day about the LUMI software stacks).
    + (Alfio) I have tried the `PrgEnv-aocc/8.2.0` module (`module swap PrgEnv-cray PrgEnv-aocc`) and indeed it doesn't load the corresponding `cray-mpich` module. To solve this problem, I have to set the variable
        ```
        export MODULEPATH=/opt/cray/pe/lmod/modulefiles/comnet/aocc/3.0/ofi/1.0:$MODULEPATH
        ```
        and then I can run `module load cray-mpich`. I've tested with a Fortran application and it runs.

+ Q: Question about the Cray Developer Environment: Do the 3rd party packages have a different support deal that the ones developed by Cray?
    + A: Unclear to LUST, we have not seen the contracts. But the installation files do come via HPE and we did notice that some builds are definitely HPE Cray-specific (choice of options and supported technologies, names of binaries to avoid conflicts with other tools, ...). But basically we cannot expect HPE to debug the GNU compiler while we can expect them to do bug fixes for the CCE compiler. And since AMD is also involved in the project, we can go to them with compiler bugs in the AMD compilers. ARM Forge is a different story, it is obtained from ARM directly and not via HPE.
    + (Harvey:) The developers will forward bugs for some of the components not developed internally, it depends. For AMD we have a special relationship with them that we can use for LUMI. All of the integration pieces (modules) are supported.

+ Q: what about h5py?
    + A: It is not included in the Cray branded module.
       ```
       module load cray-python/3.9.4.2
       python -c 'import h5py'
       pip3 list
       ```
    + A: It may be one that needs to be compiled from sources, and may also depend on which of the HDF5 configurations you need for the software that you may want your Python code to talk to.

 + Q: how about Julia, Rust, golang?
     + A: We had Rust but removed it again from the software stack due to problems with installing Rust. The whole Rust installation process is very HPC-unfreiendly (and we are not the only one suffering with this, I know this from the meetings about the software management/installation tool that we use). Golang due to its poor memory use is not even an HPC language. Julia would be interesting, but for now it looks best to do this via containers as the installation process from sources is complicated.      
     + Comment: I guess one could place binaries of Julia in the work directory?
     + Answer: I don't know, Julia binaries may require other libraries to be installed that are not installed on the Cray system. It does special things to link to some mathematical libraries and to MPI.

 + Q: There was a brief mention of singularity containers and using MPI with containers. Will HPE provide a basic singularity recipe for using MPI on LUMI? This would be a useful starting point for building containers for various application (e.g. machine learning with Horovod support). Experience shows it can be quite tricky to get this working, having right versions etc.
    + A: We're working on that. Basically, currently Open MPI is a big problem and we have failed to get it to work reliably with our network and SLURM. For containers that support MPICH 3 we already have a (currently still undocumented) module available that users can adapt and then install to set some environment variables to tell the container to use the Cray MPICH library instaed (relying on ABI compatibility with plain MPICH). After the course, try `eb --search singularity-bindings` (tomorrow we will explain what this means).

+ Q: Have you also considered conda environments, especially when it comes to complex Python dependencies?
    + A: We are providing dedicated wrapper for containerized conda and pip based environments. It will be mentioned tomorrow afternoon. But again, not everything installed via Conda might work as Conda may try to use libraries that are not compatible with LUMI. More info at https://docs.lumi-supercomputer.eu/software/installing/container_wrapper/

+ Q: Singularity is available but Docker does not seem to be available?
    + A: Docker was mentioned from administration perspective. From the user perspective singularity is the choice. For most docker containers simple `singularity pull` command should be enough for conversion. For instance `singularity pull docker://julia`

+ Q: Regarding MPI : is there any native OpenMPI implementation available?
    + A: Not really. We have some workarounds but in large scale it is expected to fail.

+ Q: What with Intel compilers, MKL Intel and Julia language?
    + A: Harvey will describe current status on the Intel development tools in the compilers talk.
    + A: We have no support for Intel in our contract with HPE and Intel will also not support it on AMD processors. If the reason why you want Intel is the classic Fortran compiler, you should really consider modifying the code as their classic compiler is end-of-line anyway and the new one has a completely different front-end so different compatibility problems. 
    + A: MKL is known to produce wrong results on the AMD processors and there are performance problems that need hacks that are not user-friendly to force it to take an AVX2 code path rather than one for the Pentium 4 from 15 years ago. At the University of Antwerp, where I work, most DFT packages for instance produce wrong results with Intel on AMD Rome CPUs that we could correct by using FFTW instead of MKL for FFT. Julia: see above, the question has already been asked, we'd like to support this but the installation procedure is a bit complicated and we cannot do everything in the first year.


### *10:30	break (30 minutes)*

### 11:00	First steps to running on Cray EX Hardware
*Session info: Examples of using the Slurm Batch system, launching jobs on the front end and basic controls for job placement.
Exercises: about 40 minutes*

+ Q: you don't need to specify the number of tasks for this script? just the number of nodes?
    + A: Just checked and the slide is indeed wrong. The #SBATCH lines will create only 2 task slots I think so srun will fail to then use 256. (Harvey: Which slide was this?) (Kurt: One of the first but I don't remember the page number, in the July version of the course it was slide 6 and the first example of a job script) Harvey: The jobs are specifying nodes (--nodes/N). We will check at end of talk.

+ Q: Does Gromacs get some benefits from the hardware threads (--hint)?
    + A: Can you be a bit clearer? Turning threads on or off? My expectation is that it would be case dependend, but I doubt as GROMACS already puts a very high stress on the CPU. (And we know that some GROMACS jobs trigger a hardware problem in some nodes that HPE is still working on because of the high load they put on the CPU.) 

+ Q: Using --exclusive on small/eap partitions would always reserve full nodes, right?
    + A: For binding exercises/jobs this flag is needed.
    + A: Using `--exclusive` on small defeats the whole purpose of the small partition which is all about having resources available for programs that cannot use a whole node. Also note that you will be billed for the whole node of course. On the EAP it is very asocial behaviour as we have only few such nodes available so it should only be done for short jobs if there is really no other option available. Note also that the EAP is not really a benchmarking platform.


+ Q: Will `--cpus-per-task` set the `OMP_NUM_THREADS` variable?
    + A: It does not. And while on some systems the Open MP runtime recognizes from the CPU sets how much threads should be created, this does not always work on LUMI as that mechanism cannot recognize between `--hint=multithread` and `--hint=nomultithread` so you may get twice the number of threads you want. We'll put a program in the software stack that shows you what srun would do by running a quick program not requiring many billing units, but it is not yet there as I am waiting for some other software to go into the same module that is not finished yet.
    + A: SLURM does set `SLURM_THREADS_PER_CORE` and `SLURM_CPUS_PER_TASK` environment variables that you can use to set `OMP_NUM_THREADS`.

          
+ Q: Is there "seff" command (exist in Puhti) to check resources used by batch job?
    + A: No, it is something we've looked into but it turns out that that script needs a SLURM setup that we do not have on LUMI and that it is not something we could install without sysadmin support. And currently the LUMI sysadmins install the system the way HPE tells them to, which means that there are some SLURM plugins that are on puhti or mahti but not on LUMI. I guess we'll see the sacct command later in the course and that can tell you what the total and average CPU time consumed by a job is so that you can get some idea about efficiency. 

+ Q: can we use mpprun instead of srun?
    + No. `srun` is the only parallel executor supported.

+ Q: Why is SMT not turned off by default if it is not beneficial in most cases?
    + A: I would say it is turned off by default (for both `small` and `standard` partitions). 
    + A: SMT tends to be most beneficial for code that runs at a low "instructions per clock", so branchy code (like databases) or code that has very bad memory access patterns, and hence creates pipeline stalls. For well written scientific codes that do proper streaming of data it tends to make matters worse rather than better as you effectively half the amount of cache available per thread and as a single thread per core already keeps the memory units busy.



+ Q: Compiling the pi/C example gives `warning: Cray does not optimize for target 'znver3' [-Wunsupported-target-opt]` Is this something to worry about? Does it mean it will not optimize for AMD at all?
    + I think you are using the wrong CCE module? The latest one (cce/13.0.0) that came with the 21.12 programming environment can optimise for zen3, but older versions didn't. *Indeed, I had some other modules loaded. Just loading `PrgEnv-cray/8.1.0` makes the warning disappear.*

+ Q [Bash completion for Slurm](https://github.com/SchedMD/slurm/blob/master/contribs/slurm_completion_help/slurm_completion.sh) does not seem to be setup on Lumi? Are there plans to install it?
    + A: No idea. This is something that has to be done at the sysadmin level, not at the level that the support team can do. Given the security constraints for a machine like LUMI and the desire to have a setup at the system level which is fully supported by HPE, there is a very strict border between what is possible at the user interface level and what sysadmins should do, and are willing to do as some features are turned off explicitly for security reasons. This, e.g., explains some of the restrictions there are on LUMI working with containers. But if you really really want it I guess you could install it in your account and activate from your .bashrc. Just sourcing the file seems to work. 

+ Q: Are we in the lunch break?
    + Not yet. Will be in 10 min. Right now is the hands-on session. 

### *12:10	lunch break (80 minutes)*

### 13:30	Overview of compilers and libraries
*Session info: An introduction to the compiler suites available. Including examples of how to get additional information about the compilation process. Special attention is given the Cray Compilation Environment (CCE) noting options relevant to porting and performance. CCE classic to Clang transition
Exercises: about 20 minutes*

Remark 1: Slide 7 (3 ways of dynamic linking) is a really important one. It implies that you will sometimes be using a different version of a library at run time than you think unless you use the third approach. It also implies the behaviour of a code may change when the default programming environment on the system is changed if you use the first apporach.

Remark 2: The Cray Fortran compiler is actually one of the most strict compilers around when it comes to standard compliance. Many codes that don't fully follow the standards fail to compile.

+ Q: would one expect a more performant code with dynamic vs. static linking?
    + A: I think on modern CPUs the main difference will be the performance during loading (static is faster as you have only one file to open and read). There are differences in the code generated (e.g., you have to use position independent code for a shared library) but I would expect that the performance impact of that will be very low or none on modern architectures as CPUs have simply been optimised to work well with the memory models for shared libraries. I haven't benchmarked it though. 

+ Q: I am trying to compile my library on LUMI. According the recommendation, I have loaded PrgEnv-cray/8.2.0. Since I am using waf compiler tool, that does not recognise cc/CC wrappers, so I have specified clang++ to be c++ compiler.


    ```
    onvysock@uan02:~/meric> CC --version
    Cray clang version 13.0.0  (24b043d62639ddb4320c86db0b131600fdbc6ec6)
    Target: x86_64-unknown-linux-gnu
    Thread model: posix
    InstalledDir: /opt/cray/pe/cce/13.0.0/cce-clang/x86_64/share/../bin

    onvysock@uan02:~/meric> clang++ --version
    Cray clang version 13.0.0  (24b043d62639ddb4320c86db0b131600fdbc6ec6)
    Target: x86_64-unknown-linux-gnu
    Thread model: posix
    InstalledDir: /opt/cray/pe/cce/13.0.0/cce-clang/x86_64/bin
    ```
    Despite using the clang++ the compilation fails that it does not find C++ header file. It seems to me, that C compiler is used instead of C++.

    ```
    [ 2/82] Compiling src/meric/meric.cpp
    14:57:01 runner ['clang++', '-O0', '-g', '-std=c++11', '-fPIC', '-fopenmp', '-I/pfs/lustrep2/users/onvysock/meric/include/', '-DMERIC_PATH="/pfs/lustrep2/users/onvysock/meric"', '-DVERBOSE', '../src/meric/meric.cpp', '-c', '-o/pfs/lustrep2/users/onvysock/meric/build/src/meric/meric.cpp.1.o']



    In file included from ../src/meric/meric.cpp:2:
    ../src/meric/meric.h:5:10: fatal error: 'iostream' file not found
    #include <iostream>
             ^~~~~~~~~~
    1 error generated.
    ```


    Do you have any idea what can be wrong?

    + A: I was expecting this problem would be solved by now, but the Cray compilers need additional options to find their own include files. These are added automatically by the wrappers. I'm not sure if I have compiled programs with waf already on LUMI (I hate all those alternative tools that are incomplete) but most install utilities have a way to tell them which compiler to use. `cc` can show the commands that it would generate using the `-craype-verbose` flag so you could see which libraries and include files it tries to use but from what I remember this is cumbersome. I checked the tool that we use to manage software installations and I do not that it seems to support Waf which means that there must be a way to set environmen variables or command line options to select the compiler.
    + A (Alfio): the flag is actually `-craype-verbose`, e.g.
      ```
      $ CC -craype-verbose test.cc 
      clang++ -march=znver2 -dynamic -D__CRAY_X86_ROME -D__CRAYXT_COMPUTE_LINUX_TARGET --gcc-toolchain=/opt/cray/pe/gcc/8.1.0/snos -isystem /opt/cray/pe/cce/13.0.0/cce-clang/x86_64/lib/clang/13.0.0/include -isystem /opt/cray/pe/cce/13.0.0/cce/x86_64/include/craylibs -Wl,-rpath=/opt/cray/pe/cce/13.0.0/cce/x86_64/lib -Wl,-rpath=/opt/cray/pe/gcc-libs test.cc -I/opt/cray/pe/libsci/21.08.1.2/CRAY/9.0/x86_64/include -I/opt/cray/pe/mpich/8.1.12/ofi/cray/10.0/include -I/opt/cray/pe/dsmml/0.2.2/dsmml//include -I/opt/cray/xpmem/2.2.40-2.1_3.9__g3cf3325.shasta/include -L/opt/cray/pe/libsci/21.08.1.2/CRAY/9.0/x86_64/lib -L/opt/cray/pe/mpich/8.1.12/ofi/cray/10.0/lib -L/opt/cray/pe/dsmml/0.2.2/dsmml//lib -L/opt/cray/pe/cce/13.0.0/cce/x86_64/lib/pkgconfig/../ -L/opt/cray/xpmem/2.2.40-2.1_3.9__g3cf3325.shasta/lib64 -Wl,--as-needed,-lsci_cray_mpi,--no-as-needed -Wl,--as-needed,-lsci_cray,--no-as-needed -ldl -Wl,--as-needed,-lmpi_cray,--no-as-needed -Wl,--as-needed,-ldsmml,--no-as-needed -lxpmem -Wl,--as-needed,-lstdc++,--no-as-needed -Wl,--as-needed,-lpgas-shmem,--no-as-needed -lquadmath -lmodules -lfi -lcraymath -lf -lu -lcsup -Wl,--as-needed,-lpthread,-latomic,--no-as-needed -Wl,--as-needed,-lm,--no-as-needed -Wl,--disable-new-dtags 
      ```
    + RE1: To be honest I am not sure, what is your advice. Should I add the include paths when compiling with clang++ (I did a fast browse and did not find the standard c++ headers in the paths mentioned in the Alfio's answer)? Should I wait for someone to fix the clang++ utility? Should I load a compiler module instead of PrgEnv module?
        + (Alfio) I'm not really familiar with the tool, apologize in advance for any naive suggestion... Could you try `CXX=CC ../../waf configure build`? I tried it with a simple C++ example in the waf repository and it correctly reports `Checking for 'clang++' (C++ compiler)    : CC `
        + RE1.1: This is not a problem of waf. Try the following:
    ```
    $ module load PrgEnv-cray/8.2.0
    $ vim hello.cpp
        #include <iostream>
        int main()
        {
            std::cout << "Hello LUMI\n";
            return 0;
        }
    $ clang++ -std=c++11 hello.cpp
        hello.cpp:1:10: fatal error: 'iostream' file not found
        #include <iostream>
                 ^~~~~~~
        1 error generated.
    $ CC -std=c++11 hello.cpp
    $ ./a.out
    Hello LUMI
    $
    ```   
     **What solution do you suggest to use, if I do not want to use `CC` but directly `clang++`?**
     If you prefer, we may use another channel for communication.
         + So, if you want directly use clang++, you should be aware that it comes from the Cray compiler, so you really need the wrappers. For instance:
    ```
    $ which clang
    /opt/cray/pe/cce/13.0.0/cce-clang/x86_64/bin/clang
    ```
    If you need a plain clang, then I suggest to use the AOCC clang:
    ```
    $ module load aocc-mixed
    ```
    and then you can compile with `clang++`  the example above.

    + RE2: I did not do a deep research, so it could be possible, that waf support Cray compiler wrapper, however as an easy solution I did just specify the `clang++`, which equals to `CC`.
        + (Alfio) Have you seen [this](https://stackoverflow.com/questions/28620263/specify-c-compiler-in-waf)?
        + RE2.1: My library compilation process supports clang++, but the CC wrapper is not working for me. I know how to tell waf, which compiler to use based on what the CC wrapper returns. The source of the problem is not in the waf, see RE1.1.
        + I've checked what EasyBuild does, tested myself and also searched a bit on the web and it looks like Waf indeed simply uses the environment variables in the way that `configure` does to specify the compilers so it should be possible to use statements like `export CC='cc'` and `export CXX='CC'` to tell Waf to use the wrappers. With this on a C++ demo program the output does show
          ```
          Checking for 'g++' (C++ compiler)        : not found
          Checking for 'clang++' (C++ compiler)    : CC
          ```
          Whis is exactly what I want to see, and continuing this with `waf configure build -vvv` clearly shows once more that Waf is using the `CC` wrapper. In general, I'd say never trust autodetection of compilers when running configure/build tools because you'll often end up using the worst one on your system. Any decent tool has a way to specify the name of the compiler and compiler flags, at least when used in the proper way by the developers creating the build recipe. All the software we have at the moment on LUMI is build using the Cray wrappers except for software where I explicitly wanted the system gcc to be able to run completely independent of the Cray PE.
        + And `clang++` does not equal to `CC`. `CC` does a lot more.
        + **RE2.2: Can you please share your wscript? The part that checks for the CXX.**

+ Q : Is the BLIS library available?
    + A: We have a recipe so that a user can install it but we don't want to make it available by default in the central stack as it would conflict with libraries already build with Cray LibSci. A look at the symbols in Cray LibSci shows that is uses a mix of OpenBLAS and BLIS. 

### *15:00	break (30 minutes)*

### 15:30	Advanced Application Placement
*Session info: More detailed treatment of Slurm binding technology and OpenMP controls.
Exercises: about 30 minutes*

+ Q: If it is only "marginally slower" that suggest that very little extra perfomance can be obtained by doing the explicit binding? Ok, now he is saying something else. Suggest to ask at end of presentation.
    + A: crossing socket boundaries may lead to significantly lower performance
    + A: depends on the particular case

+ Q: (slide 16) Are you assuming --exclusive or other kind of full-node-access here?
    + A: yes.

+ Q: which binding mechanism has a higher priority OpenMP or SLURM?
    + A: Slurm will set a cgroup, you can't escape that. But also depends on which plugins are enabled.


### 16:30	Open Questions & Answers (participants are encouraged to continue with exercises in case there should be no questions)

+ Q: Is there a mechanism for requesting packages such as MUMPS?
    + A: should be addressed tomorrow.
    + A: Checked for MUMPS. The likely reasons why we don't have that yet ready (besides that it has not yet been requested) is that we have given priority to packages for which a friendly site with a similar system provides build instructions in a way that we can easily adapt to LUMI, and a frightening element on the web site that actually asks you to specify some information about how MUMPS will be used before downloading which we as support people rather than users obviously cannot answer with any accuracy. Though it looks like the download isn't really protected.

+ Q: would you provide tools such as Extrae as modules? Or maybe users would install them?
    + A: likely answered in tomorrows talk on additional software
    

---





---


---
+ A: if someone struggles to build/install a software package LUST+CoE can help, for example, by asking around (what experiences on other systems have been made)
    + A: The reality is also that the support team of 9 FTE is way too small to do all software installations for all projects as the expected number is very high given that many countries assign lots of small projects. We have to do more than just software installations, and we are only a fraction of the size of the software support team of larger centres as, e.g., Jülich. So we have to rely a lot on users doing their own installations, possibly with the help of local support teams from the countries they come from, and hopefully then contributing their experiences so that we can make them available to others.

+ Q: I want to build/compile CP2K 9.1, may be need assistance for that
    + A: we already have a recipe (easyconfig) for that, should be more clear after tomorrows talk on additional software
    + A: CoE has expertise with CP2K too
        + (Alfio) That's they way I use to install CP2K v9.1 on LUMI:
            + `module swap PrgEnv-cray PrgEnv-gnu` (GNU is supported by CP2K)
            + `module load cray-fftw`
            + `git clone --recursive --branch  v9.1.0 https://github.com/cp2k/cp2k.git`
            + `cd cp2k/tools/toolchain`
            + `./install_cp2k_toolchain.sh --enable-cray` (use `./install_cp2k_toolchain.sh --help` to get more help on what to install). Note that this takes a while to complete.
            + `cp install/arch/local.psmp ../../arch/`
            + `cd ../../`
            + Change the `arch/local.psmp` file by adding `-fallow-argument-mismatch` flag to `FCDEBFLAGS` variable
            + `make ARCH=local VERSION=psmp`
    + A: LUST may have had a support request for CP2K 9.1 recently

+ Q: will programs like LAMMPS, ABINIT, SIESTA be available as modules?
    + A: Status for these applications:
       + Limited support for LAMMPS, only few plugins, configuration based on input we got from CSCS who have a system similar to LUMI-C. Some of the plugins are supported by neither EasyBuild nor Spack, the two frameworks for HPC software installation that we use or consult for installation procedures. 
       +  ABINIT is available as easyconfig and discussions are going on with the ABINIT authors to improve the installation. The developers have already got access via the Belgian share on LUMI.
       +  SIESTA: Kind of problematic. I've seen it fail on user tests even though the compile succeeded without any terrifying warning. They also had the brilliant idea to change the build process to one that is harder to support in tools such as Spack and EasyBuild. Therefore Spack for now stopped supporting Siesta at version 4.0.2 which is 4 years old. EasyBuild kind of supports newer versions but only in combination with some libraries that are different from what we use on the system, and do to the nature of the new build process it is difficult to adapt the EasyBuild code in a generic way but also to write a robust automated build process specifically for the Cray PE. We'd need working manual installation procedures before even looking at how we can automate the procedure and maintain it. There are [some instructions to compile Siesta with PrgEnv-gnu on the Archer2 GitHub](https://github.com/hpc-uk/build-instructions/tree/main/apps/SIESTA) but we'd need a Siesta expert to see if this is just the most basic build or includes options that Siesta might provide. At first sight it does not include METIS, ELAP, MUMPS, PEXSI or flook that are mentioned in the 4.1.5 manual as libraries that provide additional functionality.

+ Q: Are there Easybuild recipes to install the Cray PE/tools?
    + No. This is no free software and installed in a very different way. EasyBuild can use the the Cray PE as external software though. 

+ Q: I think for Lammps and other softwares alike would be better to have a short guide suggesting the best combination of compilers, libraries and slurm options that would give the best performance in a general way
    + A: not easy to provide general answers. The right combination of compilers and libraries and the right Slurm options will often depend on the particular test case. E.g., due to different vectorisation and loop unrolling strategies one compiler may be better on one problem that leads to shorter loops and another may be better on another problem with the same code that leads to longer loops. The amount of parallelism and certainly how to tune a hybrid run combining MPI with threads will depend a lot on the test case.
    + A: maybe better to provide guidance on how to determine these options on a case by case basis

+ Q: is there a supercomputer similar to LUMI in the world?
    + A: to some extend yes, Frontier (ORNL, US), Dardel (KTH, SE), Setonix (Pawsey, Australia), Adastra (CINES, Montpellier, France). For LUMI-C there is Archer2 (EPCC, UK) and Eiger (CSCS, Switzerland). The software stack for LUMI was originally developed on Eiger as otherwise it would have taken half a year or so from the start of the pilot to have something that is properly designed and working.

+ Q: What is important to participants in terms of applications (standard applications or own applications)?
    + A: Looking at the proposals submitted in the latest round in Belgium, it was about 50-50. 

### *17:00	End of first course day*

See you tomorrow at 07:00 UTC, 08:00 EPCC, 09:00 CEST or 10:00 EEST.


## April 28 (all times CEST)
### 09:00	Performance and Debugging Tools incl exercises and a break
*Session info: Includes following content broken up with Exercises/Demos and a break*
+ *Introduction to perftools*
+ *Pertfools lite modules*
+ *Loop work estimates*
+ *Reveal for performance data display, compiler feedback and automatedscoping*
+ *Debugging tools at scale*


----

#### 09:00 Introduction to Perftools -- Perftools-lite module and demo

+ Q: I would be really interested in some comments about HIP and OpenMP offload profiling as long as power consumption tracking with the tools
    + A: Noted but this course is not about LUMI-G.
    + A: Sure, we have EAP though
    + A: These tools can be used with the AMD GPUs but we don't plan to cover that in this course.
    + A: routine-level power consumption available, not sure about data transfers

+ Q: When do the GPU partition will be available? For early access and then production?
    + A: LUMI-G: not before August (pilot), general availability fall 2022. The Early Access Platform, EAP, (MI100, available already, any existing project on LUMI-C has access). The EAP is designed for porting code, not for production runs or benchmarking. Especially inter-node communication is very poor at the moment which makes benchmarking this completely irrelevant, and the GPUs in the EAP are sufficiently different that much benchmarking and really fine-tuning on them may also prove to be irrelevant on the MI250X.

+ Q: Is there a tool to track specific I/O events (like volume of data written or read along the run) ?
  + A: perftools reports include a table addressing I/O, this will be shown later.

+ Q: Do you also advise to compare the performance of the exec generated with perftools-lite (only sampling) with the original executable without any monitoring? In other words, can there be a significant overhead with just application sampling?
    + A: always good to have one reference run

+ Q: Can the perftools-lite tools also be used with MPMD execution?
    + A: yes, has been done in the past

+ Q: What should you do if you notice that perftools-lite introduces a significant overhead compared to an executable without any profiling hooks?
  + A: More likely if you trace very small, frequently called functions, you can specify not to profile certain functions.
  + Q2: Can this be done with perftools-lite?
      + A: perftools is needed to select/exclude certain functions , however this applies to tracing, it is less likely that a lite sampling experiment will skew the performance.

+ Q: What is the purpose of the perftools-base module that is loaded by default?
    + A: `man perftools-base` (HPE Cray really likes man pages rather than web-based documentation). One of the functions is to make the other perftools modules available in the Lmod hierarchy. It is a rather common practice on Cray systems to load it by default, so we follow this "convention" so that people who are familiar with the Cray Programming Environment find more or less what they expect. 
    + A: It provides the command-line tools but unlike the full perftools module it does not affect any compilations.

+ Q: Is it possible to install `perftools-*` in our machine so that we can get the interactive output? (I mean this "Apprentice" program)
    + A: /opt/cray/pe/perftools/default/share/desktop_installers contains Apprentice2 for Windows and macOS and Reveal for macOS. Some remote connect capability of these does not work with ssh keys at the moment but you can run apprentice2 on .ap2 files you copy to your desktop/laptop.
    + A: We also have the lumi-vnc module to run graphical programs on LUMI via a VNC client or web browser (try `module help lumi-vnc`), and later this year (hopefully) there should also be Open OnDemand to offer a frontend to LUMI to run GUI programs without too much trouble. 
    + Q2: but not a Linux version, it seems (I guess this would require the full Cray stack to be installed, though)
      + A: This comes up from time to time but it is not clear how large the community is of people who want this and at the moment there is no commitment to provide Linux clients. We will feed this back.
      + A: The problem may also be that release engineering for Linux can be very hard for GUI packages that are not spread through RPM or other repositories as you can never be sure which libraries are present on a Linux machine due to all the distributions and all the installation options. One of the reasons we are so slow in setting up GUI-based applications on LUMI and to get the visualisation nodes available to users is precisely that we run into these problems all the time. You may have to use one of the modern containerised solutions for that.
      + C: *The first argument is a bit surprizing, given that I would expect the HPC community to be a bit more Linux-oriented than the average public. But I totally agree that getting a GUI to run on Linux is a hell of a job, so thank you for your answers :)*
      + C: The reality is that macOS is very popular in the HPC community because it offers you a UNIX-like environment, good development tools, but also good office tools that you also need in your work, and that Windows is on the rise since it has become rather good for development on Linux also thanks to WSL and WSL2. ComputeCanada makes their HPC software stack that they serve via CernVM FS also available to their users in Canada on Windows simply via WSL2...

#### 09:55 Advanced Performance Analysis I/II — Perftools, variable scoping and compiler

+ Q: 

#### 10:45 Advanced Performance Analysis II/II — Communication Imbalance, Apprentice2, Hardware Counters, Perftools API, Feedback with Reveal, OpenMP, demo

+ Q: Is there a way to "customize" the profiling : for example if the runtime is n sec, start the profiling at t0 and stop it at t1 with 0<t0<t1<n, i. e. produce a profiling from t0 to t0+t1? it may be usefull for tracing for example a small number of itérations (rather than all itérations) and also for avoiding to generate too much data to proceed later with GUI.
    + A: You can use an API to control which parts of an application are profiled (between begin/end calls). This is covered in the talk and one of the exercise directories. The two aspects of this are first that you can collection off and on, secondly wrapping particular parts of an application between begin/end calls such that this will appear separately in the report.
    + A: Using specific time stamps is not directly possible with the API.

+ Q: Regarding the himeno example; What is the importance of distributing processes over NUMA domains?
  + A: By default, processes are not cyclically distributed over NUMA domains. Might use `--cpu-bind=verbose` as srun option to obtain binding information. 

#### 11:30 Debugging at Scale -- gdb4hpc, valgrind4hpc, ATP, stat, demo

+ Q: Is there any reason not to setup ATP by default so that it can capture any unexpected crash?
    + A: ATP has a low overhead, but it has some. So, it's up to the user to make the decision to include it or not.
    + A: It adds a signal handler. That might interfere with the application.

+ Q: Will DDT be available on LUMI?
    + A: Yes ARM forge will be available on LUMI. No ETA for the installation at the moment.

+ Q: Will totalview be also treated in the same way as DDT? Will the user have to bring its own license to use it on Lumi if I understood well?
    + A: DDT will be available as a part of the ARM Forge. I do not believe TotalView would be available.

+ Q: Is it possible/advised to enable by default both ATP and perftools-lite?
  + A: ATP could be enabled by default, there might be the odd interaction with application signal handlers to watch out for.
  + A: I (Harvey) don't recommend having profiling enabled by default as this affects how applications are built and run and generates extra data that people might not want. 


### *12:00	lunch break (60 minutes)*

### 13:00	Understanding Cray MPI on Slingshot, rank reordering and MPMD launch
*Session info: High level overview of Cray MPI on Slingshot, useful environment variable controls.
Rank reordering and MPMD application launch.
Exercises: about 20 minutes*

+ Q: When will the Slingshot upgrade take place?
    + A: ~ end of May, from then UCX won't be available

+ Q: Can `MPICH_RANK_REORDER` environment variables also be used to control binding inside a node, for example spreading across sockets?
    + A: don't think so
    + Q2: I phrased my question wrong. Suppose in a single node you bind processes to cores 0,32,64,96. Can you then use `MPICH_RANK_REORDER` to control mapping of ranks to those processes? Admittedly, this will have a smaller impact compared to inter-node communication, but it is possible that communication between 0-64 is slower than between 0-32.
    + A: This is a very good question and I have been thinking we should start looking at this from the perspective of node structure in addtion to on/off node considerations.

+ Q: What is the difference between `MPICH_RANK_REORDER_METHOD` and `srun --distribution`? Apparently the former takes precedence over the latter.
    + A: I'd say: srun will map Slurm tasks on the resources of the job, and `MPICH_RANK_REORDER_METHOD` will then influence the mapping of MPI ranks on Slurm tasks with the default being rank i on task i.
    + A: (Harvey) I really need to test this as I could imagine that distribution to nodes could be done from scratch but the custom mapping might be done from SLURM-set mapping already there.

### 14:00	I/O Optimisation — Parallel I/O
*Session info:*
*Introduction into the structure of the Lustre Parallel file system. Tips for optimising parallel bandwidth for a variety of parallel I/O schemes. Examples of using MPI-IO to improve overall application performance.*

*Advanced Parallel I/O considerations*
+ *Further considerations of parallel I/O and other APIs.*

*Being nice to Lustre*

+ *Consideration of how to avoid certain situations in I/O usage that don’t specifically relate to data movement.*

+ Q: What is the ratio between IO node to compute nodes on Lumi?
    + What do you mean by IO node?
    IO nodes is probably not the right terminologiy here indeed. I used the terminology from the decommissioned BGQ system.
    + I/O node == some node that is only used for I/O transfers???
        + A: don't think that there are such special nodes on LUMI-C, however some other partition, for example, LUMI-K (?) might be used (don't know if these partitions have better network connections for I/O)
    + The I/O servers on one of the slides where it said that you only do I/O from some processes are not hardware I/O servers, but your processes of which some take care of the I/O. Is that the source of the confusion?
    Probably. If I request a collective IO with MPIIO, which fraction of my processes will then be in charge of communicating with the file server?
    + A: maybe depends on the implementation of MPI-IO (and stripe_size, stripe_count) --> in other words: "don't know"

+ Q: What is the optimize number of files per compute nodes for MPIIO?
    + A: maybe one file per process? 
    + Q2: This would overflow the meta data server if for instance 100 000 processes write 100 000 files at the same time. The other extreme would be 100 000 files wrting collectively in one single shared file. Is there an optimum where a subset of processes would write to their own share file?
        + A: probably there is an optimum, but difficult to provide one answer to all possible scenarios

+ Q: It seems there is no metadata striping: `lfs getdirstripe .` gives `lmv_stripe_count: 0 lmv_stripe_offset: 0 lmv_hash_type: none` Is this a deliberate choice? How do you ensure load balancing across MDTs? I see generally MDT0000 already is used more than MDT0001.
    + A: second MDT seems to be there for redundancy only

+ Q: What is performance for writing small files to MDTs (https://doc.lustre.org/lustre_manual.xhtml#dataonmdt)?
    + A: It is probably a non-issue on LUMI as the file policies are such that the use of small files is strongly discouraged due to bad experiences on other CSC systems. You will be forced to use different strategies than putting 10M small files on the system.

+ Q: Do you use PFL (Progressive File Layouts - https://doc.lustre.org/lustre_manual.xhtml#pfl)? If so when do you recomend it?
     + A: With `lfs getstripe -d .` you can see the current settings; I see `stripe_count=1` and no PFL.
     + A: (Harvey) I don't have the answer but we can ask about this. I would expect some delay in any case for features to be enabled in the Lustre that HPE provides even if they have been available for some time.
         + A: I tried `lfs setstripe -E 4M -c 1 -E 64M -c 4 -E -1 -c -1 -i 4 /my/dir` and it seems to work. So I think PFLs are possible, but the default striping settings do not use it.

### *14:45	break (30 minutes)*

### 15:15	Additional software on LUMI-C
*Session info:*
+ *Software stacks and policies*
+ *Advanced Lmod use*
+ *Installing software with EasyBuild (concepts, contributed recipes)*

    + Q: Are the EasyBlocks adapted for LUMI? Do you expect users will need to modify those as well?
        + A1: some easyblocks have been adapted for LUMI, see https://github.com/Lumi-supercomputer/LUMI-SoftwareStack/tree/main/easybuild/easyblocks 

+ *Containers for Python, R, VNC (container wrappers)*

+ Q & A

### 16:15   LUMI documentation, how to get help, how to write good support requests

+ Q & A

### 16:20	What are typical/frequent support questions of users on LUMI-C?

+ Q & A

### 16:35	Open Questions & Answers (participants are encouraged to continue with exercises in case there should be no questions)

+ Q: Would LUST be interested in EB recipes contributed from users?
  + A: definitely yes
 
 
+ Q: Will mail server for slurm be installed on LUMI? so, when the calculation finish will notify by email (#SBATCH --mail-type=END)
    + A: need to ask system admins

+ Q: A question about the material from yesterday: When is it safe to use the mixed compiler modules and when it is not? I would expect it to be safe for C, but can see problems combining C++ code from different compilers (name mangling issues?) or Fortran code. Can you give any advice?
  + A: The real use case here is that you normally have a programming environment loaded and are using the wrappers but want to use another compiler to build something directly without the wrappers, typically PrgEnv-cray for the former and a newer-than-system gcc for the latter. For example you might want to build cmake with gcc but don't need to swap the whole environemnt to gnu and use the wrappers.

+ Q: Any plans for LUMI Users Group or something similar?
    + A: Exchange of solutions, experiences, etc. I was thinking online.

+ Q: Quick question: to compile a code which targets Lumi-C, I suppose the modules       LUMI/21.08  partition/C should be the right ones
    + A: yes, but better start using LUMI/21.12

+ Q: In my experience, EasyBuild is not necessarily the best tool to fix compilation problems. Do you have tips for when an existing easyblock does not work on LUMI? For example try a manual build first, and afterwards add it to EasyBuild for reproducibility?
    + A:

### *17:00	End of second course day*

# Any other notes

## Course page

https://www.lumi-supercomputer.eu/events/detailed-introduction-to-lumi-c-april-2022/

## Misc

[Download the LUST slides](https://lumi-supercomputer.github.io/LUMI-training-materials/PEAP-Q-20220427/)

# Questions
+ Q: How to get login to LUMI? (for users with a Finnish allocation)
    + A: See https://www.lumi-supercomputer.eu/get-started-2021/users-in-finland/ 

+ Q: I have registerd my public key to mycsc.fi page few days back, but I still not recived the username. Can I use my csc username (the one i use for puhti and mahti) to get login into lumi?
    + A: Best option is to send a support request for this. If you let us know the username for puhti/mahti we might check if it is created on LUMI already.

