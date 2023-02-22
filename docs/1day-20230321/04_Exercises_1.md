# Exercises 1: HPE Cray PE and modules


## Compilation of a program

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

??? Solution
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

    The one "difficulty" is that we need to link with the BLAS library. This is very easy however in 
    the HPE Cray PE if you use the compiler wrappers rather than calling the compilers yourself:
    you only need to make sure that the `cray-libsci` module is loaded and the wrappers will take
    care of the rest. And on most systems (including LUMI) this module will be loaded automatically
    when you load the `PrgEnv-*` module.

    To compile with the GNU C compiler, all you need to do is

    ```
    module load PrgEnv-gnu
    cc -O3 matrix_mult_C.c
    ```

    which will generate the executable `a.out`. Of course it is better to give the executable a proper
    name which can be done with the `-o` compiler option:

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


## Compilation of a program 2: A hybrid MPI/OpenMP program


