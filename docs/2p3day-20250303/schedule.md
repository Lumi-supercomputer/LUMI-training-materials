# Draft schedule (subject to change)

Presenters, exact time and order of the talks may still change.

<ul>
    <li><a href="#Day1">Day 1 - Intro day: Exploring LUMI</a>
    <li><a href="#Day2">Day 2 - Intro day: Running on LUMI, data on LUMI, containers on LUMI</a>
    <li><a href="#Day3">Day 3 - Advanced day 1</a>
    <li><a href="#Day4">Day 4 - Advanced day 2</a>
    <li><a href="#Day5">Day 5 - Advanced day 3</a>
</ul>

<table style="text-align: left;">
<tbody>
<!--
DAY 1
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day1"><b>DAY 1 - Monday March 3, 2025</b></a>
        </td>
    </tr>
    <tr>
        <td style="width:8em">
            09:00 CET
            <br/><em>10:00 EET</em>
        </td>
        <td><b><a href="../MI101-IntroductionCourse/">Welcome and Introduction</a></b>
        <br/><em>Presenters: Kurt Lust (LUST) and Jørn Dietze (LUST)</em>
        </td>
    </tr>
    <tr>
        <td>
            09:15 CET
            <br/><em>10:15 EET</em>
        </td>
        <td><b><a href="../M101-Architecture/">LUMI Architecture</a></b>
        <br/><em>Presenter: Emanuele Vitali (LUST)</em>
        <br/>Some insight in the hardware of LUMI is necessary to understand what
        LUMI can do and what it cannot do, and to understand how an application can
        be mapped upon the machine for optimal performance.
        </td>
    </tr>
    <tr>
        <td>
            10:10 CET
            <br/><em>11:10 EET</em>
        </td>
        <td><b><a href="../M102-CPE/">HPE Cray Programming Environment</a></b>
        <br/><em>Presenter: Kurt Lust (LUST)</em>
        <br/>As Linux itself is not a complete supercomputer operating system, many components
        that are essential for the proper functioning of a supercomputer are separate packages
        (such as the Slurm scheduler discussed on day 2) or part of programming environments. 
        It is important to understand the consequences of this, even if all you want is to simply
        run a program.
        </td>
    </tr>
    <tr>
        <td>
            11:15 CET
            <br/><em>12:15 EET</em>
        </td>
        <td><b><em>Break and networking (20 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            11:35 CET
            <br/><em>12:35 EET</em>
        </td>
        <td><b><a href="../M103-Access/">Getting Access to LUMI</a></b>
        <br/><em>Presenter: Kurt Lust (LUST)</em>
        <br/>We discuss the options to log on to LUMI and to transfer data.
        </td>
    </tr>
    <tr>
        <td>
            12:05 CET
            <br/><em>13:05 EET</em>
        </td>
        <td><b><a href="../ME103-Exercises-1/">Exercises (session #1)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            12:30 CET
            <br/><em>13:30 EET</em>
        </td>
        <td><b><em>Lunch break (60 minutesinutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            13:30 CET
            <br/><em>14:300 EET</em>
        </td>
        <td><b><a href="../M104-Modules/">Modules on LUMI</a></b>
        <br/><em>Presenter: Kurt Lust (LUST)</em>
        <br/>LUMI uses Lmod, but as Lmod can be configured in different ways, even an experienced
        Lmod user can learn from this presentation how we use modules on LUMI and how
        modules can be found.
        </td>
    </tr>
    <tr>
        <td>
            14:15 CET
            <br/><em>15:15 EET</em>
        </td>
        <td><b><a href="../ME104-Exercises-2/">Exercises (session #2)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            14:45 CET
            <br/><em>15:45 EET</em>
        </td>
        <td><b><em>Break and networking (20 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            15:05 CET
            <br/><em>16:05 EET</em>
        </td>
        <td><b><a href="../M105-SoftwareStacks/">LUMI Software Stacks</a></b>
        <br/><em>Presenter: Kurt Lust (LUST)</em>
        <br/>In this presentation we discuss how application software is made available to
        users of LUMI. For users of smaller Tier-2 clusters with large support teams compared
        to the user base of the machine, the approach taken on LUMI may be a bit unusual...
        </td>
    </tr>
    <tr>
        <td>
            16:05 CET
            <br/><em>17:05 EET</em>
        </td>
        <td><b><a href="../ME105-Exercises-3/">Exercises (session #3)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            16:30 CET
            <br/><em>17:30 EET</em>
        </td>
        <td><b><a href="../M106-Support/">LUMI Support and Documentation</a></b>
        <br/><em>Presenter: Jorik van Kemenade</em>
        <br/>Where can I find documentation or get training, and which support services are 
        available for what problems? And how can I formulate a support ticket so that I can
        get a quick answer without much back-and-forth mailing?
        </td>
    </tr>
    <tr>
        <td>
            16:55 CET
            <br/><em>17:55 EET</em>
        </td>
        <td><b><a href="../MI102-WrapUpDay1">Wrap-up of the day</a></b> 
        </td>
    </tr>
    <tr>
        <td>
            17:00 CET
            <br/><em>18:00 EET</em>
        </td>
        <td><b>Free Q&A</a></b> 
        </td>
    </tr>
    <tr>
        <td>
            17:30 CET
            <br/><em>18:30 EET</em>
        </td>
        <td><b>End of day 1</a></b> 
        </td>
    </tr>
<!--
DAY 2
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day2"><b>DAY 2 - Tuesday March 4, 2025</b></a>
        </td>
    </tr>
    <tr>
        <td style="width:8em">
            09:00 CET
            <br/><em>10:00 EET</em>
        </td>
        <td><b><a href="../MI201-IntroductionDay2">Short welcome, recap and plan for the day</a></b>
        <br/><em>Presenters: Kurt Lust</em>
        </td>
    </tr>
    <tr>
        <td>
            09:15 CET
            <br/><em>10:15 EET</em>
        </td>
        <td><b><a href="../M201-Slurm/">Slurm on LUMI</a></b>
        <br/><em>Presenter: Jorik van Kemenade</em>
        <br/>Slurm is the batch job scheduler used on LUMI. As no two Slurm configurations are
        identical, even an experienced Slurm user should have a quick look at the notes of this
        talk to understand the particular configuration on LUMI.
        </td>
    </tr>
    <tr>
        <td>
            10:45 CET
            <br/><em>11:45 EET</em>
        </td>
        <td><b><em>Break</em></b>
        </td>
    </tr>
    <tr>
        <td>
            11:05 CET
            <br/><em>12:05 EET</em>
        </td>
        <td><b><a href="../M202-Binding/">Process and Thread Distribution and Binding</a></b>
        <br/><em>Presenter: Jorik van Kemenade</em>
        <br/>To get good performance on hardware with a strong hierarchy as AMD EPYC processors and
        GPUs, it is important to map processes and threads properly on the hardware. This talk discusses
        the various mechanisms available on LUMI for this.
        </td>
    </tr>
    <tr>
        <td>
            12:05 CET
            <br/><em>13:05 EET</em>
        </td>
        <td><b><a href="../ME202-Exercises-4/">Exercises (session #4)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            12:30 CET
            <br/><em>13:30 EET</em>
        </td>
        <td><b><em>Lunch break (60 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            13:30 CET
            <br/><em>14:30 EET</em>
        </td>
        <td><b><a href="../M203-Lustre/">Using Lustre</a></b>
        <br/><em>Presenter: Emanuele Vitali</em>
        <br/>Lustre is a parallel file system and the main file system on LUMI.
        It is important to realise what the strengths and weaknesses of Lustre at the
        scale of a machine as LUMI are and how to use it properly and not disturb the
        work of other users.
        </td>
    </tr>
    <tr>
        <td>
            14:05 CET
            <br/><em>15:05 EET</em>
        </td>
        <td><b><a href="../M204-ObjectStorage/">Using object storage</a></b>
        <br/><em>Presenter: Kurt Lust</em>
        <br/>LUMI also has an object storage system. It is useful as a staging location
        to transfer data to LUMI, but some programs may also benefit from accessing the 
        object storage directly.
        </td>
    </tr>
    <tr>
        <td>
            14:50 CET
            <br/><em>15:50 EET</em>
        </td>
        <td><b><a href="../ME204-Exercises-5/">Exercises (session #5)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            15:20 CET
            <br/><em>16:20 EET</em>
        </td>
        <td><b><em>Break</em></b>
        </td>
    </tr>
    <tr>
        <td>
            15:40 CET
            <br/><em>16:40 EET</em>
        </td>
        <td><b><a href="../M205-Containers/">Containers on LUMI-C and LUMI-G</a></b>
        <br/><em>Presenter: Kurt Lust</em>
        <br/>Containers are a way on LUMI to deal with the too-many-small-files software
        installations on LUMI, e.g., large Python or Conda installations. They are also a 
        way to install software that is hard to compile, e.g., because no source code is
        available or because there are simply too many dependencies.
        </td>
    </tr>
    <tr>
        <td>
            16:50 CET
            <br/><em>17:50 EET</em>
        </td>
        <td><b><a href="../MI202-WrapUpDay2/">Wrap-up of the day</a></b>
        <br/><em>Presenter: Kurt Lust</em>
        <br/>Wrap-up of the day and an outlook towards the second part of the course.</b>
        </td>
    </tr>
    <tr>
        <td>
            17:00 CET
            <br/><em>18:00 EET</em>
        </td>
        <td><b>Free Q&A</b> 
        <br/>LUSTers stay around to answer questions.
        </td>
    </tr>
    <tr>
        <td>
            17:30 CET
            <br/><em>18:30 EET</em>
        </td>
        <td><b>End of day 2</a></b> 
        </td>
    </tr>
<!--
DAY 3
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day3"><b>DAY 3 - Wednesday March 5, 2025</b></a>
        </td>
    </tr>
    <tr>
        <td style="width:8em">
            09:00 CET
            <br/><em>10:00 EET</em>
        </td>
        <td><b><a href="../MI301-IntroductionCourse/">Welcome and Introduction course part 2</a></b>
        <br/><em>Presenters: Harvey Richardson (HPE) and Kurt Lust (LUST)</em>
        </td>
    </tr>
    <tr>
        <td style="width:8em">
            09:10 CET
            <br/><em>10:10 EET</em>
        </td>
        <td><b><a href="../M301-HPE_Cray_EX_Architecture/">LUMI Architecture, Programming and Runtime Environment</a></b>
        <br/><em>Presenter: Harvey Richardson (HPE)</em>
        <br/>Recap from the first two days of this and other LUMI intro courses: Stressing the elements from
        the LUMI architecture and programming environment that are important for the advanced part of the course.
        </td>
    </tr>
    <tr>
        <td>
            09:50 CET
            <br/><em>10:50 EET</em>
        </td>
        <td><b><a href="../M302-Compilers_and_Parallel_Programming_Models/">Overview of Compilers and Parallel Programming Models</a></b>
        <br/><em>Presenters: Harvey Richardson and Alfio Lazzaro (HPE)</em>
        <ul>
            <li>An introduction to the compiler suites available, including examples of how to get additional information about the compilation process.</li>
            <li>Cray Compilation Environment (CCE) and options relevant to porting and performance.</li>
            <li>Description of the Parallel Programming models.</li>
        </ul>
        </td>
    </tr>
    <tr>
        <td>
            10:50 CET
            <br/><em>11:50 EET</em>
        </td>
        <td><b><a href="../ME302-Exercises-6/">Exercises (session #6)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            11:20 CET
            <br/><em>12:20 EET</em>
        </td>
        <td><b><em>Break</em></b>
        </td>
    </tr>
    <tr>
        <td>
            11:40 CET
            <br/><em>12:40 EET</em>
        </td>
        <td><b><a href="../M303-Cray_Scientific_Libraries/">Cray Scientific Libraries</a></b>
        <br/><em>Presenter: Jean Pourroy (HPE)</em>
        <ul>
            <li>The Cray Scientific Libraries for CPU and GPU execution.</li>
        </ul>
        </td>
    </tr>
    <tr>
        <td>
            12:10 CET
            <br/><em>13:10 EET</em>
        </td>
        <td><b><a href="../ME303-Exercises-7/">Exercises (session #7)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            12:30 CET
            <br/><em>13:30 EET</em>
        </td>
        <td><b><em>Lunch break (60 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            13:30 CET
            <br/><em>14:30 EET</em>
        </td>
        <td><b><a href="../M304-Offload_CCE/">OpenACC and OpenMP offload with Cray Compilation Environment</a></b>
        <br/><em>Presenter: Alfio Lazzaro (HPE)</em>
        <ul>
            <li>Directive-based approach for GPU offloading execution with the Cray Compilation Environment.
        </ul>
        </td>
    </tr>
    <tr>
        <td>
            14:00 CET
            <br/><em>15:00 EET</em>
        </td>
        <td><b><a href="../M305-Porting_to_GPU/">Porting Applications to GPU</a></b>
        <br/><em>Presenter: Alfio Lazzaro (HPE)</em>
        </td>
    </tr>
    <tr>
        <td>
            14:15 CET
            <br/><em>15:15 EET</em>
        </td>
        <td><b><a href="../M306-Introduction_to_AMD_ROCm_Ecosystem/">Introduction to the AMD ROCm ecosystem and HIP</a></b>
        <br/><em>Presenter: Samuel Antão (AMD)</em>
        <ul>
            <li/> The AMD ROCm<sup>TM</sup> ecosystem
            <li/> HIP programming
        </ul>
        </td>
    </tr>
    <tr>
        <td>
            15:00 CET
            <br/><em>16:00 EET</em>
        </td>
        <td><b><a href="../ME306-Exercises-8/">Exercises (session #8)</a></b></td>
    </tr>
    <tr>
        <td>
            15:30 CET
            <br/><em>16:30 EET</em>
        </td>
        <td><b><em>Break</em></b>
        </td>
    </tr>
    <tr>
        <td>
            15:45 CET
            <br/><em>16:45 EET</em>
        </td>
        <td><b><a href="../M307-Debugging_at_Scale/">Debugging at Scale – gdb4hpc, valgrind4hpc, ATP, stat</a></b>
        <br/><em>Presenter: Thierry Braconnier (HPE)</em>
        </td>
    </tr>
    <tr>
        <td>
            16:30 CET
            <br/><em>17:30 EET</em>
        </td>
        <td><b><a href="../ME307-Exercises-9/">Exercises (session #9)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            17:00 CET
            <br/><em>18:00 EET</em>
        </td>
        <td><b>Open Questions & Answers</b>
        <br/>Participants are encouraged to continue with exercises in case there should be no questions.
        </td>
    </tr>
    <tr>
        <td>
            17:30 CET
            <br/><em>18:30 EET</em>
        </td>
        <td><b><em>End of the course day</em></b>
        </td>
    </tr>
<!--
DAY 4
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day4"><b>DAY 4 - Thursday March 6, 2025</b></a>
        </td>
    </tr>
    <tr>
        <td>
            09:00 CET
            <br/><em>10:00 EET</em>
        </td>
        <td><b><a href="../M401-Introduction_to_Perftools/">Introduction to Perftools</a></b>
        <br/><em>Presenter: Thierry Braconnier (HPE)</em>
        <ul>
            <li>Overview of the Cray Performance and Analysis toolkit for profiling applications.</li>
            <li>Demo: Visualization of performance data with Apprentice2</kli>
        </ul>
        </td>
    </tr>
    <tr>
        <td>
            09:40 CET
            <br/><em>10:40 EET</em>  
        </td>
        <td><b><a href="../ME401-Exercises-10/">Exercises (session #7)</a></b>
       </td>
    </tr>
    <tr>
        <td>
            10:10 CET
            <br/><em>11:10 EET</em>
        </td>
        <td><b><em>Break (20 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            10:30 CET
            <br/><em>11:30 EET</em>
        </td>
        <td><b><a href="../M402-Performance_Optimization_Improving_Single_Core/">Performance Optimization: Improving Single-core Efficiency</a></b>
        <br/><em>Presenter: Jean Pourroy (HPE)</em>
        </td>
    </tr>
    <tr>
        <td>
            11:00 CET
            <br/><em>12:00 EET</em>
        </td>
        <td><b><a href="../M403-Advanced_Performance_Analysis/">Advanced Performance Analysis</a></b>
        <br/><em>Presenter: Thierry Braconnier (HPE)</em>
        <ul>
            <li>Automatic performance analysis and loop work estimated with perftools</li>
            <li>Communication Imbalance, Hardware Counters, Perftools API, OpenMP</li>
            <li>Compiler feedback and variable scoping with Reveal</li>
        </ul>
       </td>
    </tr>
    <tr>
        <td>
            12:00 CET
            <br/><em>13:00 EET</em>
        </td>
        <td><b><a href="../ME403-Exercises-11/">Exercises (session #8)</a></b>
        </td>
    </tr>
   <tr>
        <td>
            12:30 CET
            <br/><em>13:30 EET</em>
        </td>
        <td><b><em>Lunch break</em></b>
        </td>
    </tr>
    <tr>
        <td>
            13:30 CET
            <br/><em>14:30 EET</em>
        </td>
        <td><b><a href="../M404-Cray_MPI_on_Slingshot/">MPI Topics on the HPE Cray EX Supercomputer</a></b>
        <br/><em>Presenter: Harvey Richardson (HPE)</em>
        <ul>
            <li>High level overview of Cray MPI on Slingshot</li>
            <li>Useful environment variable controls</li>
            <li>Rank reordering and MPMD application launch</li>
        </ul>
    </td>
    </tr>
    <tr>
        <td>
            14:15 CET
            <br/><em>15:15 EET</em>
        </td>
        <td><b><a href="../ME404-Exercises-12/">Exercises (session #12)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            14:45 CET
            <br/><em>15:45 EET</em>
        </td>
        <td><b><em>Break</em></b>
        </td>
    <tr>
        <td>
            15:00 CET
            <br/><em>16:00 EET</em>
        </td>
        <td><b><a href="../M405-AMD_ROCgdb_Debugger/">AMD Debugger: ROCgdb</a></b>
        <br/><em>Presenter: Samuel Antão (AMD)</em>
        </td>
    </tr>
    <tr>
        <td>
            15:30 CET
            <br/><em>16:30 EET</em>
        </td>
        <td><b><a href="../ME405-Exercises-13/">Exercises (session #13)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            16:00 CET
            <br/><em>17:00 EET</em>
        </td>
        <td><b><a href="../M406-Introduction_to_Rocprof_Profiling_Tool/">Introduction to ROC-Profiler (rocprof)</a></b>
        <br/><em>Presenter: Samuel Antão (AMD)</em>
        </td>
    </tr>
    <tr>
        <td>
            16:30 CET
            <br/><em>17:30 EET</em>
        </td>
        <td><b><a href="../ME406-Exercises-14/">Exercises (session #14)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            17:00 CET
            <br/><em>18:00 EET</em>
        </td>
        <td><b>Open Questions & Answers</b>
        <br/>Participants are encouraged to continue with exercises in case there should be no questions.</b>
        </td>
    </tr>
    <tr>
        <td>
            17:30 CET
            <br/><em>18:30 EET</em>
        </td>
        <td><b><em>End of the course day</em></b>
        </td>
    </tr>
<!--
DAY 5
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day5"><b>DAY 5 - Friday March 7, 2025</b></a>
        </td>
    </tr>
    <tr>
        <td>
            09:00 CET
            <br/><em>10:00 EET</em>
        </td>
        <td><b><a href="../M501-Introduction_to_Python_on_Cray_EX/">Introduction to Python on Cray EX</a></b>
        <br/><em>Presenter: Jean Pourroy (HPE)</em>
        <ul>
            <li/>Cray Python for the Cray EX
        </ul>
        </td>
    </tr>
    <tr>
        <td>
            09:20 CET
            <br/><em>10:20 EET</em>
        </td>
        <td><b><a href="../M502-IO_Optimization_Parallel_IO/">Optimizing Large Scale I/O</a></b>
        <br/><em>Presenter: Harvey Richardson (HPE)</em>
        <ul>
            <li>Introduction into the structure of the Lustre Parallel file system. </li>
            <li>Tips for optimising parallel bandwidth for a variety of parallel I/O schemes. </li>
            <li>Examples of using MPI-IO to improve overall application performance.</li>
            <li>Advanced Parallel I/O considerations</li>
            <li>Further considerations of parallel I/O and other APIs.</li>
            <li>Being nice to Lustre</li>
            <li>Consideration of how to avoid certain situations in I/O usage that don’t specifically relate to data movement.</li>
        </ul>
        </td>
    </tr>
   <tr>
        <td>
            10:00 CET
            <br/><em>11:00 EET</em>
        </td>
        <td><b><a href="../ME502-Exercises-15/">Exercises (session #15)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            10:15 CET
            <br/><em>11:15 EET</em>
        </td>
        <td><b><em>Break</em></b>
        </td>
    </tr>
    <tr>
        <td>
            10:30 CET
            <br/><em>11:30 EET</em>
        </td>
        <td><b><a href="../M503-AMD_Omnitrace/">Introduction to OmniTrace</a></b>
        <br/><em>Presenter: Samuel Antão (AMD)</em>
      </td>
        </td>
    </tr>
    <tr>
        <td>
            11:00 CET
            <br/><em>12:00 EET</em>
        </td>
        <td><b><a href="../ME503-Exercises-16/">Exercises (session #16)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            11:30 CET
            <br/><em>12:30 EET</em> 
        </td>
        <td><b><a href="../M504-AMD_Omniperf/">Introduction to Omniperf</a></b>
        <br/><em>Presenter: Samuel Antão (AMD)</em>
        </td>
    </tr>
    <tr>
        <td>
            12:00 CET
            <br/><em>13:00 EET</em> 
        </td>
        <td><b><a href="../ME504-Exercises-17/">Exercises (session #17)</a></b>
        </td>
    </tr>
     <tr>
        <td>
            12:30 CET
            <br/><em>13:30 EET</em>
        </td>
        <td><b><em>Lunch break (60 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            13:30 CET
            <br/><em>14:30 EET</em> 
        </td>
        <td><b><a href="../M505-Best_Practices_GPU_Optimization/">Best practices: GPU Optimization, tips & tricks / demo </a></b>
        <br/><em>Presenter: Samuel Antão (AMD)</em>
        </td>
    </tr>
    </tr>
     <tr>
        <td>
            15:00 CET
            <br/><em>16:00 EET</em> 
        </td>
        <td><b>Open Questions & Answers</b>
        <br/>Participants are encouraged to continue with exercises in case there should be no questions.
        </td>
    </tr>
    <tr>
        <td>
            15:30 CET
            <br/><em>16:30 EET</em> 
        </td>
        <td><b><em>End of the course</em></b>
        </td>
    </tr>
</tbody>
</table>


