# LUMI Architecture, Programming and Runtime Environment

*Presenter: Harvey Richardson (HPE)*

## Materials

<!-- Course materials will be provided during and after the course. -->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001726/Slides/HPE/01_Architecture_PE_modules_slurm.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-301-HPE_Cray_EX_Architecture.pdf`

<!--
-   Recording: `/appl/local/training/2p3day-20250303/recordings/301-HPE_Cray_EX_Architecture.mp4`
-->

These materials can only be distributed to actual users of LUMI (active user account).


## Q&A

1.  What versions of ROCm are currently supported on LUMI?

    -   *Driver is from 6.0, so 5.6 to 6.2. One but though: Each version of the programming environment is developed with a specific version of ROCm in mind, so, e.g., for GPU-aware MPI the only version we are 100% sure of, is 6.0.3. But it seems to work wel with 6.2 also. Newer or older versions of ROCm may or may not work with that driver.E.g., we know that ROCm 5.4 does not work well with the current driver. On the other hand, when we had the 5.2 driver on the system which guaranteed support for 5.0 to 5.4, but it runed out that 5.5 also worked well. We have no experience though with ROCm 6.3 at the moment. Next update of the ROCm driver is expected only during the summer, and will go to 6.3 or newer.*

    I see rocm/6.2.2 module is available; do you plan to add rocm/6.2.4  (I think it is the most up-to-date  one in 6.2.x line)?

    -   *No, but feel free to adapt the Easy/build recipe yourself. We cannot follow every single small update, and the person who made the module for us has also left the team. We also have containers from which you can experiment with newer ROCm versions, but there too we don't have the personpower to do each and every version.*
