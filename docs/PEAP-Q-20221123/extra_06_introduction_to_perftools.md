# Introduction to Perftools

-   Slide file in  `/appl/local/training/peap-q-20221123/files/06_introduction_to_perftools.pdf`

-   Recording in `/appl/local/training/peap-q-20221123/recordings/06_introduction_to_perftools.mp4`


## Q&A

1.  Can `perftools-lite` also be used with the gcc compilers?

    - yes, there is support for all the compilers offered on the machine. 
    - the 'loops' variant only works with CCE as it needs extra information from the compiler.

2.  Can `perftools` also output per-MPI-rank timings or only (as shown in the presentation) averaged over all processes?

        * you can get per rank timings in the text output with appropriate options to pat_reoprt. Conversely, you can have a look at apprentice2 which has a nice way of showing per-rank timings.
    * there is an option pe=ALL that will show timings per rank/PE


3.  The output of the statistics will tell you the name of the subroutine, line number, will it also tell you the name of the file where this is from ?
    - with the `-O ca+src` option to `pat_report` you can get the source information.


## Exercises

The exercises for this session are in the `perftools/perftools-lite` subdirectory.

!!! info "Apprentice2 and Reveal downloads"
    With `perftools-base` loaded (and it is loaded by default), you can also find the Apprentice2 downloads in `$CRAYPAT_ROOT/share/desktop_installers` or 
    `$CRAY_PERFTOOLS_PREFIX/share/desktop_installers`.
    Copy them to your local machine and install them there.
