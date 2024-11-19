# Demo option 2: A short walk-through for distributed learning

In this demo, we will install one of the PyTorch containers provided on LUMI
and run a simple distributed learning example that the LUMI User Support Team also uses
for internal testing.

The demo follows largely the instructions for distributed learning from the
[PyTorch page in the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/).

This demo shows:

-   How to install one of the containers for which we provide EasyBuild recipes

-   How to use our more recent PyTorch containers for distributed learning


## Video of the demo

<video src="https://462000265.lumidata.eu/2day-20240502/recordings/Demo2-Distributed_learning.mp4" controls="controls">
</video>


## Step 1: Getting some files that we will use

Let's create an installation directory for the demo. Set the environment variable
`installdir` to a proper value for the directories on LUMI that you have access to.

``` bash
installdir=/project/project_465001102/kurtlust/DEMO2
mkdir -p "$installdir" ; cd "$installdir"
```

We are now in the installation directory of which we also ensured its existence first.
Let's now download some files that we will use:

``` bash
wget https://raw.githubusercontent.com/Lumi-supercomputer/lumi-reframe-tests/main/checks/containers/ML_containers/src/pytorch/mnist/mnist_DDP.py
mkdir -p model ; cd model
wget https://github.com/Lumi-supercomputer/lumi-reframe-tests/raw/main/checks/containers/ML_containers/src/pytorch/mnist/model/model_gpu.dat
cd ..
```

The first two files are actually files that were developed for testing some PyTorch containers 
on LUMI after system upgrades.

