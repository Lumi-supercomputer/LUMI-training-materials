# Exercise session 13: Lustre I/O

The files for the exercises can be found in `Exercises/HPE/day4/VH1-io`.
Untar the file and you'll find a full I/O experiment with striping.

Alternatively, look again at the MPI exercises with Apprentice
If you did not do this before, set PAT_RT_SUMMARY=0. You get trace data per rank when you do this (huge file).
Set only 2 cycles in the input file (indat).
Use app2 on the .ap2 file to see new displays (see help).


## Materials

<!--
No materials available at the moment.
-->

<!--
Temporary location of materials (for the lifetime of the training project):

-   See the exercise assignments in
    `/project/project_465000644/Slides/HPE/Exercises.pdf`.

-   Exercise files in `/project/project_465000644/Exercises/HPE/day4`

Temporary web-available materials:

-    Overview exercise assignments temporarily available on
     [this link](https://462000265.lumidata.eu/4day-20231003/files/LUMI-4day-20231003-4_Exercises_day4.pdf)
-->

Archived materials on LUMI:

-   Exercise assignments in `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_HPE.pdf`

-   Exercises as bizp2-compressed tar file in
    `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_HPE.tar.bz2`

-   Exercises as uncompressed tar file in
    `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_HPE.tar`


## Q&A

6.  Is there a typo in the README? For the `lfs setstripe -c ${STRIPE_COUNT} -s ${STRIPE_SIZE} ${RUNDIR}/output` should the capital `-S` be used instead of `-s`?

    -   Indeed. I wonder how this was never noted, the error is in the slide also which has been used for 2 years... 
        It turns out to be wrong on the slide (corrected version is now available), wrong in the README (in the project directory, archived version corrected), but correct in the script where `-S` is used.

