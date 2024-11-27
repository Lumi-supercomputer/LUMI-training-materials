# Loading training data on LUMI

*Presenter:* Harvey Richardson (HPE)

<!--
<video src="https://462000265.lumidata.eu/ai-20241126/recordings/10_TrainingData.mp4" controls="controls"></video>
-->

## Extra materials

-   [Presentation slides](https://462000265.lumidata.eu/ai-20241126/files/LUMI-ai-20241126-10-Training_Data_on_LUMI.pdf)

-   Links from the "More Information" slide:

    -   [LUMI-O in the LUMI documentation](https://docs.lumi-supercomputer.eu/storage/lumio/)

    -   [Generic Tutorial on reading large datasets](https://www.kaggle.com/code/rohanrao/tutorial-on-reading-large-datasets)

    -   [Best Practice for Data Formats in Deep Learning (SURF)](https://servicedesk.surf.nl/wiki/display/WIKI/Best+Practice+for+Data+Formats+in+Deep+Learning)

    -   [Ray data loading](https://docs.ray.io/en/latest/train/user-guides/data-loading-preprocessing.html)

    -   [Pytorch Tutorial on pre-defined datasets/dataloaders](https://pytorch.org/tutorials/beginner/basics/data_tutorial.html)

    -   Example of keeping training data in memory: 
        [“Scaling Out Deep Learning Convergence Training on LUMI”, Diana Moise & Samuel Antao](https://linklings.s3.amazonaws.com/organizations/pasc/pasc23/submissions/stype119/jvCyu-msa152s2.pdf)


## Nice-to-knows

### LUMI-O

Two nice things to know about LUMI-O

-   We actually use it during this course to serve you the slides and the videos. Though it is not meant to be a web server.

-   As the LUMI-O software is done by a different team at CSC and not by HPE, it is often still up when LUMI is down. We cannot give a guarantee, but when a long downtime is announced, in the past LUMI-O was still available almost the whole downtime. So you may still be able to access data on LUMI-O, but not on the Lustre file systems when LUMI is down for maintenance.

But it is not meant for long-time data archiving. Storage on LUMI-O also disappears 90 days after your project ends. For long-term archiving and data publishing you need to use specialised services.

## Auto-cleanup of /scratch and /flash

Clean-up is not yet implemented on LUMI because until now there hasn't been a need to do so as the storage is empty enough.

The limited size of /project is also because CSC wants to avoid that LUMI is used for long-term data storage.

The idea is indeed that data is stored longtime on LUMI-O and transported to /scratch or /flash as needed as the assumption was that the whole dataset is rarely needed at the same time.

Note that asking for more quota doesn't make sense if your project doesn't have the necessary storage billing units.
Storing 20TB for one year on /scratch or /project would cost you 175,200 TB hours, so make sure you have enough storage
billing units. There is enough storage on LUMI that resource allocators can grant decent amounts of storage, but it is
not infinite. LUST cannot grant you storage billing units, that is something you need to negotiate with the instance that granted you your project on LUMI.


## Q&A

1.  What would be the preferred way to manage concurrent writing to the same file on the shared FS? Say I have a big inference job, and I want to flush the predictions to disk without keeping them in memory. One possible (naive) solution is to assign separate files to each process and then concatenate them when the inference is done. But this has the downside to require more storage than necessary, if we would be able to save such predictions to the same file. I have tried using Dask, but Dataframe support for GPU is limited to NVIDIA GPUs, unless we recompile it ourselves.

    -   Usually using a single data container to be accessed by different processes, potentially from different nodes, perform best if one sets some sort of stripping in Lustre FS for the folder where that file resides. It will cause that file to be chunked over different FS servers (details on this would be given in the talk before lunch) which means you can have each node writting/reading to/from different I/O servers, maximizing I/O BW. Specialised containers, like HDF5, also offer mechanisms to coordinate the reads and writes from different processes - a given process can read a piece of data (from FS - slower) and pass it to some other process over MPI ( node-tonode - faster). These containers will benefit of proper stripping as well.

    -   On DataFrame, I understand there is support for that in the workings for AMD GPUs, I'll try to know more.

    (User) I guess my question was more about how to avoid race conditions and data mangling with multiple processes, rather than maximizing the available resources. A possibility I found was to manually set up queues and locks, but this has the unfortunate downside that as the world size increases, more time will be waited by each process to write to the file. I was hoping more for a plug and play solution at higher level that manages distributed writing (i.e. Dask, possibly Ray or similar). 

    -   I guess that, regardless of the framework, they will handle the races for you. I don't have a recomended way, I see this more understanding what your selected framework is doing. You could select any framework that "simplifies" your management and then assess performance for it. I've seen people going with Arrow, others with HDF5 (https://docs.h5py.org/en/stable/).The performance impliciations come when these frameworks write to disk and that can usually be improved with stripping. Maybe we can have a discussion on this during the upcomming I/O talk.

    -   [Harvey] Lustre uses locks to manage contention to a file and this can be slow if you end up writing to the same parts of a file and particularly if you do that from multiple clients (nodes). I think you can turn off this locking if you are managing the consisteny yourself but this is an advanced topic and we would need to discuss it further.


2.  ROCm 6.3 came out yesterday. What improvements can we expect for AI, and is there any chance to get it on LUMI?

    -   I am actually unsure if has been officially released. It has been made available for testing but the actual release should come with release notes in https://rocm.docs.amd.com/en/latest/about/release-notes.html.

    -   ROCm 6.3 has to be tested as it is getting out of expected driver support. Hopefully, it can be made available in a container to start with.

    Looks like someone at AMD has been a bit uncareful then: https://community.amd.com/t5/ai/unlocking-new-horizons-in-ai-and-hpc-with-the-release-of-amd/ba-p/726434 was picked up by a lot of press last night.


3.  Is Megatron-LM a possibility on LUMI?

    -   I think TurkuNLP group (University of Turku, Finland) and Silo AI have been using that for training large language models on LUMI. So, yes, although it might not work out-of-the-box, they might be using a version that has been ported to LUMI.

    -   Megatron-Deepspeed is supported in AMD GPUs. There are hipified version of Megatron-LM that have been succesfully hipified for LUMI.

4.  Is ONNX supported?

    -   I haven't tested it myself on LUMI, but I don't see why it wouldn't work.

    -   ONNX runtime should be supported.

5.  If we use accelerate, do we still need to set the torch thread strategy to spawn in our script?

    -   Yes


6.  Does it make sense / any advantage to using torch compile with FSDP?

    -   It's difficult to give general guidance around this. It may make sense to your application - is a matter of testing and see if it works as expected.


7.  Are "*.parquet" files supported?

    -   It should be, this is just a matter of having the right python modules installed.

    Is it ("*.parquet") causing latency in reading? Is it  a good choice to prepare the data for training?

    -   This is impossible to answer as it depends on how you access the data in the Parquet file. Each file format has strengths and weaknesses and is optimised for certain types of data and certain access patterns. In this case, it assumes that you want to access only certain columns in most accesses, but all rows. If you then access the data the other way around, row by row, it would likely be extremely slow.

