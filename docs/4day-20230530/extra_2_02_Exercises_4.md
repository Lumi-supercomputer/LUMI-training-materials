# Exercise session 4

-   Files for the exercises are in `/project/project_465000524/exercises/HPE/day2/debugging` for the lifetime of 
    the project and only for project members.

    There are `Readme.md` files in every directory.

-   There are also more information in
    `/project/project_465000524/slides/HPE/Exercises.pdf`.

-   Permanent archive on LUMI:

    -   Exercise notes in `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.pdf`

    -   Exercises as bizp2-compressed tar file in
        `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.tar.bz2`

    -   Exercises as uncompressed tar file in
        `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-Exercises_HPE.tar`


## Q&A



1.  I am looking at the ATP exercise. The tool looks interesting, but even for the trivial program of the exercise, I get a stack trace with > 30 levels containing calls I can't make sense of (`crayTrInitBytesOn`, `do_lookup_x`, `__GI__IO_file_doallocate`). Is there a way to suppress calls to some specific libraries? Do you just ignore that output? Or do they start making sense as you get more experience with stack traces?

    **Answer** Asked the Cray people and there is really no way. You should just train your brain to neglect anything below MPI. It is not the most popular tool.

2.  How can i fix this error?

    ```
    /training/day2/debugging/ATP> stat-view atpMergedBT.dot
    Traceback (most recent call last):
      File "/opt/cray/pe/stat/4.11.13/lib/python3.6/site-packages/STATmain.py", line 73, in <module>
        raise import_exception
      File "/opt/cray/pe/stat/4.11.13/lib/python3.6/site-packages/STATmain.py", line 40, in <module>
        from STATGUI import STATGUI_main
      File "/opt/cray/pe/stat/4.11.13/lib/python3.6/site-packages/STATGUI.py", line 40, in <module>
        import STATview
      File "/opt/cray/pe/stat/4.11.13/lib/python3.6/site-packages/STATview.py", line 55, in <module>
        raise Exception('$DISPLAY is not set.  Ensure that X11 forwarding is enabled.\n')
    Exception: $DISPLAY is not set.  Ensure that X11 forwarding is enabled.
    ```
    
    **Answer** It's an X11 program so either you need an X11 server on your local PC or whatever you are using and then connect with ssh -X, but that only works well on a fast enough connection (low latency). Or you use the VNC server pRovided by the lumi-vnc module. Run
    
    ````
    module spider lumi-vnc
    module spider lumi-vnc/20230110
    ````

    for more information.
    

