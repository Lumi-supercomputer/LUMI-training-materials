# AMD Omniperf (rocprofiler-compute)

<!-- Cannot do in full italics as the ã is misplaced which is likely an mkdocs bug. -->
*Presenter: Samuel Antao (AMD)*

Course materials will be provided during and after the course.

<!--
<video src="https://462000265.lumidata.eu/2p3day-20250303/recordings/505-AMD_Omniperf.mp4" controls="controls"></video>
-->

Temporary location of materials (for the lifetime of the training project):

-   Slides: `'/project/project_465001726/Slides/AMD/session 05 - omniperf.pdf'`

Materials on the web:

-   [Slides on the web](https://462000265.lumidata.eu/2p3day-20250303/files/LUMI-2p3day-20250303-505-AMD_Omniperf.pdf)

Archived materials on LUMI:

-   Slides: `/appl/local/training/2p3day-20250303/files/LUMI-2p3day-20250303-505-AMD_Omniperf.pdf`

<!--
-   Recording: `/appl/local/training/2p3day-20250303/recordings/505-AMD_Omniperf.mp4`
-->


## Q&A


1.  Is there way to get the point values plotted on roofline if want to plot that with some different tools such as matplot lib

    -   You can get the numbers from the csv that is generated. See also the extra information here: https://rocm.docs.amd.com/projects/rocprofiler-compute/en/latest/how-to/profile/mode.html#roofline-only.

    I am interested in getting x and y co-ordinate for each kernel that is plotted. The roofline.csv file doesn't have that I? think? Which file contain that information which is used to plot roofline in PDF file generated?

    -   roofline.csv only have information about the roof lines not the kernel points. I don't know how to get that directly from the CSV files other than the PDF plots. I'll investigate and update the answer according to what I can find out.

