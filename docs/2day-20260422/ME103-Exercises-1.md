# Exercises 1: Elementary access and the HPE Cray PE

<!--
Exercises will be made available during the course
-->

-   Start with the [exercises on "Getting Access to LUMI"](E103-Access.md)

-   Continue with the [exercises on the "HPE Cray Programming environment"](E102-CPE.md)

## Q&A


1.  I am not sure how to properly switch from one node to the other when I logged in through OnDemand. Do I understand it correctly, that I need to create a private key in my home directory (on LUMI) to do that?

    -   I'm not sure i understand what is your goal. if you want to go to compute nodes you need to use srun for it (see https://docs.lumi-supercomputer.eu/runjobs/scheduled-jobs/interactive/ section `use srun to check running jobs`). Otherwise if you want to go to another login node indeed you have to have an ssh key and use agent forward. It is not possible to ssh in a compute node. This is due to LUMI having shared nodes and cgroup is limiting visibility if you have a partial allocation only via slurm, and allowing ssh to compute node would circumvent this.

    -   You cannot create keys in `.ssh` on LUMI. They will be ignored for security reasons. You also cannot ssh to a different node on LUMI. I think for the login nodes you would go through the external network interface anyway, and as we will see tomorrow, you cannot ssh to a compute node. The only way to add a key is through myCSC for CSC accounts and MyAccessID for all other accounts, see the ["Setting up SSH key pair" page in the LUMI documentation](https://docs.lumi-supercomputer.eu/firststeps/SSH-keys/).


