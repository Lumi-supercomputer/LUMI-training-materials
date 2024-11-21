# LUMI-O object storage

TODO:
*   clear up confusion key and name
*   Talk about pseudo-folders similar as in the CSC Allas documentation
*   Add OOD stuff.

## Why do I kneed to know this?

<figure markdown style="border: 1px solid #000">
  ![Slide Why know...](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/WhyKnow.png){ loading=lazy }
</figure>

Most LUMI users will be unfamiliar with object storage. 
It is a popular storage technology in the cloud, with Amazon AWS S3 as the best known example.

On LUMI, the LUMI-O object storage system is probably the best option to transfer data to and
from LUMI. Tools for object storage access often reach a much higher bandwidth than
a single sftp connection can reach.

Object storage is also a good technology if you want a backup of some of your data and
want to make that backup on LUMI itself. The object storage is completely separate from 
the regular storage of LUMI and hence offers additional security, though not as secure 
as if you would make a backup at a different compute centre.

In some research communities where cloud computing is more common, some datasets
may come in cloud-optimised formats, i.e., formats optimised for object storage.
Putting such data on the parallel file system without completely changing the 
data format is usually not a good idea.

In this section of the notes, we will discuss the properties of object storage
and show you how to get started. It is by no means meant as a reference manual
for all tools that one can use.


## In short: What is LUMI-O?

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

The object storage can be easily reached from outside LUMI also with full access 
control (and without webbrowsers). In fact, during
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


## A comparison between Lustre and LUMI-O

Or: What are the differences between a parallel filesystem and object storage?

<figure markdown style="border: 1px solid #000">
  ![Slide Lustre vs LUMI-O (1)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LustreVsLUMIO_1.png){ loading=lazy }
</figure>

<figure markdown style="border: 1px solid #000">
  ![Slide Lustre vs LUMI-O (2)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LustreVsLUMIO_2.png){ loading=lazy }
</figure>

***Integration with the system***

The Lustre parallel filesystem is very closely integrated in LUMI. In fact, it is the only
non-local filesystem that is served directly to the compute nodes. Other remote filesystems
on the Cray architecture are served via DVS, Data Virtualisation Service, a service that 
forwards requests to the actual filesystem services running on management nodes. HPE Cray
does this to minimise the number of OS daemons running in the background. Client software
on the compute and login nodes must also fairly closely match the server software on 
the actual Lustre servers. As a result of all this, the Lustre software has to be updated
with all other system software on LUMI and, e.g., the Lustre filesystems are not available
when LUMI is down for maintenance. 

The LUMI-O object storage system on the other hand, 
is a separate system, though located physically fairly close to LUMI. Its software setup
is completely independent from the software on the LUMI supercomputer itself. It has 
a regular TCP/IP connection to LUMI, but all other software to access data on LUMI-O from
LUMI runs entirely in user space. Client software also hardly depends on the version of the
Ceph server software as the protocol between both is fairly stable. As a result, upgrades
of LUMI do not affect LUMI-O and vice-versa, so LUMI-O is almost always available even when
LUMI is down. Moreover, the server software of LUMI-O can often be upgraded on-the-fly, without
noticeable downtime. Client and server also communicate through a web-based API.

***Organisation of data***

The organisation of data is also very different on Lustre and LUMI-O. 
Lustre, although very different of the local filesystem(s) on your laptop or smartphone
or more traditional networked filesystems common for networks of PCs or workstations,
uses the same organisation of data as those filesystems. Data is organised in files
stored in a hierarchical directory structure. In fact, Lustre behaves as much as possible
as other classical shared filesystems: Data written on one compute node is almost immediately
noticed on other compute nodes also. (In fact, this is also the main cause of performance
problems for some operations on Lustre.)

These files can be read, written, modified and/or appended, and deleted. So one can change 
only a fraction of the data in the file without working on the other data, and different
compute nodes can write to different parts of a file simultaneously.

The object storage system puts data as objects in buckets, and buckets are on a 
per-project basis. So there is basically a 3-level hierarchy: project, buckets and
objects, with each level just a flat space. Bucket names have to be unique within a project,
and object names have to be unique within a bucket.

