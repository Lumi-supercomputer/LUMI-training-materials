# Notes from the HedgeDoc page - day 4

These are the notes from the LUMI training,
1114-17.02.2023, 9:00--17:30 (CET) on Zoom.

-   [Day 1](hedgedoc_notes_day1.md)
-   [Day 2](hedgedoc_notes_day2.md)
-   [Day 3](hedgedoc_notes_day3.md)
-   [Day 4](hedgedoc_notes_day4.md): This page


## Introduction to Perftools

2.  A question from the first day, sorry :-) My Fortran code with OpenMP offload does not compile with -O2 (cray compiler) due to inlining issues; is it possible to quench inlining for a specific routine only? 
    -   (Harvey) `man inline`
        it might apply to whole file though so need to check, manpage might indicate this.
    -   The ipa compiler option (man crayftn) also affects inlining.
        -   yes, I discovered it does not compile due to inling, ao I reduced to level 1, 2 gives errors as well..
        -   Thank you!
    -   (Peter) Setting `__attribute__((noinline))` before the subroutine can be done in standard Clang, at least. CrayCC seems to accept it when I compile a simple program.
    -   It might also be worth to compile with -O2 but just turn of inlining with the appropriate compiler option (-hipa0 I believe for Fortran).


3.  Would it be possible to use a pointer / annotate / ??? to visually guide the narration through complex slides ? not sure whether technically possible
    -   (Harvey) It looks like Zoom does now have this capability but it has to be enabled before sharing a presentation and is embedded in menus,  I really don't want to interrupt Alfio to try this live but we will look into this.  Thanks for the suggestion.
    -   (not Harvey) It is certainly possible but depending on the software that is used for the presentation and the way of sharing (just a window or the whole screen) it requires additional software that the speaker may not have installed.
        -   okay
    -   It's a remark to take with us should there once again be a fully virtual course but it looks like the next two will be in-person with broadcast and then the technique that works for the room will determine how slides are broadcast.
        -   thank you
        -   I second the suggestion/request for future courses, it was especially difficult to follow through Alfio's slides. Maybe consider a different meeting software (one more targeted at teaching like BigBlueButton which supports the pointer) in the future? At least for me on Linux it is hit-and-miss if Zoom finds my audio (no problems with BBB or jitsi or even Teams, though)

4.  Is there a maximum duration of the measurement session supported, more or less?
    -   Not in time terms but you can use a lot of disk space with a very large number of ranks and specifically if you turn off the statistics aggregation in time.  There are controls to help here, for example only tracing a subset of the ranks or turning on and off collection at certain points.

5.  Where can I find the apprentice downloads?

    -   On LUMI, in `$CRAYPAT_ROOT/share/desktop_installers/` (with `perftools-base` loaded, which is loaded in the login environment)
    -   See also `module help perftools-base`.
    -   (Note that on LUMI the perftools default is the latest version installed. If you were using a system somewhere else with a newer perftools available than the default you can download the desktop installer of the latest version.)
    -   (Kurt) Actually the above about the default is only true at login and at the moment as currently it is indeed the latest version of the PE which is the default at login. If you load a `cpe` module of an older environmont (`cpe/21.12` for example) the default version of `perftools-base` will be the one that came with that release of the PE, and the same holds if you use the an older version of the `LUMI` software stacks.


### Exercises

!!! info "Exercise"
    -   Exercise notes and files including pdf and Readme with instructions on LUMI at `project/project_465000388/exercies/HPE`
    -   Directories for this exercise: `perftools-lite`, `perftools-lite-gpu`
    -   Copy the files to your home or project folder before working on the exercises.
    -   In some exercises you have source additional files to load the right modules necessary, check the README file.

    -   To run slurm jobs, set the necessary variables for this course by `source /project/project_465000388/exercises/HPE/lumi_g.sh` (GPU) or `source /project/project_465000388/exercises/HPE/lumi_c.sh` (CPU)

    -   Follow the readme and get familiar with the perftools-lite commands and outputs



