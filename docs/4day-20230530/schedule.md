# Course schedule

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
            <a name="Day1"><b>DAY 1 - Tuesday 30/05</b></a>
        </td>
    </tr>
    <tr>
        <td style="width:8em">
            09:00 EEST
            <br/><em>08:00 CEST</em>
        </td>
        <td>Welcome and introduction<br>
        <em>Presenters: Emmanuel Ory (LUST), Harvey Richardson (HPE)(</em>
        <!--
        <br/><em>Recording: <code>/project/project_465000524/recordings/00_Introduction.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            09:15 EEST
            <br/><em>08:15 CEST</em>
        </td>
        <td>HPE Cray EX architecture<br/>
        <em>Presenter: Harvey Richardson (HPE)</em>
        <!--
        <br/><em>Slide files: <code>/project/project_465000524/slides/HPE/01_EX_Architecture.pdf</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/01_Cray_EX_Architecture.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            10:15 EEST
            <br/><em>09:15 CEST</em>
        </td>
        <td>Programming Environment and Modules<br/>
        <em>Presenter: Harvey Richardson (HPE)</em>
        <!--
        <br/><em>Slide files: <code>/project/project_465000524/slides/HPE/02_PE_and_Modules.pdf</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/02_Programming_Environment_and_Modules.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            10:45 EEST
            <br/><em>09:45 CEST</em>
        </td>
        <td><em>break (15 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>
            11:00 EEST
            <br/><em>10:00 CEST</em>
        </td>
        <td>Running Applications
        <ul>
            <li>Examples of using the Slurm Batch system, launching jobs on the front end and basic controls for job placement (CPU/GPU/NIC)</li> 
        </ul>
        <em>Presenter: Harvey Richardson (HPE)</em>
        <!--
        <br/><em>Slide file: <code>/project/project_465000524/slides/HPE/03_Running_Applications_Slurm.pdf</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/03_Running_Applications.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            11:20 EEST
            <br/><em>10:20 CEST</em>
        </td>
        <td><b>Exercises (session #1)</b>
        <br/><em> Exercises are in <code>/project/project_465000524/exercises/HPE</code> on LUMI only.
        </td>
    </tr>
    <tr>
        <td>
            12:00 EEST
            <br/><em>11:00 CEST</em>
        </td>
        <td><em>lunch break (90 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>
            13:30 EEST
            <br/><em>12:30 CEST</em>
        </td>
        <td>Compilers and Parallel Programming Models 
        <ul>
            <li>An introduction to the compiler suites available, including examples of how to get additional information about the compilation process.</li>
            <li>Cray Compilation Environment (CCE) and options relevant to porting and performance. CCE classic to Clang transition.</li>
            <li>Description of the Parallel Programming models.</li>
        </ul>
        <em>Presenter: Alfio Lazzaro (HPE)</em>
        <!--
        <br/><em>Slide files: <code>/project/project_465000524/slides/HPE/04_Compilers_and_Programming_Models.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000524/recordings/04_Compilers_and_Programming_Models.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            14:30 EEST
            <br/><em>13:30 CEST</em>
        </td>
        <td><b>Exercises (session #2)</b>
        </td>
    </tr>
    <tr>
        <td>
            15:00 EEST
            <br/><em>14:00 CEST</em>
        </td>
        <td><em>break (15 minutes)</em>
        <!--
        <ul>
            <li>Exercises on programming models: Try swapping compilers and some GPU programs.</li>
        </ul>
        -->
        </td>
    </tr>
    <tr>
        <td>
            15:15 EEST
            <br/><em>14:15 CEST</em>
        </td>
        <td>Cray Scientific Libraries 
        <ul>
            <li>The Cray Scientific Libraries for CPU and GPU execution.</li>
        </ul>
        <em>Presenter: Alfio Lazzaro (HPE)</em>
        <!--
        <br/><em>Slide files: <code>/project/project_465000524/slides/HPE/05_Libraries.pdf</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/05_Libraries.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            15:45 EEST
            <br/><em>14:45 CEST</em>
        </td>
        <td><b>Exercises (session #3)</b>
        </td>
    </tr>
    <tr>
        <td>
            15:15 EEST
            <br/><em>14:15 CEST</em>
        </td>
        <td>OpenACC and OpenMP offload with Cray Compilation Environment 
        <ul>
            <li>Directive-based approach for GPU offloading execution with the Cray Compilation Environment.
        </ul>
        <em>Presenter: Alfio Lazzaro (HPE)</em>
        <!--
        <br/><em>Slide file: <code>/project/project_465000524/slides/HPE/06_Directives_Programming.pdf</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/06_Directives_programming.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            17:00 EEST
            <br/><em>16:00 CEST</em>
        </td>
        <td>Open Questions & Answers (participants are encouraged to continue with exercises in case there should be no questions)
        </td>
    </tr>
    <tr>
        <td>
            17:30 EEST
            <br/><em>16:30 CEST</em>
        </td>
        <td><em>End of the course day</em>
        </td>
    </tr>
<!--
DAY 2
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day2"><b>DAY 2 - Wednesday 31/05</b></a>
        </td>
    </tr>
    <tr>
        <td>
            09:00 EEST
            <br/><em>08:00 CEST</em>
        </td>
        <td>Advanced Application Placement
        <ul>
            <li>More detailed treatment of Slurm binding technology and OpenMP controls.</li>
        </ul>
        <em>Presenter: Jean Pourroy (HPE)</em>
        <!--
        <br><em>Slide file: <code>/project/project_465000524/slides/HPE/07_Advanced_Placement.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000524/recordings/07_Advanced_Placement.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            10:00 EEST
            <br/><em>09:00 CEST</em>
        </td>
        <td><b>Exercises (session #4)</b>
        </td>
    </tr>
    <tr>
        <td>
            10:30 EEST
            <br/><em>09:30 CEST</em>
        </td>
        <td><em>break (15 minutes)</em></td>
    </tr>
    <tr>
        <td>
            10:45 EEST
            <br/><em>09:45 CEST</em>
        </td>
        <td>Debugging at Scale – gdb4hpc, valgrind4hpc, ATP, stat<br/>
        <em>Presenter: Thierry Braconnier (HPE)</em>
        <!--
        <br><em>Slide file: <code>/project/project_465000524/slides/HPE/10_debugging_at_scale.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000524/recordings/12_Debugging_at_Scale.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            11:30 EEST
            <br/><em>10:30 CEST</em>
        </td>
        <td><b>Exercises (session #5)</b></td>
    </tr>
   <tr>
        <td>
            12:00 EEST
            <br/><em>11:00 CEST</em>
        </td>
        <td><em>lunch break (90 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>
            13:30 EEST
            <br/><em>12:30 CEST</em>
        </td>
        <td>Additional software on LUMI
        <ul>
            <li>Software policy.</li>
            <li>Software environment on LUMI.</li>
            <li>Installing software with EasyBuild (concepts, contributed recipes)</li>
            <li>Containers for Python, R, VNC (container wrappers)</li>
        </ul>
        <em>Presenter: Kurt Lust (LUST)</em>
        <!--
        <br><em>Slide file: <code>/project/project_465000524/slides/LUST/LUMI-Software-20230215.pdf</code> on LUMI only.</em>
        <br><em><a href="../software_stacks">Notes available</a></em>
        <br><em>Recording: <code>/project/project_465000524/recordings/09_LUMI_Software_Stack.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            15:00 EEST
            <br/><em>14:00 CEST</em>
        </td>
        <td><em>break (15 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>
            15:30 EEST
            <br/><em>14:30 CEST</em>
        </td>
        <td>Introduction to AMD ROCm<sup>TM</sup> ecosystem<br/>
        <em>Presenter: George Markomanolis (AMD)</em>
        <!--
        <br/><em><a href="../files/01_introduction_amd_rocm.pdf">Slides for download</a></em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/14_Introduction_AMD_ROCm.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            16:30 EEST
            <br/><em>15:30 CEST</em>
        </td>
        <td><b>Exercises (session #6)</b>
        <!--
        <br/><em><a href="https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA">Notes and exercises AMD</a></em>
        -->
        </td>
    </tr>
   <tr>
        <td>
            17:00 EEST
            <br/><em>16:00 CEST</em>
        </td>
        <td>Open Questions & Answers (participants are encouraged to continue with exercises in case there should be no questions)
        </td>
    </tr>
    <tr>
        <td>
            17:30 EEST
            <br/><em>16:30 CEST</em>
        </td>
        <td><em>End of the course day</em>
        </td>
    </tr>
<!--
DAY 3
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day3"><b>DAY 3 - Thursday 01/06</b></a>
        </td>
    </tr>
    <tr>
        <td>
            09:00 EEST
            <br/><em>08:00 CEST</em>
        </td>
        <td>Introduction to Perftools
        <ul>
            <li>Overview of the Cray Performance and Analysis toolkit for profiling applications.</li>
            <li>Demo: Visualization of performance data with Apprentice2</kli>
        </ul>
        <em>Presenter: Alfio Lazzaro (HPE)</em>
        <!--
        <br/><em>Slide file: <code>/project/project_465000524/slides/HPE/12_introduction_to_perftools.pdf</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/17_Introduction_to_Perftools.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            09:40 EEST
            <br/><em>08:40 CEST</em>  
        </td>
        <td><b>Exercises (session #7)</b>
        <br><em>Info about the exercises in <code>/project/project_465000524/slides/HPE/Exercises_alldays.pdf</code> on LUMI only.</em>
        </td>
    </tr>
    <tr>
        <td>
            10:10 EEST
            <br/><em>09:10 CEST</em>
        </td>
        <td><em>break</em>
        </td>
    </tr>
    <tr>
        <td>
            10:30 EEST
            <br/><em>09:30 CEST</em>
        </td>
        <td>Advanced Performance Analysis
        <ul>
            <li>Automatic performance analysis and loop work estimated with perftools</li>
            <li>Communication Imbalance, Hardware Counters, Perftools API, OpenMP</li>
            <li>Compiler feedback and variable scoping with Reveal</li>
        </ul>
        <em>Presenter: Thierry Braconnier (HPE)</em>
        <!-- 
        <br/><em>Slide file: <code>/project/project_465000524/slides/HPE/13_advanced_performance_analysis_merged.pdf</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/18_Advanced_Performance_Analysis.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            11:30 EEST
            <br/><em>10:30 CEST</em>
        </td>
        <td><b>Exercises (session #8)</b>
        <br><em>Info about the exercises in <code>/project/project_465000524/slides/HPE/Exercises_alldays.pdf</code> on LUMI only.</em>
        </td>
    </tr>
   <tr>
        <td>
            12:00 EEST
            <br/><em>11:00 CEST</em>
        </td>
        <td><em>lunch break</em>
        </td>
    </tr>
    <tr>
        <td>
            13:15 EEST
            <br/><em>12:15 CEST</em>
        </td>
        <td>Understanding Cray MPI on Slingshot, rank reordering and MPMD launch
        <ul>
            <li>High level overview of Cray MPI on Slingshot</li>
            <li>Useful environment variable controls</li>
            <li>Rank reordering and MPMD application launch</li>
        </ul>
        <em>Presenter: Harvey Richardson (HPE)</em>
        <!--
        <br/><em>Slide file: <code>/project/project_465000524/slides/HPE/08_cray_mpi_MPMD_medium.pdf</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/08_MPI_Topics.mp4</code> on LUMI only.</em>
        -->
    </td>
    </tr>
    <tr>
        <td>
            14:15 EEST
            <br/><em>13:15 CEST</em>
        </td>
        <td><b>Exercises (session #9)</b>
        <!--
        <br><em>Info about the exercises in <code>/project/project_465000524/slides/HPE/Exercises_alldays.pdf</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            14:45 EEST
            <br/><em>13:45 CEST</em>
        </td>
        <td><em>break</em>
        </td>
    <tr>
        <td>
            15:00 EEST
            <br/><em>14:00 CEST</em>
        </td>
        <td>AMD ROCgdb debugger<br/>
        <em>Presenter: George Markomanolis (AMD)</em>
        <!--
        <br/><em><a href="../files/02_Rocgdb_Tutorial.pdf">Slides for download</a></em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/15_AMD_Rocgdb_Tutorial.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            15:30 EEST
            <br/><em>14:30 CEST</em>
        </td>
        <td><b>Exercises (session #10)</b>
        <!-- <br><em><a href="https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA">Notes and exercises AMD</a></em> -->
        </td>
    </tr>
    <tr>
        <td>
            16:00 EEST
            <br/><em>15:00 CEST</em>
        </td>
        <td>Introduction to Rocprof Profiling Tool<br/>
        <em>Presenter: George Markomanolis (AMD)</em>
        <!--
        <br><em><a href="../files/03_intro_rocprof.pdf">Slides for download</a></em>
        <br><em>Recording: <code>/project/project_465000524/recordings/16_Introduction_Rocprof.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            16:30 EEST
            <br/><em>15:30 CEST</em>
        </td>
        <td><b>Exercises (session #11)</b>
        <!-- <br><em><a href="https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA">Notes and exercises AMD</a></em> -->
        </td>
    </tr>
    <tr>
        <td>
            17:00 EEST
            <br/><em>16:00 CEST</em>
        </td>
        <td>Open Questions & Answers (participants are encouraged to continue with exercises in case there should be no questions)
        </td>
    </tr>
    <tr>
        <td>
            17:30 EEST
            <br/><em>16:30 CEST</em>
        </td>
        <td><em>End of the course day</em>
        </td>
    </tr>
<!--
DAY 4
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day4"><b>DAY 4 - Friday June 2</b></a>
        </td>
    </tr>
    <tr>
        <td>
            09:00 EEST
            <br/><em>08:00 CEST</em>
        </td>
        <td>Introduction to Python on Cray EX
        <br/><em>Presenter: Alfio Lazzaro (HPE)</em>
        <!--
        <br/><em>Slide file: <code>/project/project_465000524/slides/HPE/11_IO_medium_LUMI.pdf</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/13_IO_Optimization.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            09:15 EEST
            <br/><em>08:15 CEST</em>
        </td>
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
        <!--
        <br/><em>Slide file: <code>/project/project_465000524/slides/HPE/11_IO_medium_LUMI.pdf</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/13_IO_Optimization.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            10:15 EEST
            <br/><em>09:15 CEST</em>
        </td>
        <td><b>Exercises (session #12)</b></td>
    </tr>
    <tr>
        <td>
            10:45 EEST
            <br/><em>09:45 CEST</em>
        </td>
        <td><em>break</em>
        </td>
    </tr>
    <tr>
        <td>
            11:00 EEST
            <br/><em>10:00 CEST</em>
        </td>
        <td>Performance Optimization: Improving Single-core Efficiency
        <br/><em>Presenter: Jean Pourroy (HPE)</em>
        <!--
        <br><em>Slide file: <code>/project/project_465000524/slides/HPE/09_cpu_performance_optimization.pdf</code> on LUMI only.</em>
        <br><em>Recording: <code>/project/project_465000524/recordings/11_CPU_Performance_Optimization.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            11:45 EEST
            <br/><em>10:45 CEST</em>
        </td>
        <td><b>Exercises (session #13)</b>
        </td>
    </tr>
     <tr>
        <td>
            12:00 EEST
            <br/><em>11:00 CEST</em>
        </td>
        <td><em>lunch break (75 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>
            13:15 EEST
            <br/><em>12:15 CEST</em>
        </td>
        <td>Introduction to OmniTrace
        <br/><em>Presenter: George Markomanolis (AMD)</em>
        <!--
        <br/><em><a href="../files/04_intro_omnitools_new.pdf">Slides for download</a></em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/19_Introduction_to_OmniTools.mp4</code> on LUMI only.</em>
       -->
       </td>
        </td>
    </tr>
    <tr>
        <td>
            13:40 EEST
            <br/><em>12:40 CEST</em>
        </td>
        <td><b>Exercises (session #14)</b>
        <!-- <br><em><a href="https://hackmd.io/rhopZnwTSm2xIYM3OUhwUA">Notes and exercises AMD</a></em> -->
        </td>
    </tr>
    <tr>
        <td>
            14:00 EEST
            <br/><em>13:00 CEST</em> 
        </td>
        <td>Introduction do AMD Omniperf
        <br/><em>Presenter: George Markomanolis (AMD)</em>
        <!--
        <br/><em>Recording: <code>/project/project_465000524/recordings/20_Introduction_to_Omniperf.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            14:25 EEST
            <br/><em>13:25 CEST</em> 
        </td>
        <td><b>Exercises (session #15)</b>
        </td>
    </tr>
    <tr>
        <td>
            14:45 EEST
            <br/><em>13:45 CEST</em> 
        </td>
        <td><em>break</em>
        </td>
    </tr>
    <tr>
        <td>
            15:00 EEST
            <br/><em>14:00 CEST</em> 
        </td>
        <td>Best practices: GPU Optimization, tips & tricks / demo
        <br/><em>Presenter: Samuel Antao (AMD)</em>
        <!--
        <br/><em>Some examples from the presentation: <code>/pfs/lustrep1/projappl/project_465000524/slides/AMD/pytorch-based-examples</code> on LUMI only.</em>
        <br/><em>Recording: <code>/project/project_465000524/recordings/21_Tools_in_Action_Pytorch_Demo.mp4</code> on LUMI only.</em>
        -->
        </td>
    </tr>
    <tr>
        <td>
            16:30 EEST
            <br/><em>15:30 CEST</em> 
        </td>
        <td>LUMI support and LUMI documentation.
        <ul>
            <li>What can we help you with and what not? How to get help, how to write good support requests.</li>
            <li>Some typical/frequent support questions of users on LUMI?</li>
        </ul>
        <em>Presenters: Anne Vomm and Mihkel Tiks (LUST)</em>
        <!--
        <br><em>Recording: <code>/project/project_465000524/recordings/10_LUMI_User_Support.mp4</code> on LUMI only.</em>
        -->
    </td>
    </tr>
     <tr>
        <td>
            17:00 EEST
            <br/><em>16:00 CEST</em> 
        </td>
        <td>Open Questions & Answers (participants are encouraged to continue with exercises in case there should be no questions)
        </td>
    </tr>
    <tr>
        <td>
            17:30 EEST
            <br/><em>16:30 CEST</em> 
        </td>
        <td><em>End of the course</em>
        </td>
    </tr>
</tbody>
</table>