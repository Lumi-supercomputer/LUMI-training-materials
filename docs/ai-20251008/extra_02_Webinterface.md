# Using the LUMI web interface

*Presenters:* Mats Sjöberg (CSC) and Oskar Taubert (CSC)

Content:

-   Introduction to the Open OnDemand web interface
-   Using PyTorch in JupyterLab on LUMI
-   Limitations of the web-based interactive interface and the CLI interface
  
<!--
A video recording will follow.
-->

<!--
<video src="https://462000265.lumidata.eu/ai-20251008/recordings/02_Webinterface.mp4" controls="controls"></video>
-->


## Extra materials

<!--
More materials will become available during and shortly after the course
-->
  
-   [Presentation slides](https://462000265.lumidata.eu/ai-20251008/files/LUMI-ai-20251008-02-Using_LUMI_web_UI.pdf)

-   [Hands-on exercises](E02_Webinterface.md)

-   [Direct link to the LUMI web interface](https://www.lumi.csc.fi/)


## Q&A

1.  Is it possible to use the built-in interactive breakpoint debugging features of IDEs like VS Code while running a model on LUMI interactively?

    -   VSCode and *most* of its features work either through the web app or with the normal remote features.

    How to set the debugging feature to work interactively? I remember I tried, but didn't manage to.
    
    -   Frankly, in LUST, we don't use it ourselves so we cannot really help you here.

    -   Note also that VSCode was never meant to be an HPC debugger. For debugging applications on LUMI, there are better choices that we discuss in other courses. 
  
    Any links to tutorials on how to set it to work?
    
    -   [These are the materials of a course done with HPE and AMD about their tools](https://lumi-supercomputer.github.io/advanced-latest) (and the current latest edition was actually in the same room where this course is taking place)
        
    -   (Alfio, HPE) There is a 
        [VSCode plugin to run gdb4hp](https://cpe.ext.hpe.com/docs/24.07/debugging-tools/gdb4hpc/guides/vscode-plugin.html). 
        I've not tried on LUMI though, the documentation is for CPE 24.07 (while LUMI has 24.03). 
        General documentation on gdb4hpc can be found on 
        [the CPE documentation web site](https://cpe.ext.hpe.com/docs/24.07/debugging-tools/gdb4hpc/guides/getting-started.html) 
        (and the other webpages are showing examples, e.g. 
        [this page on Python debugging](https://cpe.ext.hpe.com/docs/24.07/debugging-tools/gdb4hpc/guides/python-extension.html).

    Anything straight forward directly used to debug existing python scripts? The links look like are more for C.
    
    -   See [my last example](https://cpe.ext.hpe.com/docs/24.07/debugging-tools/gdb4hpc/guides/python-extension.html).
        Actually, the page mentions a "python" mode, see 
        [the "python" command on the man page of gdb4hpc](https://cpe.ext.hpe.com/docs/24.07/debugging-tools/gdb4hpc/man/help.html#python).
        Still, I'm not sure this is available on the version installed on LUMI...

2.  Can I use interactive features and build a UI with tools like Gradio or Streamlit while running on LUMI?
 
    -   In principle, yes.

    -   In practice though, it is a good idea to fully decouple anything graphical from computations. 
        Running a GUI app remotely is always painful due to network delays. 
        LUMI really is not a good graphical workstation. In many cases, you'll be happier running the 
        GUI pre- and postprocessing on a machine closer to where you are.

        You have to use either a web browser or VNC client that connects to a VNC server on LUMI 
        (which is also what the desktop app uses under the hood) so all you see are really a 
        sequence of compressed images sent over the network, with some lag possible in 
        mouse pointer movements etc. When using such interfaces, you really feel how slow light is...

