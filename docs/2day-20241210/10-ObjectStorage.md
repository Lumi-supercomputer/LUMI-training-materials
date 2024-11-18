# LUMI-O object storage

## Why do I kneed to know this?

<figure markdown style="border: 1px solid #000">
  ![Slide Why know...](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/WhyKnow.png){ loading=lazy }
</figure>


## What is LUMI-O?

<figure markdown style="border: 1px solid #000">
  ![Slide What is LUMI-O (1)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOWhatIs_1.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![Slide What is LUMI-O (2)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOWhatIs_2.png){ loading=lazy }
</figure>

<!-- BELGIUM 
LUMI-O is an object storage system (based on Ceph). 
It is similar to a system that CSC, the company operating LUMI, built for users of Finland
and is known there as Allas, though LUMI doesn't provide all the functionality of Allas.
-->

<!-- GENERAL More general version -->
LUMI-O is an object storage system (based on Ceph). Users from Finland may be familiar with 
Allas, which is similar to the LUMI object storage system, though LUMI doesn't provide all
the functionality of Allas.

Object file systems need specific tools to access data. They are usually not mounted as a regular
filesystem (though some tools can make them appear as a regular file system) and accessing them
needs authentication via temporary keys that are different from your ssh keys and are not only
bound to you, but also to the project for which you want to access LUMI-O. So if you want to use
LUMI-O for multiple projects simultaneously, you'll need keys for each project.

Object storage is not organised in files and directories. A much flatter structure is used with buckets
that contain objects:

-   **Buckets**: Containers used to store one or more objects. Object storage uses a flat structure with 
   only one level which means that buckets cannot contain other buckets.

-   **Objects**: Any type of data. An object is stored in a bucket.

-   **Metadata**: Both buckets and objects have metadata specific to them. The metadata of a bucket specifies, 
    e.g., the access rights to the bucket. While traditional file systems have fixed metadata (filename, 
    creation date, type, etc.), an object storage allows you to add custom metadata.

Objects can be served on the web also. This is in fact how recordings of some of the LUST
courses are served currently. However, LUMI-O is not meant to be used as a data publishing
service and is not an alternative to services provided by, e.g., EUDAT or several local
academic service providers.

The object storage can be easily reached from outside LUMI also. In fact, during
downtimes, LUMI-O is often still operational as its software stack is managed completely
independently from LUMI. It is therefore also very well suited as a mechanism for data
transfer to and from LUMI. Moreover, tools for object storage often perform much better
on high latency long-distance connections than tools as `sftp`.

LUMI-O is based on the [Ceph object file system](https://ceph.io/en/). 
It has a total capacity of 30 PB. 
Storage is persistent for the duration of a project.
Projects get a quota of 150 TB and can create up to 1K buckets and 500K objects per
bucket. These quota are currently fixed and cannot be modified.
Storage on LUMI-O is billed at 0.5 TB·hour per TB per hour, half that of
/scratch or /project. It can be a good alternative to store data from your project
that still needs to be transferred but is not immediately needed by jobs, or to
maintain backups on LUMI yourself.


## Lustre versus LUMI-O

Or: What are the differences between a parallel filesystem and object storage?

<figure markdown style="border: 1px solid #000">
  ![Slide Lustre vs LUMI-O (1)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LustreVsLUMIO_1.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![Slide Lustre vs LUMI-O (2)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LustreVsLUMIO_2.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![Slide Lustre vs LUMI-O (3)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LustreVsLUMIO_3.png){ loading=lazy }
</figure>


## Accessing LUMI-O: General principles

<figure markdown style="border: 1px solid #000">
  ![Slide Accessing LUMI-O](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOAccessing.png){ loading=lazy }
</figure>

Access to LUMI-O is based on temporary keys that need to be generated via a web interface
(though there may be alternatives in the future).

There are currently three command-line tools pre-installed on LUMI: 
[rclone](https://docs.lumi-supercomputer.eu/storage/lumio/#rclone)
(which is the easiest tool if you want public and private data), 
[s3cmd](https://docs.lumi-supercomputer.eu/storage/lumio/#s3cmd) 
and [restic](https://docs.lumi-supercomputer.eu/storage/lumio/#restic).

But you can also access LUMI-O with similar tools from outside LUMI. Configuring them
may be a bit tricky and the LUMI User Support Team cannot help you with each and every client
tool on your personal machine. However, the web interface that is used to generate the keys,
can also generate code snippets or configuration file snippets for various tools, and
that will make configuring them a lot easier.

In the future access via Open OnDemand should also become possible.



### Credential management web interface

<figure markdown style="border: 1px solid #000">
  ![Slide Credential management web interface](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialWebOverview.png){ loading=lazy }
</figure>

Keys are generated via a web interface that can be found at
[auth.lumidata.eu](https://auth.lumidata.eu).
In the future it should become possible to do so directly in the Open OnDemand interface,
and may even from the command line.

Let's walk through the interface:

!!! Demo "A walk through the credentials management web interface of LUMI-O"
    After entering the URL [auth.lumidata.eu](https://auth.lumidata.eu), you're presented
    with a welcome screen on which you have to click the "Go to login" button.

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface (1)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebCreate_01.png){ loading=lazy }
    </figure>

    This will present you with the already familiar (from Open OnDemand) screen to select
    your authentication provider:

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface (2)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebCreate_02.png){ loading=lazy }
    </figure>

    Proceed with login in through your relevant authentication provider (not shown here)
    and you will be presented with a screen that show your active projects:

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface (3)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebCreate_03.png){ loading=lazy }
    </figure>

    Click the project for which you want to generate a key, and the column to the right will appear.
    Chose how long the key should be valid (1 week or 168 hours is the maximum currently, but the
    life can be extended) and a description for the key. The latter is useful if you generate multiple
    keys for different use. E.g., for security reasons you may want to use different keys from different
    machines so that one machine can be disabled quickly if the machine would be compromised or stolen.

    Next click on the "Generate key" button, and a new key will appear in the "Available keys" section:

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface (4)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebCreate_04.png){ loading=lazy }
    </figure>

    Now click on the key to get more information about the key: 

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface (5)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebCreate_05.png){ loading=lazy }
    </figure>

    At the top of the screen you see three elements that will be important if you use the LUMI command line tool
    `lumio-conf` to generate configuration files for `rclone` and `s3cmd`: the project number (but you knew that one),
    the "Access key" and "Secret key".

    Scrolling down a bit more:

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface: Extending the life span of a key](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebExtend.png){ loading=lazy }
    </figure>

    The "Extend key" field can be used to extend the life of the key, to a maximum of 168 hours past the current time.

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface: Configuring tools (1)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebToolConfig_01.png){ loading=lazy }
    </figure>

    The "Configuration templates" is the way to generate code snippets or configuration file snippets for various tools
    (see the list on the slide). After selecting "rclone" and clicking the "Generate" button, a new screen opens:

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface: Configuring tools (2)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebToolConfig_02.png){ loading=lazy }
    </figure>

    This screen shows us the snippet for the rclone configuration file (on Linux it is
    `~/.config/rclone/rclone.conf`). Notice that it creates to so-called endpoints. In the slide
    this is `lumi-465001102-private` and `lumi-465001102-public`, for storing buckets and objects which are private
    or public (i.e., also web-accessible).


### Credential management through Open OnDemand

<figure markdown style="border: 1px solid #000">
    ![Slide Credentials management through Open OnDemand (1)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsOODCreate_01.png){ loading=lazy }
</figure>



## Configuring LUMI-O tools through a command line interface

<figure markdown style="border: 1px solid #000">
  ![Slide Configuring LUMI-O tools](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCLIToolConfig.png){ loading=lazy }
</figure>

On LUMI, you can use the `lumnio-conf` tool to configure `rclone` and `s3cmd`. 
To access the tool, you need to load the `lumio` module first, which is always available.
The same module will also load a module that makes `rclone`, `s3cmd` and `restic` available.

Whe starting `lumio-conf`, it will present with a couple of questions: The project number
associated with the key, the access key and the secret key. We have shown above where in the web
interface that information can be found. A future version may or may not be more automatic.
As we shall see in the next slide, currently the `rclone` configuration generated by this tool
is (unfortunately) different from the one generated by the web interface.

Another way to configure tools for object storage access is simply via the code snippets
and configuration files snippets as has already been discussed before. The same snippets 
should also work when you run the tools on a different computer.


### Remark: rclone configurations on LUMI-O

<figure markdown style="border: 1px solid #000">
  ![Slide rclone on LUMI-O](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCLIToolConfigRclone.png){ loading=lazy }
</figure>

The `rclone` configuration file for LUMI-O contains two end points, and unfortunately at the moment
both ways discussed on the previous slide, produce different end points.

-   When using `lumio-conf`, you'll get:
    -   `lumi-o` as the end point for buckets and object that should be private, i.e., not publicly
        accessible via the web interface, and
    -   `lumi-pub` for buckets and objects that should be publicly accessible. It does appear to be
        possible to have both types in a single bucket though.
-   When using the web generator you get specific end points for each project, so it is possible
    to access data from multiple projects simultaneously from a single configuration file:
    - `lumi-46YXXXXXX-private` is the end point to be used for buckets and objects that should be private, and
    - `lumi-46YXXXXXX-public` is the end point for data that should be publicly accessible.


## Tips & tricks

<figure markdown style="border: 1px solid #000">
  ![Slide Tips & tricks](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/TipsAndTricks_01.png){ loading=lazy }
</figure>


A description of the main `rclone` commands is outside the scope of this tutorial, but some options
are discussed in [the LUMI documentation](https://docs.lumi-supercomputer.eu/storage/lumio/#rclone),
and the same page also contains some documentation for `s3cmd` and `restic`. See the links below
for even more documentation.


## Further LUMI-O documentation

-   [Documentation for the LUMI-O object storage service](https://docs.lumi-supercomputer.eu/storage/)
-   Software for LUMI-O on LUMI is provided through the
    [`lumio` module](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumio/) which
    provides the configuration tool on top of the software and the
    [`lumio-ext-tools` module](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/l/lumio-ext-tools/)
    providing rclone, S3cmd and restic and links to the documentation of those tools.

    -   [rclone documentation](https://rclone.org/docs/)
    -   [S3cmd tools usage](https://s3tools.org/usage)
    -   [restic documentation](https://restic.readthedocs.io/en/latest/)





