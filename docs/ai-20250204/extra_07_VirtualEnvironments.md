# Extending containers with virtual environments for faster testing

*Presenter:* Gregor Decristoforo (LUST)

Contents:

-   Using pip venvs to extend existing containers
-   Create a SquashFS file for venv
-   Pros, cons and caveats of this approach


<!--
A video recording will follow.
-->

<video src="https://462000265.lumidata.eu/ai-20250204/recordings/07_VirtualEnvironments.mp4" controls="controls"></video>

## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250204/files/LUMI-ai-20250204-07-Extending_containers.pdf)

-   [Examples](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-20250204/07_Extending_containers_with_virtual_environments_for_faster_testing)

-   The [additional training materials mentioned in the "Running containers" page](extra_05_RunningContainers.md#extra-materials)
    are relevant for this presentation also.


## Q&A

1.  Somewhat related: if my experiment _generates_ a large number of files, how can I save those in a way that is nice to the filesystem (e.g. in a SquashFS filesystem, but those were read-only if I understand correctly)

    -   There is no easy way here. Probably write to a RAM disk if space allows and then pack that. But the only really good way is to use or write better software that uses modern data management libraries. And yes, we have problems with some codes that were never meant to be used on a system the size of LUMI...
  
    pointer to said "modern data management libraries"?
    
    -   Libraries like HDF5, netCDF, ADIOS2, ... Some are not even that new anymore. In some cases, I wonder what direct access to an object file system such as LUMI-O could do.

