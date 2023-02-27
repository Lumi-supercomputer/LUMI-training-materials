# Exercises 1: Modules, the HPE Cray PE and EasyBuild



## Exercises on compiling software by hand

*These exercises are optional during the session, but useful if you expect 
to be compiling software yourself.*

### Compilation of a program 1: A simple "Hello, world" program

Four different implementations of a simple "Hello, World!" program are provided:

-   `hello_world.c` is an implementation in C,
-   `hello_world.cc` is an implemenatation in C++,
-   `hello_world.f` is an implementation in Fortran using the fixed format source form,
-   `hello_world.f90` is an implementation in Fortran using the more modern free format source form.

Try to compile these programs using the programming environment of your choice.

??? Solution "Click to see the solution."
    We'll use the default version of the programming environment, but in case you want to use
    a particular version, e.g., the 22.08 version, and want to be very sure that all modules are
    loaded correctly from the start you could consider using

    ```
    module load cpe/22.08
    module load cpe/22.08
    ```

    So note that we do twice the same command as the first iteration does not always succeed to reload
    all modules in the correct version. Do not combine both lines into a single `module load` statement
    as that would again trigger the bug that prevents all modules to be reloaded in the first iteration.

    The sample programs that we asked you to compile do not use the GPU. So there are three programming
    environments that we can use: `PrgEnv-gnu`, `PrgEnv-cray` and `PrgEnv-aocc`. All three will work,
    and they work almost the same.

    Let's start with an easy case, compiling the C version of the program with the GNU C compiler.
    For this all we need to do is

    ```
    module load PrgEnv-gnu
    cc hello_world.c
    ```

    which will generate an executable named `a.out`. Of course it is better to give the executable a proper
    name which can be done with the `-o` compiler option:

    ```
    module load PrgEnv-gnu
    cc hello_world.c -o hello_world.x
    ```

    Try running this program:

    ```
    ./hello_world.x
    ```

    to see that it indeed works. We did forget another important compiler option, but we'll discover
    that in the next exercise.

    The other programs are equally easy to compile using the compiler wrappers:

    ```
    CC hello_world.cc -o hello_world.x
    ftn hello_world.f -o hello_world.x
    ftn hello_world.f90 -o hello_world.x
    ```


### Compilation of a program 2: A program with BLAS

In the `CPE_and_modules` subdirectory you'll find the C program `matrix_mult_C.c`
and the Fortran program `matrix_mult_F.f90`. Both do the same thing: a matrix-matrix
multiplication using the 6 different orders of the three nested loops involved in
doing a matrix-matrix multiplication, and a call to the BLAS routine DGEMM that does the same
for comparison.

Compile either of these programs using the Cray LibSci library for the BLAS routine.
Do not use OpenMP shared memory parallelisation. The code does not use MPI.

The resulting executable takes one command line argument, the size of the square matrix.
Run the script using `1000` for the matrix size and see what happens.

Note that the time results may be very unreliable as we are currently doing this on the login
nodes. In the session of Slurm you'll learn how to request compute nodes and it might be
interesting to redo this on a compute node with a larger matrix size as the with a matrix size
of 1000 all data may stay in the third level cache and you will not notice the differences that
you should note. Also, because these nodes are shared with a lot of people any benchmarking
is completely unreliable.

If this program takes more than half a minute or so before the first result line in the table,
starting with `ijk-variant`, is printed, you've done something wrong.

