# Exercises 4: Running jobs with Slurm

## Intro

For these exercises, you'll need to take care of some settings:

-   For the CPU exercises we advise to use the `small` partition and for the 
    exercises on GPU the `standard-g` partition.

-   During the course you can use the course training project `project_465002764`
    for these exercises. A few days after the course you will need to use a different project
    on LUMI. 

-   On April 23 we have a reservation that you can use (through `#SBATCH --reservation=...`):
  
    -   For the `small` partition, the reservation name is `lumi_intro_small`

    -   For the `standard-g` partition, the reservation name is `lumi_intro_standard-g`

An alternative (during the course only) for manually specifying 
the account, the partition and the reservation, is to set
them through modules. For this, first add an additional directory to the module search path:

```
module use /appl/local/training/modules/2day-20260422
```

and then you can load either the module `exercises/intro-C` (to use the reservation in the
`small` partition of LUMI-C) or `exercises/intro-G` (to use the reservation in the `standard-g`
partition of LUMI-G).

!!! Note "Check what these modules do..."
    Try, e.g., 

    ```
    module show exercises/intro-C
    ```

    to get an idea of what these modules do. Can you see which environment variables they set?


## Exercises

<!--
Exercises will be made available during the course
-->

-   Start with the [exercises on "Slurm on LUMI"](E201-Slurm.md)

    You may want to postpone the advanced exercise a bit as that one takes a lot of time.

-   Proceed with the [exercises on "Process and Thread Distribution and Binding"](E202-Binding.md)


## A&A

/
