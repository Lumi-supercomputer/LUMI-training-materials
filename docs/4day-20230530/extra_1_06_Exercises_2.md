# Exercise session 2

-   The exercises are basically the same as in 
    [session #1](extra_1_04_Exercises_1.md). You can now play with different
    programming models and optimisation options.

-   Permanent archive on LUMI:

    -   Exercise notes in `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.pdf`

    -   Exercises as bizp2-compressed tar file in
        `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.tar.bz2`

    -   Exercises as uncompressed tar file in
        `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.tar`



## Q&A

12. I changed my environment to `PrgEnv-gnu`, and trying to run the `Makefile`, but it gave me this message `Makefile:7: *** Currently PrgEnv-gnu is not supported, switch to PrgEnv-cray or use Makefile.allcompilers.  Stop.`. Could you please guide me how to run make for the gnu?

    **Answer** `make -f Makefile.allcompilers`
    
    **Follow up** it gave me this: `make: Nothing to be done for 'all'.`
    
    **Answer** You need to get rid of the previous compilation with       `make -f Makefile.allcompilers clean`