??? Solution "Click to see the solution."
    Just as in the previous exercise, this is a pure CPU program so we can chose between the
    same three programming environments.

    The one additional "difficulty" is that we need to link with the BLAS library. This is very easy however in 
    the HPE Cray PE if you use the compiler wrappers rather than calling the compilers yourself:
    you only need to make sure that the `cray-libsci` module is loaded and the wrappers will take
    care of the rest. And on most systems (including LUMI) this module will be loaded automatically
    when you load the `PrgEnv-*` module.

    To compile with the GNU C compiler, all you need to do is

    ```
    module load PrgEnv-gnu
    cc -O3 matrix_mult_C.c -o matrix_mult_C_gnu.x
    ```

    will generate the executable `matrix_mult_C_gnu.x`.

    Note that we add the `-O3` option and it is very important to add either `-O2` or `-O3` as by default
    the GNU compiler will generate code without any optimization for debugging purposes, and that code is
    in this case easily five times or more slower. So if you got much longer run times than indicated this
    is likely the mistake that you made.

    To use the Cray C compiler instead only one small change is needed: Loading a different programming 
    environment module:

    ```
    module load PrgEnv-cray
    cc -O3 matrix_mult_C.c -o matrix_mult_C_cray.x
    ```
 
    will generate the executable `matrix_mult_C_cray.x`.

    Likewise for the AMD AOCC compiler we can try with loading yet another `PrgEnv-*` module:

    ```
    module load PrgEnv-aocc
    cc -O3 matrix_mult_C.c -o matrix_mult_C_aocc.x
    ```

    but it turns out that this fails with linker error messages about not being able to find the
    `sin` and `cos` functions. When using the AOCC compiler the `libm` library with basic math functions is
    not linked automatically, but this is easily done by adding the `-lm` flag:

    ```
    module load PrgEnv-aocc
    cc -O3 matrix_mult_C.c -lm -o matrix_mult_C_aocc.x
    ```

    For the Fortran version of the program we have to use the `ftn` compiler wrapper instead, and the issue
    with the math libraries in the AOCC compiler does not occur. So we get

    ```
    module load PrgEnv-gnu
    ftn -O3 matrix_mult_F.f90 -o matrix_mult_F_gnu.x
    ```

    for the GNU Fortran compiler,

    ```
    module load PrgEnv-cray
    ftn -O3 matrix_mult_F.f90 -o matrix_mult_F_cray.x
    ```

    for the Cray Fortran compiler and

    ```
    module load PrgEnv-aocc
    ftn -O3 matrix_mult_F.f90 -o matrix_mult_F_aocc.x
    ```

    for the AMD Fortran compiler.

    When running the program you will see that even though the 6 different loop orderings 
    produce the same result, the time needed to compile the matrix-matrix product is very
    different and those differences would be even more pronounced with bigger matrices
    (which you can do after the session on using Slurm).

    The results with the Cray Fortran compiler are particularly interesting. The result for
    the BLAS library is slower which we do not yet understand, but it also turns out that 
    for four of the six loop orderings we get the same result as with the BLAS library DGEMM
    routine. It looks like the compiler simply recongnized that this was code for a matrix-matrix
    multiplication and replaced it with a call to the BLAS library. The Fortran 90 matrix
    multiplication is also replaced by a call of the DGEMM routine. To confirm all this,
    unload the `cray-libsci` module and try to compile again and you will see five error
    messages about not being able to find DGEMM.


### Compilation of a program 3: A hybrid MPI/OpenMP program

The file `mpi_omp_hello.c` is a hybrid MPI and OpenMP C program that sends a message
from each thread in each MPI rank. It is basically a simplified version of the
programs found in the `lumi-CPEtools` modules that can be used to quickly check 
the core assignement in a hybrid MPI and OpenMP job (see later in this tutorial).
It is again just a CPU-based program.

Compile the program with your favourite C compiler on LUMI.

We have not yet seen how to start an MPI program. However, you can run the executable
on the login nodes and it will then contain just a single MPI rank. 

??? Solution "Click to see the solution."
    In the HPE Cray PE environment, you don't use `mpicc` to compile a C MPI program,
    but you just use the `cc` wrapper as for any other C program. To enable MPI you 
    have to make sure that the `cray-mpich` module is loaded. This module will usually
    be loaded by loading one of the `PrgEnv-*` modules, but only if the right network
    target module, which is `craype-network-ofi`, is also already loaded. 

    Compiling the program is very simple:

    ```
    module load PrgEnv-gnu
    cc -O3 -fopenmp mpi_omp_hello.c -o mpi_omp_hello_gnu.x
    ```

    to compile with the GNU C compiler, 

    ```
    module load PrgEnv-cray
    cc -O3 -fopenmp mpi_omp_hello.c -o mpi_omp_hello_cray.x
    ```

    to compile with the Cray C compiler, and

    ```
    module load PrgEnv-aocc
    cc -O3 -fopenmp mpi_omp_hello.c -o mpi_omp_hello_aocc.x
    ```

    to compile with the AMD AOCC compiler.

    To run the executables generated with the GNU or Cray compiler it is not
    even needed to have the respective `PrgEnv-*` module loaded since the binaries
    will use a copy of the libraries stored in a default directory, but to run the 
    executable build with the AOCC compiler it is necessary to load the `PrgEnv-aocc` 
    module or you will get an error message about a certain library not being found.

