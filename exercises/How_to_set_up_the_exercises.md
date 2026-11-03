# How to set up the exercises for a LUMI intro training.

## Environment variables needed in both parts

``` bash
training_date='20261109'
training="2day-$training_date"
LUMIstack='25.03'
project='project_465003355'
```

## Work done in the LUST-account with access to `project_462000265`

1.  Log in to LUMI with the regular LUST account and set the umask:

    ``` bash
    umask 002
    ```

    Also set the environment variables from the previous step.

2.  Some set-up in `/appl/local/training` that is not really related to the exercises

    1.  Create a directory where the course recordings and files will find a permanent spot on LUMI:

        ``` bash
        mkdir $training
        ```

    2.  Create a script to fetch the data from LUMI-O:

        ``` bash
        cp rclone-2day-20260422.sh rclone-$training.sh
        ```

        The script needs no further changes, so a symbolic link could actually do.
        It gets the name of the training from the name of the script, so keep the structure
        of the name.

3.  For the next few steps, we need a clone of the training repository on LUMI. Make that in `/tmp`:

    ``` bash
    cd /tmp
    git clone https://github.com/Lumi-supercomputer/LUMI-training-materials.git
    cd LUMI-training-materials
    git checkout $training
    ```

4.  Copy the modules:

    ``` bash
    cd /appl/local/training/modules
    mkdir -p $training
    cd $training
    cp -r /tmp/LUMI-training-materials/modules/$training/exercises .
    ```

5.  Install the EasyBuild module with the `mkfile` tool for the course.

    ``` bash
    module unload LUMI
    export EBU_USER_PREFIX="/appl/local/training/EasyBuild/$training"
    mkdir "$EBU_USER_PREFIX"
    module load LUMI/$LUMIstack partition/common EasyBuild-user
    cd /tmp/LUMI-training-materials/easyconfigs/$training/lumi-training-tools
    eb lumi-training-tools-${training_date}.eb
    cd /appl/local/training/modules/$training
    ln -s ../../EasyBuild/$training/modules/LUMI/$LUMIstack/partition/common/lumi-training-tools
    ```

6.  At this point, we don't need the clone of the training materials repository anymore:

    ``` bash
    /bin/rm -rf /tmp/LUMI-training-materials
    ```


## Work that needs to be done in a user account that is part of the project




## Work that can be done either on LUMI or on a PC with access to LUMI-O




