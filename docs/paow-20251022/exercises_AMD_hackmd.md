# LUMI Training - Tallin, Estonia (October 2025)

## Login to Lumi

```
ssh USERNAME@lumi.csc.fi
```
To simplify the login to LUMI, you can add the following to your .ssh/config file.

```
# LUMI
Host lumi
User <USERNAME>
   Hostname lumi.csc.fi
   IdentityFile <HOME_DIRECTORY>/.ssh/id_rsa 
   ServerAliveInterval 600
   ServerAliveCountMax 30
```
The `ServerAlive*` lines in the config file may be added to avoid timeouts when idle.

Now you can shorten your login command to the following.

```
ssh lumi
```

If you are able to log in with the ssh command, you should be able to use the secure copy command to transfer files. For example, you can
copy the presentation slides from lumi to view them.

```
scp lumi:/project/project_465002175/Slides/AMD/<file_name> <local_filename>
```

You can also copy all the slides with the . From your local system:

```
mkdir slides
scp -r lumi:/project/project_465002175/Slides/AMD/* slides
```

If you don't have the additions to the config file, you would need a longer command:

```
mkdir slides
scp -r -i <HOME_DIRECTORY>/.ssh/<public ssh key file> <username>@lumi.csc.fi:/project/project_465002175/slides/AMD/ slides
```

or for a single file

```
scp -i <HOME_DIRECTORY>/.ssh/<public ssh key file> <username>@lumi.csc.fi:/project/project_465002175/slides/AMD/<file_name> <local_filename>
```

## HIP Exercises

We assume that you have already allocated resources with `salloc`

```
cp -r /project/project_465002175/Exercises/AMD/HPCTrainingExamples/ .
```

```
salloc -N 1 -p standard-g --gpus=1 -t 10:00 -A project_465002175 --reservation LUMI_advanced_gpu
```

```
module load craype-accel-amd-gfx90a
module load PrgEnv-amd
module load rocm
```

The examples are also available on github:

```
git clone https://github.com/amd/HPCTrainingExamples
```

However, we recommend using the version in `/project/project_465002175/Exercises/AMD/HPCTrainingExamples` as it has been tuned to the current LUMI environment.

### Basic examples

```
cd HPCTrainingExamples/HIP/vectorAdd
```

Examine files here – README, Makefile and `vectoradd_hip.cpp`. Notice that Makefile requires HIP_PATH to be set. Check with module show rocm or echo $HIP_PATH Also, the Makefile builds and runs the code. We’ll do the steps separately. Check also the HIPFLAGS in the Makefile.

```
export HCC_AMDGPU_TARGET=gfx90a
make
srun -n 1 ./vectoradd
```

We can use SLURM submission script, let's call it `hip_batch.sh`:

```
#!/bin/bash
#SBATCH -p standard-g
#SBATCH -N 1
#SBATCH --gpus=1
#SBATCH -t 10:00
#SBATCH --reservation LUMI_advanced_gpu
#SBATCH -A project_465002175

module load craype-accel-amd-gfx90a
module load rocm
cd $PWD/HPCTrainingExamples/HIP/vectorAdd 

export HCC_AMDGPU_TARGET=gfx90a
make vectoradd
srun -n 1 --gpus 1 ./vectoradd
```

Submit the script

```
sbatch hip_batch.sh
```

Check for output in `slurm-<job-id>.out` or error in `slurm-<job-id>.err`

Compile and run with Cray compiler

```
CC -x hip vectoradd.hip -o vectoradd
srun -n 1 --gpus 1 ./vectoradd
```

Now let’s try the cuda-stream example from `https://github.com/ROCm-Developer-Tools/HIP-Examples`. This example is from the original McCalpin code as ported to CUDA by Nvidia. This version has been ported to use HIP. See add4 for another similar stream example.

```
git clone https://github.com/ROCm-Developer-Tools/HIP-Examples
export HCC_AMDGPU_TARGET=gfx90a
cd HIP-Examples/cuda-stream
make
srun -n 1 ./stream
```

Note that it builds with the hipcc compiler. You should get a report of the Copy, Scale, Add, and Triad cases.
The variable `export HCC_AMDGPU_TARGET=gfx90a` is not needed in case one sets the target GPU for MI250x as part of the compiler flags as `--offload-arch=gfx90a`.

Now check the other examples in HPCTrainingExamples/HIP like jacobi etc.

## Hipify

We’ll use the same HPCTrainingExamples that were downloaded for the first exercise.

Get a node allocation.

