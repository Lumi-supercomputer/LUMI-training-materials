# I/O Optimization - Parallel I/O

*Presenter: Harvey Richardson (HPE)*

-   Slides available on LUMI as:
    -   `/appl/local/training/4day-20230530/files/LUMI-4day-20230530-4_04_IO_Optimization_Parallel_IO.pdf`
    -   `/project/project_465000524/slides/HPE/14_Python_Frameworks.pdf` (temporary, for the lifetime of the project)
-   Recording available on LUMI as:
    `/appl/local/training/4day-20230530/recordings/4_04_IO_Optimization_Parallel_IO.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

## Links

-   The [ExaIO project](https://www.exascaleproject.org/research-project/exaio/) paper
    ["Transparent Asynchronous Parallel I/O Using Background Threads"](https://doi.org/10.1109/TPDS.2021.3090322).

## Q&A

2. Could you please elaborate on using HDF5. What are pros and cons compared to using raw FS? Can it improve performance on LUMI?

    - Passed to the speaker in the talk, will be in the recording.

3. I have a dataset of 5 million files ranging from several KB to tens of GB, 50 TB in total. I am looking into optimilly merging files. What is a reasonable number of files and reasonable file sizes to aim at? Would it be ok if those files will range from several KB to several TB, or shall I try to balance them by size?

    -   Passed to the speaker in the talk, will be in the recording.

4. I see that my previous question was too specific. But could you please give some general advice what is a reasonable range of file sizes on LUSTRE? And may it cause problems to work with files of several TB and of several KB at the same time in parallel (and independent) processes?

    **Answer:** The previous question was not too specific but not specific enough as the right answer depends on a lot of factors. Whether working with files of multiple TBs and files of multiple Kb's simultaneously is problematic or not also depends on how you use them and how many small files there are. I'd say that in general it may be better to organise them in a directory structure where small and big files are in different directories so that you can set optimal striping parameters for both. But then again this matters less if you use the Lustre API or the MPI I/O hints discussed in the talk when creating the large files. Then you could set the directory striping parameters to something that corresponds with the small files (there was a slide giving some hints depending on the number of files) and use the API to set a proper striping for the large files. Getting good performance from large files requires a different way of working with the files then getting good performance from small files. E.g., when I read sub-megabyte files I read them in a single operation (which may not be that important anymore with better buffering in the OS) and then process the files in-memory (for text files in C this would mean using sscanf instead of fscanf, etc.)
    
    The correct answer really depends on more details.

    
5. There are modules called `cray-hdf5-parallel` on LUMI. Does that imply the `cray-hdf5` modules do not support parallel I/O?
    - for HPD5 to get the parallel support you need the parallel version


