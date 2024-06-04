# LUMI Software Stacks

*Presenter: Kurt Lust (LUST)*

<video src="https://462000265.lumidata.eu/4day-20240423/recordings/2_07_LUMI_Software_Stacks.mp4" controls="controls">
</video>

<!--
Course materials will be provided during the course.
-->

Materials available on the web:

-   [Full notes of the lecture](notes_2_07_LUMI_Software_Stacks.md)

-   [Slides (PDF)](https://462000265.lumidata.eu/4day-20240423/files/LUMI-4day-20240423-2_07_software_stacks.pdf)

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20240423/files/LUMI-4day-20240423-2_07_software_stacks.pdf`

-   Recording: `/appl/local/training/4day-20240423/recordings/2_07_LUMI_Software_Stacks.mp4`


## Additional materials

-   The information in this talk is also partly covered by the following talks from the 1-day courses:

     -   [Modules on LUMI](../1day-20240208/video_03_Modules_on_LUMI.md)

     -   [LUMI Software Stacks](../1day-20240208/video_04_LUMI_Software_Stacks.md)

-   The `cotainr` package was presented during the
    [September 27, 2023 user coffee break](https://lumi-supercomputer.github.io/LUMI-training-materials/User-Coffee-Breaks/20230927-user-coffee-break-cotainr/)


## Q&A

1.  If you have a licensed software, such as VASP, how do I use that licensed software in lumi?

    -   LUMI uses a bring your own license model. It differs per software package how this would work. 
        For VASP we have documented the installation procedure in the 
        [LUMI Software Library VASP page](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/v/VASP/). 

2.  Question on EasyBuilder. Any reason to support Ansible (better logging, yaml support, etc..)
    Seems there is an Ansible module for EasyBuilder:
    [GitHub link](https://github.com/oliviermattelaer/EBAnsible) and
    [YouTube presentation Ansible with EasyBuild](https://www.youtube.com/watch?v=Qr2udsAjkG0)
    from an EasyBuild user meeting.

    -   The repo you point to is the work of one of my colleague and is not meant to be used by users, 
        only by system administrators. The goal was basically to have a way to (re)-deploy an EasyBuild managed 
        software stack on multiple architectures. This project is unmaintained.

3.  Why EasyBuild and not spack as a package manager? I mean what is it better between them? 

    -   EuroHPC politics was a consideration as other sites in Europe were already using EasyBuild. 
        There was a lot of experience in Switzerland. 

    -   EasyBuild is rigid and can be well tested. Spack is more versatile and now quite powerful 
        if you want to create environments for multiple packages. Although Spack is very attractive, 
        there is some concern on what is going to fund future developments.

4.  I am trying to create a conda environment in a container, however t seems that it keeps 
    disconnecting my interaction VS code and login shell. Are containers only limited to a few python packages?

    -   LUMI supports specific tools to build containers for conda environments so I expect this will 
        be covered later in this talk. I am not aware of any limits.

    -   It sounds like you have connection problems, or maybe have a configuration issue in your interactive session. 
        If you are disconnected this is not caused by the process of extending/building containers.

5.  Can you take existing containers (Pytorch container for example) and install additional python packages on that container?

    -   I'm told by Alfio that the `proot` functionality gives you a nice way to do this.

    -   And for the containers that we provide, it can also be done in a virtual environment. 
        For one of the containers we already have an automated way to make it more file system friendly, 
        but see the documentation of Pytorch in the LUMI Software Library where this question is answered, 
        or after next week, check the [materials of the Amsterdam course (day 2 afternoon)](../2day-20240502/index.md#course-materials).

    - Basically, you can do the following:

        ```
        # Start a shell in your singularity container
        singularity exec -B ./workdir /path-to-singularity-image/myimage.sif bash

        #
        # Now we are running inside the container
        #

        # activate container conda
        $WITH_CONDA

        # create virtual environment to extent conda (read-only one)
        python -m venv --system-site-packages /workdir/venvsource 
        /workdir/venv/bin/activate
        python -m pip install my-extra-package
        exit
        
        # Now we are running outside the container
        # We can now invoke singularity as this to leverage the combination of conda and virtual env.
        singularity exec -B ./workdir /path-to-singularity-image/myimage.sif \
            bash -c '$WITH_CONDA ; PYTHONPATH=/workdir/vnv/lib/pythonx.y/site-packages python3 ./myapp'
        ```

6.  Will does PyTorch examples he just mentioned be available here? In this workshop?

    -   They are available on LUMI, I'm not sure if using hem is going to be covered here,
        but the [AMD talk on the last day](extra_4_11_Best_Practices_GPU_Optimization.md) may show examples of running these.

    -   Check at https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/ 
       (which links to the path at `/appl/local/containers`)

    - There will be some [examples on building pytorch and using it on Friday](extra_4_11_Best_Practices_GPU_Optimization.md).
