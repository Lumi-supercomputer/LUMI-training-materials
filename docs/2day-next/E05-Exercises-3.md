# Exercises 3: LUMI Software Stacks and EasyBuild

See [the instructions](index.md#setting-up-for-the-exercises)
to set up for the exercises.

## Information in the LUMI Software Library  

Explore the [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/).

-   Search for information for the package ParaView and quickly read through the page

??? Solution "Click to see the solution."
    [Link to the ParaView documentation](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/ParaView/)

    It is an example of a package for which we have both user-level and some technical information. The page
    will first show some license information, then the actual user information which in case of this package
    is very detailed and long. But it is also a somewhat complicated package to use. It will become easier
    when LUMI evolves a bit further, but there will always be some pain. Next comes the more technical
    part: Links to the EasyBuild recipe and some information about how we build the package.

    We currently only provide ParaView in the cpeGNU toolchain. This is because it has a lot of dependencies
    that are not trivial to compile and to port to the other compilers on the system, and EasyBuild is 
    strict about mixing compilers basically because it can cause a lot of problems, e.g., due to conflicts
    between OpenMP runtimes.


## Using modules in the LUMI software stack

41.  Search for the `bzip2` tool (and not just the `bunzip2` command as we also need the `bzip2` command) and make 
    sure that you can use software compiled with the Cray compilers in the LUMI stacks in the same session.

    ??? Solution "Click to see the solution."

        ```
        module spider bzip2
        ```

        shows that there are versions of `bzip2` for several of the `cpe*` toolchains and in several versions
        of the LUMI software stack.

        Of course we prefer to use a recent software stack, the `22.08` or `22.12` (but as of early May 2023, 
        there is a lot more software ready-to-install for `22.08`). 
        And since we want to use other software
        compiled with the Cray compilers also, we really want a `cpeCray` version to avoid conflicts between 
        different toolchains. So the module we want to load is `bzip2/1.0.8-cpeCray-22.08`.

        To figure out how to load it, use

        ```
        module spider bzip2/1.0.8-cpeCray-22.08
        ```

        and see that (as expected from the name) we need to load `LUMI/22.08` and can then use it in any of the
        partitions.





## Installing software with EasyBuild

*These exercises are based on material from the [EasyBuild tutorials](http://tutorial.easybuild.io/)
(and we have a [special version for LUMI](https://lumi-supercomputer.github.io/easybuild-tutorial/2022-CSC_and_LO/) also).*

*Note*: If you want to be able to uninstall all software installed through the exercises
easily, we suggest you make a separate EasyBuild installation for the course, e.g.,
in `/scratch/project_465000523/$USER/eb-course` if you make the exercises during the course:

-   Start from a clean login shell with only the standard modules loaded.
-   Set `EBU_USER_PREFIX`: 
     
    ```
    export EBU_USER_PREFIX=/scratch/project_465000523/$USER/eb-course
    ```

    You'll need to do that in every shell session where you want to install or use that software.

-   From now on you can again safely load the necessary `LUMI` and `partition` modules for the exercise.
  
-   At the end, when you don't need the software installation anymore, you can simply remove the directory
    that you just created.

    ```
    rm -rf /scratch/project_465000523/$USER/eb-course
    ```


### Installing a simple program without dependencies with EasyBuild

The LUMI Software Library contains the package `eb-tutorial`. Install the version of
the package for the `cpeCray` toolchain in the 22.08 version of the software stack.

*At the time of this course, in early May 2023, we're still working on EasyBuild build
recipes for the 22.12 version of the software stack.*

??? Solution "Click to see the solution."
    -   We can check the 
        [eb-tutorial page](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/e/eb-tutorial)
        in the 
        [LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs)
        if we want to see more information about the package.
    
        You'll notice that there are versions of the EasyConfigs for `cpeGNU` and `cpeCray`.
        As we want to install software with the `cpeCray` toolchain for `LUMI/22.08`, we'll
        need the `cpeCray-22.08` version which is the EasyConfig
        `eb-tutorial-1.0.1-cpeCray-22.08.eb`.

    -   Obviously we need to load the `LUMI/22.08` module. If we would like to install software
        for the CPU compute nodes, you need to also load `partition/C`.
        To be able to use EasyBuild, we also need the `EasyBuild-user` module.

        ```
        module load LUMI/22.08 partition/C
        module load EasyBuild-user
        ```

    -   Now all we need to do is run the `eb` command from EasyBuild to install the software.

        Let's however take the slow approach and first check if what dependencies the package needs:

        ```
        eb eb-tutorial-1.0.1-cpeCray-22.08.eb -D
        ```

        We can do this from any directory as the EasyConfig file is already in the LUMI Software Library
        and will be located automatically by EasyBuild. You'll see that all dependencies are already on 
        the system so we can proceed with the installation:

        ```
        eb eb-tutorial-1.0.1-cpeCray-22.08.eb 
        ```

    -   After this you should have a module `eb-tutorial/1.0.1-cpeCray-22.08` but it may not show up 
        yet due to the caching of Lmod. Try

        ```
        module av eb-tutorial/1.0.1-cpeCray-22.08
        ```

        If this produces an error message complaining that the module cannot be found, it is time to clear
        the Lmod cache:

        ```
        rm -rf $HOME/.lmod.d/.cache
        ```
    -   Now that we have the module, we can check what it actually does:

        ```
        module help eb-tutorial/1.0.1-cpeCray-22.08
        ```

        and we see that it provides the `eb-tutorial` command.

    -   So let's now try to run this command:

        ```
        module load eb-tutorial/1.0.1-cpeCray-22.08
        eb-tutorial
        ```

        Note that if you now want to install one of the other versions of this module, EasyBuild will
        complain that some modules are loaded that it doesn't like to see, including the `eb-tutorial`
        module and the `cpeCray` modules so it is better to unload those first:

        ```
        module unload cpeCray eb-tutorial
        ```

### Installing an EasyConfig given to you by LUMI User Support

Sometimes we have no solution ready in the LUMI Software Library, but we prepare one or more
custom EasyBuild recipes for you. Let's mimic this case. In practice we would likely send 
those as attachments to a mail from the ticketing system and you would be asked to put
them in a separate directory (basically since putting them at the top of your home
directory would in some cases let EasyBuild search your whole home directory for dependencies
which would be a very slow process).

You've been given two EasyConfig files to install a tool called `py-eb-tutorial` which is in fact
a Python package that uses the `eb-tutorial` package installed in the previous exercise. These
EasyConfig files are in the `EasyBuild` subdirectory of the exercises for this course.
In the first exercise you are asked to install the version of `py-eb-tutorial` for the
`cpeCray/22.08` toolchain.

??? Solution "Click to see the solution."
    -   Go to the `EasyBuild` subdirectory of the exercises and check that it indeed contains the
        `py-eb-tutorial-1.0.0-cpeCray-22.08-cray-python-3.9.12.1.eb` and
        `py-eb-tutorial-1.0.0-cpeGNU-22.08-cray-python-3.9.12.1.eb` files.
        It is the first one that we need for this exercise.

        You can see that we have used a very long name as we are also using a version suffix to
        make clear which version of Python we'll be using.

    -   Let's first check for the dependencies (out of curiosity):

        ```
        eb py-eb-tutorial-1.0.0-cpeCray-22.08-cray-python-3.9.12.1.eb -D
        ```

        and you'll see that all dependencies are found (at least if you made the previous exercise 
        successfully). You may find it strange that it shows no Python module but that is because
        we are using the `cray-python` module which is not installed through EasyBuild and only
        known to EasyBuild as an external module.

    -   And now we can install the package:

        ```
        eb py-eb-tutorial-1.0.0-cpeCray-22.08-cray-python-3.9.12.1.eb
        ```

    -   To use the package all we need to do is to load the module and to run the command that it
        defines:

        ```
        module load py-eb-tutorial/1.0.0-cpeCray-22.08-cray-python-3.9.12.1
        py-eb-tutorial
        ```

        with the same remark as in the previous exercise if Lmod fails to find the module.

        You may want to do this step in a separate terminal session set up the same way, or you
        will get an error message in the next exercise with EasyBuild complaining that there are
        some modules loaded that should not be loaded.


### Installing software with uninstalled dependencies

Now you're asked to also install the version of `py-eb-tutorial` for the `cpeGNU` toolchain in `LUMI/22.08`
(and the solution given below assumes you haven'ty accidentally installed the wrong EasyBuild recipe in one
of the previous two exercises).

??? Solution "Click to see the solution."
    -   We again work in the same environment as in the previous two exercises. Nothing has changed here.
        Hence if not done yet we need

        ```
        module load LUMI/22.08 partition/C
        module load EasyBuild-user
        ```

    -   Now go to the `EasyBuild` subdirectory of the exercises (if not there yet from the previous
        exercise) and check what the `py-eb-tutorial-1.0.0-cpeGNU-22.08-cray-python-3.9.12.1.eb` needs:

        ```
        eb py-eb-tutorial-1.0.0-cpeGNU-22.08-cray-python-3.9.12.1.eb -D
        ```

        We'll now see that there are two missing modules. Not only is the 
        `py-eb-tutorial/1.0.0-cpeGNU-22.08-cray-python-3.9.12.1` that we try to install missing, but also the
        `eb-tutorial/1.0.1-cpeGNU-22.08`. EasyBuild does however manage to find a recipe from which this module
        can be built in the pre-installed build recipes.

    -   We can install both packages separately, but it is perfectly possible to install both packages in a single
        `eb` command by using the `-r` option to tell EasyBuild to also install all dependencies.

        ```
        eb py-eb-tutorial-1.0.0-cpeGNU-22.08-cray-python-3.9.12.1.eb -r
        ```

    -   At the end you'll now notice (with `module avail`) that both the module 
        `eb-tutorial/1.0.1-cpeGNU-22.08` and `py-eb-tutorial/1.0.0-cpeGNU-22.08-cray-python-3.9.12.1`
        are now present.

        To run you can use

        ```
        module load py-eb-tutorial/1.0.0-cpeGNU-22.08-cray-python-3.9.12.1
        py-eb-tutorial
        ```

