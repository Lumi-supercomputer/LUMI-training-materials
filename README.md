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


## Data management

Large files (e.g., tar files, images, PDFs) are not stored on GitHub but on
LUMI-O. The data is pushed to LUMI-O from a laptop on which the data is
prepared using `rclone`. Some data is public, some data is private. 
Scripts to facilitate data management per course can be found in the
[LUMI-training-lumio repository](https://github.com/klust/LUMI-training-lumio)
but the way of working may need some further information that will be provided
in that repository.
