# Exercises: LUMI-O object storage


Most of these exercises require access to the training project and hence can only be made
during the course sessions or immediately thereafter.



## Ideas for the exercises

-   Use lumio-conf to create a config file for s3cmd.
-   Verify the ACLs for the buckets and objects in the training project
    -   List buckets and objects
    -   Verify the ACLs
-   Check that you can access a public object in both a private and a public object in the training project.
-   TODO: Can we list something in 462000265?
-   Create a sharing link to a private bucket private object and check in a private browser window that it indeed works.
-   Use rclone to create a public bucket and put an example file in it. View that file via a web link.

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

2.  Now go in to the [web credentials management system auth.lumidata.eu](https://auth.lumidata.eu/), find back the
    authentication key that we created in the previous exercise, and generate an s3cmd config file for it in the browser
    (no need to also install it on the system, but what would be the right filename?)

    Do not close your browser window after this exercise as it will prove useful for other exercises./

    ??? Solution "Click to see the solution"

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
            # Generated for truser
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
            `~/.s3cfg`.

3.  Use the `lumio-conf` command line tool to generate a configuration for `s3cmd` and for `rclone`.

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


## Exercises that can be made in your own project

These exercises and scripts are still under development.



