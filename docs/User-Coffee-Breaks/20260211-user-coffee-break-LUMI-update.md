# LUMI Update Webinar (February 11, 2026)

*Presenters:* Harvey Richardson (HPE), Samule Antao (AMD), Kurt Lust (LUST)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20260211-user-coffee-break-User-Update.mp4" controls="controls">
</video>

Slides of the presentations:

-   [HPE presentation](https://462000265.lumidata.eu/user-coffee-breaks/files/20260211-user-coffe-break-LUMI-update-HPE.pdf) (still missing)

-   [AMD presentation](https://462000265.lumidata.eu/user-coffee-breaks/files/20260211-user-coffe-break-LUMI-update-AMD.pdf) (still missing)

-   [LUST presentation](https://462000265.lumidata.eu/user-coffee-breaks/files/20260211-user-coffe-break-LUMI-update-LUST.pdf)


## Q&A

[Full archive of all LUMI Coffee Break questions](https://siili.rahtiapp.fi/coffeearchive2026#). This page only shows the 
questions from the LUMI update session.

1.  Is Vulkan compute supported on LUMI's MI250X GPUs, or is ROCm/HIP the only available GPU compute path? 
    I'm running a C++ inference app using NCNN (neural network framework) with Vulkan as its GPU backend. The build succeeds with `NCNN_VULKAN=ON`, but at runtime it fails to find a Vulkan GPU device, likely a missing ICD driver.
    If Vulkan isn't supported, what would be the recommended alternative for GPU-accelerated inference on LUMI?

    -   The LUMI GPUs are compute GPUs, not rendering GPUs and hence don't support Vulkan or OpenGL.
        You will have to switch to software for compute GPUs and not software that is written for 
        consumer GPUs or visualisation workstations. Most users who do inference, use the traditional AI 
        frameworks developed in a mix of Python and native languages. And some are also available as 
        libraries to be used outside Python.

        You'll have to use software that makes use of the ROCm framework. 
        That is much more than HIP alone and also includes lots of libraries, including libraries for AI operations.
        
        I checked the [NCNN GitHub](https://github.com/Tencent/ncnn) and that is not software written 
        for supercomputers but rather for consumer devices and hence uses libraries that are popular and
        widely supported on those.
        
        
2.  Based on the [AMD GPU support matrix](https://rocm.docs.amd.com/projects/install-on-linux/en/latest/reference/user-kernel-space-compat-matrix.html), 
   the current GPU driver `6.3.X` is expected to support several user-space ROCm versions 6.1.x, 6.2.x, 6.3.x, 6.4.x, 7.0.x.

    a.  Is there a preference for a certain version (e.g also 6.3)?

    b.  What is the likely effect of using a different user-space than 6.3?

    c.  We have old LUMI containers for pytorch (built by AMD?) with rocm version `6.0.3`, 
        and we find that they appear to still work for some of our training. 
        What kind of things might be expected to not perform well by using this out of 
        support rocm version? Is it that some operations that might fail or simple inefficiencies in computation,... ? 
    
    -   The later the version, the longer you can expect to be able to use your container. 
        Moreover, several performance issues have been solved in the evolutions of the 6.x line. 
        Upgrading to a later 6.x version may certainly give you extra performance, and in some
        corner cases a lot of extra performance.
        But we still have issues with 7.0. So I'd personally go for 6.4 wherever I could.

    -   If you go above or below the supported range, anything can happen. 
        Just crashes as the userland tries to use functionality that the driver does not provide, 
        but also subtle errors like wrong results.

    -   Only trying will show what can go wrong if you use older containers. 
        Note that it is also not only the ROCm version that determines if a container will run, 
        but also which version of the OFI RCCL plugin and which versions of libfabric and cxi that one 
        needs or uses.


3.  Any updates on whether AMD will provide new containers for pytorch, and a possible timeline? 
    Any timelines for the AI factory (CSC PyTorch docs mention early-spring?)

    -   AMD will likely not make any anymore. They will come from the LUMI AI factory, 
        so wherever you found something about this in the CSC documentation is likely correct.


4.  There was AMD supported container for ML in LUMI that used older ROCm, is there going to be a newer version of it as well?

    -   As said in earlier questions, containers will now come form the LAIF. We don't know what they will offer.


5.  For what I understood, ROCm PyTorch is 2.5.x. When does it support PyTorch 2.6+. 
    There are some masking functions that some transformers need. Is this already there or still incoming? 
    Or can I implement that support somehow?

    -   Not sure where you got that idea from, as we already had a container with PyTorch 2.7.1 before the system update
        in `/appl/local/containers/sif-images`.

        Each PyTorch version has an official support window of ROCm versions, though sometimes compiling PyTorch 
        yourself (which is very hard) can work on an older version of ROCm also.

        From what I see we should now be able to run PyTorch 2.9, and if we can solve the issues with RCCL we 
        experience in ROCm 7.0, also PyTorch 2.10.


6.  I had a custom conda environment with pytorch based on '/appl/local/containers/sif-images/lumi-rocm-rocm-6.2.4.sif' 
    following the AI course in [here](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/blob/main/07_Extending_containers_with_virtual_environments_for_faster_testing/examples/extending_containers_with_venv.md). 
    Are those environments supposed to work even if the ROCm has been updated? 
    I am having problems launching jobs, they don't crash but they are hanging when initializing the multi-node multi-gpu threads

    -   That container should still be OK, ROCm 6.2.4 is supported on the current driver.

        You are in that case using a ROCm userland that is in the container, so your installation will still be using the same ROCm as before, but that is OK as it is supported by the driver.
        
    -   Note the filesystem issues. Hangs can be related to that.

    -   Or you may have put something else in the container that causes issues. 
        As far as we can see, our PyTorch container built on top of 6.2.4 continued to work.
    
    Would you recommend to rebuild the image? I did not have this issues before the upgrade, or you think this is mostly about the lustre problem is going on these days?
    
    -   We can't really know without knowing all the internals. Rebuilding only makes sense if you'd have a base container with a newer ROCm and we don't have these either at the moment.

    Regarding the LUMI stack discussion, should I load the previous LUMI/24.03 if I stick with my old container, or it doesn't really matter?

    -   It does not matter. The only moment where the stack is used, is to provide `cotainr` to build the container or
        EasyBuild to install from one of our EasyBuild recipes.
    

7.  We're using pytorch containers with user-space rocm that is brought together with the 
    wheel of pytorch ([`torch-2.9.1+rocm6.4`](https://download.pytorch.org/whl/torch/)), but a colleague 
    has spotted a node communication inefficiency (defaults to TCP/IP) solved by compiling 
    and enabling `libfabric` plugin ([aws-ofi-nccl](https://github.com/aws/aws-ofi-nccl)), 
    which speeds up the training **by a factor of 2x**. This is compiled against `libfabric`, `rocm`, `mpi`, 
    with a limited amount of experience with rocm and all its pieces, and compilation, 
    anything we should be wary off?

    -   We're also still working on understanding how to best do the plugin on the new system. But

        -   The plugin has always been needed for good performance and we've been communicating that 
            in all our trainings, even non-AI trainings.
  
        -   Development of the plugin is in a bit of a messy state: It is originally a generic plugin 
            written by AWS for the libfabric library as they also use libfabric for their own NICs. 
            Then AMD also looked into development, and now HPE will take this over as they are very 
            much aware that their network needs specialised libraries for best performance. 
            So it is tricky to say for now which version would be best. 

            Our current effort is in [this file](https://github.com/Lumi-supercomputer/LUMI-EasyBuild-contrib/blob/update/aws-ofi-nccl-upstream-with-rocm/easybuild/easyconfigs/a/aws-ofi-nccl/aws-ofi-nccl-a1a626a-rocm.eb) 
            but this link will become invalid when the file is accepted in the main repository.
            
        -   For most applications, MPI performance will not be that crucial. 
            If it is, the best for now is to try to inject Cray MPICH into the container and use an mpi4py 
            compiled with that one. This can be a bit tricky: If the libc library in the container is too old, 
            packages injected from the system may not run and you may have to inject a suitable libc version also. 
            And the MPI libraries have some dependencies which may or may not be in the container. 
            This is really a per case thing. In the past, we built our containers with an OpenSUSE version 
            that is very close to the Enterprise version on the system to make this easier.

        -   Before the update we also figured out that there were sometimes slightly newer versions of 
            libfabric and the cxi provider than there were on the system that were still compatible with the 
            network drivers but offered better stability. 

            It does however take months to build up that knowledge, and it does require a stable system which is not yet the case.


8.   What are the issues of using the rocm that comes packaged with pytorch pip wheels 
    (`torch-2.10.0+rocm7.-cp310-cp310-manylinux_2_28_x86_64.whl`) compared to waiting for the 
    official rocm container? 

    -   UPDATED ANSWER AFTER THE SEMINAR: Those wheels do indeed seem to contain many if not all of the necessary libraries. 
        They do not contain the RCCL plugin which is essential for good performance on our network, 
        which the containers that we provided did contain. Also, if you would add other software that misses
        libraries, you would still have to add them which may require a full ROCm installation anyway as 
        the package manager would not find the libraries that come with the PyTorch wheels.

        Use also at your own risk as we do not know how these have been compiled. 
        There may be more issues in particular for those libraries that would interface very closely to the OS.


9.  Given all the precompiled containers with rocm6.1+torch2.4+ are broken for us 
    (possibly triton issues), and the previously only one working (rocm6.0.3+torch2.3) is unsupported, 
    we will have to contact AI Factory to find more about their timeline of their containers 
    (alongside trying to do this job ourselves). What's the best way to share any updates about this so 
    that not every user who depends on pytorch has to do the same? 

    -   As mentioned by Emmanuel, new containers are being tested at the moment. It is not clear this would have been any faster if new people had not taken this over. There was a call on this very topic this morning.

    Q: Any estimates? How long do we wait before we try to do this ourselves? (We can't use Pytorch.)

    -   I would not expect anything with such old versions of PyTorch though. 
        And we have newer containers with newer PyTorch versions that we get very few complaints about.


10. Perhaps not an AMD question, but there may be a ROCm expert in the room: after building a new container for the 
    updated ROCm version, my output now contains cryptic messages like: 
    "Params set by AI: DeviceGroupedConvFwdMultipleABD_Xdl_CShuffle<64, 64, 64, 16, Default, 32, 32, 2, 2, 1, 1, 1, 1, 1, 1>"
    It seems to be ROCm related, but what is it indicative of? library mismatch? The scripts otherwise proceed as expected.
    
    -   We in LUST can't do much more than do an internet search for this either, but that indicates 
        that it is a message from the Composable Kernel library showing which kernel is being used.

        That library tries various combinations of parameters during a warm-up phase to detect the best kernels for the hardware.
        
        I found the symbol in [this file](https://github.com/ROCm/composable_kernel/blob/develop_deprecated/library/include/ck/library/tensor_operation_instance/gpu/grouped_conv_fwd/device_grouped_conv_fwd_xdl_outelementop_instance.hpp) in the old Composable Kernels GitHub repository (didn't want to clone the new one).


11. Perhaps an updated guide on how to make singularity containers with the new ROCm version would be good? It seems perhaps the cotainr-tool is still pointing to an older base-image? Possibly this would solve some of the above questions (2,3,4,6).

    -   We cannot do everything at once. This is on our agenda but we need people who want to support that also. We currently have base versions up to 6.2 for `cotainr`, but they do not show up as a parameter with `cotainr info`.

        The `cotainr` tool comes from an external party and we also need to wait for them.


12. We are using the `PrgEnv-gnu/8.6.0`, is it safe to use now or should we switch to `PrgEnv-cray` or `PrgEnv-amd` ?

    -   It depends what you want to do. As explained in our documentation and courses, these are different compilers.

    We are interested in particular in GPU-aware MPI. Is it known to be broken with PrgEnv-gnu/8.6.0 on multiple GPU nodes?

    -   (Kurt) It is not the `PrgEnv-gnu` module that loads the specific version of the Cray MPICH library, but the 
        combination of a `cpe` module and that `PrgEnv-gnu` module. There are scenarios where `PrgEnv-gnu/8.6.0` would 
        give you an older version of the MPICH library, e.g.,

        ```bash
        module purge
        module load cpe/24.03
        module load PrgEnv-gnu/8.6.0
        ```

        will give you the MPI library from 24.03.

        But when using this in the environment immediately after logging in, or when using this with `cpe/25.03` instead, 
        you will get the MPI library of 25.03.

        When running, you would always get the MPI library of 25.03 unless you use one of the tricks described on
        [this page of the CPE lecture of the intro courses](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20251020/102-CPE/#warning-1-you-do-not-always-get-what-you-expect) which discusses the `CRAY_LD_LIBRARYPATH` issue also discussed 
        in today's seminar. Except then when compiling in `cpe/23.09` but that one will not work with `PregEnv-gnu/8.6.0` anyway.
 
    -   (Alfio, HPE) I'm not aware of any issues there, and definitely this is not related to the compiler. 
        I suggest to open a ticket on the LUMI ticketing system if you see any issues.

13. We are running an in-house CFD code and what was working before the maintenance does not anymore. 
    The code has been recompiled successfully (in appearance) with the updated software package. 
    In particular, we observe that simulations using more than 1 GPU node end up with NaN at the first iteration. 
    Everything works fine on 1 GPU node.The same mesh, with the same version of the code on our local 
    supercomputer works fine in any case. We suppose that the issue comes from the inter-node communications 
    (hence related to GPU-aware MPI) but both the MPI and the GPU transfer libraries are linked properly. 
    Would you have any recommendation to solve this issue ? Has something changed in the libraries or 
    the environment and that is not documented yet ?

    -   Other than trying alternative versions of available software to see if it helps I have a feeling 
        you will need to try to find where the working and failing runs diverge and put in a ticket about this.

        And furthermore, you may have to debug...
        
        You could of course still try to run with some of the old libraries using the tricks discussed today in the seminar to have concrete versions of libraries (the `CRAY_LD_LIBRARYPATH` story or `lumi-CrayPath` modules).


14. We need to run [SILAM](https://github.com/fmidev/silam-model)  on Lumi for the DeodE project. 
    The code is MPI/OpenMP parallel Fortran 2008. It uses quite a few libraries: 
    eccodes, netcdff, pnetcdf, proj etc. Within the project the code needs to be runnable by 
    different people, and I would prefer not to tweak runtime environment. 
    It is rather convenient to use apptainer to make portable runs,  and they work as long as all PE 
    are on the same node. Is there any way to build a container that can work in multi-node configuration at Lumi?

    -   There are Cray PE containers you can try leverage. 
        MPI workloads are known to work properly with containers given that the Cray libraries 
        are also available inside the container. Building your own container with Cray PE dependencies built 
        in it means that that container cannot be distributed outside LUMI. For more portable containers 
        you can try bind the Cray dependencies instead of having them built in the container. 

    Thank you! Any links to recipies?

    -   [This is for MPI4Py and how to use Cray MPICH](https://github.com/sfantao/LUMI-containers/blob/main/RecipesDocker/mpi4py/build-rocm-6.1.3-python-3.12-mpi4py-4.1.0.sh). 
        For ftn you'd need a base image with the Cray PE in it.

    I'll check that. Are there any recepies for apptainer and gfortran?

    -   (Alfio, HPE) For what is worth, you can refer to https://arxiv.org/abs/2407.19928. 
        With the LUMI update, you can now use MPICH 4 within the container (which is compatible with Cray-mpich 9). 
        LUMI has Singularity, but this is "just like" apptainer.

    -   The previous Containerised Cray PE modules are also discussed on the
        [ccpe page in the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/c/ccpe/).

        We're also working in LUST on a procedure to extend these containers with other software.
        It will hopefully be approved soon to be made public.


15. Another SILAM question. It compiles using ifort or gfortran. Compiler segfaults when I try llvm fortran. 
    Is porting to LLVM fortran worth the effort? What would be a procedure to handle compiler segfaults?

    -   In the LLVM ecosystem there are two open source Fortran compilers: the classic one, based on a frontend
        donated by PGI, now part of NVIDIA, and a new-generation one. LLVM 20 officially made the switch from
        the classic one to the new generation one. The new generation one is also the one used in ROCm(tm) 7.0
        and newer.

        Development for the classic one makes no sense. That is a dying compiler. But it is very interesting to
        develop for the new generation one as that one is gaining a lot of traction in the community and also 
        support from several hardware vendors, including AMD.

    -   And AMD is very keen on getting reports about issues with their new generation compiler.


16. This is maybe not directly related to today's talk, but Im trying to compile an openfoam-application. 
    It is not working, could this be related to the system upgrade or the current file system issues?

    -   OpenFOAM should work on LUMI. There is also PETSc versions with GPU acceleration.

    -   But if it requires an expensive in-situ build, it stresses the file system a lot so
        it may get stuck.


17. In ROCM v7, is there an option to fall back to classic Flang rather than amd-flang? 
    Not all codes compile with flang-new. 

    -   Classic flang should work. You just need the classic flang driver. 
        The amd-flang driver coming from ROCm doesn't "fall-back" you need to use a different compiler driver from aocc. 
        The flang drops are available [here](https://repo.radeon.com/rocm/misc/flang).

    -   But as the module files are likely incompatible, forget about linking to any library that
        relies on precompiled module files. There is no way LUST can provide yet another stack for that.

    -   The new Flang compiler is also rapidly evolving. But if the incompatibility is due to your code
        breaking the Fortran standard, then of course your issue may never get fixed.

18. Would it be an option to set up an [MCP server](https://modelcontextprotocol.io/docs/getting-started/intro) 
    that documents the recommended workflows for compiling/profiling/submitting etc? 
    MCP servers are basically documentation for LLMs (large language models). 

    -   This seems way outside of scope for us. We have neither the expertise nor the development time
        for this in LUST.


19. What risks breaking if you try to use user level ROCm 7.2 together with the 6.3 driver?

    -   We don't know, but basically everything. These libraries likely expect functionality from the driver that it does not offer.

    -   With 7.0 which is officially supported we already have issues to get RCCL to work properly on our network.



20. What is planned for CPE 26.0x and will we get that on LUMI?

    -   The CoE will investigate providing a container for this in future irrespective 
        of any plans to install on LUMI. In the past we only made update containers available to 
        users/groups who had a real need for newer compilers.

    -   For some of those containers, LUST does also do an effort to provide at least a
        partial software stack (i.e., the most popular libraries from the central software stack).
        This is also because if that version of the CPE then comes on the system, we are 
        prepared and can move faster to offer users a full software stack.

        This is what we did now with 25.03. Note that especially GPU software was missing at
        first since we could not test any of that before the update as the driver was too old.

    -   And 26.03 should enable us to move to ROCm(tm) 7.0.
