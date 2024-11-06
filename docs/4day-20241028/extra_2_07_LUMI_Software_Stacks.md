# LUMI Software Stacks

*Presenter: Kurt Lust (LUST)*

<video src="https://462000265.lumidata.eu/4day-20241028/recordings/2_07_LUMI_Software_Stacks.mp4" controls="controls">
</video>

<!--
Course materials will be provided during the course.
-->

Materials available on the web:

-   [Full notes of the lecture](notes_2_07_LUMI_Software_Stacks.md)

-   [Slides (PDF)](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-2_07_software_stacks.pdf)

Archived materials on LUMI:

-   Slides: `/appl/local/training/4day-20241028/files/LUMI-4day-20241028-2_07_software_stacks.pdf`

-   Recording: `/appl/local/training/4day-20241028/recordings/2_07_LUMI_Software_Stacks.mp4`


## Additional materials

-   The information in this talk is also partly covered by the following talks from the introductory courses:

     -   [Modules on LUMI](../2day-20240502/extra_04_Modules/.md)

     -   [LUMI Software Stacks](../2day-20240502/extra_05_Software_stacks.md)

-   The `cotainr` package was presented during the
    [September 27, 2023 user coffee break](https://lumi-supercomputer.github.io/LUMI-training-materials/User-Coffee-Breaks/20230927-user-coffee-break-cotainr/)


## Q&A

1.  The storage space in the home directory is quite limited, and there are relatively 
    few files. When I install custom software or use EasyBuild to install a few packages, 
    I quickly run out of space. How can I manage this situation? and manage the 
    number of files is relatively small....

    -   In our documentation we discuss several options: 
        https://docs.lumi-supercomputer.eu/storage/#about-the-number-of-files-quota. 
        It depends a little bit on why you run into the quota. If you have to many files 
        because of a Python installation you can consider using containers. 
        If it is during compilation you may consider using the scratch space. 
        If the not the number of files, but the size is the problem you can look at using 
        your project storage. 
        In any case, it may be a good idea to install your Easybuild recipes in the project, 
        for all members, instead of in your home folder. 
        See also: https://docs.lumi-supercomputer.eu/software/installing/easybuild/#preparation-set-the-location-for-your-easybuild-installation. 

    -   The home directory should only be used for the things that really belong in a home
        directory as Linux puts them there (like caches). It should not be used to store 
        data from your project or to install software.

2.  So you said that conda cannot be used, but it also says in the file that Conda can be used if it comes in containers? Does that mean that we can use `mamba (miniconda)` in the containers, or can we also use `conda` there?

    -   The problem is when using Anaconda. Conda is not a problem, as long as you use the best practices. See also the LUMI documentation: https://docs.lumi-supercomputer.eu/software/installing/python/. 

    -   (Kurt) There are two separate and independent issues. Firstly,  any installation with lots of small files should be containerised, and most Python or conda installations are like that. Secondly, there is also a licensing issue specifically with Anaconda. I encourage you to have a look at the license, and [there is a link in the notes](notes_2_07_LUMI_Software_Stacks.md#software-policies). Anaconda cannot be legally used on LUMI (or your university cluster or workstation for the same reason). The miniconda program can be used, but not to install from the main Anaconda channel, only from conda-forge and external channels. Other public domain implementations come with their own license and may nor may not be used.

3.  Since the list of available modules gets so big and the old ones are shown first, what are the policies of keeping support for outdated software?

    -   We remove whole SW stacks from time to time after major system upgrades, after showing lmod deprecation warnings and then hiding it. 
  
        Note that the old version issue only exists in the output of `module spider`. With `module avail` you will
        only see the versions that are relevant for the version of the LUMI stack that you have selected.
    
4.  To install VASP + VTST + 'VASPSOL++' + CPVASP (VASP plugins) @Lumi, how should I proceed with the installation, and which installation methods should I choose? If using EasyBuild (EB), how should I configure the installation files?
(When I search using eb -S VASP, I cannot find any preconfigured EasyBuild easyconfigs files that include VTST, VASPsol++, or other plugins(CP-VASP). Would it be possible for you to provide such EasyConfigs or help to find them? )

    -   We cannot fully support VASP and even if there were no licensing issues, as we cannot do all installations for everybody with all plugins etc that a single user may require and have to focus on those combinations for which we expect more demand. You will very likely have to do a manual installation following the VASP installation instructions and knowing how to use the Cray PE compilers. I know someone in the Flemish local support team is looking into such an EasyConfig which may or may not adaptable to Linux. But software with such restrictive licenses as VASP are nearly impossible to support. As we don't have access to the VASP sources due to its license, we cannot do anything and have to rely on external parties with access.
