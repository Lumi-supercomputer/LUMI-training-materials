# Course schedule

<em>All times CET.</em>

<ul>
    <li><a href="#Day1">Day 1</a>
    <li><a href="#Day2">Day 2</a>
    <li><a href="#Day3">Day 3</a>
    <li><a href="#Day4">Day 4</a>
</ul>

<table style="text-align: left;">
<tbody>
<!--
DAY 1
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day1"><b>DAY 1</b></a>
        </td>
    </tr>
    <tr>
        <td>09:00&nbsp;&nbsp;</td>
        <td>Welcome and introduction<br>
        <em>Presenters: Emmanuel Ory (LUST), Jørn Dietze (LUST), Harvey Richardson (HPE)</em>
        <br><em><a href="../video_00_Introduction">Recording</a></em>
        </td>
    </tr>
    <tr>
        <td>09:10</td>
        <td>HPE Cray EX architecture<br/>
        <em>Presenter: Harvey Richardson (HPE)</em><br>
        <em>Slide files: <code>/project/project_465000388/slides/HPE/01_EX_Architecture.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/01_Cray_EX_Architecture.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>10:10</td>
        <td>Programming Environment and Modules<br/>
        <em>Presenter: Harvey Richardson (HPE)</em><br>
        <em>Slide files: <code>/project/project_465000388/slides/HPE/02_PE_and_Modules.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/02_Programming_Environment_and_Modules.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>10:40</td>
        <td><em>break (15 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>10:55</td>
        <td>Running Applications
        <ul>
            <li>Examples of using the Slurm Batch system, launching jobs on the front end and basic controls for job placement (CPU/GPU/NIC)</li> 
        </ul>
        <em>Presenter: Harvey Richardson (HPE)</em><br>
        <em>Slide file: <code>/project/project_465000388/slides/HPE/03_Running_Applications_Slurm.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/03_Running_Applications.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>11:15</td>
        <td><b>Exercises</b><br/>
        <em> Exercises are in <code>/project/project_465000388/exercises/HPE</code> on LUMI only.
        </td>
    </tr>
    <tr>
        <td>12:00</td>
        <td><em>lunch break (90 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>13:30</td>
        <td>Compilers and Parallel Programming Models 
        <ul>
            <li>An introduction to the compiler suites available, including examples of how to get additional information about the compilation process.</li>
            <li>Cray Compilation Environment (CCE) and options relevant to porting and performance. CCE classic to Clang transition.</li>
            <li>Description of the Parallel Programming models.</li>
        </ul>
        <em>Presenter: Alfio Lazzaro (HPE)</em><br>
        <em>Slide files: <code>/project/project_465000388/slides/HPE/04_Compilers_and_Programming_Models.pdf</code> on LUMI only.</em>
        <br>    <em>Recording: <code>/project/project_465000388/recordings/04_Compilers_and_Programming_Models.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>14:30</td>
        <td><b>Exercises</b>
        </td>
    </tr>
    <tr>
        <td>15:00</td>
        <td><em>break (30 minutes)</em>
        <ul>
            <li>Exercises on programming models: Try swapping compilers and some GPU programs.</li>
        </ul>
        </td>
    </tr>
    <tr>
        <td>15:30</td>
        <td>Cray Scientific Libraries 
        <ul>
            <li>The Cray Scientific Libraries for CPU and GPU execution.</li>
        </ul>
        <em>Presenter: Alfio Lazzaro (HPE)</em><br>
        <em>Slide files: <code>/project/project_465000388/slides/HPE/05_Libraries.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/05_Libraries.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>16:00</td>
        <td><b>Exercises</b>
        </td>
    </tr>
    <tr>
        <td>16:45</td>
        <td>Open Questions & Answers (participants are encouraged to continue with exercises in case there should be no questions)
        </td>
    </tr>
    <tr>
        <td>17:30</td>
        <td><em>End of the course day</em>
        </td>
    </tr>
<!--
DAY 2
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day2"><b>DAY 2</b></a>
        </td>
    </tr>
    <tr>
        <td>09:00</td>
        <td>CCE Offloading Models
        <ul>
            <li>Directive-based approach for GPU offloading execution with the Cray Compilation Environment.</li>
        </ul>
        <em>Presenter: Alfio Lazzaro (HPE)</em>
        <br><em>Slide file: <code>/project/project_465000388/slides/HPE/06_Directives_Programming.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/06_Directives_programming.mp4</code> on LUMI only.</em>
         </td>
    </tr>
    <tr>
        <td>09:45</td> 
        <td><b>Exercises</b>
        <br/><em>See also: <code>/project/project_465000388/slides/HPE/Exercises_alldays.pdf</code> on LUMI only.</em>
         </td>
    </tr>
    <tr>
        <td>10:15</td>
        <td><em>break (30 minutes)</em></td>
    </tr>
    <tr>
        <td>10:45</td>
        <td>Advanced Placement
        <ul>
            <li>More detailed treatment of Slurm binding technology and OpenMP controls.</li>
        </ul>
        <em>Presenter: Jean Pourroy (HPE)</em>
        <br><em>Slide file: <code>/project/project_465000388/slides/HPE/07_Advanced_Placement.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/07_Advanced_Placement.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>11:40</td>
        <td><b>Exercises</b>
        </td>
    </tr>
    <tr>
        <td>12:10</td>
        <td><em>lunch break (65 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>13:15</td>
        <td>Understanding Cray MPI on Slingshot, rank reordering and MPMD launch
        <ul>
            <li>High level overview of Cray MPI on Slingshot</li>
            <li>Useful environment variable controls</li>
            <li>Rank reordering and MPMD application launch</li>
        </ul>
        <em>Presenter: Harvey Richardson (HPE)</em>
        <br><em>Slide file: <code>/project/project_465000388/slides/HPE/08_cray_mpi_MPMD_medium.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/08_MPI_Topics.mp4</code> on LUMI only.</em>
    </td>
    </tr>
    <tr>
        <td>14.15</td>
        <td><b>Exercises</b>
        </td>
    </tr>
    <tr>
        <td>14:45</td>
        <td><em>break (15 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>15:00</td>
        <td>Additional software on LUMI
        <ul>
            <li>Software policy.</li>
            <li>Software environment on LUMI.</li>
            <li>Installing software with EasyBuild (concepts, contributed recipes)</li>
            <li>Containers for Python, R, VNC (container wrappers)</li>
        </ul>
        <em>Presenter: Kurt Lust (LUST)</em>
        <br><em><a href="https://462000265.lumidata.eu/4day-20230214/files/LUMI-Software-20230215.pdf">Slides for download (PDF)</a></em>
        <br><em><a href="../software_stacks">Notes available</a></em>
        <br><em><a href="../video_09_LUMI_Software_Stack">Recording</a>
        </td>
    </tr>
    <tr>
        <td>16:30</td>
        <td>LUMI support and LUMI documentation.
        <ul>
            <li>What can we help you with and what not? How to get help, how to write good support requests.</li>
            <li>Some typical/frequent support questions of users on LUMI?</li>
        </ul>
        <em>Presenter: Jørn Dietze (LUST)</em>
        <br><em><a href="../video_10_LUMI_User_Support">Recording</a>
    </td>
    </tr>
    <tr>
        <td>17:00</td>
        <td>Open Questions & Answers (participants are encouraged to continue with exercises in case there should be no questions)
        </td>
    </tr>
    <tr>
        <td>17:30</td>
        <td><em>End of the course day</em>
        </td>
    </tr>
<!--
DAY 3
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day3"><b>DAY 3</b></a>
        </td>
    </tr>
    <tr>
        <td>09:00</td>
        <td>Performance Optimization: Improving Single-core Efficiency<br/>
        <em>Presenter: Jean Pourroy (HPE)</em>
        <br><em>Slide file: <code>/project/project_465000388/slides/HPE/09_cpu_performance_optimization.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/11_CPU_Performance_Optimization.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>09:45</td>
        <td>Debugging at Scale – gdb4hpc, valgrind4hpc, ATP, stat<br/>
        <em>Presenter: Thierry Braconnier (HPE)</em>
        <br><em>Slide file: <code>/project/project_465000388/slides/HPE/10_debugging_at_scale.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/12_Debugging_at_Scale.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>10:10</td>
        <td><b>Exercises</b></td>
    </tr>
    <tr>
        <td>10:30</td>
        <td><em>break</em>
        </td>
    </tr>
    <tr>
        <td>10:50</td>
        <td>I/O Optimizing Large Scale I/O
        <ul>
            <li>Introduction into the structure of the Lustre Parallel file system. </li>
            <li>Tips for optimising parallel bandwidth for a variety of parallel I/O schemes. </li>
            <li>Examples of using MPI-IO to improve overall application performance.</li>
            <li>Advanced Parallel I/O considerations</li>
            <li>Further considerations of parallel I/O and other APIs.</li>
            <li>Being nice to Lustre</li>
            <li>Consideration of how to avoid certain situations in I/O usage that don’t specifically relate to data movement.</li>
        </ul>
        <em>Presenter: Harvey Richardson (HPE)</em>
        <br><em>Slide file: <code>/project/project_465000388/slides/HPE/11_IO_medium_LUMI.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/13_IO_Optimization.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>11:40</td>
        <td><b>Exercises</b>
        </td>
    </tr>
    <tr>
        <td>12:10</td>
        <td><em>lunch break</em>
        </td>
    </tr>
    <tr>
        <td>13:30</td>
        <td>Introduction to AMD ROCm<sup>TM</sup> ecosystem<br/>
        <em>Presenter: George Markomanolis (AMD)</em>
        <br><em><a href="https://462000265.lumidata.eu/4day-20230214/files/01_introduction_amd_rocm.pdf">Slides for download (PDF)</a></em>
        <br><em>Recording: <code>/project/project_465000388/recordings/14_Introduction_AMD_ROCm.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>14:30</td>
        <td><b>Exercises</b>
        <br><em><a href="https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA">Notes and exercises AMD</a></em>
        </td>
    </tr>
    <tr>
        <td>15:00</td>
        <td><em>break</em>
        </td>
    <tr>
        <td>15:30</td>
        <td>AMD Debugger: ROCgdb<br/>
        <em>Presenter: Bob Robey (AMD)</em>
        <br><em><a href="https://462000265.lumidata.eu/4day-20230214/files/02_Rocgdb_Tutorial.pdf">Slides for download (PDF)</a></em>
        <br><em>Recording: <code>/project/project_465000388/recordings/15_AMD_Rocgdb_Tutorial.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>16:05</td>
        <td><b>Exercises</b>
        <br><em><a href="https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA">Notes and exercises AMD</a></em>
        </td>
    </tr>
    <tr>
        <td>16:25</td>
        <td>Introduction to Rocprof Profiling Tool<br/>
        <em>Presenter: George Markomanolis (AMD)</em>
        <br><em><a href="https://462000265.lumidata.eu/4day-20230214/files/03_intro_rocprof.pdf">Slides for download (PDF)</a></em>
        <br><em>Recording: <code>/project/project_465000388/recordings/16_Introduction_Rocprof.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>16:45</td>
        <td><b>Exercises</b>
        <br><em><a href="https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA">Notes and exercises AMD</a></em>
        </td>
    </tr>
    <tr>
        <td>17:10</td>
        <td>Open Questions & Answers (participants are encouraged to continue with exercises in case there should be no questions)
        </td>
    </tr>
    <tr>
        <td>17:30</td>
        <td><em>End of the course day</em>
        </td>
    </tr>
<!--
DAY 4
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day4"><b>DAY 4</b></a>
        </td>
    </tr>
    <tr>
        <td>09:00</td>
        <td>Introduction to Perftools
        <ul>
            <li>Overview of the Cray Performance and Analysis toolkit for profiling applications.</li>
            <li>Demo: Visualization of performance data with Apprentice2</kli>
        </ul>
        <em>Presenter: Alfio Lazzaro (HPE)</em>
        <br><em>Slide file: <code>/project/project_465000388/slides/HPE/12_introduction_to_perftools.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/17_Introduction_to_Perftools.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>09:40</td>
        <td><b>Exercises</b>
        <br><em>Info about the exercises in <code>/project/project_465000388/slides/HPE/Exercises_alldays.pdf</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>10:10</td>
        <td><em>break</em>
        </td>
    </tr>
    <tr>
        <td>10:30</td>
        <td>Advanced Performance Analysis
        <ul>
            <li>Automatic performance analysis and loop work estimated with perftools</li>
            <li>Communication Imbalance, Hardware Counters, Perftools API, OpenMP</li>
            <li>Compiler feedback and variable scoping with Reveal</li>
        </ul>
        <em>Presenter: Thierry Braconnier (HPE)</em>
        <br><em>Slide file: <code>/project/project_465000388/slides/HPE/13_advanced_performance_analysis_merged.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/18_Advanced_Performance_Analysis.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>11:25</td>
        <td><b>Exercises</b>
        <br><em>Info about the exercises in <code>/project/project_465000388/slides/HPE/Exercises_alldays.pdf</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>12:00</td>
        <td><em>lunch break (90 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>13:34</td>
        <td>Introduction to OmniTools<br/>
        (late start due to technical problems)
        <br><em>Presenter: Suyash Tandon (AMD)</em>
        <br><em><a href="https://462000265.lumidata.eu/4day-20230214/files/04_intro_omnitools_new.pdf">Slides for download (PDF)</a></em>
        <br><em>Recording: <code>/project/project_465000388/recordings/19_Introduction_to_OmniTools.mp4</code> on LUMI only.</em>
       </td>
        </td>
    </tr>
    <tr>
        <td>14:20</td>
        <td><b>Exercises</b>
        </td>
    </tr>
    <tr>
        <td>14:45</td>
        <td>Introduction do AMD Omniperf<br/>
        <em>Presenter: George Markomanolis (AMD)</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/20_Introduction_to_Omniperf.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>15:20</td>
        <td><em>break</em>
        </td>
    </tr>
    <tr>
        <td>15:40</td>
        <td>Tools in Action - An Example with Pytorch
        <br/><em>Presenter: Samuel Antao (AMD)</em>
        </td>
    </tr>
    <tr>
        <td>17:00</td>
        <td>Open Questions & Answers (participants are encouraged to continue with exercises in case there should be no questions)
        <br><em>Some examples from the presentation: <code>/pfs/lustrep1/projappl/project_465000388/slides/AMD/pytorch-based-examples</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000388/recordings/21_Tools_in_Action_Pytorch_Demo.mp4</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>17:30</td>
        <td><em>End of the course</em>
        </td>
    </tr>
</tbody>
</table>
