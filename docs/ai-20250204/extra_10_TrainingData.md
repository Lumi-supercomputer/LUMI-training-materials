# Loading training data on LUMI

*Presenter:* Harvey Richardson (HPE)

A video recording will follow.

<!--
<video src="https://462000265.lumidata.eu/ai-20250204/recordings/10_TrainingData.mp4" controls="controls"></video>
-->

## Extra materials

More materials will become available during and shortly after the course

-   [Presentation slides](https://462000265.lumidata.eu/ai-20250204/files/LUMI-ai-20250204-10-Training_Data_on_LUMI.pdf)

-   Links from the "More Information" slide:

    -   [LUMI-O in the LUMI documentation](https://docs.lumi-supercomputer.eu/storage/lumio/)

    -   [Generic Tutorial on reading large datasets](https://www.kaggle.com/code/rohanrao/tutorial-on-reading-large-datasets)

    -   [Best Practice for Data Formats in Deep Learning (SURF)](https://servicedesk.surf.nl/wiki/display/WIKI/Best+Practice+for+Data+Formats+in+Deep+Learning)

    -   [Ray data loading](https://docs.ray.io/en/latest/train/user-guides/data-loading-preprocessing.html)

    -   [Pytorch Tutorial on pre-defined datasets/dataloaders](https://pytorch.org/tutorials/beginner/basics/data_tutorial.html)

    -   Example of keeping training data in memory: 
        [“Scaling Out Deep Learning Convergence Training on LUMI”, Diana Moise & Samuel Antao](https://linklings.s3.amazonaws.com/organizations/pasc/pasc23/submissions/stype119/jvCyu-msa152s2.pdf)

-   [Training materials from the most recent LUMI introductory training in December 2024](../2day-20241210/index.md)

    -   The ["LUMI-O Object Storage" talk](../2day-20241210/M10-ObjectStorage.md)
        discusses using LUMI-O and the differences with a parallel file system such as Lustre..


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

/