## Information in the LUMI Software Library  

Explore the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/).

-   Search for information for the package ParaView and quickly read through the page

??? Solution "Click to see the solution."
    [Link to the Paraview documentation](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/ParaView/)

    It is an example of a package for which we have both user-level and some technical information. The page
    will first show some license information, then the actual user information which in case of this package
    is very detailed and long. But it is also a somewhat complicated package to use. It will become easier
    when LUMI evolves a bit further, but there will always be some pain. Next comes the more technical
    part: Links to the EasyBuild recipe and some information about how we build the package.

    We currently only provide ParaView in the cpeGNU toolchain. This is because it has a lot of dependencies
    that are not trivial to compile and to port to the other compilers on the system, and EasyBuild is 
    strict about mixing compilers basically because it can cause a lot of problems, e.g., due to conflicts
    between OpenMP runtimes.


## Installing software with EasyBuild

*These exercises are based on material from the [EasyBuild tutorials](http://tutorial.easybuild.io/).*

*Note*: If you want to be able to uninstall all software installed through the exercises
easily, we suggest you make a separate EasyBuild installation for the course, e.g.,
in `/scratch/project_465000XXX/$USER/eb-course`:

-   Start from a clean login shell with only the standard modules loaded.
-   Set `EBU_USER_PREFIX`: 
     
    ```
    export EBU_USER_PREFIX=/scratch/project_465000XXX/$USER/eb-course
    ```

    You'll need to do that in every shell session where you want to install or use that software.

-   From now on you can again safely load the necessary `LUMI` and `partition` modules for the exercise.
  
-   At the end, when you don't need the software installation anymore, you can simply remove the directory
    that you just created.

    ```
    rm -rf /scratch/project_465000XXX/$USER/eb-course
    ```


### Installing a simple program without dependencies with EasyBuild

The LUMI Software Library contains the package `eb-tutorial`. Install the version of
the package for the `cpeCray` toolchain in the 22.08 version of the software stack.

??? Solution "Click to see the solution."
    -   We can check the 
        [eb-tutorial page](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/e/eb-tutorial)
        in the 
        [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs)
        if we want to see more information about the package.
    
        You'll notice that there are versions of the EasyConfigs for `cpeGNU` and `cpeCray`.
        As we want to install software with the `cpeCray` toolchain for `LUMI/22.08`, we'll
        need the `cpeCray-22.08` version which is the EasyConfig
        `eb-tutorial-1.0.1-cpeCray-22.08.eb`.

    -   Obviously we need to load the `LUMI/22.08` module. If we would like to install software
        for the CPU compute nodes, you need to also load `partition/C`.
        To be able to use EasyBuild, we also need the `EasyBuild-user` module.

        ```
        module load LUMI/22.08 partition/C
        module load EasyBuild-user
        ```

    -   Now all we need to do is run the `eb` command from EasyBuild to install the software.

        Let's however take the slow approach and first check if what dependencies the package needs:

        ```
        eb eb-tutorial-1.0.1-cpeCray-22.08.eb -D
        ```

        We can do this from any directory as the EasyConfig file is already in the LUMI Software Library
        and will be located automatically by EasyBuild. You'll see that all dependencies are already on 
        the system so we can proceed with the installation:

        ```
        eb eb-tutorial-1.0.1-cpeCray-22.08.eb 
        ```

    -   After this you should have a module `eb-tutorial/1.0.1-cpeCray-22.08` but it may not show up 
        yet due to the caching of Lmod. Try

        ```
        module av eb-tutorial/1.0.1-cpeCray-22.08
        ```

        If this produces an error message complaining that the module cannot be found, it is time to clear
        the Lmod cache:

        ```
        rm -rf $HOME/.lmod.d/.cache
        ```

### Installing an EasyConfig given to you by LUMI User Support

Sometimes we have no solution ready in the LUMI Software Library, but we prepare one or more
custom EasyBuild recipes for you. Let's mimic this case. In practice we would likely send 
those as attachments to a mail from the ticketing system and you would be asked to put
them in a separate directory (basically since putting them at the top of your home
directory would in some cases let EasyBuild search your whole home directory for dependencies
which would be a very slow process).

You've been given two EasyConfig files to install a tool called `py-eb-tutorial` which is in fact
a Python package that uses the `eb-tutorial` package installed in the previous exercise. These
EasyConfig files are in the `EasyBuild` subdirectory of the exercises for this course.
In the first exercise you are asked to install the version of `py-eb-tutorial` for the
`cpeCray/22.08` toolchain.

??? Solution "Click to see the solution."
    -   Go to the `EasyBuild` subdirectory of the exercises and check that it indeed contains the
        `py-eb-tutorial-1.0.0-cpeCray-22.08-cray-python-3.9.12.1.eb` and
        `py-eb-tutorial-1.0.0-cpeGNU-22.08-cray-python-3.9.12.1.eb` files.
        It is the first one that we need for this exercise.

        You can see that we have used a very long name as we are also using a version suffix to
        make clear which version of Python we'll be using.

    -   Let's first check for the dependencies (out of curiosity):

        ```
        eb py-eb-tutorial-1.0.0-cpeCray-22.08-cray-python-3.9.12.1.eb -D
        ```

        and you'll see that all dependencies are found (at least if you made the previous exercise 
        successfully). You may find it strange that it shows no Python module but that is because
        we are using the `cray-python` module which is not installed through EasyBuild and only
        known to EasyBuild as an external module.

    -   And now we can install the package:

        ```
        eb py-eb-tutorial-1.0.0-cpeCray-22.08-cray-python-3.9.12.1.eb
        ```

    -   To use the package all we need to do is to load the module and to run the command that it
        defines:

        ```
        module load py-eb-tutorial/1.0.0-cpeCray-22.08-cray-python-3.9.12.1
        py-eb-tutorial
        ```

        with the same remark as in the previous exercise if Lmod fails to find the module.

        You may want to do this step in a separate terminal session set up the same way, or you
        will get an error message in the next exercise with EasyBuild complaining that there are
        some modules loaded that should not be loaded.


