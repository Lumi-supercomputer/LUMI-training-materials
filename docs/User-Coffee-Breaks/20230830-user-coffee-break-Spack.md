# Spack on LUMI (August 30, 2023)

*Presenters:* Peter Larsson (LUST & KTH PDC)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20230830-user-coffee-break-Spack.mp4" controls="controls">
</video>

## Q&A

[Full archive of all LUMI Coffee Break questions](https://hackmd.io/@lust/coffeearchive#2023-06-28-1300-%E2%80%93-1345-CEST). This page only shows the 
Spack-related questions.

1.  **Q:** I do not know all the limitations but if you create many spack instances in a project you can hit the quota regarding number of files, right?

    **Answer:** Yes, it is true. For this reason we provide “central” spack installation with most common software pieces already available (so called upstream spack instance). If you use spack module then you wouldn’t need to install everything in your own directory.
