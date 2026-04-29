# Exercises 2: Modules on LUMI

<!--
Exercises will be made available during the course
-->

-   [Exercises on "Modules on LUMI"](E104-Modules.md)


## Q&A


1.  Why is module keyword/spider sometimes freezing? I.e. the same search may take a few seconds or nothing happens for 5 min.
 
    -   Answered after the access lecture already: Likely it is rebuilding the cache and with too many users using 
        the filesystem in the wrong way, filesystems on LUMI have become extremely slow at times.

        And then there are cases where the filesystem as a whole also freezes and since the cache is a file, if reading that one does not work, it also freezes. But that is the same freeze that you sometimes notice when saving a file in an editor. Basically when a switch fails Lustre sometimes freezes for a moment and with 900 switches in the system this does happen more often than we like.


