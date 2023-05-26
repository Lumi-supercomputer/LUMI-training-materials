# Advanced Performance Analysis part 2

-   Slide file in  `/appl/local/training/peap-q-20221123/files/08_advanced_performance_analysis_part2.pdf`

-   Recording in `/appl/local/training/peap-q-20221123/recordings/08_advanced_performance_analysis_part2.mp4`


## Q&A

1.  If perftools runs on CLE/Mac/windows where can we get it/ find install instructions? 

    * Only apprentice2 and reveal are available as clients on mac/windows (basically the user interface components to interpret the collected data). These should be self-installing executables. Like `*.dmg` on a MAC.
    * You can download the apprentice install files from LUMI (look at the info box above question 23)

2.  I managed to install apprentice2 on my MAC. How can I connect to Lumi? I need to provide a password, but when connecting to Lumi via the terminal I just pass the local ssh key...
    - There is no password access enabled, you have to setup ssh in a way that it is being picked up by apprentice
    - It should work if you have a ssh config file with the hostname, username and identity file for lumi. Can you connect to lumi with just `ssh lumi`?
        - Yes, I can connect to lumi with just `ssh lumi`. However: apprentice2, open remote with host `username@lumi.csc.fi` prompts for a password


## Exercises

The exercises are in the `perftools` subdirectory.