```
salloc -N 1 --ntasks=1 --gpus=1 -p standard-g -A project_465002175 –-t 00:10:00`--reservation LUMI_advanced_gpu
```

A batch version of the example is also shown.

### Hipify Examples

#### Exercise 1: Manual code conversion from CUDA to HIP (10 min)

Choose one or more of the CUDA samples in `HPCTrainingExamples/HIPIFY/mini-nbody/cuda` directory. Manually convert it to HIP. Tip: for example, the cudaMalloc will be called hipMalloc.
Some code suggestions include `nbody-block.cu`, `nbody-orig.cu`, `nbody-soa.cu`

You’ll want to compile on the node you’ve been allocated so that hipcc will choose the correct GPU architecture.

#### Exercise 2: Code conversion from CUDA to HIP using HIPify tools (10 min)

Use the `hipify-perl` script to “hipify” the CUDA samples you used to manually convert to HIP in Exercise 1. hipify-perl is in $ROCM_PATH/bin directory and should be in your path.

First test the conversion to see what will be converted

```
hipify-perl -no-output -print-stats nbody-orig.cu
```

You'll see the statistics of HIP APIs that will be generated.

```
[HIPIFY] info: file 'nbody-orig.cu' statisitics:
  CONVERTED refs count: 10
  TOTAL lines of code: 91
  WARNINGS: 0
[HIPIFY] info: CONVERTED refs by names:
  cudaFree => hipFree: 1
  cudaMalloc => hipMalloc: 1
  cudaMemcpy => hipMemcpy: 2
  cudaMemcpyDeviceToHost => hipMemcpyDeviceToHost: 1
  cudaMemcpyHostToDevice => hipMemcpyHostToDevice: 1
```

`hipify-perl` is in `$ROCM_PATH/bin` directory and should be in your path. In some versions of ROCm, the script is called `hipify-perl`.

Now let's actually do the conversion.

```
hipify-perl nbody-orig.cu > nbody-orig.cpp
```

Compile the HIP programs.

```
hipcc -DSHMOO -I ../ nbody-orig.cpp -o nbody-orig
```

```
The `#define SHMOO` fixes some timer printouts. 
Add `--offload-arch=<gpu_type>` if not set by the environment to specify 
the GPU type and avoid the autodetection issues when running on a single 
GPU on a node.
```

-   Fix any compiler issues, for example, if there was something that didn’t hipify correctly.

-   Be on the lookout for hard-coded Nvidia specific things like warp sizes and PTX.

Run the program

```
srun ./nbody-orig
```

A batch version of Exercise 2 is:

```
#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks=1
#SBATCH --gpus=1
#SBATCH -p standard-g
#SBATCH -A project_465002175
#SBATCH -t 00:10:00
#SBATCH --reservation  LUMI_advanced_gpu

module load craype-accel-amd-gfx90a
module load rocm

export HCC_AMDGPU_TARGET=gfx90a

cd HPCTrainingExamples/mini-nbody/cuda
hipify-perl -print-stats nbody-orig.cu > nbody-orig.cpp
hipcc -DSHMOO -I ../ nbody-orig.cpp -o nbody-orig
srun ./nbody-orig
cd ../../..
```

Notes:

-   Hipify tools do not check correctness

-   `hipconvertinplace-perl` is a convenience script that does `hipify-perl -inplace -print-stats` command


## Rocprof

Setup environment

```
salloc -N 1 --gpus=8 -p standard-g --exclusive -A project_465002175 -t 20:00 --reservation LUMI_advanced_gpu

module load PrgEnv-cray
module load craype-accel-amd-gfx90a
module load rocm
```

Obtain examples repo and navigate to the HIPIFY exercises

```
cd HPCTrainingExamples/HIPIFY/mini-nbody/hip/
```

Compile and run one case. We are on the front-end node, so we need to point he tools to use the correct GPU:

```
export HCC_AMDGPU_TARGET=gfx90a
```
have two ways to compile for the GPU that we want to run on. We can now complete the build with:

```
make nbody-orig
```

Now run `rocprof` on nbody-orig to obtain hotspots list

```
srun rocprof --stats nbody-orig 65536
```

Check Results

```
cat results.csv
```

Check the statistics result file, one line per kernel, sorted in descending order of durations

```
cat results.stats.csv
```

Using `--basenames on` will show only kernel names without their parameters.

```
srun rocprof --stats --basenames on nbody-orig 65536
```

Check the statistics result file, one line per kernel, sorted in descending order of durations

```
cat results.stats.csv
```

Trace HIP calls with `--hip-trace`

```
srun rocprof --stats --hip-trace nbody-orig 65536
```

Check the new file `results.hip_stats.csv`

```
cat results.hip_stats.csv
```

Profile also the HSA API with the `--hsa-trace`

```
srun rocprof --stats --hip-trace --hsa-trace nbody-orig 65536
```

Check the new file `results.hsa_stats.csv`

```
cat results.hsa_stats.csv
```

On your laptop, download `results.json`

```
scp -i <HOME_DIRECTORY>/.ssh/<public ssh key file> <username>@lumi.csc.fi:<path_to_file>/results.json results.json
```

Open a browser and go to [`https://ui.perfetto.dev/`](https://ui.perfetto.dev/).

