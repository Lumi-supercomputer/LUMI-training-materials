# How to set up the exercises for a LUMI intro training.

## Environment variables needed

``` bash
training_date='20261109'
training="2day-$training_date"
LUMIstack='25.03'
project='project_465003355'
```

## Preparatory work

1.  In the `LUMI-training-materials` repo, subdirectory `easyconfigs`:

    1.  Create a subdirectory for the training
        and copy the `lumi-training-tools` subdirectory from the template into it:

        ``` bash
        cp -r 2day-template $training
        ```

    2.  Now adapt the template:

        ``` bash
        cd $training/lumi-training-tools
        sed -e "s/template/$training_date/" -i "" lumi-training-tools-template.eb 
        mv lumi-training-tools-template.eb lumi-training-tools-$training_date.eb
        ```
        
2.  In the `LUMI-training-materials` repo, subdirectory `modules`:

    1.  Copy the template file:

        ``` bash
        cp -r 2day-template $training
        ```

    2.  Edit the modulefiles:

        ``` bash
        cd $training/exercises
        sed -e "s/project_46YXXXXXX/$project/" -i "" small.lua
        sed -e "s/project_46YXXXXXX/$project/" -i "" standard-g.lua
        ```

        and also check the name of the reservations in both LUA scripts.

3.  In the `LUMI-intro-training` repository, in the `EasyBuild` subdirectory:

    1.  Check if the EasyConfigs need to be upgraded to a new toolchain version.

4.  In the `LUMI-intro-training` repository, in `prepare-LUST/05_SoftwareStacks/EasyBuild-contrib`:

    1.  Check if the EasyConfigs need to be updated to a new toolchain version.

    2.  If so, ensure that the updated EasyConfigs land in the `LUMI-EasyBuild-contrib`
        repository and on LUMI before the training.

5.  In the `LUMI-intro-training` repository, in `prepare-LUST/10_ObjectStorage`:

    1.  The scripts usually need no changes.
   
    2.  We do need a key for the LUMI-O course project though and an `rclone` and `s3cmd` configuration
        file for that project and for `project_462000265`, which we will do in a later step.

6.  In the `LUMI-intro-training` repository, in `prepare-LUST`: 

    1.  Create the tar file with the exercises:

        ``` bash
        ./make_tar.sh $training_date
        ```

    2.  Transfer the new `.tar` and `.tar.bz2` file to the appropriate location on LUMI-O.

        On the Mac of Kurt, this is easily accomplished:

        ``` bash
        cd ..
        mkdir -p /Users/klust/Projects/LUMI-WS/SubWS-LUMI-Training/LUMI-training-lumio/public/$training/files
        cp exercises-$training_date.tar exercises-$training_date.tar.bz2 /Users/klust/Projects/LUMI-WS/SubWS-LUMI-Training/LUMI-training-lumio/public/$training/files
        ``` 

        and run the script to update LUMI-O.



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

1.  Set a copy of the tar file with exercises in the scratch directory.

    ``` bash
    umask 002
    cd /scratch/$project
    wget https://462000265.lumidata.eu/$training/files/exercises-$training_date.tar.bz2
    ```


## Work that can be done either on LUMI or on a PC with access to LUMI-O

1.  Create an access key for `project_465000265` and an s3cmd configuration file `~/.s3cfg-lumi-462000265`.

    On LUMI, you could use `lumio-conf` for the last task.

2.  Create an access key for the course training project and s3cmd configuration files
    `~/.s3cfg-lumi-${project/project_/}` and `~/.s3cfg`.

    ``` bash
    cp ~/.s3cfg-lumi-${project/project_/} ~/.s3cfg
    ```

    On LUMI, you could use `lumio-conf` to create both files.

3.  Now we need to install the necessary files for the exercises on object storage:
    From the `LUMI-intro-training` repository, subdirectory `prepare-LUST/10_ObjectStorage/`:

    1.  Make sure that buckets from a previous course in `project_462000265` are removed:

        ```
        ./delete_buckets_462000265.sh
        ```

    2.  Next create the new buckets. This is done in two steps:

        -   Buckets in the actual training project:

            ```
            ./create_buckets.sh
            ```

            This uses `~/.s3cfg`, so that file should be for the training project!

        -   Some buckets in the LUST training project to demonstrate access from another project:

            ```
            ./create_buckets_462000265.sh ${project/project_/}
            ```
