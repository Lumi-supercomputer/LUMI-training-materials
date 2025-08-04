# Container demo 1: Fooocus

[Fooocus](https://github.com/lllyasviel/Fooocus) is an AI-based image generating
package that is available under the
[GNU General Public License V3](https://github.com/lllyasviel/Fooocus/blob/main/LICENSE).

The version on which we first prepared this demo,
insists on writing in the directories with some of the Fooocus files, so we cannot put
Fooocus in a container at the moment.

It is based on PyTorch. However, we cannot use the containers provided on LUMI as-is
as additional system level libraries are needed for the graphics.

This demo shows:

-   Installing one of the containers provided on LUMI with EasyBuild,

-   Installing additional software in the container with the
    [SingularityCE "unprivileged proot builds" process](https://docs.sylabs.io/guides/3.11/user-guide/build_a_container.html#unprivilged-proot-builds)
    and the SUSE Linux `zypper` install tool,

-   Further adding packages in a virtual environment and putting them in 
    a SquashFS file for better file system performance, and

-   Using that setup with Fooocus.


## Video of the demo

This is a video for a previous version of the demo though.

<video src="https://465000095.lumidata.eu/training-materials-web/intro-evolving/recordings/Demo1-Fooocus.mp4" controls="controls">
</video>


## Installing Fooocus


### Step 1: Checking Fooocus

Let's create an installation directory for the demo. Set the environment variable
`installdir` to a proper value for the directories on LUMI that you have access to.

``` bash
installdir=/scratch/project_465002174/$USER/DEMO1
mkdir -p "$installdir" ; cd "$installdir"
```

We are now in the installation directory of which we also ensured its existence first.
Let's now download and unpack Fooocus release 2.5.5 (the one we tested for this demo)

``` bash
fooocusversion=2.5.5
wget https://github.com/lllyasviel/Fooocus/archive/refs/tags/v$fooocusversion.zip
unzip v$fooocusversion.zip
rm -f v$fooocusversion.zip
```

If we check what's in the Fooocus directory:

``` bash
ls Fooocus-$fooocusversion
```

we see a rather messy bunch of mostly Python files missing the traditional setup scripts that you 
expect with a Python package. So installing this could become a messy thing...

It also contains a `Dockerfile` (to build a base Docker container), a `requirements_docker.txt`
and a `requirements_versions.txt` file that give hints about what exactly is needed. 
The `Dockerfile` suggests close to the top that some OpenGL libraries will be needed.
And the fact that it can be fully installed in a docker container also indicates that there
must in fact be ways to run it in readonly directories, but in this demo we'll put Fooocus in
a place were it can write. The `requirements_docker.txt` file also suggests to use Pytorch 2.1.0, but
we'll take some risks though and use a newer version of PyTorch than suggested as for AMD GPUs
it is often important to use recently enough versions (and because that version has a more sophisticated
module better suited for what we want to demonstrate). 


### Step 2: Install the PyTorch container

We can find an overview of the available PyTorch containers on the
[PyTorch page in the LUMI Software Library](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/).
We'll use a version that already has support for Python virtual environments built in as that 
will make it a lot easier to install extra Python packages. Moreover, as we have also seen that we will
need to change the container, we'll follow a somewhat atypical build process.

Rather than installing directly from the available EasyBuild recipes, we'll edit an EasyConfig
to change the name to reflect that we have made changes and installed Fooocus with it.
First we must prepare a temporary directory to do this work and also set up EasyBuild:

``` bash
mkdir -p "$installdir/tmp" ; cd "$installdir/tmp"
module purge
module load LUMI/24.03 partition/container EasyBuild-user
```

We'll now use a function of EasyBuild to copy an existing EasyConfig file to a new location, and
rename it in one move to reflect the module version that we want:

``` bash
eb --copy-ec PyTorch-2.3.1-rocm-6.0.3-python-3.12-singularity-20240923.eb PyTorch-2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923.eb
```

This is not enough to generate a module `PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923`, 
we also need to edit the `versionsuffix` line in the EasyBuild recipe. Of course you can do this easily with
your favourite editor, but to avoid errors we'll use a command for the demo that you only need to copy:

``` bash
sed -e "s|^\(versionsuffix.*\)-singularity-\(.*\)|\1-Fooocus-singularity-\2|" -i PyTorch-2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923.eb
```

Let's check:

``` bash
grep versionsuffix PyTorch-2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923.eb
```

which returns

```
versionsuffix = f'-rocm-{local_c_rocm_version}-python-{local_c_python_mm}-Fooocus-singularity-{local_c_date}'
```

so we see that the `versionsuffix` line looks rather strange but we do see that the `-Fooocus-` part is injected
in the name so we assume everything is OK.

We're now ready to install the container with EasyBuild:

``` bash
eb PyTorch-2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923.eb
```

The documentation in the PyTorch page in the LUMI Software Library suggests that we can now delete the
container file in the installation directory, but this is a bad idea in this case as we want to build our
own container and hence will not use one of the containers provided on the system while running.

We're now finished with EasyBuild so don't need the modules related to EasyBuild anymore. So lets's clean
the environment an load the PyTorch container module that we just built with EasyBuild:

``` bash
module purge
module load LUMI/24.03
module load PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923
```

Notice that we don't need to load `partition/container` anymore. Any partition would do, and in fact, we can 
even use `CrayEnv` instead of `LUMI/24.03`.

Notice that the container module provides the environment variables `SIF` and `SIFPYTORCH`, both of which 
point to the `.sif` file of the container:

``` bash
echo $SIF
echo $SIFPYTORCH
```

We'll make use of that when we add SUSE packages to the container.


### Step 3: Adding some SUSE packages

To update the singularity container, we need three things.

First, the `PyTorch` module cannot be loaded as it sets a number of singularity-related 
environment variables. Yet we want to use the value of `SIF`, so we will simply save it in
a different environment variable before unloading the module:

``` bash
export CONTAINERFILE="$SIF"
module unload PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923
```

Second, the `proot` command is not available by default on LUMI, but it can be enabled by loading
the `systools` module in `LUMI/23.09` or newer stacks, or `systools/23.09` or newer in `CrayEnv`:

``` bash
module load systools
```

Third, we need a file defining the build process for singularity. This is a bit technical and outside
the scope of this tutorial to explain what goes into this file. It can be created with the following shell
command:

``` bash
cat > lumi-pytorch-rocm-6.0.3-python-3.10-pytorch-v2.3.1-Fooocus.def <<EOF

Bootstrap: localimage

From: $CONTAINERFILE

%post

zypper -n install -y Mesa libglvnd libgthread-2_0-0 hostname

EOF
```

You can check the file with

``` bash
cat lumi-pytorch-rocm-6.0.3-python-3.10-pytorch-v2.3.1-Fooocus.def
```

We basically install an OpenGL library that emulates on the CPU and some missing tools.
Note that the AMD MI250X GPUs are not rendering GPUs, so we cannot run hardware accelerated
rendering on them.

An annoying element of the singularity build procedure is that it is not very friendly for
a Lustre filesystem. We'll do the build process on a login node, where we have access
to a personal RAM disk area that will also be cleaned automatically when we log out, which is always
useful for a demo. Therefore we need to set two environment variables for Singularity, and
create two directories, which is done with the following commands:

``` bash
export SINGULARITY_CACHEDIR=/tmp/singularity/cache
export SINGULARITY_TMPDIR=/tmp/singularity/tmp

mkdir -p $SINGULARITY_CACHEDIR
mkdir -p $SINGULARITY_TMPDIR
```

Note that `$SINGULARITY_TMPDIR` can contain a lot of files during the `singularity build` process
as the container will be unpacked in this area.

Now we're ready to do the actual magic and rebuild the container with additional packages
installed in it:

``` bash
singularity build $CONTAINERFILE lumi-pytorch-rocm-6.0.3-python-3.10-pytorch-v2.3.1-Fooocus.def
```

The build process will ask you if you want to continue as it will overwrite the container file,
so confirm with `y`. The whole build process may take a couple of minutes.

We'll be kind to our fellow LUMI users and already clean up the directories that we just created:

``` bash
rm -rf /tmp/singularity
```

Let's reload the container:

``` bash
module load PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923
```

and do some checks:

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

We do have the hostname command in the container (one of the packages mentioned in the
container `.def` file that we created) as is easily tested:

``` bash
hostname
```

and

``` bash
ls /usr/lib64/*mesa*
```

shows that indeed a number of MESA libraries are installed (the OpenGL installation that we did).

```bash
pip list
```

shows that there are already a lot of Python packages in the container.

We can now leave the container with the 

``` bash
exit
``` 

command (or CTRL-D key combination).

So it looks we are ready to start installing Python packages...


### Step 4: Adding Python packages

To install the packages, we'll base ourselves on the `requirements_versions.txt` file which we found in the
Fooocus directories. We'll omit packages that have close enough versions and are already in the container.
The installation has to happen from within the container though. So let's got
to the Fooocus directory and go into the container again:

First we copy the `requirements_versions.txt` file from the Fooocus directory and 
edit it a bit:

```bash
cd $installdir
cp Fooocus-$fooocusversion/requirements_versions.txt requirements.txt
```

and edit it to

```
torchsde==0.2.6
transformers==4.42.4
omegaconf==2.3.0
gradio==3.41.2
pygit2==1.15.1
opencv-contrib-python-headless==4.10.0.84
httpx==0.27.0
onnxruntime==1.18.1
timm==1.0.7
rembg==2.0.57
groundingdino-py==0.4.0
segment_anything==1.0
```

(i.e., delete the lines for `einops`,  `safetensors`, `accelerate`, `pyyamml`, `pillow`,
`scipy`, `tqdm`, `psutil`, `pytorch_lightning`, `numpy`, `tokenizers` and `packaging`).
Even though there is already a version of `transformers` in the package, it is too old
and Fooocus is rather picky so we leave that line in.

Alternatively, you can simply create the file by copying the following command:

```bash
cat > requirements.txt <<EOF
torchsde==0.2.6
transformers==4.42.4
omegaconf==2.3.0
gradio==3.41.2
pygit2==1.15.1
opencv-contrib-python-headless==4.10.0.84
httpx==0.27.0
onnxruntime==1.18.1
timm==1.0.7
rembg==2.0.57
groundingdino-py==0.4.0
segment_anything==1.0
EOF
```

Now go back into the container:

``` bash
singularity shell $SIF
```

We'll install the extra packages simply with the `pip` tool:

``` bash
pip install -r requirements.txt
```

This process may again take a few minutes.

An error message suggests that there are some problems with the container that we used
which are solved with

```bash
pip install lightning-utilities torchmetrics
```

After finishing,

``` bash
ls /user-software/venv/pytorch/lib/python3.12/site-packages/
```

shows that indeed a lot of packages have been installed. Though accessible from the container,
they are not in the container `.sif` file as that file cannot be written.

Let's leave the container again:

``` bash
exit
```

Now try:

``` bash
ls $CONTAINERROOT/user-software/venv/pytorch/lib/python3.12/site-packages/
```

and notice that we see the same long list of packages. In fact, a trick to see the number of files 
and directories is

``` bash
lfs find $CONTAINERROOT/user-software/venv/pytorch/lib/python3.12/site-packages | wc -l
```

which prints the name of all files and directories and then counts the number of lines, and we see that 
this is a considerable number. Lustre isn't really that fond of it. However, the module also provides an
easy solution: We can convert the `$EBROOTPYTORCH/user-software` subdirectory into a SquashFS file that can
be mounted as a filesystem in the container, and the module provides all the tools to make this easy to do.
All we need to do is to run

``` bash
make-squashfs
```

This will also take some time as the script limits the resources the `make-squashfs` can use to keep the 
load on the login nodes low.
Now we can then safely remove the `user-software` subdirectory:

``` bash
rm -rf $CONTAINERROOT/user-software
```

Before continuing, we do need to reload the module so that the bindings between the container and
files and directories on LUMI are reset:

``` bash
module load PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923
```

Just check

``` bash
singularity exec $SIF ls /user-software/venv/pytorch/lib/python3.12/site-packages
```

and see that our package installation is still there!

However, we can no longer write in that directory. E.g., try

``` bash
singularity exec $SIF touch /user-software/test
```

to create an empty file `test` in `/user-software` and note that we get an error message.

So now we are ready-to-run.


### The reward: Running Fooocus

First go into the directory containing the Fooocus package :

``` bash
cd "$installdir/Fooocus-$fooocusversion"
```

We'll start an interactive job with a single GPU:

``` bash
srun -psmall-g -n1 -c7 --time=30:00 --gpus=1 --mem=60G -A project_465002174 --pty bash
```

The necessary modules will still be available, but if you are running from a new shell, you 
can load them again:

``` bash
module load LUMI/24.03
module load PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923
```

Also check the hostname if it is not part of your prompt as you will need it later:

``` bash
hostname
```

We can now go into the container:

``` bash
singularity shell $SIF
```

and launch Fooocus:

``` bash
python launch.py --listen --disable-xformers
```

Fooocus provides a web interface. If you're the only one on the node using Fooocus, it should run
on port 7865. To access it from our laptop, we need to create an SSH tunnel to LUMI. The precise statement
needed for this will depend on your ssh implementation. With an OpenSSH-like client, you can use:

``` bash
ssh -N -L 7865:nid00XXXX:7865 <myusername>@lumi.csc.fi
```

**replacing with the node name that we got from the `hostname` command`, `<mysuername>` with your
username on LUMI and adding command line options to point to your key if needed.**

Next, simply open a web browser on your laptop and point to 

```
http://localhost:7865
```

Note though that the initialisation of Fooocus can take a while and you cannot connect to it as long
as a line similar to

```
App started successful. Use the app with http://localhost:7865/ or 0.0.0.0:7865
```

is shown.


### Alternative way of running

We can also launch Fooocus directly from the `srun` command, e.g., from the directory containing the 
Fooocus code,

``` bash
module load LUMI/24.03
module load PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923
srun -psmall-g -n1 -c7 --time=30:00 --gpus=1 --mem=60G -A project_465002174 --pty \
   bash -c 'echo -e "Running on $(hostname)\n" ; singularity exec $SIF python launch.py --listen --disable-xformers'
```

It will also print the host name on which the Fooocus is running, so you can connect to Fooocus using the
same procedure as above.


## Further discovery

-   [YouTube channel "Jump Into AI"](https://www.youtube.com/@JumpIntoAI)
    has a [Fooocus playlist](https://www.youtube.com/playlist?list=PLK9cwl_eT4jKM-VwOm3zHl0lCFNnbwMD6)
