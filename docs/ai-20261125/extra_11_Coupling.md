# Coupling machine learning with HPC simulation

*Presenter:* Harvey Richardson(HPE)
<br/>*Co-author:*  Alessandro Rigazzi (formerly HPE)

<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20260611/recordings/11_Coupling.mp4" controls="controls"></video>


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20260611/files/LUMI-ai-20260611-11-Coupling_Simulation_and_AI.pdf)

-   [Recent LUMI User Coffee Break seminar on SmartSim](https://lumi-supercomputer.github.io/LUMI-training-materials/User-Coffee-Breaks/20250924-user-coffee-break-SmartSim/)

-   [Recent LUMI SmartSim training](../smartsim-20260331/index.md)


-   References from the slides:

    -   Language Interoperability
   
        -   [f2py and fmodpy intro](https://www.matecdev.com/posts/fortran-in-python.html)

        -   [forpy](https://github.com/ylikx/forpy)

        -   [pybind11](https://github.com/pybind/pybind11)

        -   Talk: "Reducing the overhead of coupling machine learning models between Python and Fortran"
            [YouTube video](https://www.youtube.com/watch?v=Ei6H_BoQ7g4)
            and [slides](https://jackatkinson.net/slides/RSECon23)

    -   Interoperability at framework level:

        -   FTorch: Torch inference library for Fortran on
            [GitHub](https://github.com/Cambridge-ICCS/FTorch)

        -   Fortran Keras Bridge, tensorflow but not very active
            on [GitHub](https://github.com/scientific-computing/FKB)
            and [paper on arXiv](https://arxiv.org/abs/2004.10652)

    -   CrayLabs SmartSim:

        -   [CrayLabs SmartSim on GitHub](https://github.com/CrayLabs/SmartSim)

        -   [SmartSim Example Zoo on GitHub](https://github.com/CrayLabs/SmartSim-Zoo)

        -   [Archer2 webinar "Exploring new computations frontiers with SmartSim"](https://www.archer2.ac.uk/training/courses/241024-smartsim-vt/)

    -   Examples

        -   [AI and Weather Forcasting at ECMWF](https://physicsworld.com/a/european-centre-celebrates-50-years-at-the-forefront-of-weather-forecasting/)

        -   Using SmartSim in MOM6 for turbulence modeling:
            [Partee et al. [2022]: Using Machine Learning at scale in numerical simulations with SmartSim: An application to ocean climate modeling](https://doi.org/10.1016/j.jocs.2022.101707)

        -   [Andrew Mole et al. [2025]: Reinforcement Learning Increases Wind Farm Power Production by Enabling Closed-Loop Collaborative Control](https://arxiv.org/abs/2506.20554)

        -   [Co-development of a SmartSim module for OpenFOAM](https://github.com/OFDataCommittee/openfoam-smartsim)

        -   Examples from Density Functional Theory

            -   [Pure non-local machine-learned density functional theory for electron correlation](https://www.nature.com/articles/s41467-020-20471-y#citeas)

            -   [Large-Scale Materials Modeling at Quantum Accuracy](https://dl.acm.org/doi/10.1145/3581784.3627037)

        -   DeepDriveMD example of selecting "promising" protein folding solutions from an ensemble

            -   Paper [DeepDriveMD: Deep-Learning Driven Adaptive Molecular Simulations for Protein Folding](https://arxiv.org/pdf/1909.07817.pdf)

        -   Nobel Prize in Chemistry 2024 for protein folding using Alphafold and other tools

            -   [Nobel press release](https://www.nobelprize.org/prizes/chemistry/2024/press-release/)
                and [additional technical document 1](https://www.nobelprize.org/uploads/2024/11/popular-chemistryprize2024.pdf) 
                and [additional technical document 2](https://www.nobelprize.org/uploads/2024/10/advanced-chemistryprize2024.pdf)


## Q&A


1.  In the workflow shown in the slides, the simulation sends tensors to SmartRedis, the ML model processes them, and the results are sent back to the simulation.

    If we scale this to many simulation replicas or large tensor data, what usually becomes the main bottleneck: data transfer through SmartRedis, the in-memory database/orchestrator, the ML model execution, or the placement of tasks in Slurm?

    -   There is a bottleneck in two areas, the TCP networking and the fact that the orchestrator can only use one GPU as currently architected. To get around the latter you would have to make the model be a client. These issues are going to be addressed with a new version that is being architected with a collaboration with two US universities and that change is likely to happen in the next couple of months.

    More specifically, how should we profile such a coupled simulation–AI workflow to distinguish between communication overhead, database/orchestrator saturation, and GPU model-inference bottlenecks?

    Are there recommended best practices on LUMI for placing the simulation, SmartSim database, and ML model processes to reduce data-movement overhead? For example, should the database/orchestrator be placed close to the simulation tasks, close to the GPU model workers, or distributed in some way when scaling to many ensemble members?

    -   We organized a SmartSim workshop, with all the slides and lectures being published here: https://lumi-supercomputer.github.io/LUMI-training-materials/smartsim-20260331/

    -   If you have a scenario where something like SmartSim could be appropriate then please get in touch and we can connect you with the developers and I'm sure they would be happy to have a further discussion. This could be done at any time by putting in a LUMI ticket and asking to connect to HPE CoE people.
