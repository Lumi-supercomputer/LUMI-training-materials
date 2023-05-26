# Compilers and Libraries

-   Slide file in  `/appl/local/training/peap-q-20221123/files/04_Compilers_and_Libraries.pdf`

-   Recording in `/appl/local/training/peap-q-20221123/recordings/04_Compilers_and_Libraries.mp4`


## Q&A

6. By default the libraries are shared (dynamic), so isn't it good practice to but the compiling part of the application in the slurm script job ?

    - In general, no. The libraries on the system will not change that often, only after service breaks / upgrades of the Cray Programming Environment. It would also be inefficient to compile using compute node allocation if you have e.g. a wide parallel job with 100 compute nodes.
    - You must also consider that it uses your allocated resources (from your project)

17. Question about the cray fortran compiler: I've been trying to use it now on some private code, and it crashes when it encounters preprocesseor statements like `#ifdef` which gfortran is happy about. Is this expected? Is there a way to handle this?
    - What error does the compiler give?
        - `ftn-100: This statement must begin with a label, a keyword or identifier`, so it just seems to take the statement literally
    - Did you use the right filename extension to activate the preprocessor or the -ep/-ez options shown in the presentation?
    - That is probably the problem, I think I missed that comment, I will go back to the slides to look
    - After loading PrgEnv-cray you can also get extensive help about all the command line options using man crayftn
    - Source file extension needs to start with F and not f to automatically trigger the preprocessor.
    - The other cause might be that sometimes there are subtle differences between wat a C and Fortran preprocessor allows but I believe there is an option for that also. I remember having such a ticket long ago.
    - Thanks, the filename was actually the problem, I wasn't expecting that
    - I may have another advice, just in case: the CCE produces modules with capital letters names (FOO.mod), you can use `-emf` to get lowercase (like gfortran).


## Exercises

A tar file with exercises is available as `/appl/local/training/peap-q-20221123/files/exercises-1day-20221123.tar.gz`. 

Try the compiler exercises in `perftools/compiler_listings` and try recompiling the exercises from earlier. You don't need to run any jobs.

