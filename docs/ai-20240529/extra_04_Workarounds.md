# Understanding GPU activity & checking jobs

*Presenter:* Samuel Añtao (AMD)

<video src="https://462000265.lumidata.eu/ai-20240529/recordings/04_Workarounds.mp4" controls="controls">
</video>


## Extra materials

-   [Presentation slides](https://462000265.lumidata.eu/ai-20240529/files/LUMI-ai-20240529-04-Understanding_GPU_activity.pdf)

-   [Hands-on exercises](E04_Workarounds.md)


## Q&A

1.  Is `nvtop` available on LUM?

    -   Not preinstalled but you can build it yourself using Easybuild, see 
        [nvtop in the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/n/nvtop/). 
        Also check our [docs about how to setup Easybuild](https://docs.lumi-supercomputer.eu/software/installing/easybuild/#preparation-set-the-location-for-your-easybuild-installation)
        or watch the [presentation on LUMI Software Stacks from the recent Amsterdam training](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/extra_05_Software_stacks/) 
        (or [check the notes linked on that page](https://lumi-supercomputer.github.io/LUMI-training-materials/2day-20240502/05_Software_stacks/#easybuild-to-extend-the-lumi-software-stack))

        We restrict software in the central stack to things that are widely used **and** easy to maintain and explain as we need to be able to move fast after a system update and managing a central stack has serial bottlenecks to keep everything organised. The next system update is going to be a huge one and you will see afterwards what we mean as we expect a lot of repairs will be needed to the central stack...

        After all, corrections in a central stack are not easy. You can simply delete a container and start over again as a user. You can delete your user software installation and start over again and it will only hurt your project. But you cannot simply delete stuff in a central stack and start over as users are using that stack at the moment and all those jobs would fail until there is a compatible stack in place... (to use an argument from the [container presentation after this one](extra_05_RunningContainers.md))
