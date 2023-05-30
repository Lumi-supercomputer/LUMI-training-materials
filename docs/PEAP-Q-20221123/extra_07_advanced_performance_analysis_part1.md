# Advanced Performance Analysis part 1

-   Slide file in  `/appl/local/training/peap-q-20221123/files/07_advanced_performance_analysis_part1.pdf`

-   Recording in `/appl/local/training/peap-q-20221123/recordings/07_advanced_performance_analysis_part1.mp4`


## Q&A

1.  I downloaded and installed "Apprentice2" under Windows. Even if I am able to connect to LUMI via SSH, I am not able to open a remote folder with Apprentice2 (connection failed). Is it something special to configure (I added the ssh keys to pageagent and also added a LUMI section in my ~/.ssh/config)?

    - I think you will have to copy the files to the laptop as Windows has no concept of a generic ssh setup for a user as far as I know.
    - **Kurt** I'd have to check when I can get access to a Windows machine (as my work machine is macOS), but Windows 10 and 11 come with OpenSSH and can use a regular config file in the .ssh subdirectory. And that could allow to define an alias with a parameter that points to the keu file. Windows 10 and 11 also have a built-in ssh agent equivalent that Windows Open?SSH can use. 


