# Exercises

The main goal is to try out what you have learned in the course on your own code for the hackathon.

There are also AMD exercises available in the 
[online document "LUMI pre-hackathon training - May 2025"](https://hackmd.io/@sfantao/lumi-prehack-may-2025).

<!--
Alternatively, AMD exercises are available as an [online text](https://hackmd.io/@sfantao/lumi-hackathon-krakow-nov2023)
(or [version saved as Chrome .mht file](https://462000265.lumidata.eu/profiling-20250507/files/03_AMD_Excercise_notes.mht),
may not open directly in your browser, also
`/appl/local/training/profiling-20250507/files/03_AMD_Excercise_notes.mht`)
-->


## Q&A

1.  `srun rocprof --stats nbody-orig 65536`, what is number 65536 in here? 

    -   A command line argument for the `nbody-orig` command: The number of bodies to use in the simulation, 
        so determining the size of the problem. See the "main" function in the code. 
        When not given, the default is 30000.

2. In the "content for rocprof_counters.txt" section of the example - what does the "pmc" mean?

    -   It means that that line in the input file specifies a number of counters that you want to see. If you'd have time to go through the rocprof documentation: There is more that goes into this file, like you can give specific kernels or gpus you want to monitor. It is an abbreviation for Performance Monitoring Counters.

        In the newest version it is actually recommended to use one of the different more powerful input formats (in JSON or YAML, both not really widespread in the HPC community) which offer even more options.

3.  If I want to use rocprofv2 with --plugin perfetto, is there any module I should load? I tried to profile julia code using guide in https://amdgpu.juliagpu.org/stable/profiling/#rocprof. Everything worked, but the results can not be analysed by https://ui.perfetto.dev/

    -   Samuel is busy in one of the rooms. I wonder if it makes sense to try with rocprofv3 from the rocm/6.2.2 module? I'm not sure which versions of rocprof need a special version of Perfetto.

    It works with rocm/6.2.2. I didn't see the results because the example run time is too short. I found it by zoom-in finally. Thanks!
