# Introduction to LUMI

*Presenters:* Gregor Decristoforo (LUST), Marlon Tobaben (CSC)

Content:

-   How LUMI differs from other clusters
-   AMD GPUs instead of NVIDIA
-   Slingshot Interconnect

<!-- A video recording will follow. -->

<video src="https://462000265.lumidata.eu/ai-20261125/recordings/LUMI-ai-20261125-01_Lumi_Introduction.mp4" controls="controls"></video>


## Extra materials

<!-- More materials will become available during and shortly after the course. -->

-   [Presentation slides](https://462000265.lumidata.eu/ai-20261125/files/LUMI-ai-20261125-01-Lumi_intro.pdf)


## Q&A

1.  What is the best way to get access to LUMI AI Factory as a startup?

    -   Good question, the best first step is to go to the following page https://lumi-ai-factory.eu and look at our services. You can just reach out to https://lumi-ai-factory.eu/contact-us/ and my colleagues will get back to you. If you are in Riga in person, I (Marlon) am happy to talk to you in person.

2.  Do people store sensitive data on LUMI, like medical information? If so, is there a particular protocol to follow, or guarantees that LUMI provides about the acess / eventual deletion of such data?
 
    -   Tor: In my experience there are very few projects with sensitive data on LUMI. Your project files are only accessible by members of your project and a very few select sysadmins but there are no real guarantees of deletion or handling of this data and the files will not be stored in a secure zone, at least not more than any regular project on LUMI

    -   The best approach would be to reach out to LUMI support describing the constraints you have. LUMI is not a Trusted Research Environment.

    -   The various documents in the [LUMI Terms and Policies](https://lumi-supercomputer.eu/termsandpolicies/)
        also contain information about this.

3.  The folder structure on my screen is Home Directory: `projappl`, `scratch` and `flash`. Not  `project`, `scratch`, `flash`? Assuming `projappl` = `project`.

    - Yes, `projappl` and `project` are synonyms