Click on `Open trace file` in the top left corner.

Navigate to the `results.json` you just downloaded.

Use the keystrokes W,A,S,D to zoom in and move right and left in the GUI

```
Navigation
w/s	Zoom in/out
a/d	Pan left/right
```

### Perfetto issue

You could open a browser and go to [`https://ui.perfetto.dev/`](https://ui.perfetto.dev/) to load the latest version of the tool but we recomment using an older version that is known to work well with traces generated by rocprof. For that, make sure you start a session to connect to LUMI as:

```
ssh -i <HOME_DIRECTORY>/.ssh/<public ssh key file> <username>@lumi-uan01.csc.fi -L10000:uan01:10000
```

and then connect to [`http://localhost:10000`](http://localhost:10000).

Alternatively you can run perfetto on your laptop if you have a Docker installed with:

```
docker run -it --rm -p 10000:10000 --name myperfetto sfantao/perfetto4rocm
```

You need to have the Docker daemon running in your workstation, e.g.:

```
sudo dockerd
```

We can now proceed to connect your web browser to: [`http://localhost:10000`](http://localhost:10000) and open the trace.

<figure markdown style="border: 1px solid #000">
  ![Perfetto image...](https://462000265.lumidata.eu/paow-20251022/img/perfetto_1.png){ loading=lazy }
</figure>

Read about hardware counters available for the GPU on this system (look for gfx90a section)

```
less $ROCM_PATH/lib/rocprofiler/gfx_metrics.xml
```

Create a `rocprof_counters.txt` file with the counters you would like to collect

```
vi rocprof_counters.txt
```

Content for `rocprof_counters.txt`:

```
pmc : Wavefronts VALUInsts
pmc : SALUInsts SFetchInsts GDSInsts
pmc : MemUnitBusy ALUStalledByLDS
```

Execute with the counters we just added:

```
srun rocprof --timestamp on -i rocprof_counters.txt  nbody-orig 65536
```

You'll notice that rocprof runs 3 passes, one for each set of counters we have in that file.

Contents of `rocprof_counters.csv`

```
cat rocprof_counters.csv
```

### Exploring RocprofV3

Rocprofv3 is becoming the recommended version for ROCm 6.2 onward. You can experiment with this version by running:

```
module use /appl/local/containers/test-modules
module load rocm/6.2.2
```

We can now repeat the experiment we did before and obtain a HIP trace with the kernels and copy information:

```
srun rocprofv3 --hip-trace --kernel-trace --memory-copy-trace --output-format=pftrace -- ./nbody-orig 65536
```

Notice the difference in the options in comparison to rocprof V1. One can be more selective on what to collect. You would also notice that the profiler is faster and has less overhead. It also has the choice of using `pftrace` format that are more compatible with latest versions of the Perfetto UI [`https://ui.perfetto.dev/`](https://ui.perfetto.dev/). The trace will look similar to what seen before with a slightly different convention for the namming of the different sections:

<figure markdown style="border: 1px solid #000">
  ![Perfetto image...](https://462000265.lumidata.eu/paow-20251022/img/perfetto_2.png){ loading=lazy }
</figure>


## Omnitrace

-   Load Omnitrace

    For ROCm versions older than 6.2, Omnitrace is not installed as part of the ROCm suite. So we use a separate instalation for this.

    ```
    module load craype-accel-amd-gfx90a
    module load PrgEnv-amd
    module load cray-python

    module use /appl/local/containers/test-modules
    module load rocm/6.0.3 omnitrace/1.12.0-rocm6.0.x
    ```

-   Allocate resources with `salloc`

    ```
    salloc -N 1 --ntasks=1 --partition=standard-g --gpus=1 -A project_465002175 --time=00:15:00 --reservation LUMI_advanced_gpu
    ```

-   Check the various options and their values and also a second command for description

    ```
    srun -n 1 --gpus 1 omnitrace-avail --categories omnitrace
    ```

    ```
    srun -n 1 --gpus 1 omnitrace-avail --categories omnitrace --brief --description
    ```

-   Create an Omnitrace configuration file with description per option

    ```
    srun -n 1 omnitrace-avail -G omnitrace.cfg --all
    ```

-   Declare to use this configuration file:

    ```
    export OMNITRACE_CONFIG_FILE=/path/omnitrace.cfg
    ```

-   Get the training examples:

    ```
    cp -r /project/project_465002175/Exercises/AMD/HPCTrainingExamples/ .
    ```

-   Compile and execute saxpy

    ```
    cd HPCTrainingExamples/HIP/saxpy
    hipcc --offload-arch=gfx90a -O3 -o saxpy saxpy.hip
    time srun -n 1 ./saxpy
    ```

-   Check the duration

-   Compile and execute Jacobi

    ```
    cd HIP/jacobi
    ```

-   Now build the code

    ```
    make -f Makefile.cray
    time srun -n 1 --gpus 1 Jacobi_hip -g 1 1
    ```

-   Check the duration

### Dynamic instrumentation (the commands take a significant ammount of time)

-   Execute dynamic instrumentation: 
    ```
    time srun -n 1 -c 7 --gpus 1 omnitrace-instrument -- ./saxpy
    ```
    and check the duration

-   About Jacobi example, as the dynamic instrumentation would take long time, check what the binary calls and gets instrumented: 
    ```
    nm --demangle Jacobi_hip | egrep -i ' (t|u) '
    ```

-   Available functions to instrument: 
    ```
    srun -n 1 -c 7 --gpus 1 omnitrace-instrument -v 1 --simulate --print-available functions -- ./Jacobi_hip -g 1 1
    ```

    -   the simulate option means that it will not execute the binary


### Binary rewriting (to be used with MPI codes and decreases overhead)

-   Binary rewriting: 
    ```
    srun -n 1 --gpus 1 omnitrace-instrument -v -1 --print-available functions -o jacobi.inst -- ./Jacobi_hip
    ```

    -   We created a new instrumented binary called `jacobi.inst`

-   Executing the new instrumented binary: 
    ```
    time srun -n 1 --gpus 1 omnitrace-run -- ./jacobi.inst -g 1 1
    ```
    and check the duration

-   See the list of the instrumented GPU calls: 
    ```
    cat omnitrace-jacobi.inst-output/TIMESTAMP/roctracer.txt
    ```


### Visualization

-   Copy the perfetto-trace.proto to your laptop, open the web page [`https://ui.perfetto.dev/v46.0-35b3d9845/#/`](https://ui.perfetto.dev/v46.0-35b3d9845/#/). Click to open the trace and select the file


### Hardware counters

-   See a list of all the counters: 
    ```
    srun -n 1 --gpus 1 omnitrace-avail --all
    ```

-   Declare in your configuration file: 
    ```
    OMNITRACE_ROCM_EVENTS = GPUBusy,Wavefronts,VALUBusy,L2CacheHit,MemUnitBusy
    ```

-   Execute: 
    ```
    srun -n 1 --gpus 1 omnitrace-run -- ./jacobi.inst -g 1 1
    ```
    and copy the perfetto file and visualize


### Sampling

Activate in your configuration file `OMNITRACE_USE_SAMPLING = true` and `OMNITRACE_SAMPLING_FREQ = 100`, execute and visualize


### Kernel timings

-   Open the file `omnitrace-binary-output/timestamp/wall_clock.txt` (replace binary and timestamp with your information)

-   In order to see the kernels gathered in your configuration file, make sure that `OMNITRACE_USE_TIMEMORY = true` and `OMNITRACE_FLAT_PROFILE = true`, execute the code and open again the file `omnitrace-binary-output/timestamp/wall_clock.txt`


## Omniperf

-   Load Omniperf:

    Omniperf uses a separate instalation as it is not part of ROCm before its version 6.2. Let's load it in our environment.

    ```
    module load craype-accel-amd-gfx90a
    module load PrgEnv-amd
    module load cray-python

    module use /appl/local/containers/test-modules
    module load rocm/6.0.3 omniperf/2.1.0
    ```

-   Reserve a GPU, compile the exercise and execute Omniperf, observe how many times the code is executed

    ```
    salloc -N 1 --ntasks=1 --partition=small-g --gpus=1 -A project_465002175 --time=00:30:00
    cp -r /project/project_465002175/Exercises/AMD/HPCTrainingExamples/ .
    cd HPCTrainingExamples/HIP/dgemm/
    mkdir build
    cd build
    cmake ..
    make
    cd bin
    srun -n 1 -c 7 omniperf profile -n dgemm -- ./dgemm -m 8192 -n 8192 -k 8192 -i 1 -r 10 -d 0 -o dgemm.csv
    ```

-   Run 
    ```
    srun -n 1 --gpus 1 omniperf profile -h
    ```
    to see all the options

-   Now is created a workload in the directory workloads with the name dgemm (the argument of the -n). So, we can analyze it

    ```
    srun -n 1 --gpus 1 omniperf analyze -p workloads/dgemm/MI200/ &> dgemm_analyze.txt
    ```

-   If you want to only roofline analysis, then execute: 
    ```
    srun -n 1 omniperf profile -n dgemm --roof-only -- ./dgemm -m 8192 -n 8192 -k 8192 -i 1 -r 10 -d 0 -o dgemm.csv
    ```
    There is no need for `srun` to analyze but we want to avoid everybody to use the login node. Explore the file `dgemm_analyze.txt`.

-   We can select specific IP Blocks, like:
    ```
    srun -n 1 --gpus 1 omniperf analyze -p workloads/dgemm/MI200/ -b 7.1.2
    ```
    But you need to know the code of the IP Block

-   If you have installed Omniperf on your laptop (no ROCm required for analysis) then you can download the data and execute:
    ```
    omniperf analyze -p workloads/dgemm/MI200/ --gui
    ```

-   Open the web page: `http://IP:8050/`. The IP will be displayed in the output

For more exercises, visit here: https://github.com/amd/HPCTrainingExamples/tree/main/OmniperfExamples or locally HPCTrainingExamples/OmniperfExamples, there are 5 exercises, in each directory there is a readme file with instructions.


## Pytorch example

This example is supported by the files in `/project/project_465002175/Exercises/AMD/Pytorch` (or the `Exercises/AMD/Pytorch` subdirectory in the download of the AMD exercises after the course: [Download as .tar.bz2](https://462000265.lumidata.eu/paow-20251022/files/LUMI-paow-20251022-Exercises_AMD.tar.bz2) or [download as .tar](https://462000265.lumidata.eu/paow-20251022/files/LUMI-paow-20251022-Exercises_AMD.tar)).

These script experiment with different tools with a more realistic application. They cover PyTorch, how to install it, run it and then profile and debug a MNIST based training. We selected the one in [https://github.com/kubeflow/examples/blob/master/pytorch_mnist/training/ddp/mnist/mnist_DDP.py](https://github.com/kubeflow/examples/blob/master/pytorch_mnist/training/ddp/mnist/mnist_DDP.py) but the concept would be similar for any PyTorch-based distributed training.

This is mostly based on a two node allocation.

-   Installing PyTorch directly on the filesystem using the system python installation.
    ```
    ./01-install-direct.sh
    ```

-   Installing PyTorch in a virtual environment based on the system python installation.
    ```
    ./02-install-venv.sh
    ```

-   Installing PyTorch in a condo environment based on the condo package python version.
    ```
    ./03-install-conda.sh
    ```

-   Testing a container prepared for LUMI that comprises PyTorch.
    ```
    ./04-test-container.sh
    ```

-   Test the right affinity settings.
    ```
    ./05-afinity-testing.sh
    ```

-   Complete example with MNIST training with all the trimmings to run it properly on LUMI.
    ```
    ./06-mnist-example.sh
    ```

-   Examples using rocprof, Omnitrace and Omniperf.
    ```
    ./07-mnist-rocprof.sh
    ```
    ```
    ./08-mnist-omnitrace.sh
    ```
    ```
    ./09-mnist-omnitrace-python.sh
    ```
    ```
    ./10-mnist-omniperf.sh
    ```

-   Example using Pytorch built-in profiling capabilities.
    ```
    ./11-mnist-pytorch-profile.sh
    ```


## HIP optimization

### Optimizing DAXPY HIP

In this exercise, we will progressively make changes to optimize the DAXPY kernel on GPU. Any AMD GPU can be used to test this.

DAXPY Problem:

```
Z = aX + Y
```

where `a` is a scalar, `X`, `Y` and `Z` are arrays of double precision values.

In DAXPY, we load 2 FP64 values (8 bytes each) and store 1 FP64 value (8 bytes). We can ignore the scalar load because it is constant. We have 1 multiplication and 1 addition operation for the 12 bytes moved per element of the array. This yields a low arithmetic intensity of 2/24. So, this kernel is not compute bound, so we will only measure the achieved memory bandwith instead of FLOPS.

### Inputs

-   `N`, the number of elements in `X`, `Y` and `Z`. `N` may be reset to suit some optimizations.
  
    Choose a sufficiently large array size to see some differences in performance.


### Build Code

```
module load craype-accel-amd-gfx90a
module use /appl/local/containers/test-modules
module load rocm/6.2.4

git clone https://github.com/amd/HPCTrainingExamples.git
cd HPCTrainingExamples/HIP-Optimizations/daxpy
make
```


### Run exercises

```
salloc -N 1 --ntasks=1 --partition=small-g --gpus=1 -A project_465002175 --time=00:30:00
srun ./daxpy_1 10000000
srun ./daxpy_2 10000000
srun ./daxpy_3 10000000
srun ./daxpy_4 10000000
srun ./daxpy_5 10000000
```

### Things to ponder about

#### `daxpy_1`

This shows a naive implementation of the daxpy problem on the GPU where only 1 wavefront is launched and the 64 work-items in that wavefront loop over the entire array and process 64 elements at a time. We expect this kernel to perform very poorly because it simply utilizes a part of 1 CU, and leaves the rest of the GPU unutilized.


#### `daxpy_2`

This time, we are launching multiple wavefronts, each work-item now processing only 1 element of each array. This launches N/64 wavefronts, enough to be scheduled on all CUs. We see a big improvement in performance here.


#### `daxpy_3`

In this experiment, we check to see if launching larger workgroups can help lower our kernel launch overhead because we launch fewer workgroups if each workgroup has 256 work-items. In this case too, an improvement in measured bandwidth achieved is seen.


#### `daxpy_4`

If we ensured that the array has a multiple of `BLOCK_SIZE` elements so that all work-items in each workgroup have an element to process, then we can avoid the conditional statement in the kernel. This could reduce some instructions in the kernel.. Do we see any improvement? In this trivial case, this does not matter. Nevertheless, it is something we could keep in mind.

Question: What happens if `BLOCK_SIZE` is `1024`? Why?


#### `daxpy_5`

In this experiment, we will use double2 type in the kernel to see if the compiler can generate `global_load_dwordx4` instructions instead of `global_load_dwordx2` instructions. So, with same number of load and store instructions, we are able to read/write two elements from each array in each thread. This should help amortize on the cost of index calculations.

To show this difference, we need to generate the assembly for these two kernels. To generate the assembly code for these kernels, ensure that the `-g --save-temps` flags are passed to `hipcc`. Then you can find the assembly code in `daxpy_*-host-x86_64-unknown-linux-gnu.s` files. Examining `daxpy_3` and `daxpy_5`, we see the two cases (edited here for clarity):

`daxpy_3`:

```
    global_load_dwordx2 v[2:3], v[2:3], off
    v_mov_b32_e32 v6, s5
    global_load_dwordx2 v[4:5], v[4:5], off
    v_add_co_u32_e32 v0, vcc, s4, v0
    v_addc_co_u32_e32 v1, vcc, v6, v1, vcc
    s_waitcnt vmcnt(0)
    v_fmac_f64_e32 v[4:5], s[6:7], v[2:3]
    global_store_dwordx2 v[0:1], v[4:5], off
```

`daxpy_5`:

```
    global_load_dwordx4 v[0:3], v[0:1], off
    v_mov_b32_e32 v10, s5
    global_load_dwordx4 v[4:7], v[4:5], off
    s_waitcnt vmcnt(0)
    v_fmac_f64_e32 v[4:5], s[6:7], v[0:1]
    v_add_co_u32_e32 v0, vcc, s4, v8
    v_fmac_f64_e32 v[6:7], s[6:7], v[2:3]
    v_addc_co_u32_e32 v1, vcc, v10, v9, vcc
    global_store_dwordx4 v[0:1], v[4:7], off
```

We observe that, in the `daxpy_5` case, there are two `v_fmac_f64_e32` instructions as expected, one for each element being processed.


### Notes

-   Before timing kernels, it is best to launch the kernel at least once as warmup so that those initial GPU launch latencies do not affect your timing measurements.

-   The timing loop is typically several hundred iterations.

-   You may find that the various optimizations work differently in MI200 vs MI300 devices, and this may be due to differences in hardware architecture.

