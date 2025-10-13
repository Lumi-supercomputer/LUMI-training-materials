# Introduction to LUMI

*Presenter:* Gregor Decristoforo (LUST)

Content:

-   How LUMI differs from other clusters
-   AMD GPUs instead of NVIDIA
-   Slingshot Interconnect

<!--
A video recording will follow.
-->

<!--
<video src="https://462000265.lumidata.eu/ai-20251008/recordings/01_Lumi_Introduction.mp4" controls="controls"></video>
-->

## Extra materials

<!--
More materials will become available during and shortly after the course
-->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-01-Lumi_intro.pdf)


## Q&A

1.  There was a question about the use of CuPy for AMD GPUs

    -   [Here's a blog discussing using python libraries like cuPy on AMD GPUs.](https://rocm.blogs.amd.com/artificial-intelligence/cupy_hipdf_portfolio_opt/README.html)

        Examples sometimes come in containers, one has to be careful the ROCm versions are compatible with the LUMI drivers. At the moment the most recent ROCm version one can aim at is 6.2.4.


1.  Question about AppTainer from the audience in the room:

    -   We use Singularity Community Edition for a reason. LUMI does not allow user name spaces or anything that requires higher privileges to run, so there are severe restrictions on building containers. Singularity Community Edition supports the so-called proot build process since version 3.11 which can be used to extend an existing container and works very well for us. AppTainer does not support this.


3. AI workshop runs several times in a year. Which one should I follow? The latest one? What are the differences?

    -   It is basically every time the same, with small updates as LUMI evolves. 

    -   What will happen next year is still unclear because there is also the LUMI AI factory and the EuroHPC Minverva project who will also organise AI training activities.

