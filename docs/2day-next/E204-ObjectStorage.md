# Exercises: LUMI-O object storage


Most of these exercises require access to the training project and hence can only be made
during the course sessions or immediately thereafter.

They have to be made in order, as the first exercises create the access credentials and
tools configuration files that are used in the following exercises.


## Exercises to be made in the training project

1.  We've already put some buckets and objects in the training project 
    `project_465001603` and your fellow course followers who are further ahead in
    the exercises, may have put a few more in. Go into Open OnDemand and browse
    the buckets.

    ??? Solution "Click here to see the solution."

        Solving the exercise requires several steps.

        1.  Log on to Open OnDemand: Go to [www.lumi.csc.fi](https://www.lumi.csc.fi/) as 
            discussed in the "Getting Access" lecture in day one of this course. 

        2.  You need to create an authentication key to access LUMI-O.

            1.  Open the "Cloud storage configuration" app.
            2.  Scroll towards the bottom.
            3.  Select project 465001603
            4.  There is no need now to create an `s3cmd` configuration also as we will do so in one of
                the next exercises, but it will do no harm either. It is also not necessary yet to also 
                configure a public remote but again, this does no harm.
            5.  Click on the "Submit" button.
            
        3.  Now we'll browse the buckets and objects.
 
            1.  Leave the "Cloud storage configuration" app by navigating back in the browser or clicking
                the "LUMI" logo at the top left of the screen.
            2.  Open the "Home Directory" app.
            3.  Towards the bottom in the left column, you should now see "lumi-465001603-private", and if you
                created a public access point, also "lumi-465001603-public".

                Notice once more that these are just endpoints. Uploading to them will set a different ACL
                (Access Control List) for the objects and buckets, but when you browse in both you see both
                private and public objects with no way to distinguish between them.\
            4.  If you know click on "lumi-465001603-private", you should see a number of buckets in the right pane,
                and from there you can browse further into these buckets. There are two buckets that we created
                for this training: `training.public` and `training.private`. Both contain 3 objects, and in both
                one of the objects contained a slash in the name, so you get to see a directory first with one "file".
                E.g., the objects in the bucket `training.public` are `private-in-public.txt`, `public-in-public.txt`
                and `HTML/public.html`.

2.  *There is no exercise 2 in this set as that one is only relevant for users
    who are not making the exercise in the training project.*

3.  Now go in to the [web credentials management system auth.lumidata.eu](https://auth.lumidata.eu/), find back the
    authentication key that we created in the first exercise, and generate an s3cmd config file for it in the browser.
    There is no need to install the key already as we will do that in the next exercise in a different
    way, but what would be the filename?

    Do not close your browser window after this exercise as it will prove useful for other exercises.

    ??? Solution "Click here to see the solution."

        Solving this exercise requires again several steps.

        1.  Go into the [web credentials management system auth.lumidata.eu](https://auth.lumidata.eu/).
            You can log in in the same way you did in Open OnDemand in the previous exercise.
            After logging in, you should see a screen "Your projects" with at least a line for the 
            project 465001603.

        2.  To find back the authentication key, simply click on the line for the project 465001603.
            A new pane will appear at the right with first a section to generate a new authentication
            key pair and then a section "Available keys" which will list a key with the key description
            "lumi web interface".

        3.  To generate a configuration file for `s3cmd` for that key, simply click on the key and a new right
            pane appears. At the top, you find the "Access key details", then a section to extend the key 
            duration and then a section "Configuration templates".

            Use the "Select format" box to select `s3cmd` and click on "Generate". A new tab will appear in
            the browser with text that looks like

            ```
            # s3cmd configuration template for project 
            # Generated for UUUUUUUU
            # Valid until 2024-12-07T11:39:17+02:00
            # DO NOT SHARE!

            # Default location is ${HOME}/.s3cfg

            [lumi-465001603]
            access_key   = XXXXXXXXXXXXXXXXXXXX
            secret_key   = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            host_base    = https://lumidata.eu
            host_bucket  = https://lumidata.eu
            human_readable_sizes = True
            enable_multipart = True
            signature_v2 = True
            use_https = True
            ```

            This text can be copied to the `s3cmd` configuration file which on Linux-like systems is
            `~/.s3cfg`, and if you want to have an `s3cmd` configuration for multiple systems,
            the suggested name is `~/.s3cfg-lumi-465001726`.

4.  Use the `lumio-conf` command line tool to generate a configuration for `s3cmd` and for `rclone`.

    ??? Solution "Click here to see the solution."

        1.  If you type `lumio-conf` in a shell command line, you're likely get an error. That is because
            you first need to load a module to make the command available. In this exercise, we'll use
            the latest version of this tool, and all we need to do to make the command available, is

            ```
            module load lumio
            ```

            You will see a warning which is meant for users who have been using this module before as at
            the end of November 2024 a new version was installed that creates different configurations that
            are more equivalent to those created by Open OnDemand.

        2.  Type `lumio-conf` to start the `lumio-conf` tool in default mode, where it will create configuration
            files for `rclone` and `s3cmd`.

            The first question it will ask you, is the project number. Fill in `465001603`.

            Next it will ask you for the "Access key". We found that information in the previous exercise: It was
            at the top of the right column after selecting the project in the
            [web credentials management system auth.lumidata.eu](https://auth.lumidata.eu/) and then selecting
            the key. You can copy the
            access key information from their. Many terminal emulators support copy and paste, so you can copy
            it from the web browser and paste it into your terminal. Copying is easy with the rectangular icon
            next to the value of the Access key. Note that when you paste the data or type the access key, it will 
            not be shown so you have no feedback. Press the enter key.

            Next the program will ask for the "Secret key" which again you can find in the web credentials management
            system, on the next line. Again copy and paste into your terminal window, and again the key 
            will not be shown on the screen.

            `lumio-conf` will now create the configuration files. It will print information about its 
            `rclone` configuration which is stored in the file `~/.config/rclone/rclone.conf` and creates
            two endpoints for `rclone`: `lumi-465001603-private` and `lumi-465001603-public`, and for
            `s3cmd` it will actually create two files: A configuration file `~/.s3cfg-lumi-465001603`, and
            it will then also create or overwrite `~/.s3cfg` with that configuration. 
            
        3.  Feel free to inspect those files.
   
            In `~/.s3cfg-lumi-465001603`, you'll see a section similar to

            ```
            [lumi-465001603-private]
            type              = s3
            acl               = private
            env_auth          = false
            provider          = Ceph
            endpoint          = https://lumidata.eu
            access_key_id     = XXXXXXXXXXXXXXXXXXXX
            secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            project_id        = 465001603

            [lumi-465001603-public]
            type              = s3
            acl               = public
            env_auth          = false
            provider          = Ceph
            endpoint          = https://lumidata.eu
            access_key_id     = XXXXXXXXXXXXXXXXXXXX
            secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            project_id        = 465001603
            ```

            while in `~/.s3cfg` and `~/.s3cfg-lumi-465001603`, you'll see something similar to

            ```
            use_https            = True
            secret_key           = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            host_base            = https://lumidata.eu
            project_id           = 465001603
            chunk_size           = 15
            human_readable_sizes = True
            enable_multipart     = True
            signature_v2         = True
            signurl_use_https    = True
            access_key           = XXXXXXXXXXXXXXXXXXXX
            host_bucket          = https://lumidata.eu
            ```

    ??? Remark "Using Open OnDemand instead"

        It is also possible to generate the exactly same files the Open OnDemand "Cloud storage tool" by
        checking both the "Generate s3cmd configuration" and "Configure public remote" checkboxes.
        In fact, this version of the `lumio-conf` tool was developed to also be used under the hood of
        Open OnDemand. The command line tool can do more though as it can also generate configurations for
        the AWS tools and the `boto3` Python package.

    ??? Remark "Why don't we have all the same tools from the [web credentials management system auth.lumidata.eu](https://auth.lumidata.eu/) in Open OnDemand?"

        The web credential management system was actually there already before Open OnDemand was deployed.
        Writing a more powerful app for Open OnDemand with the same functionality, takes time and as a small
        team, we have to make choices. It is important to have a separate platform also for the credentials
        management. Open OnDemand is down during LUMI maintenance as it is part of the main LUMI installation.
        However, the web based credential management system is more closely integrated with the object storage
        itself and has a different maintenance cycle. Hence it can remain available when LUMI is down, so that
        users can still access their data on LUMI-O from their home institution or personal computer.

5.  Which buckets and objects are there in the training project `project_465001603`? Check with the command line
    tools for which you prepared the configuration file in the previous exercise
    (as we have done this already with Open OnDemand)

    Hint: Many commands have a `--help` option to get you on the way.

    ??? Solution "Click here to see the solution."

        -   With `s3cmd`: `s3cmd ls` will show you the buckets. It will return something like

            ```
            2024-11-30 10:31  s3://training.private
            2024-11-30 10:31  s3://training.public
            ```

            There may be more lines if some course participants have already created additional buckets.

            And we can then use `s3cmd ls s3://training.private` to see the objects in that bucket.
            It will hopefully (if nobody messed with the bucket) return:

            ```
                                DIR  s3://training.private/HTML/
            2024-11-30 10:51    59   s3://training.private/private-in-private.txt
            2024-11-30 10:51    58   s3://training.private/public-in-private.txt
            ```

            This is not the complete object list as it shows a pseudo-folder view. The first line starts with `DIR` which 
            indicates a pseudo-directory, but you can now use 

            ```
            s3cmd ls s3://training.private/HTML/
            ```

            where the slash at the end is actually important to see

            ```
            2024-11-30 10:51   235   s3://training.private/HTML/private.html
            ```

            Now if we use instead

            ```
            s3cmd ls --recursive s3://training.private
            ```

            we do get all objects in the bucket:

            ```
            2024-11-30 10:51   235   s3://training.private/HTML/private.html
            2024-11-30 10:51    59   s3://training.private/private-in-private.txt
            2024-11-30 10:51    58   s3://training.private/public-in-private.txt
            ```

        -   With `rclone`: Now we need to specify the endpoint as `rclone` supports multiple projects in a 
            single configuration.

            The command to use is now: `rclone ls lumi-465001603-private:` which returns something similar to

            ```
                235 training.private/HTML/private.html
                59 training.private/private-in-private.txt
                58 training.private/public-in-private.txt
                231 training.public/HTML/public.html
                58 training.public/private-in-public.txt
                57 training.public/public-in-public.txt
            ```

            Now if you'd try `rclone ls lumi-465001603-public:` instead, you'd see exactly the same because
            these are two endpoints for the same project. Their behaviour is different though when uploading
            objects.

            In these case we also already see all three objects in both the `training.private` and `training.public`
            buckets.

6.  Check the ACLs of the `training.public` and `training.private` buckets and the objects in those buckets.
    Which objects are publicly available and which are not?

    ??? Solution "Click here to see the solution."

        Your friend for this is the `s3cmd info` command. 
        E.g., to check the bucket `training.public`, use `s3cmd info s3://training.public`.
        The crucial lines in the output are:

        ```
        ACL:       *anon*: READ
        ACL:       LUST Training / 2024-12-10-11 Supercomputing with LUMI - Online: FULL_CONTROL
        ```

        The last line will always be present, with the name of the project and then `FULL_CONTROL`
        as whoever has the credentials of the project can do everything with the bucket. The first line
        says that everybody has read rights to this bucket and tells that this is a public bucket.
        When you use `s3cmd info s3://training.private`, only the second line will be present in the
        output, telling that this is a private object.

        To check the credentials of the `public-in-private.txt` object in the `training.private`
        bucket, use

        ```
        s3cmd info s3://training.private/public-in-private.txt
        ``` 

        The output will contain

        ```
        ACL:       *anon*: READ
        ACL:       LUST Training / 2024-12-10-11 Supercomputing with LUMI - Online: FULL_CONTROL
        ```

        which shows that this object is actually public. So a private bucket can contain a public object,
        and in fact, you can access it with, e.g., a web browser without authenticating anywhere.

        You can do this for all objects in both commands:

        ```
        s3cmd info s3://training.public/public-in-public.txt
        s3cmd info s3://training.public/private-in-public.txt
        s3cmd info s3://training.private/public-in-private.txt
        s3cmd info s3://training.private/private-in-private.txt
        s3cmd info s3://training.public/HTML/public.html
        s3cmd info s3://training.private/HTML/private.html
        ```

        The name of each object suggests the answer.

7.  Use command line tools to download the file `private-in-private.txt` from the `training.private` bucket in
    the `project_465001603` training project of this training.

    ??? Solution "Click here to see the solution."

        -   With `s3cmd`: 

            ```
            s3cmd get s3://training.private/private-in-private.txt
            ```

        -   With `rclone`:

            ```
            rclone copy lumi-465001603-private:training.private/private-in-private.txt .
            ```

8.  What would be the web-URL to access the public object `public-in-public.txt` in the `training.public` bucket?
    Next try the same strategy to access `private-in-public.txt` in the  `training.public` bucket and both
    `public-in-private.txt` and `private-in-private.txt` in the `training.private` bucket. What works and what doesn't?

    ??? Solution "Click here to see the solution."

        -   `public-in-public.txt` in the `training.public` bucket:
            [https://465001603.lumidata.eu/training.public/public-in-public.txt](https://465001603.lumidata.eu/training.public/public-in-public.txt)
            or
            [https://lumidata.eu/465001603:training.public/public-in-public.txt](https://lumidata.eu/465001603:training.public/public-in-public.txt)
            both work. So we can access a public object in a public bucket.

        -   `private-in-public.txt` in the `training.public` bucket:
            Neither
            [https://465001603.lumidata.eu/training.public/private-in-public.txt](https://465001603.lumidata.eu/training.public/private-in-public.txt)
            nor
            [https://lumidata.eu/465001603:training.public/private-in-public.txt](https://lumidata.eu/465001603:training.public/private-in-public.txt)
            work.

        -   `public-in-private.txt` in the `training.private` bucket:
            [https://465001603.lumidata.eu/training.private/public-in-private.txt](https://465001603.lumidata.eu/training.private/public-in-private.txt)
            or
            [https://lumidata.eu/465001603:training.private/public-in-private.txt](https://lumidata.eu/465001603:training.private/public-in-private.txt)
            both work. So we can access a public object in a public bucket.

        -   `private-in-private.txt` in the `training.private` bucket:
            Neither
            [https://465001603.lumidata.eu/training.private/private-in-private.txt](https://465001603.lumidata.eu/training.private/private-in-private.txt)
            nor
            [https://lumidata.eu/465001603:training.private/private-in-private.txt](https://lumidata.eu/465001603:training.private/private-in-private.txt)
            work.


    ??? Remark "Check this remark only after the solution."
        So if we can access public objects in both public and private buckets, what is then the difference between both?
        Well, in a public bucket you can list the objects without using credentials while you cannot in a private bucket.

        Try either 
        [https://465001603.lumidata.eu/training.private](https://465001603.lumidata.eu/training.private) or
        [https://lumidata.eu/465001603:training.private](https://lumidata.eu/465001603:training.private)
        and notice that you get a cryptic error message.

        However, try either
        [https://465001603.lumidata.eu/training.public](https://465001603.lumidata.eu/training.public) or
        [https://lumidata.eu/465001603:training.public](https://lumidata.eu/465001603:training.public)
        and you get a much longer answer though again rather cryptic for ordinary people. It is an XML file
        and if you read through it, you'll find the names of the objects that we know are in the bucket.

9.  Create a web link (presigned URL) to share the private object `HTML/private.html` in the `training.private` bucket. Next
    open a private/incognito browser window and check that the link indeed works (we use a private browser window / incognito mode to
    be sure that it doesn't pick up any credentials anywhere just to be sure).

    ??? Solution "Click here to see the solution."

        For this, we can use the `rclone link` tool: 

        ```
        rclone link lumi-465001603-private:training.private/HTML/private.html
        ```

        will produce output that will look like this:

        ```
        2024/12/04 21:43:29 NOTICE: S3 bucket training.private path HTML: Public Link: Reducing expiry to 1w as off is greater than the max time allowed
        https://lumidata.eu/training.private/HTML/private.html?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=KEII85V27JOJTCGM6XQQ%2F20241204%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241204T194329Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=35a3bc04d997d50471ecd1a6637cd063f9dfb2a40e173f758030d6ced48926bf
        ```

        Note that the validity is automatically restricted to 7 days (604800 seconds) which is a limit imposed by LUMI, but the link would actually fail
        sligthly earlier as the key expires if the lifetime of the key used to create the link, is not extended.

        One can also set a shorter link lifetime, e.g.,

        ```
        rclone link --expire 2d lumi-465001603-private:training.private/HTML/private.html
        ```

        which will produce output that will look like this:

        ```
        https://lumidata.eu/training.private/HTML/private.html?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=KEII85V27JOJTCGM6XQQ%2F20241204%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241204T194645Z&X-Amz-Expires=172800&X-Amz-SignedHeaders=host&X-Amz-Signature=055f936dc0c23576cf2ba6211c4465f6f2488501c27a7096d0c9af0925d8f884
        ```

        so just the URL without further warning. But if you analyse the URL carefully, you see the field 
        `X-Amz-Expires=172800` which indicates that the link expires after 2 days or 172800 seconds.

        Now just copy the URL and check in a browser...

10. **Data sharing example** On LUMI, `project_462000265` is used to store 
    materials from previous trainings given by LUST, HPE and AMD, and make some of those materials
    available on the web. However, you are not part of that project so cannot request an authentication key for that
    project. But, as some files are public, you are able to access some buckets and objects in this project with
    some tools. We've created two buckets, `intro-training.public` and `intro-training.private` with the same contents
    and ACLs as the `training.public` and `training.private` buckets in the `project_465001603` training project.
    Let's see if we can access them with command line tools.

    List the objects in both buckets.

    ??? Solution "Click here to see the solution."

        -   With `s3cmd`: 

            ```
            s3cmd ls --recursive s3://462000265:intro-training.public/
            ```

            returns something along the lines of

            ```
            2024-12-07 17:31   231   s3://462000265:intro-training.public/HTML/public.html
            2024-12-07 17:31   343   s3://462000265:intro-training.public/HTML/shared.html
            2024-12-07 17:31    58   s3://462000265:intro-training.public/private-in-public.txt
            2024-12-07 17:31    57   s3://462000265:intro-training.public/public-in-public.txt
            ```

            while

            ```
            s3cmd ls --recursive s3://462000265:intro-training.private/
            ```

            returns

            ```
            ERROR: Access to bucket '462000265:intro-training.private' was denied
            ERROR: S3 error: 403 (AccessDenied)
            ```

            This should not surprise you, as you are not a member of the `462000265` project and are not using
            access credentials for that project in this exercise, but for `465001603` training project.

            Note that in the first command we did list an object whose name suggests that it is a private object.

        -   With `rclone`: 

            ```
            rclone ls lumi-465001603-private:"462000265:intro-training.public"
            ``` 

            returns something along the lines of

            ```
                231 HTML/public.html
                343 HTML/shared.html
                58 private-in-public.txt
                57 public-in-public.txt
            ```

            while

            ```
            rclone ls lumi-465001603-private:"462000265:intro-training.private"
            ``` 

            returns something similar to

            ```
            2024/12/07 19:39:03 Failed to ls: AccessDenied:
                status code: 403, request id: tx0000092793a87e000e519-0067548837-61b0c46-lumi-prod, host id:
            ```

            so an error (as we would expect, see the comments for the solution with `s3cmd`)

11. We continue on the data sharing example. 
    Can we check the ACLs of the objects in the `intro-training.public` bucket?

    ??? Solution "Click here to see the solution." 

        For this exercise, `s3cmd` is our friend.

        Let's try for `public-in-public.txt`: The output of

        ```
        s3cmd info s3://462000265:intro-training.public/public-in-public.txt
        ```

        actually produces output with an error message. The precise output:

        ```
        File size: 57
        Last mod:  Sat, 07 Dec 2024 17:31:04 GMT
        MIME type: text/plain
        Storage:   STANDARD
        MD5 sum:   db24072368ff20ad202395aa7dd66487
        SSE:       none
        Policy:    Not available: GetPolicy permission is needed to read the policy
        ERROR: Access to bucket '462000265:intro-training.public' was denied
        ERROR: S3 error: 403 (AccessDenied)
        ```

        The reason is that listing permissions does require more rights than the ones we have in the bucket
        because even though the bucket itself is actually public to the world, this is not enough
        to also check permissions.

12. We continue on the data sharing example. 
    Download the `HTML/public.html` from the `intro-training.public` bucket in `project_465000265`.
    We couldn't check in the previous exercise, but this is actually a public object in a public
    bucket.
    Can you do so with a web browser also (or the `wget` or `curl` commands if you are familiar
    with them)?
    
    ??? Solution "Click here to see the solution."

        -   With `s3cmd`:
  
            ```
            s3cmd get s3://462000265:intro-training.public/HTML/public.html
            ```

        -   With `rclone`:

            ```
            rclone copy lumi-465001603-private:"462000265:intro-training.public/HTML/public.html" .
            ```

        -   With a web browser: both the URL
            [https://462000265.lumidata.eu/intro-training.public/HTML/public.html](https://462000265.lumidata.eu/intro-training.public/HTML/public.html)
            and 
            [https://lumidata.eu/462000265:intro-training.public/HTML/public.html](https://lumidata.eu/462000265:intro-training.public/HTML/public.html)
            work.

        -   With the `wget` command: both

            ```
            wget https://462000265.lumidata.eu/intro-training.public/HTML/public.html
            ```

            and

            ```
            wget https://lumidata.eu/462000265:intro-training.public/HTML/public.html
            ```

            work.

        -   With the `curl` command: Both

            ```
            curl https://462000265.lumidata.eu/intro-training.public/HTML/public.html
            ```

            and

            ```
            curl https://lumidata.eu/462000265:intro-training.public/HTML/public.html
            ```

            will print the content of the file on the terminal.

            ```
            curl -o public.html https://462000265.lumidata.eu/intro-training.public/HTML/public.html
            ```

            would store the result in the file `public.html` in the current directory.


13. We continue on the data sharing example. 
    Download the `HTML/shared.html` from the `intro-training.private` bucket.
    This is a private object in a private bucket that has been explicitly shared with the
    training project using

    ```
    s3cmd setacl --acl-grant='read:465001603$465001603' s3://intro-training.private/HTML/shared.html
    ```
    
    ??? Solution "Click here to see the solution."

        -   With `s3cmd`:
  
            ```
            s3cmd get s3://462000265:intro-training.private/HTML/shared.html
            ```

            so we can use `s3cmd` to download this object, even though it is otherwise fully
            private except for the explicit read rights given to the training project.

        -   With `rclone`:

            ```
            rclone copy lumi-465001603-private:"462000265:intro-training.private/HTML/shared.html" .
            ```

            and this also works.

        -   Trying to use any of the other tools of the previous exercise will fail though. E.g.,
            neither the web URL 
            [https://462000265.lumidata.eu/intro-training.private/HTML/shared.html](https://462000265.lumidata.eu/intro-training.private/HTML/shared.html)
            nor
            [https://lumidata.eu/462000265:intro-training.private/HTML/shared.html](https://lumidata.eu/462000265:iintro-training.private/HTML/shared.html)

            nor any of the commands

            ```
            wget https://462000265.lumidata.eu/intro-training.private/HTML/shared.html
            wget https://lumidata.eu/462000265:intro-training.private/HTML/shared.html
            curl https://462000265.lumidata.eu/intro-training.private/HTML/shared.html
            curl https://lumidata.eu/462000265:intro-training.private/HTML/shared.html
            ```

            work as these would need read rights for anonymous users which are not granted as this is
            a private object.

        The presigned URL is more interesting if you want to quickly share an object with someone
        (e.g., if the LUMI User Support Teams asks you for a reproducer) and are not too concerned
        that someone else may get hold of the link, while the method of data sharing used here,
        will give permanent access to users of another project, or at least, until the access is
        specifically revoked, but there is no chance that someone else would gain access.


## Exercises that can be made in your own project

These exercises need to be made in the indicated order, as some exercises prepare
materials for the following exercises.

They are numbered to be equivalent to the exercises made during the course in the
course project.

You do need a project on LUMI to make these exercises. Wherever we use
`46YXXXXXX`, replace with the number of your project.

1.  This exercise replaces the first exercise made during the course.
    It is the first step in preparing the environment needed for exercise 3
    and later.

    Go into [Open OnDemand](https://www.lumi.csc.fi) and use the 
    "Cloud storage configuration" app to create an access key for your project
    `project_46YXXXXXX`. Also create a configuration for `s3cmd` and a public
    rclone endpoint.

    Check the result in the "Home directory" app.

    ??? Solution "Click here to see the solution."

        Solving the exercise requires several steps.

        1.  Log on to Open OnDemand: Go to [www.lumi.csc.fi](https://www.lumi.csc.fi/) as 
            discussed in the "Getting Access" lecture in day one of this course. 

        2.  You need to create an authentication key to access LUMI-O.

            1.  Open the "Cloud storage configuration" app.
            2.  Scroll towards the bottom.
            3.  Select project 46YXXXXXX
            4.  Also click the checkboxes next to "Generate s3cmd configuration" and
                "Configure public remote".
            5.  Click on the "Submit" button.
            
        3.  Now we'll check the result.
 
            1.  Leave the "Cloud storage configuration" app by navigating back in the browser or clicking
                the "LUMI" logo at the top left of the screen.
            2.  Open the "Home Directory" app.
            3.  Towards the bottom in the left column, you should now see "lumi-46YXXXXXX-private" and 
                "lumi-46YXXXXXX-public".

                Notice once more that these are just endpoints. Uploading to them will set a different ACL
                (Access Control List) for the objects and buckets, but when you browse in both you see both
                private and public objects with no way to distinguish between them.\

2.  This is not really an exercise, but instructions to set up the environment for the next 
    exercises.

    In the directory with LUST exercises that were downloaded following the
    [instructions to set up for the exercises](index.md#setting-up-for-the-exercises),
    go into the `ObjectStorage` directory. In that directory, run the `create_buckets.sh`
    script with your project number `46YXXXXXX` as the argument:

    ```
    ./create_buckets.sh 46YXXXXXX
    ```

    This will create two buckets and populate them.

    The script will only work on LUMI, and after successfully making the first exercise,
    including the creation of the `s3cmd` configuration file. The script does rely on the file
    `~/.s3cfg-lumi-46YXXXXXX`.

3.  Now go in to the [web credentials management system auth.lumidata.eu](https://auth.lumidata.eu/), find back the
    authentication key that we created in the first exercise, and generate an s3cmd config file for it in the browser
    (no need to also install it on the system as we've done that already, but what would be the right filename?)

    Do not close your browser window after this exercise as it will prove useful for other exercises.

    ??? Solution "Click here to see the solution."

        Solving this exercise requires again several steps.

        1.  Go into the [web credentials management system auth.lumidata.eu](https://auth.lumidata.eu/).
            You can log in in the same way you did in Open OnDemand in the previous exercise.
            After logging in, you should see a screen "Your projects" with at least a line for the 
            project 46YXXXXXX.

        2.  To find back the authentication key, simply click on the line for the project 46YXXXXXX.
            A new pane will appear at the right with first a section to generate a new authentication
            key pair and then a section "Available keys" which will list a key with the key description
            "lumi web interface".

        3.  To generate a configuration file for `s3cmd` for that key, simply click on the key and a new right
            pane appears. At the top, you find the "Access key details", then a section to extend the key 
            duration and then a section "Configuration templates".

            Use the "Select format" box to select `s3cmd` and click on "Generate". A new tab will appear in
            the browser with text that looks like

            ```
            # s3cmd configuration template for project 
            # Generated for UUUUUUUU
            # Valid until 2024-12-07T11:39:17+02:00
            # DO NOT SHARE!

            # Default location is ${HOME}/.s3cfg

            [lumi-46YXXXXXX]
            access_key   = XXXXXXXXXXXXXXXXXXXX
            secret_key   = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            host_base    = https://lumidata.eu
            host_bucket  = https://lumidata.eu
            human_readable_sizes = True
            enable_multipart = True
            signature_v2 = True
            use_https = True
            ```

            This text can be copied to the `s3cmd` configuration file which on Linux-like systems is
            `~/.s3cfg`, and if you want to have an `s3cmd` configuration for multiple systems,
            the suggested name is `~/.s3cfg-lumi-46YXXXXXX`.

4.  Use the `lumio-conf` command line tool to generate a configuration for `s3cmd` and for `rclone`
    (which will overwrite the configuration files we made in the first exercise).

    ??? Solution "Click here to see the solution."

        1.  If you type `lumio-conf` in a shell command line, you're likely get an error. That is because
            you first need to load a module to make the command available. In this exercise, we'll use
            the latest version of this tool, and all we need to do to make the command available, is

            ```
            module load lumio
            ```

            You will see a warning which is meant for users who have been using this module before as at
            the end of November 2024 a new version was installed that creates different configurations that
            are more equivalent to those created by Open OnDemand.

        2.  Type `lumio-conf` to start the `lumio-conf` tool in default mode, where it will create configuration
            files for `rclone` and `s3cmd`.

            The first question it will ask you, is the project number. Fill in `46YXXXXXX`.

            Next it will ask you for the "Access key". We found that information in the previous exercise: It was
            at the top of the right column after selecting the project in the
            [web credentials management system auth.lumidata.eu](https://auth.lumidata.eu/) and then selecting
            the key. You can copy the
            access key information from their. Many terminal emulators support copy and paste, so you can copy
            it from the web browser and paste it into your terminal. Copying is easy with the rectangular icon
            next to the value of the Access key. Note that when you paste the data or type the access key, it will 
            not be shown so you have no feedback. Press the enter key.

            Next the program will ask for the "Secret key" which again you can find in the web credentials management
            system, on the next line. Again copy and paste into your terminal window, and again the key 
            will not be shown on the screen.

            `lumio-conf` will now create the configuration files. It will print information about its 
            `rclone` configuration which is stored in the file `~/.config/rclone/rclone.conf` and creates
            two endpoints for `rclone`: `lumi-46YXXXXXX-private` and `lumi-46YXXXXXX-public`, and for
            `s3cmd` it will actually create two files: A configuration file `~/.s3cfg-lumi-46YXXXXXX`, and
            it will then also create or overwrite `~/.s3cfg` with that configuration. 
            
        3.  Feel free to inspect those files.
   
            In `~/.s3cfg-lumi-46YXXXXXX`, you'll see a section similar to

            ```
            [lumi-46YXXXXXX-private]
            type              = s3
            acl               = private
            env_auth          = false
            provider          = Ceph
            endpoint          = https://lumidata.eu
            access_key_id     = XXXXXXXXXXXXXXXXXXXX
            secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            project_id        = 46YXXXXXX

            [lumi-46YXXXXXX-public]
            type              = s3
            acl               = public
            env_auth          = false
            provider          = Ceph
            endpoint          = https://lumidata.eu
            access_key_id     = XXXXXXXXXXXXXXXXXXXX
            secret_access_key = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            project_id        = 46YXXXXXX
            ```

            while in `~/.s3cfg` and `~/.s3cfg-lumi-46YXXXXXX`, you'll see something similar to

            ```
            use_https            = True
            secret_key           = XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
            host_base            = https://lumidata.eu
            project_id           = 46YXXXXXX
            chunk_size           = 15
            human_readable_sizes = True
            enable_multipart     = True
            signature_v2         = True
            signurl_use_https    = True
            access_key           = XXXXXXXXXXXXXXXXXXXX
            host_bucket          = https://lumidata.eu
            ```

    ??? Remark "Using Open OnDemand instead"

        It is also possible to generate the exactly same files the Open OnDemand "Cloud storage tool" by
        checking both the "Generate s3cmd configuration" and "Configure public remote" checkboxes.
        In fact, this version of the `lumio-conf` tool was developed to also be used under the hood of
        Open OnDemand. The command line tool can do more though as it can also generate configurations for
        the AWS tools and the `boto3` Python package.

    ??? Remark "Why don't we have all the same tools from the [web credentials management system auth.lumidata.eu](https://auth.lumidata.eu/) in Open OnDemand?"

        The web credential management system was actually there already before Open OnDemand was deployed.
        Writing a more powerful app for Open OnDemand with the same functionality, takes time and as a small
        team, we have to make choices. It is important to have a separate platform also for the credentials
        management. Open OnDemand is down during LUMI maintenance as it is part of the main LUMI installation.
        However, the web based credential management system is more closely integrated with the object storage
        itself and has a different maintenance cycle. Hence it can remain available when LUMI is down, so that
        users can still access their data on LUMI-O from their home institution or personal computer.

5.  Which buckets and objects are there in the training project `project_46YXXXXXX`? Check with the command line
    tools for which you prepared the configuration file in the previous exercise.
    And maybe try Open Ondemand als as we haven't done that yet.

    Hint: Many commands have a `--help` option to get you on the way.

    ??? Solution "Click here to see the solution."

        -   With `s3cmd`: `s3cmd ls` will show you the buckets. It will return something like

            ```
            2025-02-11 17:23  s3://training.private
            2025-02-11 17:23  s3://training.public
            ```

            There may be more lines if some course participants have already created additional buckets.

            And we can then use `s3cmd ls s3://training.private` to see the objects in that bucket.
            It will hopefully (if nobody messed with the bucket) return:

            ```
                                DIR  s3://training.private/HTML/
            2025-02-11 17:23    59   s3://training.private/private-in-private.txt
            2025-02-11 17:23    58   s3://training.private/public-in-private.txt
            ```

            This is not the complete object list as it shows a pseudo-folder view. The first line starts with `DIR` which 
            indicates a pseudo-directory, but you can now use 

            ```
            s3cmd ls s3://training.private/HTML/
            ```

            where the slash at the end is actually important to see

            ```
            2025-02-11 17:23   235   s3://training.private/HTML/private.html
            ```

            Now if we use instead

            ```
            s3cmd ls --recursive s3://training.private
            ```

            we do get all objects in the bucket:

            ```
            2025-02-11 17:23   235   s3://training.private/HTML/private.html
            2025-02-11 17:23    59   s3://training.private/private-in-private.txt
            2025-02-11 17:23    58   s3://training.private/public-in-private.txt
            ```

        -   With `rclone`: Now we need to specify the endpoint as `rclone` supports multiple projects in a 
            single configuration.

            The command to use is now: `rclone ls lumi-46YXXXXXX-private:` which returns something similar to

            ```
                235 training.private/HTML/private.html
                59 training.private/private-in-private.txt
                58 training.private/public-in-private.txt
                231 training.public/HTML/public.html
                58 training.public/private-in-public.txt
                57 training.public/public-in-public.txt
            ```

            Now if you'd try `rclone ls lumi-46YXXXXXX-public:` instead, you'd see exactly the same because
            these are two endpoints for the same project. Their behaviour is different though when uploading
            objects.

            In these case we also already see all three objects in both the `training.private` and `training.public`
            buckets.

        -   With Open OnDemand:

            1.  Log in to [Open OnDemand](https://www.lumi.csc.fi/) if you're no longer logged
                in after exercise 1.
            2.  Open the "Home Directory" app.
            3.  Towards the bottom in the left column, you should now see "lumi-46YXXXXXX-private", and if you
                created a public access point, also "lumi-46YXXXXXX-public".

                Notice once more that these are just endpoints. Uploading to them will set a different ACL
                (Access Control List) for the objects and buckets, but when you browse in both you see both
                private and public objects with no way to distinguish between them.\
            4.  If you know click on "lumi-46YXXXXXX-private", you should see a number of buckets in the right pane,
                and from there you can browse further into these buckets. There are two buckets that we created
                for this training: `training.public` and `training.private`. Both contain 3 objects, and in both
                one of the objects contained a slash in the name, so you get to see a directory first with one "file".
                E.g., the objects in the bucket `training.public` are `private-in-public.txt`, `public-in-public.txt`
                and `HTML/public.html`.

6.  Check the ACLs of the `training.public` and `training.private` buckets and the objects in those buckets.
    Which objects are publicly available and which are not?

    ??? Solution "Click here to see the solution."

        Your friend for this is the `s3cmd info` command. 
        E.g., to check the bucket `training.public`, use `s3cmd info s3://training.public`.
        The crucial lines in the output are:

        ```
        ACL:       *anon*: READ
        ACL:       LUST Training / 2024-12-10-11 Supercomputing with LUMI - Online: FULL_CONTROL
        ```

        The last line will always be present, with the name of the project and then `FULL_CONTROL`
        as whoever has the credentials of the project can do everything with the bucket. The first line
        says that everybody has read rights to this bucket and tells that this is a public bucket.
        When you use `s3cmd info s3://training.private`, only the second line will be present in the
        output, telling that this is a private object.

        To check the credentials of the `public-in-private.txt` object in the `training.private`
        bucket, use

        ```
        s3cmd info s3://training.private/public-in-private.txt
        ``` 

        The output will contain

        ```
        ACL:       *anon*: READ
        ACL:       LUST Training / 2024-12-10-11 Supercomputing with LUMI - Online: FULL_CONTROL
        ```

        which shows that this object is actually public. So a private bucket can contain a public object,
        and in fact, you can access it with, e.g., a web browser without authenticating anywhere.

        You can do this for all objects in both commands:

        ```
        s3cmd info s3://training.public/public-in-public.txt
        s3cmd info s3://training.public/private-in-public.txt
        s3cmd info s3://training.private/public-in-private.txt
        s3cmd info s3://training.private/private-in-private.txt
        s3cmd info s3://training.public/HTML/public.html
        s3cmd info s3://training.private/HTML/private.html
        ```

        The name of each object suggests the answer.

7.  Use command line tools to download the file `private-in-private.txt` from the `training.private` bucket in
    the `project_46YXXXXXX` training project of this training.

    ??? Solution "Click here to see the solution."

        -   With `s3cmd`: 

            ```
            s3cmd get s3://training.private/private-in-private.txt
            ```

        -   With `rclone`:

            ```
            rclone copy lumi-46YXXXXXX-private:training.private/private-in-private.txt .
            ```

8.  What would be the web-URL to access the public object `public-in-public.txt` in the `training.public` bucket?
    Next try the same strategy to access `private-in-public.txt` in the  `training.public` bucket and both
    `public-in-private.txt` and `private-in-private.txt` in the `training.private` bucket. What works and what doesn't?

    ??? Solution "Click here to see the solution."

        -   `public-in-public.txt` in the `training.public` bucket:
            [https://46YXXXXXX.lumidata.eu/training.public/public-in-public.txt](https://46YXXXXXX.lumidata.eu/training.public/public-in-public.txt)
            or
            [https://lumidata.eu/46YXXXXXX:training.public/public-in-public.txt](https://lumidata.eu/46YXXXXXX:training.public/public-in-public.txt)
            both work. So we can access a public object in a public bucket.

        -   `private-in-public.txt` in the `training.public` bucket:
            Neither
            [https://46YXXXXXX.lumidata.eu/training.public/private-in-public.txt](https://46YXXXXXX.lumidata.eu/training.public/private-in-public.txt)
            nor
            [https://lumidata.eu/46YXXXXXX:training.public/private-in-public.txt](https://lumidata.eu/46YXXXXXX:training.public/private-in-public.txt)
            work.

        -   `public-in-private.txt` in the `training.private` bucket:
            [https://46YXXXXXX.lumidata.eu/training.private/public-in-private.txt](https://46YXXXXXX.lumidata.eu/training.private/public-in-private.txt)
            or
            [https://lumidata.eu/46YXXXXXX:training.private/public-in-private.txt](https://lumidata.eu/46YXXXXXX:training.private/public-in-private.txt)
            both work. So we can access a public object in a public bucket.

        -   `private-in-private.txt` in the `training.private` bucket:
            Neither
            [https://46YXXXXXX.lumidata.eu/training.private/private-in-private.txt](https://46YXXXXXX.lumidata.eu/training.private/private-in-private.txt)
            nor
            [https://lumidata.eu/46YXXXXXX:training.private/private-in-private.txt](https://lumidata.eu/46YXXXXXX:training.private/private-in-private.txt)
            work.


    ??? Remark "Check this remark only after the solution."
        So if we can access public objects in both public and private buckets, what is then the difference between both?
        Well, in a public bucket you can list the objects without using credentials while you cannot in a private bucket.

        Try either 
        [https://46YXXXXXX.lumidata.eu/training.private](https://46YXXXXXX.lumidata.eu/training.private) or
        [https://lumidata.eu/46YXXXXXX:training.private](https://lumidata.eu/46YXXXXXX:training.private)
        and notice that you get a cryptic error message.

        However, try either
        [https://46YXXXXXX.lumidata.eu/training.public](https://46YXXXXXX.lumidata.eu/training.public) or
        [https://lumidata.eu/46YXXXXXX:training.public](https://lumidata.eu/46YXXXXXX:training.public)
        and you get a much longer answer though again rather cryptic for ordinary people. It is an XML file
        and if you read through it, you'll find the names of the objects that we know are in the bucket.

9.  Create a web link (presigned URL) to share the private object `HTML/private.html` in the `training.private` bucket. Next
    open a private/incognito browser window and check that the link indeed works (we use a private browser window / incognito mode to
    be sure that it doesn't pick up any credentials anywhere just to be sure).

    ??? Solution "Click here to see the solution."

        For this, we can use the `rclone link` tool: 

        ```
        rclone link lumi-46YXXXXXX-private:training.private/HTML/private.html
        ```

        will produce output that will look like this:

        ```
        2024/12/04 21:43:29 NOTICE: S3 bucket training.private path HTML: Public Link: Reducing expiry to 1w as off is greater than the max time allowed
        https://lumidata.eu/training.private/HTML/private.html?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=KEII85V27JOJTCGM6XQQ%2F20241204%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241204T194329Z&X-Amz-Expires=604800&X-Amz-SignedHeaders=host&X-Amz-Signature=35a3bc04d997d50471ecd1a6637cd063f9dfb2a40e173f758030d6ced48926bf
        ```

        Note that the validity is automatically restricted to 7 days (604800 seconds) which is a limit imposed by LUMI, but the link would actually fail
        sligthly earlier as the key expires if the lifetime of the key used to create the link, is not extended.

        One can also set a shorter link lifetime, e.g.,

        ```
        rclone link --expire 2d lumi-46YXXXXXX-private:training.private/HTML/private.html
        ```

        which will produce output that will look like this:

        ```
        https://lumidata.eu/training.private/HTML/private.html?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=KEII85V27JOJTCGM6XQQ%2F20241204%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20241204T194645Z&X-Amz-Expires=172800&X-Amz-SignedHeaders=host&X-Amz-Signature=055f936dc0c23576cf2ba6211c4465f6f2488501c27a7096d0c9af0925d8f884
        ```

        so just the URL without further warning. But if you analyse the URL carefully, you see the field 
        `X-Amz-Expires=172800` which indicates that the link expires after 2 days or 172800 seconds.

        Now just copy the URL and check in a browser...

10. **Data sharing example** On LUMI, `project_462000265` is used to store 
    materials from previous trainings given by LUST, HPE and AMD, and make some of those materials
    available on the web. However, you are not part of that project so cannot request an authentication key for that
    project. But, as some files are public, you are able to access some buckets and objects in this project with
    some tools. We've created two buckets, `intro-training.public` and `intro-training.private` with the same contents
    and ACLs as the `training.public` and `training.private` buckets in the `project_46YXXXXXX` training project.
    Let's see if we can access them with command line tools.

    List the objects in both buckets.

    ??? Solution "Click here to see the solution."

        -   With `s3cmd`: 

            ```
            s3cmd ls --recursive s3://462000265:intro-training.public/
            ```

            returns something along the lines of

            ```
            2025-02-12 14:05   231   s3://462000265:intro-training.public/HTML/public.html
            2025-02-12 14:05   343   s3://462000265:intro-training.public/HTML/shared.html
            2025-02-12 14:05    58   s3://462000265:intro-training.public/private-in-public.txt
            2025-02-12 14:05    57   s3://462000265:intro-training.public/public-in-public.txt
            ```

            while

            ```
            s3cmd ls --recursive s3://462000265:intro-training.private/
            ```

            returns

            ```
            ERROR: Access to bucket '462000265:intro-training.private' was denied
            ERROR: S3 error: 403 (AccessDenied)
            ```

            This should not surprise you, as you are not a member of the `462000265` project and are not using
            access credentials for that project in this exercise, but for `46YXXXXXX` training project.

            Note that in the first command we did list an object whose name suggests that it is a private object.

        -   With `rclone`: 

            ```
            rclone ls lumi-46YXXXXXX-private:"462000265:intro-training.public"
            ``` 

            returns something along the lines of

            ```
                231 HTML/public.html
                343 HTML/shared.html
                58 private-in-public.txt
                57 public-in-public.txt
            ```

            while

            ```
            rclone ls lumi-46YXXXXXX-private:"462000265:intro-training.private"
            ``` 

            returns something similar to

            ```
            2024/12/07 19:39:03 Failed to ls: AccessDenied:
                status code: 403, request id: tx0000092793a87e000e519-0067548837-61b0c46-lumi-prod, host id:
            ```

            so an error (as we would expect, see the comments for the solution with `s3cmd`)

11. We continue on the data sharing example. 
    Can we check the ACLs of the objects in the `intro-training.public` bucket?

    ??? Solution "Click here to see the solution." 

        For this exercise, `s3cmd` is our friend.

        Let's try for `public-in-public.txt`: The output of

        ```
        s3cmd info s3://462000265:intro-training.public/public-in-public.txt
        ```

        actually produces output with an error message. The precise output:

        ```
        File size: 57
        Last mod:  Sat, 07 Dec 2024 17:31:04 GMT
        MIME type: text/plain
        Storage:   STANDARD
        MD5 sum:   db24072368ff20ad202395aa7dd66487
        SSE:       none
        Policy:    Not available: GetPolicy permission is needed to read the policy
        ERROR: Access to bucket '462000265:intro-training.public' was denied
        ERROR: S3 error: 403 (AccessDenied)
        ```

        The reason is that listing permissions does require more rights than the ones we have in the bucket
        because even though the bucket itself is actually public to the world, this is not enough
        to also check permissions.

12. We continue on the data sharing example. 
    Download the `HTML/public.html` from the `intro-training.public` bucket in `project_465000265`.
    We couldn't check in the previous exercise, but this is actually a public object in a public
    bucket.
    Can you do so with a web browser also (or the `wget` or `curl` commands if you are familiar
    with them)?
    
    ??? Solution "Click here to see the solution."

        -   With `s3cmd`:
  
            ```
            s3cmd get s3://462000265:intro-training.public/HTML/public.html
            ```

        -   With `rclone`:

            ```
            rclone copy lumi-46YXXXXXX-private:"462000265:intro-training.public/HTML/public.html" .
            ```

        -   With a web browser: both the URL
            [https://462000265.lumidata.eu/intro-training.public/HTML/public.html](https://462000265.lumidata.eu/intro-training.public/HTML/public.html)
            and 
            [https://lumidata.eu/462000265:intro-training.public/HTML/public.html](https://lumidata.eu/462000265:intro-training.public/HTML/public.html)
            work.

        -   With the `wget` command: both

            ```
            wget https://462000265.lumidata.eu/intro-training.public/HTML/public.html
            ```

            and

            ```
            wget https://lumidata.eu/462000265:intro-training.public/HTML/public.html
            ```

            work.

        -   With the `curl` command: Both

            ```
            curl https://462000265.lumidata.eu/intro-training.public/HTML/public.html
            ```

            and

            ```
            curl https://lumidata.eu/462000265:intro-training.public/HTML/public.html
            ```

            will print the content of the file on the terminal.

            ```
            curl -o public.html https://462000265.lumidata.eu/intro-training.public/HTML/public.html
            ```

            would store the result in the file `public.html` in the current directory.


13. There is no equivalent to exercise 13 from the series to be made during a course.

14. Should you want to clean up your space on LUMI-O and remove the buckets used in the 
    exercise, there is a script for that.

    In the directory with LUST exercises that were downloaded following the
    [instructions to set up for the exercises](index.md#setting-up-for-the-exercises),
    go into the `ObjectStorage` directory. In that directory, run the `delete_buckets.sh`
    script with your project number `46YXXXXXX` as the argument:

    ```
    ./delete_buckets.sh 46YXXXXXX
    ```

    The buckets should now be removed.



