# Introduction to Python on Cray EX

*Presenter: Jean Pourroy (HPE)*

<!--
Course materials will be provided during and after the course.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001726/Slides/HPE/11_Python_Frameworks.pdf`
-->

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-502-Introduction_to_Python_on_Cray_EX.pdf`

-   Recording: `/appl/local/training/2p3day-20250303/recordings/502-Introduction_to_Python_on_Cray_EX.mp4`

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  The description of how to install python packages is different from the approche recommended in the docs (https://docs.lumi-supercomputer.eu/software/installing/python/ ) Comments? Should we just use venvs?

    -   *On that page we recommend multiple approaches, depending on the size of your Python installation. You can use a venv, directly on the filesystem, if you just need to add 1 or 2 packages to cray-Python. See also: https://docs.lumi-supercomputer.eu/software/installing/python/#use-the-cray-python-module.*

2.  In the past, I have tried to link python with C libraries built with the system's mpi. I typically have problems because I need to match the mpi used for python and the library. How can I check the mpi version used in the system's cray python?

    -   *It uses the system Python. But if you load the Cray Python module you can check:
        ```
        $ python
        Python 3.11.7 (main, Feb  8 2024, 20:49:32) [GCC 12.3.0] on linux
        Type "help", "copyright", "credits" or "license" for more information.
        >>> import mpi4py
        >>> >>> mpi4py.get_config()
        {'mpicc': '/opt/cray/pe/mpich/default/ofi/GNU/12.3/bin/mpicc', 'mpicxx': '/opt/cray/pe/mpich/default/ofi/GNU/12.3/bin/mpicxx', 'include_dirs': '/opt/cray/pe/mpich/default/ofi/GNU/12.3/include', 'libraries': 'mpich', 'library_dirs': '/opt/cray/pe/mpich/default/ofi/GNU/12.3/lib', 'extra_link_args': '-shared'}
        ```
        (btw, this is mpich 3.4a2)*

    Thanks! I think I see my problem then. I typically load the cray env. In that case, when I (which cc), I get: `/opt/cray/pe/mpich/8.1.29/ofi/crayclang/17.0/bin/mpicc`. Which is why I guess they never match :)
    
    -   *Note that we said on Day 1 (intro part) that to use mpicc correctly on LUMI, you also need to set an environment variable to point it to the right version of the GNU compiler...*

        *And the wrappers (`cc` etc.) should also work. I believe this is how we did GPAW which also links to MPI.*

