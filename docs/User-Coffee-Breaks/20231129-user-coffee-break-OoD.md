# Open OnDemand: A web interface for LUMI (November 29, 2023)

*Presenters:* René Løwe Jacobsen (LUST & DeiC)

<video src="https://462000265.lumidata.eu/user-coffee-breaks/recordings/20231129-user-coffee-break-OoD.mp4" controls="controls">
</video>


## Q&A

[Full archive of all LUMI Coffee Break questions](https://hackmd.io/@lust/coffeearchive#). This page only shows the 
questions from the Open OnDemand session.


### Open OnDemand

1.  Are there plans to add other IDEs like PyCharm along with VSCode?

    -   You can install the PyCharm VScode plugin, but be careful that files are not all installed in your home (small file quota there)

2.  How can you run Pytorch from OpenOnDemand?

    -   New documentation about PyTorch: https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/
    -   You can access your python virtual/conda environments from within the jupyter notebook.

3.  Regarding Jupyter, why is it required to load a virtual environment to use python packages and not using system-wise installations instead?

    -   LUMI is a multi-user system. There is no configuration that is good for everybody, so something systemwide does not make sense. Moreover, another restriction that limits what we can do system-wide, is that Python distributes packages in too many small files that puts a severe load on the file system, so we prefer Python in containers.

        Virtual environments actually also became important simply because there are so many package conflicts in Python.
         
    -   You can also install your python environment easily with the container wrapper: https://docs.lumi-supercomputer.eu/software/installing/container-wrapper/ . It encapsulates it nicely in a container and puts no strain on the LUMI file system

    -   And as LUMI is a multi-user system, there are even multiple versions of Python itself. The system Python is for system management and hence the default version of SUSE, but then there are newer versions provided by modules. This is the very nature of an HPC system.

4.  Comment: [mlflow](https://mlflow.org/) may be added to web interface, in addition to tensorboard. This could be useful also for pytorch users.


### Other questions

1.  Can I have a `tmux` session persist after logout or ssh disconnect? I know there are plugins such as `tmux-ressurect` to save and restore sessions, but there are cases where I might be running a task in a `tmux` session which I would like to be able to resume or reconnect to after a logout.  I understand some of the issues one can raise around this approach, but there are other less abusive uses of tmux like simply storing a working environment (inc. environment variables) which I find very useful. Hopefully you can help answer, or maybe suggest tools to restore the full working environment of several sessions. Thanks! 

    -   The tmux executable is on the system but we do not actively support it. The resources on the login nodes are limited and if everybody leaves things running, we're run out of resources. 

        Personally I have bash functions in my login environment that I use to initialise specific session types (modules and environment variables).
      
        As the environment on LUMI sometimes changes it is also not a good idea to store it unless you understand very well the problems that can occur.
      
        Not refreshing the environment also has other disadvantages. E.g., we've seen corrupt Lmod environments and logging out and in helps to clean things up. Or we change things on the system that are then not picked up, and if users keep using the same session for weeks and then submit tickets it's really not the first thing we think about as the cause of the problem.

2.  We would like to use Gaussian quantum chemistry software on LUMI (I'm sure thre are more users who would be interested to use it). Gaussian doesn't support "bring your own license" approach, and they strictly determine the location where it is allowed to use. Gaussian customer support clarifed that our license is only valid on the licensed location (e.g. university campus). They also mentionned that CSC has a supercomputer center license, which allows external accademic users access to the binary code, but this license is not valid for LUMI. CSC has last year expressed an interst to obtaining a Gaussian license for LUMI as well, but so far, there has been no steps toward that. Can you clarify if and when Gaussian software will be available on LUMI?

    -   LUST will not invest in the license. If CSC wants to for their users, they can, but we don't speak for CSC. It is not a very scalable code (its LINDA parallelisation technology is basically technology from the early '90s that does not exploit modern fast interconnects well) and unless you have a source code license, it may not even run on LUMI. We have very bad experiences with some other codes already that come as binaries. The interconnect can be a problem, but people should also realise that the compute nodes only run a subset of SUSE Linux as some daemons are disabled (and we know software that doesn't work or has limited functionality because of this). Software that can use the AMD GPUs has a higher priority for our central budget. They only support some NVIDIA GPUs and no AMD GPUs.

        For a system whose prime focus is development of exascale technologies their license that forbids comparison with other codes is also not interesting.

3.  I'm already in contact with support about this, so sorry if this is a repetition. I'm trying to get some multi-node pytorch code to run using torchrun but for some reason it fails with NCCL (connection) errors. The code works on a single node and I earlier on had a variety that (sometimes) worked with multiple nodes, but irregularily failed. Support has tried pytorch examples for multi-node code which seemed to work, but the code I have still fails. The code in 

    -   You are talking here to the same people as those who do the ticket so we really cannot say anything here more.
    
        The message I got from AMD is that `torchrun` is actually not the ideal way to run PyTorch on LUMI. When they built the container for LUMI, they started PyTorch via Python itself. 
        
    Ok, but what way should be used then? handling it all manually, when there is a wrapper in place that should exactly care about all of these issues concerning multi-node settings?

    -   The script I have seen uses `srun` outside the container with each container starting a Python process with access to 1 GPU. 
        
    I also tried one `srun` now within an allocation. Same issue. 

    -   Basically, the script I got is

        ```
        #!/bin/bash -e

        wd=$(pwd)
        jobid=$(squeue --me | head -2 | tail -n1 | awk '{print $1}')


        #
        # Example assume allocation was created, e.g.:
        # N=1 ; salloc -p standard-g  --threads-per-core 1 --exclusive -N $N --gpus $((N*8)) -t 4:00:00 --mem 0
        #

        set -x

        SIF=/appl/local/containers/sif-images/lumi-pytorch-rocm-5.6.1-python-3.10-pytorch-v2.1.0.sif

        # Utility script to detect the master node
        cat > $wd/get-master.py << EOF
        import argparse
        def get_parser():
            parser = argparse.ArgumentParser(description="Extract master node name from Slurm node list",
                    formatter_class=argparse.ArgumentDefaultsHelpFormatter)
            parser.add_argument("nodelist", help="Slurm nodelist")
            return parser


        if __name__ == '__main__':
            parser = get_parser()
            args = parser.parse_args()

            first_nodelist = args.nodelist.split(',')[0]

            if '[' in first_nodelist:
                a = first_nodelist.split('[')
                first_node = a[0] + a[1].split('-')[0]

            else:
                first_node = first_nodelist

            print(first_node)
        EOF

        rm -rf $wd/run-me.sh
        cat > $wd/run-me.sh << EOF
        #!/bin/bash -e

        # Make sure GPUs are up
        if [ \$SLURM_LOCALID -eq 0 ] ; then
            rocm-smi
        fi
        sleep 2

        export MIOPEN_USER_DB_PATH="/tmp/$(whoami)-miopen-cache-\$SLURM_NODEID"
        export MIOPEN_CUSTOM_CACHE_DIR=\$MIOPEN_USER_DB_PATH

        # Set MIOpen cache to a temporary folder.
        if [ \$SLURM_LOCALID -eq 0 ] ; then
            rm -rf \$MIOPEN_USER_DB_PATH
            mkdir -p \$MIOPEN_USER_DB_PATH
        fi
        sleep 2

        # Report affinity
        echo "Rank \$SLURM_PROCID --> \$(taskset -p \$\$)"


        # Start conda environment inside the container
        \$WITH_CONDA

        # Set interfaces to be used by RCCL.
        export NCCL_SOCKET_IFNAME=hsn0,hsn1,hsn2,hsn3

        # Set environment for the app
        export MASTER_ADDR=\$(python /workdir/get-master.py "\$SLURM_NODELIST")
        export MASTER_PORT=29500
        export WORLD_SIZE=\$SLURM_NPROCS
        export RANK=\$SLURM_PROCID
        export ROCR_VISIBLE_DEVICES=\$SLURM_LOCALID

        # Run app
        cd /workdir/mnist
        python -u mnist_DDP.py --gpu --modelpath /workdir/mnist/model

        EOF
        chmod +x $wd/run-me.sh

        c=fe
        MYMASKS="0x${c}000000000000,0x${c}00000000000000,0x${c}0000,0x${c}000000,0x${c},0x${c}00,0x${c}00000000,0x${c}0000000000"

        Nodes=4
        srun --jobid=$jobid -N $((Nodes)) -n $((Nodes*8)) --gpus $((Nodes*8)) --cpu-bind=mask_cpu:$MYMASKS \
            singularity exec \
            -B /var/spool/slurmd \
            -B /opt/cray \
            -B /usr/lib64/libcxi.so.1 \
            -B /usr/lib64/libjansson.so.4 \
            -B $wd:/workdir \
            $SIF /workdir/run-me.sh
        ```
        
        that a colleague of mine tested.
        
        It is also the basis of what we have tried to pack in a [wrapper module for the PyTorch containers we got from AMD](https://lumi-supercomputer.github.io/LUMI-EasyBuild-docs/p/PyTorch/).

4.  Will you look at supporting mojo programming language in the future, once the language has developed to a more mature level?

    -   It is unfortuantely very difficult for us to support any packages and software packages as we are a very small team. Instead we provide a simple way for you to install the packages yourself using EasyBuild: https://docs.lumi-supercomputer.eu/software/installing/easybuild/

    -   Once there is a Mojo Easyconfig available you can install it easily. maybe ask the developers to create one or send us a support request and we can have a look.

    -   **[Kurt]** Well actually, I notice it is something for AI software with Python so it would have to go in those containers. And you can probably just instal it with pip on top of one of the existing containers...