The demo also uses a popular dataset (one of the MNIST datasets) from 
[Yann LeCun](https://www.linkedin.com/in/yann-lecun/), a data scientist at Meta.
The pointers to the dataset are actually included in the `torchvision` package which is why it is not
easy to track where the data comes from. 
The script that we use will download the data if it is not present, but does so on each process, leading
to a high load on the web server providing the data and throttling after a few tries, so we will prepare the data
instead in the `$installdir` subdirectory:

```bash
mkdir -p data/MNIST/raw
wget --recursive --level=1 --cut-dirs=3 --no-host-directories \
    --directory-prefix=data/MNIST/raw --accept '*.gz' http://yann.lecun.com/exdb/mnist/
gunzip data/MNIST/raw/*.gz
for i in $(seq 0 31); do ln -s data "data$i"; done
```


## Step 2: Installing the container

We can find an overview of the available PyTorch containers on the
[PyTorch page in the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/).
We'll use a version that already has support for Python virtual environments built in as that 
will make it a lot easier to install extra Python packages. 

First we need to load and configure EasyBuild and make sure that EasyBuild can run in a clean
environment:

``` bash
module purge
module load LUMI/23.09 partition/container EasyBuild-user
```

The `partition/container` is a "special" partition whose main purpose is to tell EasyBuild-user (and other modules
that we use to install software on the system) to configure EasyBuild to install container modules. Afterwards,
these containers are available in any partition of the `LUMI` stacks and in the `CrayEnv` stack. 
The `EasyBuild-user` module here is responsible of configuring EasyBuild and also ensures that a proper version of EasyBuild
is loaded.

After loading `EasyBuild-user`, installing the container from the EasyBuild recipe is very easy:

``` bash
eb PyTorch-2.2.0-rocm-5.6.1-python-3.10-singularity-20240315.eb
```

We're now finished with EasyBuild so don't need the modules related to EasyBuild anymore. So lets's clean
the environment an load the PyTorch container module that we just built with EasyBuild:

``` bash
module purge
module load LUMI/23.09
module load PyTorch/2.2.0-rocm-5.6.1-python-3.10-singularity-20240315
```

Note that the module defines two environment variables that point to the `.sif` file of the container:

``` bash
echo $SIF
echo $SIFPYTORCH
```

All our container modules provide the `SIF` environment variable, but the name of the second one depends on the
name of the package, and it may be safer to use should you load multiple container modules of different packages
to quickly switch between them.

!!! Note "If you're really concerned about disk space..."
    ... you may chose to delete the version of the container that we have installed. To continue, you then
    need to reload the `PyTorch` module:

    ``` bash
    rm -f $SIF
    module load PyTorch/2.2.0-rocm-5.6.1-python-3.10-singularity-20240315
    ```

    Now check again the `SIF` and `SIFPYTORCH` environment variables and note that they now point to
    files in `/appl/local/containers`:

    ``` bash
    echo $SIF
    echo $SIFPYTORCH
    ```

    We do not recommend you remove the container file as your module will stop working if the image
    is removed from `/appl/local/containers` which we do when we deem the file not useful anymore as it
    causes trouble for too many users. But it may still work fine for what you do with it...

All containers with module files also define the environment variable `CONTAINERROOT`, pointing to the 
directory in which EasyBuild installs the `.sif` file (and not pointing to `/appl/local/containers` if
you've removed the container `.sif` file). The standard EasyBuild variable `EBROOTPYTORCH` is also defined
and serves the same purpose, but of course has a different name for other packages.

Let's do some checks:

``` bash
singularity shell $SIF
``` 

brings us into the container (note that the command prompt has changed).

The command

``` bash
which python
```

returns

```
/user-software/venv/pytorch/bin/python
```

which shows that the virtual environment pre-installed in the container is indeed active.

Let's leave the container again:

``` bash
exit
```

and check the `$CONTAINERROOT` directory:

``` bash
module load systools
tree $CONTAINERROOT
```

There is a lot of stuff in there. If we scroll up enough, we see:

-   A subdirectory `easybuild` which among other things turns out to contain copies
    of the EasyBuild recipe that we used. This directory basically contains all important
    files to reproduce the installation, except for the container it used itself.

-   The `user-software` subdirectory contains all the files that can
    be found in the container also in `/user-software`. (It is simply bound to 
    that directory in the container through an environmet variable that the module sets.) 

-   There is a `bin` subdirectory with some scripts. The `start-shell` script is only there
    for historical reasons and compatibility with some other containers, but the 
    `make-squashfs` and `unmake-squashfs` files are useful and can be used to make the Python
    virtual environment more filesystem-friendly by converting the `user-software` subdirectory
    into a SquashFS file which is then mounted in the container.

-   The `runscripts` subdirectory contains some scripts that we will use to simplify
    running the container. The scripts by no means cover all use cases, but they are nice
    examples about how scripts for your specific tasks could be written.
    This directory is also mounted in the container as `/runscripts` so that it is
    easy to access.


## Step 3: Running a distributed learning example.

The `conda-python-distributed` script is written to ease distributed learning with PyTorch.
Distributed learning requires some initialisation of environment variables that are used by
PyTorch or by libraries from the ROCm<sup>TM</sup> stack. It passes its arguments to the
Python command. It is mostly meant to be used on full nodes with one task per GPU, as in 
other cases not all initialisations make sense or are even valid.

Let's check the script:

``` bash
cat $CONTAINERROOT/runscripts/conda-python-distributed
```

The first block,

``` bash
if [ $SLURM_LOCALID -eq 0 ] ; then
    rocm-smi
fi
sleep 2
```

has mostly a debugging purpose. One task per node will run `rocm-smi` on that node and its output can
be used to check if all GPUs are available as expected. The `sleep` command is there because we have
experienced that sometimes there is still stuff going on in the background that may prevent later
commands to fail.
<!-- TODO Is this right and is the sleep command really needed? -->

The next block does some very needed initialisations for the MIOpen cache, an important library
for neural networks, as the default location causes problems on LUMI as Lustre locking is not 
compatible with MIOpen:

``` bash
export MIOPEN_USER_DB_PATH="/tmp/$(whoami)-miopen-cache-$SLURM_NODEID"
export MIOPEN_CUSTOM_CACHE_DIR=$MIOPEN_USER_DB_PATH

# Set MIOpen cache to a temporary folder.
if [ $SLURM_LOCALID -eq 0 ] ; then
    rm -rf $MIOPEN_USER_DB_PATH
    mkdir -p $MIOPEN_USER_DB_PATH
fi
sleep 2
```

These commands basically move the cache to a subdirectory of `/tmp`.

Next we need to tell RCCL, the communication library, which interfaces it should use
as otherwise it may try to communicate over the management network of LUMI which does
not work. This is done through some `NCCL_*` environment variables which may be counterintuitive,
but RCCL is basically the equivalent of NVIDIA NCCL.

``` bash
export NCCL_SOCKET_IFNAME=hsn0,hsn1,hsn2,hsn3
export NCCL_NET_GDR_LEVEL=3
```

Fourth, we need to ensure that each task uses the proper GPU. This is one point where we 
assume that one GPU (GCD) per task is used. The script also assumes that the
["Linear assignment of GCD, then match the cores" idea](08-Binding.md#linear-assignment-of-gcd-then-match-the-cores)
is used, so we will need some more complicated CPU mapping in the job script.

PyTorch also needs some initialisation that are basically the same on NVIDIA and
AMD hardware. This includes setting a master for the communication (the first node of 
a job) and a port for the communication. That port is hard-coded, so a second instance
of the script on the same node would fail. So we basically assume that we use full nodes.
To determine that master, another script from the `runscripts` subdirectory is used.

``` bash
export MASTER_ADDR=$(/runscripts/get-master "$SLURM_NODELIST")
export MASTER_PORT=29500
export WORLD_SIZE=$SLURM_NPROCS
export RANK=$SLURM_PROCID
```

Now we can turn our attention to the job script. Create a script `mnist.slurm` in
the demo directory `$installdir` by copying the code below:

``` bash
#!/bin/bash -e
#SBATCH --nodes=4
#SBATCH --gpus-per-node=8
#SBATCH --output="output_%x_%j.txt"
#SBATCH --partition=standard-g
#SBATCH --mem=480G
#SBATCH --time=5:00
#SBATCH --account=project_<your_project_id>

module load LUMI/23.09
module load PyTorch/2.2.0-rocm-5.6.1-python-3.10-singularity-20240315

c=fe
MYMASKS="0x${c}000000000000,0x${c}00000000000000,0x${c}0000,0x${c}000000,0x${c},0x${c}00,0x${c}00000000,0x${c}0000000000"

srun --ntasks=$((SLURM_NNODES*8)) --cpu-bind=mask_cpu:$MYMASKS \
  singularity exec $SIFPYTORCH \
    conda-python-distributed -u mnist_DDP.py --gpu --modelpath model
```

Launch the script by setting some environment variables to use the course account and reservation:

``` bash
export SBATCH_ACCOUNT=project_465001102
export SBATCH_RESERVATION=TODO
```

and then launching the job script:

``` bash
sbatch mnist.slurm
```

(After the course, use any valid project with GPU billing units and omit the `SBATCH_RESERVATION` environment
variable)

When the job script ends (which is usually fast once it gets the resources to run),
the output can be found in `output_mnist.slurm_1234567.txt` where you need to
replace `1234567` with the actual job id.
