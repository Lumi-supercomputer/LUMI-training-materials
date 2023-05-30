# HPE Cray EX Architecture

-   Slide file in  `/appl/local/training/peap-q-20221123/files/01_EX_Architecture.pdf`

-   Recording in `/appl/local/training/peap-q-20221123/recordings/01_EX_Architecture.mp4`


## Q&A

3. What's the expected CPU clock for a heavy all-core job?
    - 2.45 GHz base clock rate (https://www.amd.com/en/product/10906)
    - Don't expect any boost for a really heavy load. The effective clock is determined dynamically by the system depending on the heating/cooling situation. It can be complex, because heavy network/MPI traffic will also affect this, and the node tries to distribute power between the CPU cores, the IO die on the CPU, (the GPUs for LUMI-G), and the network cards on-the-fly to optimize for the best performance.

4. Regarding the CPU cores and threads : you said that the threads are hardware : should we run large runs on the number of threads, rather than the number of nodes ?
    - Could you elaborate a bit more? 
    - My understanding is : a cpu that has 64 cores, shows 128 threads by multithreading, therefore cases that use the cpu 100% load during 100% of the time will be better tu run on 64 core, rather than the 128 threads to eliminate the overhead of the operating system due to scheduling the software threads to the hardware core.
    - There are two sessions about SLURM in the course where it will be explained how to use hyperthreading etc. 
    - In general, hyperthreading doesn't offer much benefits on a good code, rather the contrary. It's really more lack of cache and memory bandwidth stat stops you from using hyperthreading. Hyperthreading is basically a way to hide latency in very branchy code such as databases. In fact there are codes that run faster using a given number of nodes and 75% of the cores than the same number of nodes and all cores per socket, without hyperthreading.
    - OK I will wait for the next parts of the course. Thank you

