# Miscellaneous questions

1.  Do we have to have some Conda Venv in our LUMI profile to be able to execute my python script? Because now, it returns:

    ```
    $ python -V
    -bash: python: command not found
    ```

    ok, it seems to return the standard python, in my LUMI profile:

    ```
    $ python3 -V
    Python 3.6.15
    ```

    -   That is the topic of a different talk. If you are not using any module, 
        then you are working the wrong way as you only get the (old) system Python. 
        On a modern HPC system, if software does not come from a module or a container, you're doing the wrong thing. 
        The system Python is `python3`  by the way. The `cray-python` modules provide newer versions of Python.

        ```
        $ module load cray-python
        $ python -V 
        Python 3.10.10
        ```
   
    In our CSC Puhti HPC, we get Tykki module which is a container to activate all virtual machine pip install capabilities, I thought we had a same setup in LUMI, too!

    -   Again, see [day 2, the software stacks presentation](extra_2_07_LUMI_Software_Stacks.md), for the LUMI equivalent. 
        LUMI is a multinational machine so cannot exactly mirror any national cluster.

2.  Is there currently any deep learning pre-installed modules in LUMI? 
     `$ module avail` does not seem to return any familiar platforms nor libraries!

    -   See [day 2, the software stacks presentation](extra_2_07_LUMI_Software_Stacks.md), for our software policies 
        and how we manage software and how to find out where to find software. 
        AI software will be on the second last slide as it is the culmination of all material 
        in that talk given the complexity of that software.

3.  If you want to have your own virtual environment, for example with anaconda, how do you create this?

    -   See [day 2, the software stacks presentation, also](extra_2_07_LUMI_Software_Stacks.md). 
        Preferably in a container, and we have an equivalent of the Tykky tool on Puhti/Mahti 
        (if you know this as a Finnish user) and `cotainr`, another tool to build containers with a conda installation.

4.  In terms of Moving data to/from LUMI, do we have a capability to connect it to CSC ALLAS for efficient data storage, 
    or should I traditionally use `$ rsync` command to transfer from my local machine to `/scratch/proj_XXXXX` directory?

    -   Yes, but you should check the CSC documentation, not the LUMI documentation. 
        The LUMI User Support Team has no access to Allas and cannot help you with that, CSC set that one up. 
        See [this page](https://docs.csc.fi/data/Allas/allas_lumi/).
