# Exercises: Accessing LUMI

See [the instructions](index.md#setting-up-for-the-exercises)
to set up for the exercises.

1.  Log on to an arbitrary login node of LUMI.

    Can you find how to check your quota and status of your allocation?

    ??? Solution "Click to see the solution."
        How to check your quota and status of your allocation, is explained in
        the message-of-the-day at the bottom of the "Announcements" section:
        you can use the `lumi-workspaces` command.

        The `lumi-workspaces` command uses Lustre commands to check the quota
        in real-time. It will however get stuck if one of the Lustre filesystems
        used by your project or user account, is unavailable. In that case we still
        have the `lumi-ldap-userinfo` and `lumi-ldap-projectinfo` commands. Don't try
        to understand all output of those commands. They are meant to be used by the 
        LUMI User Support Team in the first place. However, it does show the last
        stored quota. But it can take a while after, e.g., deleting files before
        that shows up in this data (typically up to one hour, but longer in case
        of technical problems on the system which you may not always notice).


2.  How can you log on to a specific login node of LUMI, e.g., the login node "uan01"?
  
    ??? Solution "Click to see the solution."
        To log in to the login node "uan01", use the hostname `lumi-uan01.csc.fi`
        instead of `lumi.csc.fi`.

        This may be useful if you use software on your desktop that tries to connect
        repeatedly to LUMI and then tries to find, e.g., a running server that it 
        created before.

3.  Create a shell on a login node using the Open OnDemand web interface.
  
    ??? Solution "Click to see the solution."
        -   Point your web browser to 
            [`https://www.lumi.csc.fi`](https://www.lumi.csc.fi). 
            With some browsers
            it is sufficient to type `lumi.csc.fi` in the address bar while others
            require `www.lumi.csc.fi`.
        -   Click the "Go to login" button. What you need to do here, depends on how
            you got your account. Most users in the course will have to use the "Login Puhuri"
            choice, but if you got your userid via a 462 project, it will be "Login Haka" or in rare
            cases "Login CSC".
        -   Once you're in the web interface, click on "Login node shell" (likely the third
            choice on the first line). It will open a new tab in the browser with a login shell
            on LUMI. Note that Open OnDemand uses a different set of login nodes.

            The "Login node shell" app does not require billing units, but has the
            same restrictions on use as the regular login nodes. It should not be
            used for heavy computations. The "Compute node shell" app will give you
            an interactive shell on a specific set of compute nodes set aside for
            interactive use, but will be charged to your billing units. It will give
            you exclusive access to a number of cores and associated memory. 
            The "Desktop" app gives you a richer environment, but will also require
            billing units. Depending on the type of node that you use for this,
            this will require either CPU or GPU billing units, but more about 
            that in the [session on Slurm](M201-Slurm.md) on day 2 of this course.

4.  Try to transfer a file from your desktop/laptop to your home directory via the Open OnDemand web interface.

    ??? Solution "Click to see the solution."
        -   Go back into Open OnDemand if you have left it after the previous exercise.
        -   On the main screen of the web interface, choose "Home directory".
        -   Depending on the browser and your system you may be able to just drag-and-drop files 
            into the frame that shows your files, or you can click the blue "Upload" button towards
            the top of the screen.
