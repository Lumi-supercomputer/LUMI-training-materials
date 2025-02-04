# Hands-on: Run a simple PyTorch example notebook

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20250204/02_Using_the_LUMI_web_interface).
-->
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/02_Using_the_LUMI_web_interface).

A video recording of the discussion of the solution will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250204/recordings/E02_Webinterface.mp4" controls="controls"></video>
-->


## Q&A

1.  How to use git lfs?

    -   The lfs module for git is not on LUMI by default and currently not also available as a pre-installed module 
        (due to issues in the past). We do offer ways to install it yourself via EasyBuild recipes 
        (see [the git-lfs page in the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/g/git-lfs/))
        but that is not covered in this course but in our regular intro course. 
        Since we don't use git lfs ourselves in our work, this particular recipe is also not well tested.

        The system image on LUMI is deliberately kept small as it eats from the RAM on the compute nodes 
        and as a too large image also slows down (re)booting too much. The central software stack also 
        has its management issues due to the way it is organised, so we don't put things in there 
        unless they are of broad use and we are also sure that the build is OK. Changing something in 
        the central stack why assuring that no running jobs break, is hard and a slow process so we 
        have chosen for a more flexible approach.
