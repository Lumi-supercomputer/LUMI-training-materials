

#
# Step 1: Downloads and preparation
#

# Where to install
installdir=/scratch/project_465001726/$USER/DEMO2
mkdir -p "$installdir" ; cd "$installdir"

# Some cleanup for EasyBuild
module unload LUMI
export EBU_USER_PREFIX=$installdir/EasyBuild

# Get the scripts
mkdir mnist ; pushd mnist
wget https://raw.githubusercontent.com/Lumi-supercomputer/lumi-reframe-tests/98327968ff300ed0181d5d14b5dd49cdf1d7b743/checks/containers/ML_containers/src/pytorch/mnist/mnist_DDP.py
sed -i -e 's|download=True|download=False|' mnist_DDP.py
mkdir -p model ; cd model
wget https://github.com/Lumi-supercomputer/lumi-reframe-tests/raw/98327968ff300ed0181d5d14b5dd49cdf1d7b743/checks/containers/ML_containers/src/pytorch/mnist/model/model_gpu.dat
cd ..

# Get the dataset
mkdir -p data/MNIST/raw
pushd data/MNIST/raw
wget https://github.com/golbin/TensorFlow-MNIST/raw/refs/heads/master/mnist/data/train-images-idx3-ubyte.gz
wget https://github.com/golbin/TensorFlow-MNIST/raw/refs/heads/master/mnist/data/train-labels-idx1-ubyte.gz
wget https://github.com/golbin/TensorFlow-MNIST/raw/refs/heads/master/mnist/data/t10k-images-idx3-ubyte.gz
wget https://github.com/golbin/TensorFlow-MNIST/raw/refs/heads/master/mnist/data/t10k-labels-idx1-ubyte.gz    
gunzip -k *.gz
popd
for i in $(seq 0 31); do ln -s data "data$i"; done

#
# Step 2: Installing the container
#

module purge
module load LUMI/24.03 partition/container EasyBuild-user

eb PyTorch-2.3.1-rocm-6.0.3-python-3.12-singularity-20240923.eb

module purge
module load LUMI/24.03
module load PyTorch/2.3.1-rocm-6.0.3-python-3.12-singularity-20240923

echo "SIF =        $SIF"
echo "SIFPYTORCH = $SIFPYTORCH"

# Some checks
echo -e "Which python in the container?"
singularity exec $SIF which python

module load systools
echo -e "\n\nDirectory structure of \$CONTAINEROOT=$CONTAINERROOT:\n"
tree $CONTAINERROOT

#
# Step 3: Running a distributed learning example
#

# Check the runscript
echo -e "\n\nconda-python-dstirbuted:\n"
cat $CONTAINERROOT/runscripts/conda-python-distributed

