# Coupling machine learning with HPC simulation

*Presenter:* Harvey Richardson(HPE)
<br/>*Co-author:*  Alessandro Rigazzi (HPE)

<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20250527/recordings/11_Coupling.mp4" controls="controls"></video>


## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250527/files/LUMI-ai-20250527-11-Coupling_Simulation_and_AI.pdf)

-   References from the slides:

    -   Language Interoperability
   
        -   [f2py and fmodpy intro](https://www.matecdev.com/posts/fortran-in-python.html)

        -   [forpy](https://github.com/ylikx/forpy)

        -   [pybind11](https://github.com/pybind/pybind11)

        -   Talk: "Reducing the overhead of coupling machine learning models between Python and Fortran"
            [YouTube video](https://www.youtube.com/watch?v=Ei6H_BoQ7g4)
            and [slides](https://jackatkinson.net/slides/)

    -   Interoperability at framework level:

        -   Fortran Keras Bridge, tensorflow but not very active
            on [GitHub](https://github.com/scientific-computing/FKB)
            and [paper on arXiv](https://arxiv.org/abs/2004.10652)

    -   CrayLabs SmartSim:

        -   [CrayLabs SmartSim on GitHub](https://github.com/CrayLabs/SmartSim)

        -   [SmartSim Example Zoo on GitHub](https://github.com/CrayLabs/SmartSim-Zoo)

        -   [Archer2 webinar "Exploring new computations frontiers with SmartSim"](https://www.archer2.ac.uk/training/courses/241024-smartsim-vt/)


## Q&A

1.  Is SmartSim designed for inference only, or it also support end-to-end training, 
    meaning gradient flows backwards from hybrid simulation result to the ML model? 
    Google rewrite the entire global weather model with differentiable framework (neuralGCM) 
    to have end-to-end training, is there other way to do that?

    -   (Harvey) I asked about this.

    -   What Google did was to use JAX to code the entire simulation and since all JAX operations are automatically differentiated, 
        then you can use the gradients to update whatever model you embed into it. That's not a typical SmartSim workflow, 
        as we don't want people to rewrite their code. In SmartSim, training cannot happen in the DB. 
        So you need to set up a training application which gets data from the DB, updates the model, 
        and finally uploads the new model to the DB, where it can be used for inference.

