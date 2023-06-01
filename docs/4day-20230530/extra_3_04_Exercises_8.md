# Exercise session 8

-   See `/project/project_465000524/slides/HPE/Exercises.pdf` for the exercises.

-   Files are in 
    `/project/project_465000524/exercises/HPE/day3`


## Q&A

1.  Do I get it right that perftool  can actually point/suggest me the code  which will improve /benefit from GPUs?
     - Not quite. Performance analysis is a pre-requisite for any optimization work. If the code spends a lot of time in MPI or I/O then concentrate on that. If you can identify areas of the code where computation is significant then think about taking those to the GPU.
/thansk, got the discussion/

2.  ```MPIDI_CRAY_init: GPU_SUPPORT_ENABLED is requested, but GTL library is not linked``` while running the python example (perftools-python)
    - Are you compiling without the compiler wrappers, there is an extra library that needs to be linked otherwise.
    - No compilation is involved as I run a Python script. It is odd that there is something "compiler"-related jumps out.
    - Are you using mpi4py from cray-python?
    - ```time srun -n 4 pat_run `which python` heat-p2p.py```, ah, yes, in the imports. ```from mpi4py import MPI```
    - Are you online (remote) or in the room? **online**
    - For GPU applications built without the wrappers you need libraries from here ${PE_MPICH_GTL_DIR_amd_gfx90a} ${PE_MPICH_GTL_LIBS_amd_gfx90a}
    I need to get that gtl library, I need to get Alfio to look. (Alfio is looking but has network issue at the moment)
    - (Alfio) By any chance, do you have the MPICH_GPU_SUPPORT_ENABLED set? **no idea, will check** ... **yes**. Should I unset it? 
        yes, this is for G2G MPI. There is a way to preload the library in python, if needed.  
    - Works, thanks!
    - The issue here is that this envar tells the MPI you want to do GPU to GPU communication avoiding the cpu and to do that it needs this extra library.  As Alfo notes this needs special setup in python to get this library. Glad this fixed it. We will talk a little 
    - more about python in a later session.

    Comment: Hei! I would like to emphasize that Python is a rapidly developing language, which warrants fast version changes. As the language evolves, it introduces new features that users may want to use for their benefit. It also introduces backward incompatibility, as always. I see it as important that users have a choice of versions already as modules (userspace Python is a possibility, but a rather ugly one). The idea applies not only to the training but to LUMI in general.
    
    **Answer to the comment:** As long as Python does not have decent version management and decent package management what you ask is simply impossible. The Python community turned  Python into a complete mess. Breaking compatibility with older code every 18 months is just a crazy idea. It turns Python in an unstable platform. So users using it should be prepared to deal with an unstable platform that cannot be properly supported. Or just look at the **extremely** poor code management in crucial projects such as NumPy. If you're looking for an example for a computer science course about how to make something that is unsupportable, NumPy is your perfect example. You don't realise how much time people who work on software installation tools lose with each version trying to get that package to work properly on new platforms. In that light it is not surprising the the version that HPE Cray can provide to us is a bit behind the leading edge. Maybe the Python community should learn how to manage a project in an enterprise quality way if they want enterprise quality support for their tools.

    By the way, I don't know if we mean the same thing with "user space software installation", but as on an HPC cluster the amount of software that can be installed in the system image is very limited almost all software is installed in "user space", so an application that cannot be properly installed in "user space" is not suited for an HPC cluster. E.g., potential compatibility problems with new system software is not the only reason why we don't keep old versions of the PE on the system.

    Pure Python is also **extremely** inefficient and all efforts to make a proper JIT platform for Python so far have failed. All work only in a few cases. Now that we are in a era where transistors don't become cheaper anymore so it is no longer possible to get more performance in the next machine by using more transistors without raising budgets considerably, it is actually becoming important to look at better languages that can actually run efficiently.

    (Harvey) I think is is more a discussion for the pub

    (Philipp) I agree. I am old enough to witness 2.95 to 3.x transition in GCC, which makes me softer in these matters. Nevertheless, there is no right answer, indeed.