Buckets cannot contain other buckets (contrary to directories which can contain other
directories). Objects are not really arranged in a hierarchy, even though some tools
make it appear as if this is the case by showing them in a directory tree-like 
structure, but this structure is really just created based on the "names" of the objects
(the correct terminology is the key of the object) and you will notice that structuring 
the objects like this in a view is actually a rather expensive operation in client software.

Objects are managed through simple atomic operations. One can put an object in the object
storage, get its content, copy an object or delete an object. But contrary to a file 
in Lustre, the object cannot be modified: One cannot simply change a part of the content,
but the object needs to be replaced with a new object.

Some tools can do multipart uploads: An large object is uploaded in multiple parts (which
can create more parallelism and hence have a higher combined bandwidth), but these parts
are actually objects by themselves that are combined in a single object at the end.
If the upload would get interrupted, the parts would actually continue to live as 
separate objects unless a suitable bucket policy is set
(and we have run into issues already with a user depleting their quota on LUMI-O with
stale objects from failed multipart uploads).

***Optimised for?***

Lustre is optimised first and for most for bandwidth to the compute nodes when doing
large file I/O operations from multiple nodes to a file. This optimisation for performance
also implies that simpler schemes for redundancy have to be used. Data is protected from
a single disk failure and on most systems even from dual disk failure, but performance
will be reduced during a disk repair action and even though the server functions are usually
done in high availability pairs, we have seen more than one case where a server pair fails
making part of the data inaccessible.

The LUMI-O object storage is much more optimised for reliability and uses a very
complicated internal redundancy scheme. On LUMI-O each object is spread over 11 so-called
storage nodes, spread over at least 6 racks, with never more than 2 storage nodes in a single
rack. As only 8 storage nodes of an object are needed to recover the data of an object, one 
can even lose an entire rack of hardware while keeping the object available.


***Access***

Lustre, as it is fully integrated in LUMI (or any other supercomputer that uses it),
has no separate authentication. You log on to LUMI and you have access to files on the
Lustre file system based on permissions: your userid and the linux group(s) that you belong to.
You will see your files as on any other POSIX file system. No external access is possible
and it depends completely on the authentication system of LUMI running and working properly.

The LUMI-O object storage works with a separate credentials-based authentication system. 
These credentials have to be created first in one of two ways that we will discus later
and they have a very finite lifetime after which they need to be regenerated (when expired)
or extended (if you do so before expiration).

In fact, in LUMI-O, projects are handled as so-called "single user tenants/accounts": 
the project numerical ID (e.g., 465000001) is both the tenant/account name and project
name. LUMI-O will not further distinguish between the users in a LUMI project. 
Hence it is definitely not an option to make a backup from your home directory in a way
that it would be secured from access by other users in your LUMI project.

