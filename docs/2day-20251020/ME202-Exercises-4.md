# Exercises 4: Running jobs with Slurm

## Intro

For these exercises, you'll need to take care of some settings:

-   For the CPU exercises we advise to use the `small` partition and for the 
    exercises on GPU the `standard-g` partition.

-   During the course you can use the course training project `project_465001965`
    for these exercises. A few days after the course you will need to use a different project
    on LUMI. 

-   On June 3 we have a reservation that you can use (through `#SBATCH --reservation=...`):
  
    -   For the `small` partition, the reservation name is `LUMI_Intro_1`

    -   For the `standard-g` partition, the reservation name is `LUMI_Intro_2`

An alternative (during the course only) for manually specifying 
the account, the partition and the reservation, is to set
them through modules. For this, first add an additional directory to the module search path:

```
module use /appl/local/training/modules/2day-20251020
```

and then you can load either the module `exercises/intro-C` or `exercises/intro-G`.

!!! Note "Check what these modules do..."
    Try, e.g., 

    ```
    module show exercises/intro-C
    ```

    to get an idea of what these modules do. Can you see which environment variables they set?


## Exercises

Exercises will be made available during the course 

<!--
-   Start with the [exercises on "Slurm on LUMI"](E201-Slurm.md)

    You may want to postpone the advanced exercise a bit as that one takes a lot of time.

-   Proceed with the [exercises on "Process and Thread Distribution and Binding"](E202-Binding.md)
-->

## Q&A

/
