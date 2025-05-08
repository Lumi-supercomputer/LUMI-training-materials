# HPE and AMD profiling tools (May 7, 2025)

## Schedule

For each session, the schedule also contains a link to the page with downloadable materials and
the recordings.

- [Original schedule (PDF)](https://462000265.lumidata.eu/profiling-20250507/files/2025-05_Pre-Hackathon-Profiling-Agenda.pdf)

<table style="text-align: left;">
<tbody>
    <tr>
        <td>10:15 CEST<br/><em>11:15 EEST</em></td>
        <td><b><A href="00_Introduction/">Welcome and introduction</a></b>
        <br><em>Presenter: Gregor Decristoforo (LUST) and Jean Pourroy (HPE)</em>
        </td>
    </tr>
    <tr>
        <td>10:30 CEST<br/><em>11:30 EEST</em></td>
        <td><b><a href="01_HPE_Cray_PE_tools/">HPE Cray PE tools introduction</a></b>
        <br/><em>Presenter: Jean Pourroy and Thierry Braconnier (HPE)</em>
       </td>
    </tr>
    <tr>
        <td>12:00 CEST<br/><em>13:00 EEST</em></td>
        <td><em>lunch break (60 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>13:00 CEST<br/><em>14:00 EEST</em></td>
        <td><b><a href="02_AMD_tools/">AMD ROCm<sup>TM</sup> profiling tools</a></b>
        <br/><em>Presenter: Samuel Antao (AMD)</em>
        </td>
    </tr>
    <tr>
        <td>14:45 CEST<br/><em>15:45 EEST</em></td>
        <td><em>break (15 minutes)</em>
        </td>
    </tr>
    <tr>
        <td>15:00 CEST<br/><em>16:00 EEST</em></td>
        <td><b><A href="03_Exercises/">Hands-on with examples or own code</a></b>
        </td>
    </tr> 
    <tr>
        <td>16:30 CEST<br/><em>17:30 EEST</em></td>
        <td><em>Close</em>
        </td>
    </tr>
</tbody>
</table>

<!--
## Course organisation

-   [HedgeDoc for the bootstrapping day](https://md.sigma2.no/lumi-hackathon-profiling-spring2025?both#)
-   Project for the course: `project_465001957`
-   [Zoom link](https://cscfi.zoom.us/j/65207108811?pwd=Mm8wZGUyNW1DQzdwL0hSY1VIMDBLQT09)
-->

## Extras

-   [Links to documentation of commands on LUMI](A01-Documentation.md)

-   [Perfetto](https://perfetto.dev/), the "program" used to visualise the output of omnitrace, 
    is not a regular application but 
    [a browser application](https://ui.perfetto.dev/). Some browsers nowadays offer the option to install it on your
    system in a way that makes it look and behave more like a regular application (Chrome, Edge among others).

Some of the exercises used in the course are based on exercises or other material available in various GitHub repositories:

-   [vcopy.cpp example from the Omniperf presentation](https://raw.githubusercontent.com/AMDResearch/omniperf/main/sample/vcopy.cpp)

-   [mini-nbody from the AMD exercises](https://github.com/ROCm-Developer-Tools/HIP-Examples/tree/master/mini-nbody)
