# Schedule proposal 3, with separate talk on LUMI-O and support talk on day 1.

## Themes

<ul>
    <li/><a href="#Day1">Day 1</a>: Exploring LUMI from the login nodes and web interface
    <li/><a href="#Day2">Day 2</a>
        <ul>
            <li/>Running jobs efficiently
            <li/>Storing data on LUMI: Lustre parallel file system and object storage
            <li/>Containers on LUMI-C and LUMI-G (with some attention to AI)
        </ul>
</ul>


## Schedule

<ul>
    <li/><a href="#Day1">Day 1</a>
    <li/><a href="#Day2">Day 2</a>
</ul>

<table style="text-align: left;">
<tbody>
<!--
DAY 1
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day1"><b>DAY 1 - 10 December 2024</b></a>
        </td>
    </tr>
    <tr>
        <td style="width:8em">
            09:00 CET
            <br/><em>10:00 EET</em>
        </td>
        <td><b><a href="../MI01-IntroductionCourse/">Welcome and Introduction</a></b>
        <!--<br/><em>Presenters: Kurt Lust (LUST) and Jørn Dietze (LUST)</em>-->
        </td>
    </tr>
    <tr>
        <td>
            09:15 CET
            <br/><em>10:15 EET</em>
        </td>
        <td><b><a href="../M01-Architecture/">LUMI Architecture</a></b>
        <!--<br/><em>Presenter: Kurt Lust (LUST)</em>-->
        <br/>Some insight in the hardware of LUMI is necessary to understand what
        LUMI can do and what it cannot do, and to understand how an application can
        be mapped upon the machine for optimal performance.
        </td>
    </tr>
    <tr>
        <td>
            10:00 CET
            <br/><em>11:00 EET</em>
        </td>
        <td><b><a href="../M02-CPE/">HPE Cray Programming Environment</a></b>
        <!--<br/><em>Presenter: Kurt Lust (LUST)</em>-->
        <br/>As Linux itself is not a complete supercomputer operating system, many components
        that are essential for the proper functioning of a supercomputer are separate packages
        (such as the Slurm scheduler discussed on day 2) or part of programming environments. 
        It is important to understand the consequences of this, even if all you want is to simply
        run a program.
        </td>
    </tr>
    <tr>
        <td>
            11:00 CET
            <br/><em>12:00 EET</em>
        </td>
        <td><b><em>Break (30 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            11:20 CET
            <br/><em>12:20 EET</em>
        </td>
        <td><b><a href="../M03-Access/">Getting Access to LUMI</a></b>
        <!--<br/><em>Presenter: Kurt Lust (LUST)</em>-->
        <br/>We discuss the options to log on to LUMI and to transfer data.
        </td>
    </tr>
    <tr>
        <td>
            11:50 CET
            <br/><em>12:50 EET</em>
        </td>
        <td><b><a href="../ME03-Exercises-1/">Exercises (session #1)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            12:20 CET
            <br/><em>13:20 EET</em>
        </td>
        <td><b><em>Lunch break (55 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            13:15 CET
            <br/><em>14:15 EET</em>
        </td>
        <td><b><a href="../M04-Modules/">Modules on LUMI</a></b>
        <!--<em>Presenter: Kurt Lust (LUST)</em>-->
        LUMI uses Lmod, but as Lmod can be configured in different ways, even an experienced
        Lmod user can learn from this presentation how we use modules on LUMI and how
        modules can be found.
        </td>
    </tr>
    <tr>
        <td>
            13:55 CET
            <br/><em>14:55 EET</em>
        </td>
        <td><b><a href="../ME04-Exercises-2/">Exercises (session #2)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            14:15 CET
            <br/><em>15:15 EET</em>
        </td>
        <td><b><em>Break (20 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            14:35 CET
            <br/><em>15:35 EET</em>
        </td>
        <td><b><a href="../M05-SoftwareStacks/">LUMI Software Stacks</a></b>
        <!--<br/><em>Presenter: Kurt Lust (LUST)</em>-->
        <br/>In this presentation we discuss how application software is made available to
        users of LUMI. For users of smaller Tier-2 clusters with large support teams compared
        to the user base of the machine, the approach taken on LUMI may be a bit unusual...
        </td>
    </tr>
    <tr>
        <td>
            15:35 CET
            <br/><em>16:35 EET</em>
        </td>
        <td><b><a href="../ME05-Exercises-3/">Exercises (session #3)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            15:55 CET
            <br/><em>16:55 EET</em>
        </td>
        <td><b><a href="../M06-Support/">LUMI Support and Documentation</a></b>
        <!--<em>Presenter: Kurt Lust (LUST)</em>-->
        <br/>Where can I find documentation or get training, and which support services are 
        available for what problems? And how can I formulate a support ticket so that I can
        get a quick answer without much back-and-forth mailing?
        </td>
    </tr>
    <tr>
        <td>
            16:25 CET
            <br/><em>17:25 EET</em>
        </td>
        <td><b><a href="../MI02_WrapUpDay1">Wrap-up of the day</a></b> 
        </td>
    </tr>
    <tr>
        <td>
            16:30 CET
            <br/><em>17:30 EET</em>
        </td>
        <td><b>Free Q&A</a></b>
        <br/>LUSTers stay onlLine to answer further questions
        </td>
    </tr>
    <tr>
        <td>
            17:00 CET
            <br/><em>18:00 EET</em>
        </td>
        <td><b>End of day 1</a></b> 
        </td>
    </tr>
<!--
DAY 2
-->
    <tr>
        <td colspan="2" align="center">
            <a name="Day2"><b>DAY 2 - 11 December 2024</b></a>
        </td>
    </tr>
    <tr>
        <td style="width:8em">
            09:00 CET
            <br/><em>10:00 EET</em>
        </td>
        <td><b><a href="../MI03-IntroductionDay2">Short welcome, recap and plan for the day</a></b>
        <!--<br/><em>Presenters: Kurt Lust (LUST) and Jørn Dietze (LUST)</em>-->
        </td>
    </tr>
    <tr>
        <td>
            09:15 CET
            <br/><em>10:15 EET</em>
        </td>
        <td><b><a href="../M07-Slurm/">Slurm on LUMI</a></b>
        <!--<br/><em>Presenter: Kurt Lust (LUST)</em>-->
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
        <td><b><em>Break (20 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            11:05 CET
            <br/><em>12:05 EET</em>
        </td>
        <td><b><a href="../M08-Binding/">Process and Thread Distribution and Binding</a></b>
        <!--<br/><em>Presenter: Kurt Lust (LUST)</em>-->
        <br/>To get good performance on hardware with a strong hierarchy as AMD EPYC processors and
        GPUs, it is important to map processes and threads properly on the hardware. This talk discusses
        the various mechanisms available on LUMI for this.
        </td>
    </tr>
    <tr>
        <td>
            12:00 CET
            <br/><em>13:00 EET</em>
        </td>
        <td><b><a href="../ME08-Exercises-4/">Exercises (session #4)</a></b>
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
            13:25 CET
            <br/><em>14:25 EET</em>
        </td>
        <td><b><a href="../M09-Lustre/">Using Lustre</a></b>
        <!--<em>Presenter: Kurt Lust (LUST)</em>-->
        <br/>Lustre is a parallel file system and the main file system on LUMI.
        It is important to realise what the strengths and weaknesses of Lustre at the
        scale of a machine as LUMI are and how to use it properly and not disturb the
        work of other users.
        </td>
    </tr>
    <tr>
        <td>
            13:55 CET
            <br/><em>14:55 EET</em>
        </td>
        <td><b><a href="../M10-ObjectStorage/">Using object storage</a></b>
        <!--<em>Presenter: Kurt Lust (LUST)</em>-->
        <br/>LUMI also has an object storage system. It is useful as a staging location
        to transfer data to LUMI, but some programs may also benefit from accessing the 
        object storage directly.
        </td>
    </tr>
    <tr>
        <td>
            14:25 CET
            <br/><em>15:25 EET</em>
        </td>
        <td><b><a href="../ME10-Exercises-5/">Exercises (session #5)</a></b>
        </td>
    </tr>
    <tr>
        <td>
            14:45 CET
            <br/><em>15:45 EET</em>
        </td>
        <td><b><em>Break (20 minutes)</em></b>
        </td>
    </tr>
    <tr>
        <td>
            15:05 CET
            <br/><em>16:05 EET</em>
        </td>
        <td><b><a href="../M11-Containers/">Containers on LUMI-C and LUMI-G</a></b>
        <!--<em>Presenter: Kurt Lust (LUST)</em>-->
        <br/>Containers are a way on LUMI to deal with the too-many-small-files software
        installations on LUMI, e.g., large Python or Conda installations. They are also a 
        way to install software that is hard to compile, e.g., because no source code is
        available or because there are simply too many dependencies.
        </td>
    </tr>
    <tr>
        <td>
            16:05 CET
            <br/><em>17:05 EET</em>
        </td>
        <td><b><a href="../MI04-WhatElse/">What Else?</a></b>
        <br/>A brief discussion about what else LUST offers, what is not covered in this course,
        and how you can learn about it.</b>
        <!--<em>Presenter: Kurt Lust (LUST)</em>-->
        </td>
    </tr>
    <tr>
        <td>
            16:15 CET
            <br/><em>17:15 EET</em>
        </td>
        <td><b>Free Q&A</b> 
        <br/>LUSTers stay around to answer questions.
        </td>
    </tr>
    <tr>
        <td>
            16:45 CET
            <br/><em>17:45 EET</em>
        </td>
        <td><b>End of day 2</a></b> 
        </td>
    </tr>
</tbody>
</table>
