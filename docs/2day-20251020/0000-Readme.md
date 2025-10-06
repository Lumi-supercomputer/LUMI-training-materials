# Setting up for the training

-   We need a tar file with the exercises and have them installed in the course project

    -   Follow the instructions on 
        [github.com/klust/LUMI-intro-training/tree/main/prepare-LUST](https://github.com/klust/LUMI-intro-training/tree/main/prepare-LUST)
        to prepare the tar file.

        For this training, we ran

        ``` bash
        make_tar 20251020
        ```

        which creates the files `exercises-20251020.tar` and `exercises-20251020.tar.bz2` in the root of
        the repository directory tree.

    -   Upload those file to the course bucket on LUMI-O project 462000265, to the objects
        `files/exercises-20251020.tar` and `files/exercises-20251020.tar.bz2`.

    -   Untar that file in the course project directory `/project/project_465001274`:
  
        ``` bash
        umask 002
        mkdir Exercises && cd Exercises
        wget https://462000265.lumidata.eu/2day-20251020/files/exercises-20251020.tar.bz2
        tar -xf exercises-20251020.tar.bz2
        rm -rf exercises-20251020.tar.bz2
        ```

        This will create the `Exercises` subdirectory in that project.

-   We need to set up some software that can be used to demo Lustre.
    The EasyConfig for this software is in this repository in the `easyconfigs/2day-20251020` subdirectory.

    Steps

    -   Transfer the easyconfig `lumi-training-tools-20251020.eb` and related patch file 
        `mkfile_Makefile_install.patch` to your LUST account on LUMI.

    -   Install with `EasyBuild-user`: In a fresh shell

        ``` bash
        umask 002
        mkdir -p /appl/local/training/EasyBuild/2day-20251020
        export EBU_USER_PREFIX='/appl/local/training/EasyBuild/2day-20251020'
        module load LUMI/24.03 partition/common EasyBuild-user
        eb lumi-training-tools-20251020.eb -r .
        ```

        TODO: The repository with the mkfile version we used has disappeared, need to find another
        version...

    -   Link the module in the proper place:

        ``` bash
        mkdir -p /appl/local/training/modules/2day-20251020
        cd /appl/local/training/modules/2day-20251020
        ln -s ../../EasyBuild/2day-20251020/modules/LUMI/24.03/partition/common/
        ```
    
-   Create modules to set the Slurm parameters for the project and reservation:

    -   Create the directory:

        ``` bash
        mkdir -p /appl/local/training/modules/2day-20251020/exercises
        cd /appl/local/training/modules/2day-20251020/exercises
        ```

    -   Create the file `intro-C.lua` with content:

        ``` lua
        local slurm_partition =   'small'
        local slurm_reservation = 'LUMI_Intro_small'
        local slurm_account =     'project_465002174'

        whatis( 'Description: Sets account, reservation and partition for exercises using the ' .. slurm_partition .. ' partition.' )

        help( [[
        Description
        ===========
        Loading this module sets the project account, reservation and partition for
        the exercises using the ]] .. slurm_partition .. [[ partition by using Slurm environment
        variables.
        ]] )

        setenv( 'SLURM_ACCOUNT',      slurm_account )
        setenv( 'SLURM_PARTITION',    slurm_partition )
        setenv( 'SLURM_RESERVATION',  slurm_reservation )

        setenv( 'SBATCH_ACCOUNT',     slurm_account )
        setenv( 'SBATCH_PARTITION',   slurm_partition )
        setenv( 'SBATCH_RESERVATION', slurm_reservation )

        setenv( 'SALLOC_ACCOUNT',     slurm_account )
        setenv( 'SALLOC_PARTITION',   slurm_partition )
        setenv( 'SALLOC_RESERVATION', slurm_reservation )
        ```

    -   Create the file `intro-G.lua` with content:

        ``` lua
        local slurm_partition =   'standard-g'
        local slurm_reservation = 'LUMI_Intro_standard-g'
        local slurm_account =     'project_46500274'

        whatis( 'Description: Sets account, reservation and partition for exercises using the ' .. slurm_partition .. ' partition.' )

        help( [[
        Description
        ===========
        Loading this module sets the project account, reservation and partition for
        the exercises using the ]] .. slurm_partition .. [[ partition by using Slurm environment
        variables.
        ]] )

        setenv( 'SLURM_ACCOUNT',      slurm_account )
        setenv( 'SLURM_PARTITION',    slurm_partition )
        setenv( 'SLURM_RESERVATION',  slurm_reservation )

        setenv( 'SBATCH_ACCOUNT',     slurm_account )
        setenv( 'SBATCH_PARTITION',   slurm_partition )
        setenv( 'SBATCH_RESERVATION', slurm_reservation )

        setenv( 'SALLOC_ACCOUNT',     slurm_account )
        setenv( 'SALLOC_PARTITION',   slurm_partition )
        setenv( 'SALLOC_RESERVATION', slurm_reservation )
        ```

