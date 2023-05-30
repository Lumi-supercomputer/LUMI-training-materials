# Programming Environment and Modules

-   Slide file in  `/appl/local/training/peap-q-20221123/files/02_PE_and_Modules.pdf`

-   Recording in `/appl/local/training/peap-q-20221123/recordings/02_PE_and_Modules.mp4`


## Q&A

5. At the ExaFoam summer school I was told that HDF5 parallel I/O does not scale to exa scale applications. Ist that correct Instead the exafoam project is working on an ADIOS-2 based system for parallel I/O in OpenFOAM. Feel free to answer this question at the most appropriate time in the course
    - This is the current understanding, so I would say "yes" (even if I'm not a 100% expert).
    - The HDF5 group had a [BOF at SC22 about their future plans]( https://www.hdfgroup.org/2022/10/hdf5-in-the-era-of-exascale-and-cloud-computing/)
    - I would not rule out HDF5 parallel I/O at large scale on LUMI-C for runs of say 500 nodes or similar. The best approach would be to try to benchmark it first for your particular use case.
    - It depends on what you would exactly need to do. If you need to write to file, I am not sure there are real alternatives. ADIOS would be great for in-situ processing.
    - **[Harvey]** I have heard of some good experience about ADIOS-2 but have not tried it yet myself, on my list of things to do.
    - One of the engines that ADIOS-2 can use is HDF5 so it is not necessarily more scalable. Just as for HDF5, it will depend much on how it is used and tuned for the particular simulation.

6. Will there be, for the exercises, shown on-screen (in the zoom session) terminal session which will show how to use all the commands, how to successfully complete the exercises, or will we be void of visual guide and will we only have to rely on the voice of the person presenting the exercises? What I mean - can we please have the presenter show interactively the commands and their usage and output?
    - You can find exercises at `/project/project_465000297/exercises/` with Readme's. You can copy the directory in your area. Just follow them and let us know if you have questions. We will cover it during the next sessions.
    
