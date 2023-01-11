# LUMI-G Training, January 11, 2023

## Course overview

<em>All times CET.</em>

<table style="text-align: left;">
<tbody>
<tr>
    <td>09:00&nbsp;&nbsp;</td>
    <td>Introduction<br>
    <em>Presenter: Jørn Dietze (LUST)</em>
    </td>
</tr>
<tr>
    <td>09:10</td>
    <td>Introduction to the HPE Cray Hardware and Programming Environment on LUMI-G
    <ul>
        <li>The HPE Cray EX hardware architecture and software stack</lo>
        <li>The Cray module environment and compiler wrapper scripts</li>
        <li>An introduction to the compiler suites for GPUs
    </ul>
    <em>Presenter: Harvey Richardson (HPE)</em><br>
    <em>Slide files: <code>/project/project_465000320/slides/HPE/01_Intro_EX_Architecture_and_PE.pdf</code>  on LUMI only.</em>
    </td>
</tr>
<tr>
    <td>10:15</td>
    <td><em>break (30 minutes)</em>
    </td>
</tr>
<tr>
    <td>10:45</td>
    <td>First steps for running on LUMI-G
    <ul>
        <li>Examples of using the Slurm Batch system, launching jobs on the front end and basic controls for job placement (CPU/GPU/NIC)</li> 
        <li>MPI update for GPUs and SlingShot 11 (GPU-aware communications)</li> 
        <li>Profiling tools </li>
    </ul>
    <em>Presenter: Alfio Lazzaro (HPE)</em><br>
    <em>Slide file: <code>project/project_465000320/slides/HPE/02_Running_Applications_and_Tools.pdf</code> on LUMI only.</em>
    </td>
</tr>
<tr>
    <td>12:00</td>
    <td><em>lunch break (60 minutes)</em>
    </td>
</tr>
<tr>
    <td>13:00</td>
    <td>AMD topics
    <ul>
        <li>GPU Hardware intro </li>
        <li>Introduction to ROCm and HIP</li>
        <li>Porting Applications to HIP </li>
        <li>ROCm libraries </li>
        <li>Profiling</li>
        <li>Debugging</li>
    </ul>
    <!--
    <em>Slide file: <code>/project/project_465000297/slides/04_Compilers_and_Libraries.pdf</code> on LUMI only.</em>
    </td>
    -->
</tr>
<tr>
    <td>14:45</td>
    <td><em>break (30 minutes)</em></td>
</tr>
<tr>
    <td>15:15</td>
    <td>AMD topics (Ctd)
    <ul>
        <li>GPU Hardware intro </li>
        <li>Introduction to ROCm and HIP</li>
        <li>Porting Applications to HIP </li>
        <li>ROCm libraries </li>
        <li>Profiling</li>
        <li>Debugging</li>
    </ul>
    <!--
    <em>Presenter: Jean Pourroy</em><br>
    <em>Slide file: <code>/project/project_465000297/slides/05_Advanced_Placement.pdf</code> on LUMI only.</em>
    -->
    </td>
</tr>
<tr>
    <td>16:30</td>
    <td>General Questions &amp; Answers 
    <!-- (participants are encouraged to continue with exercises in case there should be no questions) -->
    </td>
</tr>
<tr>
    <td>17:00</td>
    <td><em>End of the course</em></td>
</tr>
</tbody>
</table>

<!--
# OLD INFORMATION TO BE ADAPTED

## Downloads

-   [Introduction to the AMD ROCm<sup>TM</sup> Ecosystem (PDF, 6.3M)](files/LUMIG_training_AMD_ecosystem_23_08_2022.pdf)
-   [Exercises for "Introduction to the AMD ROCm<sup>TM</sup> Ecosystem" (tar file, 56k)](files/LUMI_G-AMD-Exercises.tar)

## Notes

-   [Notes from the hackmd page](hackmd_notes.md)
-->

## Exercises

Some of the exercises used in the course are based on exercises or other material available in various GitHub repositories:

-   [OSU benchmark](https://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.9.tar.gz)
-   [Fortran OpenACC examples](https://github.com/RonRahaman/openacc-mpi-demos)
-   [Fortran OpenMP examples](https://github.com/ye-luo/openmp-target)
-   [Collections of examples in BabelStream](https://github.com/UoB-HPC/BabelStream)
-   [hello_jobstep example](https://code.ornl.gov/olcf/hello_jobstep)
-   [Run OpenMP example in the HPE Suport Center](https://support.hpe.com/hpesc/public/docDisplay?docId=a00114008en_us&docLocale=en_US&page=Run_an_OpenMP_Application.html)
-   [ROCm HIP examples](https://github.com/ROCm-Developer-Tools/HIP-Examples)
