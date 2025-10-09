# Hands-on: Advancing your own project and general Q&A

Bring your own AI code, you want to run on LUMI, and spent some time applying what 
you have learned during the workshop - with on-site support from LUST/AMD.

## Closing remarks

<video src="https://462000265.lumidata.eu/ai-20251008/recordings/E12_Conclusions.mp4" controls="controls"></video>


<!--
## Extra materials

-   [LUMI AI guide promoted in the closing words](https://github.com/Lumi-supercomputer/LUMI-AI-Guide)
-->


## General Q&A

1.  This hands-on will only be on-site or there will also be some support for online attendants? I assume sharing our own projects will be more difficult online. 

    -   This is meant to be onsite-only. We cannot give the same experience online, and it would 
        also draw too much resources from the room. We'll only answer questions online if there is time left.

        There is a real advantage to joining our courses onsite, as communication is so much easier 
        than what we can do online with a group, or even with a single person. 

2.  I have a question about the topic explained yesterday, extending containers with virtual environments. 
    Do I understand correctly, that one possible way to extend a container with additional packages is like this: 

    ```
    (allocate resources if running the code and debugging is needed)
    ##### Step 1: Run a container interactively

        module use /appl/local/containers/ai-modules
        module load singularity-AI-bindings
        singularity shell /appl/local/containers/sif-images/lumi-pytorch-rocm-6.2.4-python-3.12-pytorch-v2.7.0.sif
        $WITH_CONDA

    ##### Step 2: Set up an environment, add new packages and save the environment config
        python -m venv myenv --system-site-packages
        source myenv/bin/activate

        # at ths point, we can use "pip install ..."
    -->   # but can we also use "conda install ..." here? -- No, we cannot

        conda -env export my_environment.yml
        

    ##### Step 3: Create a new container using the conda config and cotainr, and delete the environment
        module purge
        module use /appl/local/training/modules/AI-20241126
        module load LUMI/24.03 cotainr 

        cotainr build my_container.sif --base-image=/appl/local/containers/sif-images/lumi-rocm-rocm-6.2.4.sif --conda-env=my_environment.yml
        rm -rf myenv
    ```

    -   You can only install packages with pip inside the virtual environment created with venv. 
        This is not a conda environment but one created with venv which is part of the python standard 
        library and doesn't use any external dependencies like conda. 

        The conda environment is inside the container and read-only.
    
    -   Aside from the the pip install instead of conda install this looks fine. 
        I am not sure about the conda -env export my_environment.yml step. 
        Please check whether the new packages are included in that .yml file. 
        If not, just add them to the .yml file manually.

    -   Another easy way is to simply install our EasyBuild module for your container of choice. 
        All recent ones already have a virtual environment pre-defined and pre-activated. 
        You can install packages in them simply with `pip install` and when you're finished, 
        you pack the virtual environment in a SquashFS file with `make-squasfs`, reload the module 
        and re-enter the container. The packages will now come from the SquashFS file, so the 
        file system issues that were shown in the presentation on getting training data on LUMI, 
        will no longer be present. We didn't benchmark, but there is likely hardly any speed 
        difference between running with everything in one container, or the container + SquashFS f
        ile approach. It is documented on the 
        [PyTorch page in the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/) 
        and specifically in the 
        ["User documentation (singularity container) -> "Extending the containers with virtual environment support" -> "Manual procedure" section](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/#manual-procedure)

        This approach is for the containers that we offer via EasyBuild only though. 
        In the CSC documentation, you'll see that they also offer containers with PyTorch, 
        but they arrange virtual environments in a different way and there is no easy way to pack 
        them in a SquashFS file afterwards.
