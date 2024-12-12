# Process and Thread Distribution and Binding

*Presenter: Jorik van Kemenade*

To get good performance on hardware with a strong hierarchy as AMD EPYC processors and
        GPUs, it is important to map processes and threads properly on the hardware. This talk discusses
        the various mechanisms available on LUMI for this.

## Materials

<!--
Materials will be made available during and after the lecture
-->

<video src="https://462000265.lumidata.eu/2day-20241210/recordings/08-Binding.mp4" controls="controls"></video>

-   [Slides](https://462000265.lumidata.eu/2day-20241210/files/LUMI-2day-20241210-08-Binding.pdf)

-   [Course notes](08-Binding.md) (based on an earlier version of the presentation and not thoroughly tested again)

-   [Exercises](E08-Binding.md)

<!--
-    A video recording will follow.
-->


## Q&A

1.  So I should always use these magic numbers from the slides for cpu binding? I there is a way to derive them somehow from the system? 

    -   The easiest way to find these numbers is indeed from the examples in the documentation. You can derive them also from the [diagrams that we use for the LUMI architecture](https://docs.lumi-supercomputer.eu/hardware/lumig/). If you want to get these numbers on the system, it is possible but hard. In that case you can have a look at [notes that were made by Kurt (who gave this presentation before)](08-Binding.md). The "more technical examples" show how to use `lstopo` to understand what SLURM is doing and how it maps the hardware on the nodes.

    -   `lstopo` on an exclusive node in the batch job step will show you the whole structure of the node without interference of Slurm. That is also what I used when writing the `gpu_check` command (based also on some code from ORNL/Frontier)
