# Hands-on: Run a simple PyTorch example notebook

*Presenters:* **Marlon Tobaben (CSC)** and Mats Sjöberg (CSC)

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20260611/02_Using_the_LUMI_web_interface).

<!--
[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/02_Using_the_LUMI_web_interface).
-->

<!--
A video recording of the discussion of the solution will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20260611/recordings/E02_Webinterface.mp4" controls="controls"></video>


## Q&A

1.  When cloning the github repo with ssh from the lumi shell with `git@github.com:Lumi-supercomputer/Getting_Started_with_AI_workshop.git`, do i need to set up a ssh key from within lumi?

    -   The follow the course you can clone via [`https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop.git`](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop.git) as you do not want to push but only "download" the repository
    
    Not here or not ever? Or are there situations where I want to use ssh from lumi to github?
    
    -   For work on your own repositories you want to use ssh. And it works no differently from other Linux or macOS systems. So you then need to have a private key for your GitHub account on LUMI in `~/.ssh`. My personal preferred way to work is to do all Git accesses from my local laptop and do most of the development there and only synchronise to LUMI when needed so that I can continue development when LUMI is down or have only one master copy for multiple clusters. Also, GitHub access on LUMI can be slow, partly because of the Lustre filesystem (Git wasn't really designed for performance on parallel filesystems) but we've seen GitHub throttle traffic to LUMI also.
