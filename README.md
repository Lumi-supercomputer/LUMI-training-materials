# LUMI training materials repository

## Processing

The web site is currently not build via GitHub actions but is built offline
on a PC. The tool used is `mkdocs` as is also used for the 
[mail LUMI documentation](https://github.com/Lumi-supercomputer/lumi-userguide).
However, the version of the software that is used to build this web site may be
different, and some additional packages may be employed. See the 
`requirements.txt` file in the repository.

All development is done in a fork of the repository. GitHub is set up with
`upstream` as the remote name for the 
[main repository on the lumi-supercomputer GitHub](https://github.com/Lumi-supercomputer/LUMI-training-materials)
while `origin`is used as the remote name for the fork in which all work is being done.

IF the repositories are set up in this way, then the following Makefile targets can
be used to build the web site:

-   `serve` or `preview`: Preview the web site on your computer. (Point the browser to - usually - localhost:8000)
-   `build`: Build locally, not very useful.
-   `deploy-origin`: Deploy the web site to the remote `origin`, i.e., the fork, which is ideal for testing without
    disrupting the production site.
-   `deploy-upstream`: Deploy the web site to the remote `upstream`, i.e., the 
    [production site on lumi-supercomputer.github.io](https://lumi-supercomputer.github.io/LUMI-training-materials/)


## Structure of the docs subdirectory

-   Each regular course has its own subdirectory with materials in the `docs` subdirectory. As such it becomes
    rather easy to archive that material when no longer relevant.

    Hackaton materials are also considered as a course.

    Each course also has its own subdirectory in the LUMI-training-lumio `courses` subdirectory. The capitalisation
    of the name in there may be different as it has to be a valid bucket name and it turns out that it the character
    range that can be used for the name of a bucket on LUMI-O is rather limited, e.g., no capitals.

-   The user coffee break material is considered as a special course, so get a subdirectory (`User-Coffee-Breaks`) 
    with further organisation in that subdirectory. 
    There is currently a single bucket on LUMI-O for all material of the coffee breaks (`user-coffee-breaks`).

-   The User Update docs and sessions made after some system updates are also together considered as a special course
    with currently a single bucket on LUMI-O for all material. Again we do make a further structure in the `User-Updates` 
    subdirectory in this repository and can do the same in the `user-updates` bucket.

Other subdirectories:

-   `docs/assets` currently only contains the favicon.
-   `docs/stylesheets` contains the stylesheet used to define extra admonitions.
-   The contents of `site_customisations` is largely based on that for the LUMI docs


## Data management

Large files (e.g., tar files, images, PDFs) are not stored on GitHub but on
LUMI-O. The data is pushed to LUMI-O from a laptop on which the data is
prepared using `rclone`. Some data is public, some data is private. 
Scripts to facilitate data management per course can be found in the
[LUMI-training-lumio repository](https://github.com/klust/LUMI-training-lumio)
but the way of working may need some further information that will be provided
in that repository.
