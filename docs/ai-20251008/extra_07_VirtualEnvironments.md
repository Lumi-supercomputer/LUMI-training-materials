# Extending containers with virtual environments for faster testing

*Presenter:* Gregor Decristoforo (LUST)

Contents:

-   Using pip venvs to extend existing containers
-   Create a SquashFS file for venv
-   Pros, cons and caveats of this approach


<!--
A video recording will follow.
-->

<!--
<video src="https://462000265.lumidata.eu/ai-20251008/recordings/07_VirtualEnvironments.mp4" controls="controls"></video>
-->

## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-07-Extending_containers.pdf)

-   [Examples](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/07_Extending_containers_with_virtual_environments_for_faster_testing)
<!--
-   [Examples](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20251008/07_Extending_containers_with_virtual_environments_for_faster_testing)
-->

-   The [additional training materials mentioned in the "Running containers" page](extra_05_RunningContainers.md#extra-materials)
    are relevant for this presentation also.


## Q&A

1.  So far we have focused on working with containers. Is there any situation when it is enough to 
    work only inside a venv or conda environment?

    -   Not really as soon as you have a Python environment with thousands of files. 
        Python is a real file system killer on HPC clusters. The only way you could do it, 
        is by installing your Python environment in `/tmp`, then put it in a tar file or 
        some other archive, and whenever you run a job, untar that archive again in `/tmp` of all compute nodes.

        But then you are, e.g., also limited to the ROCm version installed on the system 
        while with containers, you can use a slightly newer one (+2 or so with the current 
        driver, so up to 6.2, and likely +3 or +4 with the next driver). 
        Given how quickly the evolution of AI packages goes and their preference for the newest ROCm, 
        you really want the most recently supported except right after a system update.

    Is this answer true also for other clusters with NVIDIA GPUs like COSMO, Leonardo, etc?

    -   Yes. The file system issue is present in most affordable parallel filesystems: Lustre, BeeGFS and 
        GPFS/Spectrum Scale are the ones I have used. Some vendors claim to have a solution, 
        but it comes at a very high cost. So it is true for Leonardo also. I don't know the COSMO cluster. 
        But I once had to install some Python packages on the predecessor of the current MareNostrum cluster 
        at BSC. What took 15s on my laptop, took 30 minutes on Leonardo. 
        So if all these files would be read by Python, it would be equally bad.

        This has nothing to see with the brand of GPUs. It is only that because of the size of LUMI, 
        it shows more than on smaller clusters, as the file system metadata access does not scale nicely 
        with the size of the cluster, and that we pay more attention to this issue in our courses than 
        some other sites, also because CSC has seen issues on various clusters they manage. 
        The one advantage that you may have on NVIDIA is that, as it has evolved a bit further already, 
        there is less pressure to use the very latest version of CUDA for your AI packages.
      
        I remember some people from HPE telling that they ran a particular Python test - I don't remember 
        if it was on LUMI or a very similar cluster - and in the container it ran twice as fast as outside 
        the container, basically because Python was busy loading and reloading Python packages from the 
        file system all the time.
      
    So, even at the beginning of a project when I just want to test an idea, it is best practice to start from a container? 

    -   If you don't run that at scale, i.e., test your idea on a lot of nodes or with multiple simultaneous jobs, 
        you can just try from the filesystem. Probably use `/flash` for that though. That will already 
        help a little. Note also that with our EasyBuild modules around our PyTorch containers, it is very 
        easy to pack your virtual environment in a SquashFS file. Just a single command and reloading the 
        module. Which still gives you all the advantages of our PyTorch installations as there went a lot
        of effort in getting RCCL work as well as possible.
    
    Thanks! I didn't know that. I never went really deep into Lustre's recommendations in the 
    documentation of any of the clusters I have used. I will pay more attention. I think it is 
    something most workshops or webinars don't stress enough (and we users don't ask).

2.  Given this [requirements.txt](https://github.com/DAMO-NLP-SG/VideoLLaMA2/blob/main/requirements.txt) 
    example, I usually run `module load pytorch/2.2` and then comment out the PyTorch entries, 
    but now that I’ve learned about container tools (e.g., Singularity, `cotainr`), what’s the best way 
    to manage dependencies like PyTorch and other packages without manually editing the requirements file each time?

    -   There's no unambiguous "best way", it depends on how complicated the other packages are. 
        If most packages you need are in the container (or pytorch module), then it's probably best 
        to use that as a starting point like you have been doing. However, if the extra requirements a
        re more complicated it might make sense to create your own container, e.g., with `cotainr`. 
        Unfortunately Python package management is complicated and messy :-)

    I meant if at least they have the environment working with their provided list of packages, 
    what kind of additional issues I might face that would let it difficult to have a direct 
    `pip install -r requirements.txt` work directly?

    -   It depends a lot what is in the requirements.txt. For example if it specifies a different 
        PyTorch version, in the worst case it will then automatically install a CUDA-PyTorch which 
        doesn't work on LUMI.


