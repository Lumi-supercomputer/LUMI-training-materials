# Application Fingerprinting (January 29, 2025)

*Presenter:* Thomas Jakobsche (Uni Basel)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20250129-user-coffee-break-Application-Fingerprinting.mp4" controls="controls"></video>


## Abstract

LUMI is participating in a research project with the HPC group of Prof. Florina Ciorba at the Department of Mathematics and Computer Science of the University of Basel. This work will contribute to the PhD work of Thomas Jakobsche focusing on Monitoring and Operational Data Analytics (MODA) and how to better characterize user workloads and avoid inefficient resource usage on HPC systems.
    
Part of his work is to develop tooling that will record some metadata from applications that are being run, like what modules are loaded and which binaries are being executed with the goal to help the LUMI user support team detect misconfigurations and inefficient resource usage. The tooling should be entirely transparent to any user codes and have a negligible impact on application runtime. We have thus far tested these tools internally, and are now in a state where we would want to try it out with a broader scope of real user codes, both to further confirm that it does not cause any issues with user codes and also to gauge how well we can characterize actual user workloads. Currently the tools do not work with anything that is containerized, meaning that if you run mainly containerized applications you cannot participate.

Participating in the testing is really simple, you need to load a module and run whatever you normally run with the module loaded. You can contribute just a few runs or you can keep the module loaded for longer periods. In case you encounter any issues with the module, it causing issues with the programs you run, or significant performance impacts, please reach out to the LUMI service desk with a description of what you ran and how you ran it.

To load the module on LUMI use:
```
module use /appl/local/csc/modulefiles/
module load siren
```
or
```
module load Local-CSC siren
```
Submitting jobs with the module loaded or loading it inside the batch job should both have the same result. In practice what the module does is it adds the fingerprinting library into any applications you run, and once you unload the module the library will no longer be added to any new runs.

We appreciate any runs you can do with the module loaded, from simple single binaries to more complex workflows. If you have further questions please contact the LUMI service desk.

