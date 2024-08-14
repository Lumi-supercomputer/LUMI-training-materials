# Changes after the update of August-September 2024

Major changes to the programming environments:

-   ROCm 6.0.3 is now the default ROCm version.

    The installed driver should be able to install ROCm version 5.6 to 6.2,
    but that does not imply that all of those versions will work with all
    versions of the Cray Programming Environment.

-   The new 24.03 programming environment is the **only programming environment
    that is fully supported by HPE** as it is the only programming environment on
    the system with official support for the current version of the operating
    system and ROCm 6.0.

    It is therefore also the system default version of the programming environment.

    This implies that if you experience problems, the answer might be that you
    will have to move to 24.03 or at least try if the problems occur there too.

-   The second new programming environment on the system is 23.12. This is offered
    "as is", and problems cannot be excluded, especially with GPU software, as this
    version does not officially support ROCm 6.0.

-   Older programming environments on the system are offered "as is" as they do 
    not support the current version of the OS nor do they support ROCm 6.

    In fact, even repairing by trying to install the user-level libraries of older 
    versions of ROCm may not be a solution, as the versions that are fully
    supported by those programming environments are not supported by the current
    ROCm driver on the system, and there can be only one driver.

    Expect problems in particular with GPU code.

-   Some major changes to the programming environment:

    -   The `amd/6.0.3` module does not offer the complete ROCm environment as older
        versions did. So you may now have to load the `rocm/6.0.3` module also pretty
        much as was needed with the other programming environments for complete ROCm
        support.

    -   23.12 and 24.03 use the `gcc-native` modules. They will, as older versions of the
        programming environment are phased out, completely replace the `gcc` modules.

        Note that using the GNU compilers without wrappers is different from before
        in these modules. E.g., in `gcc-native/12.3`, the compilers are now called
        `gcc-12`, `g++-12` and `gfortran-12`.

        When using the GNU compilers with the wrappers, one should make sure that the
        right version of the wrappers is used with each type of GNU compiler module.
        If you are not using the LUMI stacks, it is best to use the proper `cpe` module
        to select a version of the programming environment and then use the default version
        of the `craype` wrapper module for that version of the CPE.

We are still in the process of building and installing new software stacks based on
the 23.12 and 24.03 versions of the CPE. The `LUMI/23.12` stack will closely resemble
the `23.09` stack as when we started preparing it, it was expected that this stack too
would have been fully supported by HPE (but then we were planning an older version of
ROCm), while the `24.03` stack contains more updates to packages in the central
installation. They will appear on the system when ready. Since problems building a
software stack are unpredictable, we do not make any promises about a specific date.

Note that even though the system default version of the programming environment is
24.03, the default version of the LUMI stack will remain 23.09 until 24.03 is sufficiently
complete. We do encourage all users to **never** load the `LUMI` module without specifying
a version, as that will protect your jobscripts from future changes on the system.
