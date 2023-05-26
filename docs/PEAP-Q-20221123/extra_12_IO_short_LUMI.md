# Optimizing Large Scale I/O

-   Slide file in  `/appl/local/training/peap-q-20221123/files/12_IO_short_LUMI.pdf`

-   Recording in `/appl/local/training/peap-q-20221123/recordings/12_IO_short_LUMI.mp4`


## Q&A

1.  You mentioned that you are using a RAID array to have redundancy of storage (and I read RAID-6 in the slides), have you considered using the ZFS file system ? I don't know too much, but i read it could be more reliable and better performance.
    - in ZFS you also chose a RAID level. I'm not sure what is used on LUMI, and it might be different for metadata and the storage targets. You will not solve the metadata problem with ZFS though. I know H?PE supports two backend file systems for Lustre but I'm not sure which one is used on LUMI.

2.  This is really a question about the earlier session on performance tools, but I hope it's still OK to post it: I've tried using `perftools-lite`on my own code, but doing so it does not compile (it does without the modules). The linking seems to fail with 
    `WARNING: cannot acquire file status information for '-L/usr/lib64/libdl.so' [No such file or directory]`
    Is this something that has been seen before? Any tips/hints on what is going on?
    - without checking the code is hard to understand what it the problem. Do you really link with libdl.so in your compilation?
    - Yes, doing ldd on a successful compile gives `libdl.so.2 => /lib64/libdl.so.2 (0x00007f228c3b0000)` The other dl library symlinks to that one.
    - OK, the question is the line `-L/usr/lib64/libdl.so`, I wonder if you are using somewhere in the makefile
    - Yes, this is a large cmake set-up though, but cmake has `CMakeCache.txt:LIBDL_LIBRARY:FILEPATH=/usr/lib64/libdl.so`
    - Then we are hitting a situation where perftools-lite doesn't work... Try perftools, restricting to `-g `
    - OK, thanks! Will try that.


