# Application Placement

*Presenter: Jean-Yves Vet (HPE)*


## Materials

Temporary location of materials (for the lifetime of the training project):

-   Slides: `/project/project_465001154/Slides/HPE/04_Application_Placement.pdf`

Archived materials on LUMI:

-   Slides: `/appl/local/training/paow-20240611/files/LUMI-paow-20240611-1_04_Application_Placement.pdf`

-   Recording: `/appl/local/training/paow-20240611/recordings/1_04_ApplicationPlacement.mp4`

These materials can only be distributed to actual users of LUMI (active user account).

Bash functions to convert between hexadecimal and binary (slide 17):

``` bash
# Convert hexa to binary
0x () {
    local val=$(tr '[a-z]' '[A-Z]' <<< $1)
    echo "binary: `BC_LINE_LENGTH=0 bc <<< \"ibase=16;obase=2;$val\"`" 
}
# Convert binary to hexa
0b () {
    local val=$(tr '[a-z]' '[A-Z]' <<< $1)
    echo "hexa: `BC_LINE_LENGTH=0 bc <<< \"ibase=2;obase=10000;$val\"`"
}
```

## Links

-   [Extended version of the talk in the 4-day comprehensive course of April 2024](../4day-20240423/extra_2_05_Advanced_Application_Placement.md)


## Q&A

/