3.  If I try to extend one of the base images with an environment.yml that I'm porting from a machine 
    with NVIDIA gpus (which has cuda dependencies outof the box). What changes should I make or 
    can I just extend it as it is from a suitable base image? I've tried to do it directly and got a value error:
    ```
    ValueError: Invalid command cmd='bash conda_installer.sh -b -s -p /opt/conda' passed to Singularity resulted in the FATAL error: FATAL:   container creation failed: mount /var/spool/slurmd->/var/spool/slurmd error: while mounting /var/spool/slurmd: destination /var/spool/slurmd doesn't exist in container
    ```

    -   What packages are in your yml? Specifically what packages use cuda?

    Pytorch itself is listed, and some packages like : `cuda-crt-tools=12.9.86=ha770c72_2`, etc

    -    That error message has nothing to do with the list of packages. Mounting works differently 
         while building a container and you cannot do that with the bindings module loaded. 
         When building, all your mount points must first exist in the container as a directory, 
         while this is not the case while running the container. 

    Ok, I've removed the bindings load and tried again. Got a RuntimeError from multiple conda installs interfering:
    ```
    RuntimeError: Multiple Conda installs interfere. We risk destroying the Conda install in /opt/miniconda3. Aborting!
    ```
            
    -   You cannot run cotainr on a base image that already contains a conda installation. Could that be the case?

    lumi-pytorch-rocm-6.2.4-python-3.12-pytorch-v2.7.1.sif

    -   That is indeed the issue. You can extend those containers using `pip` I believe, but extending 
        them with conda is a bit more tricky as you need to use the mechanism of conda to extend an 
        installation. I've tried it once, and though the particular package that I tried to install 
        seemed to be installed, it did not show up in `conda list`. As it was for a ticket and as 
        the user did not provide further information I needed to see if it worked for them, 
        I did not continue the experiment though.
        I used something like
        ```
        Bootstrap: localimage

        From: {local_sif}

        %post

        conda install -c conda-forge openvdb --override-channels --freeze-installed --yes

        ```
    
    Should I use another base-image to replicate my conda environment or build it from scratch from my required libraries?

    -    If you want to use cotainr then you need to use a different base-image. 
         Cotainr will always try to install conda again. Alternatively, you could look at the 
         existing packages in e.g. `lumi-pytorch-rocm-6.2.4-python-3.12-pytorch-v2.7.1.sif`. 
         `singularity shell lumi-pytorch-rocm-6.2.4-python-3.12-pytorch-v2.7.1.sif` and then `conda list`. 
         See what packages are available and then extend it with the missing packages using 
         the venv approach from the last presentation.  

    I'll try both approaches, a base image without conda would be `lumi-rocm-rocm-6.2.4.sif`? In this case I guess I would need to change the pytorch versions no? Currently it is listed as `pytorch=2.4.1=cpu_mkl_py312hf535c18_100`

    -   Yes. That image should work with pytorch 2.7.1. And you probably need to remove all of the 
        cuda specific packages as well.

    Oh sorry didn't see the follow up. 

    -   So for the rocm 6.2.4 base image you would need the following in your conda.yml:

        ```
        pip:
            - --extra-index-url https://download.pytorch.org/whl/rocm6.2.4/
            - torch==2.7.1+rocm6.2.4
            - torchaudio==2.7.1+rocm6.2.4
            - torchvision==0.22.1+rocm6.2.4
        ```

    Specific packages I would need to install which i couldn't see on the latest pytorch base-image are xarray, dask, tensorstore, netcdf4, zarr. I would prefer to keep everything under a conda environment as I haven't tried to install those with pip yet but if it works...

    -   I see, so maybe the best option is to enter the shell of an existing image with pytorch, 
        try to install the missing packages with pip and `conda -env export environment.yml`. 
        Then build a container from this conda environment with a base-image?

        I don't think any of those packages require extensions that interact with the GPU directly. 
        Things like netCDF might interact with MPI. That should mean that they are relatively easily 
        installable in a venv and then squashed. That would be the first approach I would try. 
        Check that the netCDF (not the python bindings) inside the container is installed with 
        MPI support if that is indeed applicable. If there isn't a netCDF in the container, you would 
        have to build a container that has it.

    -   Don't use `zarr` with data on a Lustre filesystem though. Zarr is designed to use data on object file
        systems. When putting that data on a Lustre file system, you really kill Lustre. 

        See towards the end of [the section "A comparision between Lustre and LUMI-O" in the course notes of
        the object storage lecture of our more general intro course](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20250602/204-ObjectStorage/#in-short-what-is-lumi-o).

    I forgot to create the venv inside the container (I've copied it from a base-image to my folder) 
    before starting to install libraries with pip on the singularity shell. It successfully installed some. 
    Is there a problem with this? Can I still export the conda environment and build a new container 
    with that file?

    -   If you don't create a virtual environment, and don't point `pip` to where it should install packages,
        it will install them in your home directory, and yes, this is an issue:

        1.  You may run out of space or out of file quota in your home directory

        2.  If you do that from different containers, your Python installation will become a huge 
            mess, as all those things get mixed.

4.  I've got an OOM error while extending the image from the previous question, 
    but I've also got this in the workshop exercise which was solved by setting more memory 
    on the allocation. How do I know how much resources should be allocated to use `cotainr`?

    -   I honestly unfortunately don't have a good answer for this. It depends on the base image a lot. 
        So unfortunately you'll probably have to trial and error.

    -   Sometimes it's best to just take it on the safe side and if you have CPU billing units, 
        just take a whole CPU node. Or like half a GPU node if you have no other choice.

