# Hands-on: Checking GPU usage interactively using rocm-smi

*Presenters:* Samuel Antão (AMD)

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20261125/04_Understanding_GPU_activity_and_checking_jobs).
-->

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/04_Understanding_GPU_activity_and_checking_jobs).

<!--
A video recording of the discussion of the solution will follow.
-->

<!--
<video src="https://462000265.lumidata.eu/ai-20261125/recordings/LUMI-ai-20261125-E04_CheckingGPU.mp4" controls="controls"></video>
-->


## Q&A

1.  Should the commands in[section 04 of the exercises](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/04_Understanding_GPU_activity_and_checking_jobs) be run in a new web Jupyter session or in the Login node shell (I am using the Lumi web UI). Can they be run in the UIs Visual Studio Code app?

    -   They should be run in the login node shell

    -   VS Code app *might* work, but since that is already running inside a batch job it might cause issues, so login node shell is recommended

2.  Does it matter in what folder i am? Currently in 03? Prob shoul navigate to 04?

    -   Shouldn't matter, but maybe best to change to keep things separated

3.  Why is there `/appl/local/laifs/containers/lumi-multitorch-u24r72f21m50t211-20261028_090706/lumi-multitorch-full-u24r72f21m50t211-20261028_090706.sif` in the first cell in [section 04 of the exercises](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/04_Understanding_GPU_activity_and_checking_jobs)?

    -   A container such as `/appl/local/laifs/containers/lumi-multitorch-u24r72f21m50t211-20261028_090706/lumi-multitorch-full-u24r72f21m50t211-20261028_090706.sif` can work also as an executable. If we execute `/appl/local/laifs/containers/lumi-multitorch-u24r72f21m50t211-20261028_090706/lumi-multitorch-full-u24r72f21m50t211-20261028_090706.sif` it will execute whatever default command the container was setup with. In this case the container doesn't do anything and it was in exercise just as a confiramtion that the container exist in that path.
