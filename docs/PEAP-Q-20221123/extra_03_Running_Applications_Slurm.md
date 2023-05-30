# Running Applications

-   Slide file in  `/appl/local/training/peap-q-20221123/files/03_Running_Applications_Slurm.pdf`

-   Recording in `/appl/local/training/peap-q-20221123/recordings/03_Running_Applications_Slurm.mp4`


## Q&A

1.  I would like to know whether it is possible to run FEM simulation software (e.g., COMSOL Multiphysics) on LUMI?
    - As long as it is installed correctly then I see no reason why not. It has been run on other Cray EX systems. The only complication here will be the commerical license.  LUMI does not have its own license, you would have to provide your own. There might be some complications right now, because the compute nodes do not have internet access, which would block access to the license server. We hope that internet access will be enabled on the compute nodes soon.

2.  Is it something like MC (Midnight Commander) installed?
   - No, and midnight commander specifically has some annoying dependencies so it will not come quickly in a way that integrates properly with all the other software on LUMI.
   - You can see your files and transfer to and from LUMI using tools like [filezilla](https://filezilla-project.org/) and the host `sftp://lumi.csc.fi`
   - And for people on a connection with sufficiently low latency Visual Studio Code also works. The client-server connection seems to fail easily though on connections with a higher latency. It is also more for editing remotely in a user friendly way than browsing files or running commands. But we do understand that mc is awesome for some people.
   - In the future there will also be an [Open OnDemand](https://openondemand.org/) interface to LUMI.
   - MC is ok but Krusader is better

12. and WinSCP?
    - That is client software to run on your PC. It should work. 
    - In general, until we have Open OnDemand, the support for running GUI software on LUMI is very limited. And after that it will not be brilliant either, as an interface such as GNOME is not ideal to run on multiuser login nodes due to the resources it needs but also due to how it works internally.
    
15. Would it be alright to test the building of licensed software such as VASP during the course and the EasyBuild system you have in place? (and benchmark with very small test run of course)
    - Please don't run benchmarks of your own software on the project account. If you already have another project, use that one instead.
    - You can install and run VASP but need to bring your own license file. See also [here](https://docs.lumi-supercomputer.eu/software/guides/vasp/) or the future page in the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/v/VASP/).

!!! exercise
    Exercises are available at `/project/project_465000297/exercises/ProgrammingModels/`
    Copy the files to your home folder before unpacking them.

## Exercises

A tar file with exercises is available as `/appl/local/training/peap-q-20221123/files/exercises-1day-20221123.tar.gz`. 