### Installing software with uninstalled dependencies

Now you're asked to also install the version of `py-eb-tutorial` for the `cpeGNU` toolchain in `LUMI/22.08`
(and the solution given below assumes you haven'ty accidentally installed the wrong EasyBuild recipe in one
of the previous two exercises).

??? Solution "Click to see the solution."
    -   We again work in the same environment as in the previous two exercises. Nothing has changed here.
        Hence if not done yet we need

        ```
        module load LUMI/22.08 partition/C
        module load EasyBuild-user
        ```

    -   Now go to the `EasyBuild` subdirectory of the exercises (if not there yet from the previous
        exercise) and check what the `py-eb-tutorial-1.0.0-cpeGNU-22.08-cray-python-3.9.12.1.eb` needs:

        ```
        eb py-eb-tutorial-1.0.0-cpeGNU-22.08-cray-python-3.9.12.1.eb -D
        ```

        We'll now see that there are two missing modules. Not only is the 
        `py-eb-tutorial/1.0.0-cpeGNU-22.08-cray-python-3.9.12.1` that we try to install missing, but also the
        `eb-tutorial/1.0.1-cpeGNU-22.08`. EasyBuild does however manage to find a recipe from which this module
        can be built in the pre-installed build recipes.

    -   We can install both packages separately, but it is perfectly possible to install both packages in a single
        `eb` command by using the `-r` option to tell EasyBuild to also install all dependencies.

        ```
        eb py-eb-tutorial-1.0.0-cpeGNU-22.08-cray-python-3.9.12.1.eb -r
        ```

    -   At the end you'll now notice (with `module avail`) that both the module 
        `eb-tutorial/1.0.1-cpeGNU-22.08` and `py-eb-tutorial/1.0.0-cpeGNU-22.08-cray-python-3.9.12.1`
        are now present.

        To run you can use

        ```
        module load py-eb-tutorial/1.0.0-cpeGNU-22.08-cray-python-3.9.12.1
        py-eb-tutorial
        ```

