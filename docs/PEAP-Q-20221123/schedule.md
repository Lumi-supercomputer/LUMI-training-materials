# Course schedule

## Wednesday November 23

<em>All times CET.</em>

<table style="text-align: left;">
<tbody>
<tr>
    <td>09:30&nbsp;&nbsp;</td>
    <td><b><a href="../extra_00_Introduction/">Welcome, introduction to the course</a></b><br>
    <em>Presenter: Kurt Lust (LUST)</em>
    </td>
</tr>
<tr>
    <td>09:45</td>
    <td><b><br><a href="../extra_01_HPE_Cray_EX_Architecture/">Introduction to the HPE Cray Hardware</a> and <a href="../extra_02_Programming_Environment_and_Modules/">Programming Environment</a></b>
    <ul>
        <li>The HPE Cray EX hardware architecture and software stack</lo>
        <li>The Cray module environment and compiler wrapper scripts</li>
    </ul>
    <em>Presenter: Harvey Richardson (HPE)</em><br>
    </td>
</tr>
<tr>
    <td>10:55</td>
    <td><em>break (25 minutes)</em>
    </td>
</tr>
<tr>
    <td>11:20</td>
    <td><b><A href="../extra_03_Running_Applications_Slurm/">Running Applications</a></b>
    <ul>
        <li>Examples of using the Slurm Batch system, launching jobs on the front end and basic controls for job placement</li>
        <li>Exercises: about 45 minutes</li>
    </ul>
    </td>
</tr>
<tr>
    <td>12:40</td>
    <td><em>lunch break (80 minutes)</em>
    </td>
</tr>
<tr>
    <td>14:00</td>
    <td><b><A href="../extra_04_Compilers_and_Libraries/">Compilers and Libraries</a></b>
    <ul>
        <li>An introduction to the compiler suites available</li>
        <li>How to get additional information about the compilation process</li>
        <li>Special attention is given the Cray Compilation Environment (CCE) noting options relevant to porting and performance. CCE classic to Clang transition</li>
        <li>Exercises: about 20 minutes</li>
    </ul>
    </td>
</tr>
<tr>
    <td>15:30</td>
    <td><em>break (30 minutes)</em></td>
</tr>
<tr>
    <td>16:00</td>
    <td><b><A href="../extra_05_Advanced_Placement/">Advanced Placement</a></b>
    <ul>
        <li>More detailed treatment of Slurm binding technology and OpenMP controls</li>
        <li>Exercises: about 30 minutes</li>
    </ul>
    <em>Presenter: Jean Pourroy</em><br>
    </td>
</tr>
<tr>
    <td>17:00</td>
    <td><b>Open Questions &amp; Answers</b>
    <br/>Participants are encouraged to continue with exercises in case there should be no questions.
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
    <td><b><a href="../extra_06_introduction_to_perftools/">Introduction to Perftools</a>, 
        <a href="../extra_07_advanced_performance_analysis_part1/">Performance Analysis Part 1</a> and <a href="../extra_08_advanced_performance_analysis_part2/">Part 2</a>, and 
        <a href="../extra_09_debugging_at_scale/">Debugging at Scale</a></b>
    <ul>
        <li>Introduction to perftools</li>
        <li>Pertfools lite modules</li>
        <li>Loop work estimates</li>
        <li>Reveal for performance data display, compiler feedback and automatedscoping</li>
        <li>Debugging tools at scale</li>
    </ul>
    <em>Presenters: Alfio Lazarro and Thierry Braconnier (HPE)</em><br>
    </td>
</tr>
<tr>
    <td>12:15</td>
    <td><em>lunch break (60 minutes)</em></td>
</tr>
<tr>
    <td>13:15</td>
    <td><b><A href="../extra_11_cray_mpi_MPMD_short/">MPI Topics on the HPE Cray EX Supercomputer</a></b>
    <ul>
        <li>High level overview of Cray MPI on Slingshot, useful environment variable controls.</li>
        <li>Rank reordering and MPMD application launch.</li>
        <li>Exercises: about 20 minutes</li>
    </ul>
    <em>Presenter: Harvey Richardson</em><br>
    </td>
</tr>
<tr>
    <td>14:15</td>
    <td><b><a href="../extra_12_IO_short_LUMI/">Optimizing Large Scale I/O</a></b>
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
    <td><b><a href="../extra_13_LUMI_Software_Stacks/">LUMI Software Stacks</a></b>
    <ul>
        <li>Software policy</li>
        <li>Software environment on LUMI</li>
        <li>Installing software with EasyBuild (concepts, contributed recipes)</li>
        <li>Containers for Python, R, VNC (container wrappers)</li>
    </ul>
    <em>Presenter: Kurt Lust (LuST)</em><br>
    </td>
</tr>
<tr>
    <td>16:40</td>
    <td><b><a href="../extra_14_LUMI_User_Support/">LUMI User Support</a></b>
    <ul>
        <li>LUMI documentation</li>
        <li>What can we help you with and what not? How to get help, how to write good support requests</li>
        <li>Some typical/frequent support questions of users on LUMI-C?</li>
    </ul>
    <em>Presenter: Jørn Dietze (LUST)</em><br>
    </td>
</tr>
<tr>
    <td>17:10</td>
    <td><b><a href="../extra_15_Day_2_QandA/">Open Questions &amp; Answers</a></b>
    <br/>Participants are encouraged to continue with exercises in case there should be no questions.
    </td>
</tr>
<tr>
    <td>17:30</td>
    <td><em>End of second course day</em></td></tr>
</tbody>
</table>

