# Exercises: HPE Cray Programming Environment

See [the instructions](index.md#setting-up-for-the-exercises)
to set up for the exercises. For these exercises, you'll need the files in
the `CPE` subdirectory.

*These exercises are optional during the session, but useful if you expect 
to be compiling software yourself. The source files mentioned can be found in
the subdirectory CPE of the download.*


## Compilation of a program 1: A simple "Hello, world" program

Four different implementations of a simple "Hello, World!" program are provided in the `CPE` subdirectory:

-   `hello_world.c` is an implementation in C,
-   `hello_world.cc` is an implementation in C++,
-   `hello_world.f` is an implementation in Fortran using the fixed format source form,
-   `hello_world.f90` is an implementation in Fortran using the more modern free format source form.

Try to compile these programs using the programming environment of your choice.

??? Solution "Click to see the solution."
    We'll use the default version of the programming environment (24.03 at the moment of the
    course in December 2024), but in case you want to use
    a particular version, e.g., the 23.12 version, and want to be very sure that all modules are
    loaded correctly from the start you could consider using

    ```
    module load cpe/23.12
    module load cpe/23.12
    ```

    (but don't try this now or undo again by loading `cpe/24.03` twice or logging in again).

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

    which will generate an executable named `a.out`. 
    
    Of course it is better to give the executable a proper
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


## Compilation of a program 2: A program with BLAS

In the `CPE` subdirectory you'll find the C program `matrix_mult_C.c`
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
you should note. Also, because these nodes are shared with a lot of people, any benchmarking
is completely unreliable.

<!--
If this program takes more than half a minute or so before the first result line in the table,
starting with `ijk-variant`, is printed, you've very likely done something wrong (unless the load
on the system is extreme). In fact, if you've done things well the time reported for the
`ijk`-variant should be well under 3 seconds for both the C and Fortran versions...
-->
If you're doing things right, the time reported for the
`ijk`-variant should be well under 3 seconds for both the C and Fortran versions...
It is not a shame at all if you can't find the solution without looking into the solution.
Only people with experience with compilers will likely be able to make this exercise only
relying on the course materials and the compiler documentation, so don't search too long.

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
    in this case easily four times or more slower. So if you got much longer run times than indicated this
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
    produce the same result, the time needed to compute the matrix-matrix product is very
    different and those differences would be even more pronounced with bigger matrices
    (which you can do after the session on using Slurm).

    The exercise also shows that not all codes are equal even if they produce a result of the
    same quality. The six different loop orderings run at very different speed, and none of our
    simple implementations can beat a good library, in this case the BLAS library included in
    LibSci. The optimal variants are also different for C and Fortran as the matrix elements
    are stored in a different order in memory.

    The results with the Cray Fortran compiler are particularly interesting. The result for
    the BLAS library is slower which we do not yet understand, but it also turns out that 
    for four of the six loop orderings we get the same result as with the BLAS library DGEMM
    routine. It looks like the compiler simply recognized that this was code for a matrix-matrix
    multiplication and replaced it with a call to the BLAS library. The Fortran 90 matrix
    multiplication is also replaced by a call of the DGEMM routine. To confirm all this,
    unload the `cray-libsci` module and try to compile again and you will see five error
    messages about not being able to find DGEMM. If you don't want the Cray Fortran compiler
    to recognise patterns that it can replace with library routines, add the `-h nopattern`
    flag to the command line:

    ```
    module load PrgEnv-cray
    ftn -O3 -h nopattern matrix_mult_F.f90 -o matrix_mult_F_cray.x
    ```



## Compilation of a program 3: A hybrid MPI/OpenMP program

The file `mpi_omp_hello.c` is a hybrid MPI and OpenMP C program that sends a message
from each thread in each MPI rank. It is basically a simplified version of the
programs found in the `lumi-CPEtools` modules that can be used to quickly check 
the core assignment in a hybrid MPI and OpenMP job (see later in this tutorial).
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

    To run the executables it is not
    even needed to have the respective `PrgEnv-*` module loaded since the binaries
    will use a copy of the libraries stored in a default directory, though there have
    been bugs in the past preventing this to work with `PrgEnv-aocc`.

??? Note "What about the `mpicc`, etc., compiler wrappers?"
    The usual MPI compiler wrappers like `mpicc`, `mpicxx` or `mpifort`
    are provided also. Though they will take care of linking with the MPI
    libraries properly, they do not take care of linking with the BLAS libraries
    and some other HPE CPE libraries that are linked in automatically when using
    the CPE wrappers.

    Moreover, when using the wrappers in the `PrgEnv-gnu` version of Cray MPICH, 
    they don't understand the right names for the GCC compiler executables based on
    which GCC module is loaded. As a result, when loading one of the `gcc-native` modules
    which are now the standard GCC modules in the HPE Cray PE, they will run the system 
    compiler instead, and you may get errors when trying to link or run with other libraries
    that are properly compiled with the much newer GCC versions in the `gcc-native` modules.

    Just try:

    ```
    module load PrgEnv-gnu
    mpicc --version
    ```

    to see this issue when using a recent version of the programming environment (such as 
    the 24.03 default version).

    A workaround is to point the environment variable `MPICH_CC` to the correct GCC C compiler
    executable. If you're making this exercise in the 24.03 version of the CPE (the default 
    version when this exercise was last revised), you can use:

    ```
    module load PrgEnv-gnu
    export MPICH_CC=gcc-13
    mpicc --version
    ```

    Similarly, for C++ and Fortran, you'd have to point `MPICH_CXX` and `MPICH_FC` to the
    correct versions of `g++` and `gfortran`.


