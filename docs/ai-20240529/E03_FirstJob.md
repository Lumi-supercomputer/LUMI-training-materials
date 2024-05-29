# Hands-on: Run a simple single-GPU PyTorch AI training job

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/blob/main/03_Your_first_AI_training_job_on_LUMI).


## Q&A

1.  Is it alright/normal to always get the following message/warning in the start of our output file?

    ```
    The following modules were not unloaded:
      (Use "module --force purge" to unload all):

      1) ModuleLabel/label   2) lumi-tools/24.05   3) init-lumi/0.2

    The following sticky modules could not be reloaded:

      1) lumi-tools
    ```

    -   Yes, that is completely normal. If you want to know more about how the module system works, we recommend our regular [introductory courses](http://lumi-supercomputer.github.io/intro-latest). E.g., the [lecture on modules of the recent Amsterdam training, currently our most recent training](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/extra_04_Modules/). It is not possible to compress all relevant material of that course in this 2-day course unfortunately.

        Basically it is the result of some modules on LUMI being sticky, and all this is explained in [this section of the notes of the modules talk of the Amsterdam intro course](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/04_Modules/#sticky-modules-and-the-module-purge-command).


2.  What is the rationele behind asking for 7 CPUs if you do the training on 1 GPU (Maybe it was mentioned during the presentation, but I lost connection at some point)?

    -   The nodes are configured to leave some CPUs free for GPU driver activity leaving 7 per GPU. It is useful to routinely ask for these so that if you are getting all the cpus associated with each GPU.

    Thanks, so in principle you could just ask for just 1 cpu, but it would kind of waste the other 6?

    -   All GPU codes also launch from CPUs and in some cases that CPU part of the code is also multithreaded. Can't speak for your case, but earlier today a user wanted more than 7 cores per GPU... E.g., managing the loading of data is largely done by the CPU.


