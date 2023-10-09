# Exercise session 13

<!--
No materials available at the moment.
-->

-   See the exercise notes in  `/project/project_465000644/slides/HPE/Exercises.pdf` 
    for the exercises (for the lifetime of the project).

-   Material for the IO exercises is in 
    `/project/project_465000644/Exercises/HPE/day4/VH1-io` (for the lifetime of the project).

    And of course you can continue on previous exercises.

-   Permanent archive on LUMI:

    -   Exercise notes in `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_HPE.pdf`

    -   Exercises as bizp2-compressed tar file in
        `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_HPE.tar.bz2`

    -   Exercises as uncompressed tar file in
        `/appl/local/training/4day-20231003/files/LUMI-4day-20231003-Exercises_HPE.tar`


## Q&A

6.  Is there a typo in the README? For the `lfs setstripe -c ${STRIPE_COUNT} -s ${STRIPE_SIZE} ${RUNDIR}/output` should the capital `-S` be used instead of `-s`?

    -   Indeed. I wonder how this was never noted, the error is in the slide also which has been used for 2 years... 
        It turns out to be wrong on the slide (corrected version is now available), wrong in the README (in the project directory, archived version corrected), but correct in the script where `-S` is used.

