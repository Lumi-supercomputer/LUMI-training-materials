# Course schedule

## Wednesday November 23

<em>All times CET.</em>

<table style="text-align: left;">
<tbody>
<tr>
    <td>09:30&nbsp;&nbsp;</td>
    <td>Welcome, introduction to the course <br>
    <em>Presenter: Kurt Lust (LUST)</em><br>
    <em><a href="https://462000265.lumidata.eu/peap-q-20221123/files/LUMI-PEAPQ-intro-20221124.pdf">Slides</a> available online.</em>
    </td>
</tr>
<tr>
    <td>09:45</td>
    <td>Introduction to the HPE Cray Hardware and Programming Environment
    <ul>
        <li>The HPE Cray EX hardware architecture and software stack</lo>
        <li>The Cray module environment and compiler wrapper scripts</li>
    </ul>
    <em>Presenter: Harvey Richardson (HPE)</em><br>
    <em>Slide files: <code>/project/project_465000297/slides/01_EX_Architecture.pdf</code> and <code>/project/project_465000297/slides/02_PE_and_Modules.pdf</code> on LUMI only.</em>
    </td>
</tr>
<tr>
    <td>10:55</td>
    <td><em>break (25 minutes)</em>
    </td>
</tr>
<tr>
    <td>11:20</td>
    <td>First steps to running on Cray EX Hardware
    <ul>
        <li>Examples of using the Slurm Batch system, launching jobs on the front end and basic controls for job placement</li>
        <li>Exercises: about 45 minutes</li>
    </ul>
    <em>Slide file: <code>/project/project_465000297/slides/03_Running_Applications_Slurm.pdf</code> on LUMI only.</em>
    </td>
</tr>
<tr>
    <td>12:40</td>
    <td><em>lunch break (80 minutes)</em>
    </td>
</tr>
<tr>
    <td>14:00</td>
    <td>Overview of compilers and libraries
    <ul>
        <li>An introduction to the compiler suites available</li>
        <li>How to get additional information about the compilation process</li>
        <li>Special attention is given the Cray Compilation Environment (CCE) noting options relevant to porting and performance. CCE classic to Clang transition</li>
        <li>Exercises: about 20 minutes</li>
    </ul>
    <em>Slide file: <code>/project/project_465000297/slides/04_Compilers_and_Libraries.pdf</code> on LUMI only.</em>
    </td>
</tr>
<tr>
    <td>15:30</td>
    <td><em>break (30 minutes)</em></td>
</tr>
<tr>
    <td>16:00</td>
    <td>Advanced Application Placement
    <ul>
        <li>More detailed treatment of Slurm binding technology and OpenMP controls</li>
        <li>Exercises: about 30 minutes</li>
    </ul>
    <em>Presenter: Jean Pourroy</em><br>
    <em>Slide file: <code>/project/project_465000297/slides/05_Advanced_Placement.pdf</code> on LUMI only.</em>
    </td>
</tr>
<tr>
    <td>17:00</td>
    <td>Open Questions &amp; Answers (participants are encouraged to continue with exercises in case there should be no questions)
    </td>
</tr>
<tr>
    <td>17:30</td>
    <td><em>End of first course day</em></td>
</tr>
</tbody>
</table>

## Thursday November 24

<em>All times CET.</em>

<table style="text-align: left;">
<tbody>
<tr>
    <td>09:30&nbsp;&nbsp;</td>
    <td>Performance and Debugging Tools incl exercises<br>
    <ul>
        <li>Introduction to perftools</li>
        <li>Pertfools lite modules</li>
        <li>Loop work estimates</li>
        <li>Reveal for performance data display, compiler feedback and automatedscoping</li>
        <li>Debugging tools at scale</li>
    </ul>
    <em>Presenters: Alfio Lazarro and Thierry Braconnier (HPE)</em><br>
    <em>Slide files: <code>/project/project_465000297/slides/06_introduction_to_perftools.pdf</code>,
    <code>/project/project_465000297/slides/07_advanced_performance_analysis_part1.pdf</code>,
    <code>/project/project_465000297/slides/08_advanced_performance_analysis_part2.pdf</code>
    and <code>/project/project_465000297/slides/09_debugging_at_scale.pdf</code> on LUMI only.</em>
    </td>
</tr>
<tr>
    <td>12:15</td>
    <td><em>lunch break (60 minutes)</em></td>
</tr>
<tr>
    <td>13:15</td>
    <td>Understanding Cray MPI on Slingshot, rank reordering and MPMD launch
    <ul>
        <li>High level overview of Cray MPI on Slingshot, useful environment variable controls.</li>
        <li>Rank reordering and MPMD application launch.</li>
        <li>Exercises: about 20 minutes</li>
    </ul>
    <em>Presenter: Harvey Richardson</em><br>
    <em>Slide file: <code>/project/project_465000297/slides/11_cray_mpi_MPMD_short.pdf</code> on LUMI only.</em>
    </td>
</tr>
<tr>
    <td>14:15</td>
    <td>I/O Optimisation — Parallel I/O
    <ul>
        <li>Introduction into the structure of the Lustre Parallel file system</li>
        <li>Tips for optimising parallel bandwidth for a variety of parallel I/O schemes</li>
        <li>Examples of using MPI-IO to improve overall application performance.</li>
        <li>Advanced Parallel I/O considerations</li>
        <li>Further considerations of parallel I/O and other APIs.</li>
        <li>Being nice to Lustre</li>
        <li>Consideration of how to avoid certain situations in I/O usage that don’t specifically relate to data movement.</li>
    </ul>
    <em>Presenter: Harvey Richardson</em><br>
    <em>Slide file: <code>/project/project_465000297/slides/12_IO_short_LUMI.pdf</code> on LUMI only.</em>
    </td>
</tr>
<tr>
    <td>15:00</td>
    <td><em>break (20 minutes)</em></td>
</tr>
<tr>
    <td>15:20</td>
    <td>Additional software on LUMI-C
    <ul>
        <li>Software policy</li>
        <li>Software environment on LUMI</li>
        <li>Installing software with EasyBuild (concepts, contributed recipes)</li>
        <li>Containers for Python, R, VNC (container wrappers)</li>
    </ul>
    <em>Presenter: Kurt Lust (LuST)</em><br>
    <em><a href="https://462000265.lumidata.eu/peap-q-20221123/files/LUMI-PEAPQ-software-20221124.pdf">Slides</a> and <a href="../software_stacks/">notes</a> available online.</em>
    </td>
</tr>
<tr>
    <td>16:40</td>
    <td>LUMI support 
    <ul>
        <li>LUMI documentation</li>
        <li>What can we help you with and what not? How to get help, how to write good support requests</li>
        <li>Some typical/frequent support questions of users on LUMI-C?</li>
    </ul>
    <em>Presenter: Jørn Dietze (LUST)</em><br>
    <em><a href="https://462000265.lumidata.eu/peap-q-20221123/files/LUMI-PEAPQ-support-20221124.pdf">Slides</a> available online.</em>
    </td>
</tr>
<tr>
    <td>17:10</td>
    <td>Open Questions &amp; Answers 
    (participants are encouraged to continue with exercises in case there should be no questions)
    </td>
</tr>
<tr>
    <td>17:30</td>
    <td><em>End of second course day</em></td></tr>
</tbody>
</table>