LUMI-O clients and servers talk to each other via a web based API. There is a whole range
of tools for all popular operating systems that support this API, both command line tools
and GUI tools. In this world, external access is natural. 
There is really no difference in accessing LUMI-O from LUMI or from any other
internet-connected computer. It is even possible to access LUMI-O via a web browser
if such access is set up properly. It is documented in the bottom parts of the
["Advanced usage of LUI-O" page in the LUMI docs](https://docs.lumi-supercomputer.eu/storage/lumio/advanced/#sharing-data-with-other-projects).


***MDS and ODS***

Both Lustre and the Ceph object storage system work with metadata servers (MDS) and object data servers (ODS),
but this is where the similarities end. The internal organisation of MDS and ODS is 
completely different in both, but those differences are not that important at the
level of this tutorial.


***Parallelism is key to performance***

Both Lustre and LUMI-O require parallel access to get the optimal performance. How that parallelism is best organised,
is very different though.

Lustre will perform best when large accesses are made to large files by multiple processes preferably on 
multiple nodes of the supercomputer. Parallelism through accessing different files from each process will
be far less performant and may even lead to an overload on the metadata servers.

The object storage is different in that respect: As operations on objects are atomic, they should
also be accessed from a single process. But multiple processes or threads should access multiple 
objects simultaneously for optimal access. However, even in those cases the bandwidth will be 
somewhat limited as the network connection between LUMI-O and LUMI is a lot less as between
the Lustre object data servers and the LUMI compute nodes, as both are fully integrated in the
same high performance interconnect.


***Cost***

The hardware required for Lustre may not be as expensive as for some other fileservers, but a hard disk
based Lustre filesystem is still not cheap and if you want a performant flash based filesystem that can
endure a high write load also and not only a high read load, it is very expensive. The LUMI-O hardware 
is a lot cheaper, though this is also partly because it has a lower bandwidth.

The billing units accounted for storage on LUMI reflect the purchase cost per petabyte for LUMI-O and 
the Lustre filesystems, with the object storage billed at half the price of the hard disk based Lustre
filesystems and the flash based Lustre filesystem at 10 times the cost of the hard disk based one.


<figure markdown style="border: 1px solid #000">
  ![Slide Lustre vs LUMI-O (3)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LustreVsLUMIO_3.png){ loading=lazy }
</figure>

The differences between a parallel file system and object storage also translate into differences
in "file formats" between both (with "file formats" between quotes as we cannot speak about files on
the object storage). The best way of managing life data on both systems is very different.

Take as an example [netCDF](https://www.unidata.ucar.edu/software/netcdf/) versus the 
[zarr data format](https://guide.cloudnativegeo.org/zarr/intro.html). 
Both are popular in, e.g., earth and climate science.
NetCDF is a file format developed specifically with supercomputers with large parallel file systems
in mind, while zarr is a cloud-optimised technology. 
You cannot work with netCDF files from an object storage system as they would be stored as a single
object and only atomic operations are possible.
Zarr on the other hand is da format to store large-scale N-dimensional data on an object storage
system by breaking it up in a structured set of objects that each can be accessed with atomic 
operations. But if you bring that hierarchy of objects as individual files onto a parallel file system,
you risk creating problems with the metadata server as you will be dealing with lots of small files.

There is no "best" here: both are different technologies, developed with a specific purpose in mind,
and which one you should use is hence dictated by the technology that you want to use to store your
data. 


## Accessing LUMI-O: General principles

<figure markdown style="border: 1px solid #000">
  ![Slide Accessing LUMI-O](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOAccessing.png){ loading=lazy }
</figure>

Access to LUMI-O is based on temporary credentials that need to be generated via 
one of two web interfaces: Either a dedicated credential management portal,
or the Open OnDemand interface to LUMI that we discussed in the 
["Getting access" session](03-Access.md). 
We will discuss both options in this chapter of the notes.

There are currently three command-line tools pre-installed on LUMI
to transfer data back and forth between LUMI and LUMI-O: 
[rclone](https://docs.lumi-supercomputer.eu/storage/lumio/#rclone)
(which is the easiest tool if you want both public web-accessible and private data), 
[s3cmd](https://docs.lumi-supercomputer.eu/storage/lumio/#s3cmd) 
and [restic](https://docs.lumi-supercomputer.eu/storage/lumio/#restic).
All these tools are made available through the `lumio` module that can
be loaded in any software stack.

The [`boto3` Python package](https://pypi.org/project/boto3/) 
is a good choice if you need programmatic access to
the object storage. Note that you need to use fairly recent versions which in turn
require a more recent Python than the system Python on LUMI (but any of the `cray-python`
modules would be sufficient). As it is better to containerize Python installations with
many packages on LUMI, and as most users also prefer to work with virtual environments,
it is not pre-installed on LUMI as it would be impossible to embed it into the Cray
Python distributions.

But you can also access LUMI-O with similar tools from outside LUMI. Configuring them
may be a bit tricky and the LUMI User Support Team cannot help you with each and every client
tool on your personal machine. However, the dedicated credential management web interface
can also generate code snippets or configuration file snippets for various tools, and
that will make configuring them a lot easier.

There also exist GUI-based tools for all popular operating systems. Almost every tool
suitable for AWS S3 storage should also work for LUMI-O when properly configured.

The Open OnDemand web interface also has a tool to show buckets and objects on LUMI-O
in a folder-like structure (created based on object "names" with slashes) and can be
used to upload and download objects, but it is not a substitute for the specific tools
for object storage. When you upload or download via the web browser, you don't talk directly
to LUMI-O, but you use a web browser that talks to the web server using web APIs, with all
performance limitations of those protocols, and the web server then talks to LUMI-O.


### Credential management web interface

<figure markdown style="border: 1px solid #000">
  ![Slide Credential management web interface](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialWebOverview.png){ loading=lazy }
</figure>

One way to create the credentials to access LUMI-O, is via the
the credential management web interface that can be found at
[auth.lumidata.eu](https://auth.lumidata.eu).
This system runs independently from LUMI, just as the object storage 
itself, and usually remains available during downtimes of LUMI.
So even though you may prefer creating credentials via Open OnDemand, it
is good to learn to use this system as it can still give you access to your 
data on LUMI-O while LUMI is down for maintenance.

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

    Click the project for which you want to generate access credentials (called "authentication keys"
    or "access keys" in the interface), and the column to the right will appear.
    Chose how long the authentication key should be valid (1 week or 168 hours is the maximum currently, but the
    life can be extended) and a description for the authentication key. The latter is useful if you generate multiple
    keys for different use. E.g., for security reasons you may want to use different authentication keys from different
    machines so that one machine can be disabled quickly if the machine would be compromised or stolen.

    Next click on the "Generate key" button, and a new key will appear in the "Available keys" section:

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface (4)](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebCreate_04.png){ loading=lazy }
    </figure>

    Now click on the key to get more information about the key: 

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface: Check credentials](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebCheck.png){ loading=lazy }
    </figure>

    At the top of the screen you see three elements that will be important if you use the LUMI command line tool
    `lumio-conf` to generate configuration files for `rclone` and `s3cmd`: the project number (but you knew that one),
    the "Access key" and "Secret key". The access key and secret key will also be needed if you configure other clients,
    e.g., a GUI client on your laptop, by hand. The other bit of information that is useful if you configure tools by hand,
    is the endpoint URL, which is "https://lumidata.eu/" and is not shown in the interface.

    !!! Note "Note: One more configuration parameter"
        LUMI-O requires path-style (https://projectnum.lumidata.eu/bucket) addressing to buckets while
        not the virtual-hosted style (https://bucket.projectnum.lumidata.eu) is not supported.
        From a technical point of view, this is because the 
        `*.lumidata.eu` wildcard TLS certificate can only represent one layer of subdomains
        which is used for the project numbers.

        Many clients default to this, but some will require a configuration option or an environment variable.
        Commonly used parameters and environment variables are `use_path_style`, `force_path_style`
        or `S3_FORCE_PATH_STYLE`. Notably `aws-sdk` defaults to trying virtual-hosted style when reading public buckets.

        Note that we can only give hints on how to do things, but the LUMI User Support Team cannot support any
        possible client and certainly not commercial ones to which we cannot get access.

    Scrolling down a bit more:

    <figure markdown style="border: 1px solid #000">
      ![Slide Credentials management web interface: Extending the life span of a key](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCredentialsWebExtend.png){ loading=lazy }
    </figure>

    The "Extend key" field can be used to extend the life of the key, to a maximum of 168 hours past the current time.
    You can extend the life of an access key as often as you can, but it is not possible to create an access key that 
    remains valid for more than 168 hours. This is done for security reasons as now a compromised key can only be
    used for a limited amount of time, even if you haven't noticed that the access key has been compromised and hence
    fail to invalidate the access key in the interface.

    The credential management interface can also be used to generate snippets for configuration files for
    various tools:

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

TODO


## Configuring LUMI-O tools through a command line interface

<figure markdown style="border: 1px solid #000">
  ![Slide Configuring LUMI-O tools](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/LUMIOCLIToolConfig.png){ loading=lazy }
</figure>

On LUMI, you can use the `lumio-conf` tool to configure `rclone` and `s3cmd`. 
To access the tool, you need to load the `lumio` module first, which is always available.
The same module will also load a module that makes `rclone`, `s3cmd` and `restic` available.

Whe starting `lumio-conf`, it will present you with a couple of questions: The project number
associated with the key, the access key and the secret key. We have shown above where in the web
interface that information can be found. A future version may or may not be more automatic.
As we shall see in the next slide, currently the `rclone` configuration generated by this tool
is (unfortunately) different from the one generated by either the credential management web 
interface or Open OnDemand.

Another way to configure tools for object storage access is simply via the code snippets
and configuration files snippets as has already been discussed before. The same snippets 
should also work when you run the tools on a different computer.
E.g., for rclone the configuration file on Linux is
`~/.config/rclone/rclone.conf`
and the code snippet can be added to that file (or replace an earlier code snippet
for the same project). These code snippets can also be used to configure tools on 
your own laptop or other systems that you have access to. As we have discussed already,
there is no difference in accessing LUMI-O from LUMI or from other systems if the same
tools are used.


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
    -   `lumi-46YXXXXXX-private` is the end point to be used for buckets and objects that should be private, and
    -   `lumi-46YXXXXXX-public` is the end point for data that should be publicly accessible.


## Policies and ACLs

<figure markdown style="border: 1px solid #000">
  ![Slide Policies and ACLs](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/PoliciesACLs.png){ loading=lazy }
</figure>

Access to buckets and objects is controlled through policies and access control lists (ACLs).

Policies are set at the bucket level only, but it is possible to build very complex
policies that restrict access to some objects. It is a very powerful mechanism,
but also one that is rather hard to use. In Ceph, the object storage system on LUMI,
policies are a relatively new addition. Ceph policies are a subset of the policies
on Amazon AWS S3 storage. There is some information on policies in the
["Advanced usage of LUMI-O" section of the LUMI docs](https://docs.lumi-supercomputer.eu/storage/lumio/advanced/#granular-access-management)
and the [section on "Bucket Policies" in the Ceph Reef documentation](https://docs.ceph.com/en/reef/radosgw/bucketpolicy/)
is also relevant.

ACLs are a less sophisticated mechanism. They can be applied to both buckets and objects.
However, they can only add rights and not take rights away. Moreover, they need to be
applied to each object in a bucket separately (though commands will usually provide 
an option to apply them recursively to all objects in a bucket or maybe even pseudo-folder).
They are an easy way though to make an bucket or an individual object public.

Note that a private bucket can contain public objects which you can then still see through,
e.g., a web browser if you know the name of an object, or a bucket can be public but contain
only private objects in which case you can only list the objects.

When using `rclone` on LUMI, specific access control lists will be attached to each object 
depending on which end point name you have used.


### Some examples

<figure markdown style="border: 1px solid #000">
  ![Slide Policies and ACLs: Examples](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/PoliciesACLsExamples.png){ loading=lazy }
</figure>

The `s3cmd` command is your friend if you want to inspect or change policies and
ACLs on LUMI. It is available via the `lumio` module.

1.  You can make a bucket and all objects in it public with

    ```
    s3cmd setacl --recursive --acl-public s3://bucket/ 
    ```

    (replace "bucket" with the name of the bucket) or private with

    ```
    s3cmd setacl --recursive --acl-private s3://bucket/
    ```

2.  You can grant or revoke read rights to a bucket with

    ```
    s3cmd setacl --acl-grant=’read:465000000$465000000’ s3://bucket
    s3cmd setacl --acl-revoke=’read:465000000$465000000’ s3://bucket
    ```

    Note the use of single quotes as we want to avoid that the Linux shell interpretes
    `$465000000` as a (non-existent) environment variable. And of course, replace "465000000"
    with your project number.

    One can also grant or revoke read rights to an object in a similar way.

3.  Checking the current ACLs and more of an object, can also be done with the `s3cmd` command.

    Some examples (but you cannot try them yourself as you'd need access credentials for the 
    462000265 project that contains those buckets and objects):

    -   A bucket used to serve the images on this page:

        ```
        s3cmd info s3://2day-20241210
        ```

        produces

        ```
        s3://2day-20241210/ (bucket):
          Location:  lumi-prod
          Payer:     BucketOwner
          Ownership: none
          Versioning:none
          Expiration rule: none
          Block Public Access: none
          Policy:    none
          CORS:      none
          ACL:       *anon*: READ
          ACL:       LUMI training material: FULL_CONTROL
          URL:       http://lumidata.eu/2day-20241210/
        ```

        Note the ACL "`*anon*: READ`" in the output, showing that this is a public bucket.

    -   An example of an object in that bucket:

        ```
        s3cmd info s3://2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/Title.png
        ```

        where the output shows again that this is a public object:

        ```
        s3://2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/Title.png (object):
          File size: 4384337
          Last mod:  Thu, 21 Nov 2024 14:55:47 GMT
          MIME type: image/png
          Storage:   STANDARD
          MD5 sum:   69e1f1460cff3fca79730530e7fb28d7
          SSE:       none
          Policy:    none
          CORS:      none
          ACL:       *anon*: READ
          ACL:       LUMI training material: FULL_CONTROL
          URL:       http://lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/Title.png
          x-amz-meta-mtime: 1732200870.757744714
        ```

    -   However, if you try

        ```
        s3cmd info s3://4day-20241028/files/LUMI-4day-20241028-1_01_HPE_Cray_EX_Architecture.pdf
        ``` 

        you get

        ```
        s3://4day-20241028/files/LUMI-4day-20241028-1_01_HPE_Cray_EX_Architecture.pdf (object):
          File size: 1299322
          Last mod:  Wed, 06 Nov 2024 09:28:35 GMT
          MIME type: application/pdf
          Storage:   STANDARD
          MD5 sum:   9f2ec727731feba562c401fb0cb156c1
          SSE:       none
          Policy:    none
          CORS:      none
          ACL:       LUMI training material: FULL_CONTROL
          x-amz-meta-mtime: 1730109719.352306659
        ```

        you see that there is no ACL "`*anon*: READ`" as this is a private object, and even though
        the bucket it is in is public: 

        ```
        s3cmd info s3://4day-20241028/
        ```

        shows

        ```
        s3://4day-20241028/ (bucket):
          Location:  lumi-prod
          Payer:     BucketOwner
          Ownership: none
          Versioning:none
          Expiration rule: none
          Block Public Access: none
          Policy:    none
          CORS:      none
          ACL:       *anon*: READ
          ACL:       LUMI training material: FULL_CONTROL
          URL:       http://lumidata.eu/4day-20241028/
        ```

        you'll see that, e.g., accessing
        [https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-1_01_HPE_Cray_EX_Architecture.pdf](https://462000265.lumidata.eu/4day-20241028/files/LUMI-4day-20241028-1_01_HPE_Cray_EX_Architecture.pdf)
        or
        [https://lumidata.eu/462000265:4day-20241028/files/LUMI-4day-20241028-1_01_HPE_Cray_EX_Architecture.pdf](https://lumidata.eu/462000265:4day-20241028/files/LUMI-4day-20241028-1_01_HPE_Cray_EX_Architecture.pdf)
        produces an error message, while
        [https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/Title.png](https://462000265.lumidata.eu/2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/Title.png)
        or
        [https://lumidata.eu/462000265:2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/Title.png](https://lumidata.eu/462000265:2day-20241210/img/LUMI-2day-20241210-10-ObjectStorage/Title.png)
        are links to the object used before in this example and work.



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

<!--
-   Other tools that we've successfully used:

    -   [rclone browser](https://kapitainsky.github.io/RcloneBrowser/).
        It uses the regular rclone configuration file on macOS (`~/.config/rclone/rclone.conf`
        as mentioned above). TODO: Windows?

        It hasn't seen any new release since 2020 though so is mostly abandonware.

    -   We've had some success with [CommanderOne](https://ftp-mac.com/)
        on macOS, but this is a commercial package.

-->

