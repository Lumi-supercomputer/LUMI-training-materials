#! /bin/bash
# Source or run this file to try out some of the commands of DEMO1.
#

#
# Step 1: Preparations
#

# Where to install
installdir=/scratch/project_465001726/$USER/DEMO1
mkdir -p "$installdir" ; cd "$installdir"

# Some cleanup for EasyBuild
module unload LUMI
export EBU_USER_PREFIX=$installdir/EasyBuild

# Get Fooocus
fooocusversion=2.5.5
wget https://github.com/lllyasviel/Fooocus/archive/refs/tags/v$fooocusversion.zip
unzip v$fooocusversion.zip
rm -f v$fooocusversion.zip
echo -e "\n\nFooocus directory:\n"
ls Fooocus-$fooocusversion

#
# Step 2: Install the PyTorch container
#

mkdir -p "$installdir/tmp" ; cd "$installdir/tmp"
module purge
module load LUMI/24.03 partition/container EasyBuild-user

eb --copy-ec PyTorch-2.3.1-rocm-6.0.3-python-3.12-singularity-20240923.eb PyTorch-2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923.eb
sed -e "s|^\(versionsuffix.*\)-singularity-\(.*\)|\1-Fooocus-singularity-\2|" -i PyTorch-2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923.eb

echo -e "\n\nCheck the EB versionsuffix line:"
grep versionsuffix PyTorch-2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923.eb

# Do the actual install
eb PyTorch-2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923.eb

# Testing
module purge
module load LUMI/24.03
module load PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923

echo "SIF =        $SIF"
echo "SIFPYTORCH = $SIFPYTORCH"

#
# Step 3: Adding SUSE packages
#

export CONTAINERFILE="$SIF"
module unload PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923

module load systools

cat > lumi-pytorch-rocm-6.0.3-python-3.10-pytorch-v2.3.1-Fooocus.def <<EOF

Bootstrap: localimage

From: $CONTAINERFILE

%post

zypper -n install -y Mesa libglvnd libgthread-2_0-0 hostname

EOF

echo -e "\n\nContainer definition file:\n"
cat lumi-pytorch-rocm-6.0.3-python-3.10-pytorch-v2.3.1-Fooocus.def
echo 

# Move singularity workspace away from the home directory.
export SINGULARITY_CACHEDIR=/tmp/singularity/cache
export SINGULARITY_TMPDIR=/tmp/singularity/tmp

mkdir -p $SINGULARITY_CACHEDIR
mkdir -p $SINGULARITY_TMPDIR

singularity build --force $CONTAINERFILE lumi-pytorch-rocm-6.0.3-python-3.10-pytorch-v2.3.1-Fooocus.def

# Clean-up
rm -rf /tmp/singularity

# Some testing...
module load PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923

echo -e "Which python in the container?"
singularity exec $SIF which python

echo -e "Can I find the hostname (tool installed with zypper)?"
singularity exec $SIF hostname 

echo -e "Can I find some mes libraries (installed with zypper)? "
singularity exec $SIF bash -c 'ls /usr/lib64/*mesa*'

echo -e "Installed Python packages:"
singularity exec $SIF pip list

#
# Now adding Python packages
#

cd $installdir

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

singularity exec $SIF pip install -r requirements.txt
singularity exec $SIF pip install lightning-utilities torchmetrics

echo -e "\n\nNew list of Python packages:\n"
singularity exec $SIF pip list

# Turn into a squashFS file
make-squashfs
rm -rf $CONTAINERROOT/user-software

# Some testing
module load PyTorch/2.3.1-rocm-6.0.3-python-3.12-Fooocus-singularity-20240923

echo -e "\n\nCan we still find the Python packages?:\n"
singularity exec $SIF pip list
