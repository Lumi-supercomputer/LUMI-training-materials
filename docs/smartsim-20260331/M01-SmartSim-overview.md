# Overview of ML and HPC coupling - Introduction to SmartSim - A practical usage example

*Presenter: Holly Judge*

<video src="https://462000265.lumidata.eu/smartsim-20260331/recordings/LUMI-SmartSim-20260331-01-SmartSim-overview.mp4" controls="controls"></video>

-      [Slides](https://462000265.lumidata.eu/smartsim-20260331/files/01-SmartSim-Overview.pdf)


## Q&A


1.  Is the driver script always Python?

    - **Answer:** Yes, current supported versions of Python are 3.9-3.11 for the [latest release version on PyPI](https://pypi.org/project/smartsim/) and 3.10-3.12 for the development branch from our [GitHub repository](https://github.com/CrayLabs/SmartSim.git)
  

2.  Would it automatically allocate compute nodes using simple configs?  

    - **Answer:** It can! SmartSim can use an existing allocation (e.g. `salloc`) or it can fetch an allocation on it's own (e.g. `sbatch`). It is also not strictly limited to SLURM, it also works with PBS style schedulers.


3.  It seems SmartSim using some databases called SmartRedis, is it some kind of application on top of Redis?

    - **Answer:** Kind of! SmartSim uses a companion library (SmartRedis) that acts as a client to Redis. Under the hood, SmartSim/SmartRedis stand up a Redis database to act as the Orchestrator, which allows for comunication between processes without using the file system. It also uses the plugin RedisAI to use Redis for machine learning capabilities.


4.  The SmartSim seems to use PyTorch, should it thus be run from a container on LUMI? How does this ineract with the job submission and the networking?

    - **Answer:** There is a container on LUMI that we will be u  on in the workshop, but it doesn't _need_ to be run with that build of PyTorch. By default SmartSim ships with a `smart` command line tool that will help install compatable versions of your ML backends, and it is possible to point this tool at a local install of Torch.

    - **Additional Note:** If your ML process doesn't need to interact with the Orchestrator (e.g. for training), you can launch a SmartSim job that uses the containerized version of pytorch for training and save artifacts (e.g. a `.pt` file) that can then be uploaded to the Orchestrator for inference.

5.  The Python driver script must be run on the login n  then starts the orchestrator (if I'm correct). Does this orchestrator then also spawn new experiments or jobs, or are all jobs launched from the driver script? (I think this is now awnsered in the persentation)

    - **Answer:** More jobs can be started from the driver scrip e the orchestrator in the driver script, but the orchestrator itself will not launch any additional HPC jobs. Jobs launched from the driver script will have environment variables set that will enable easy communication between jobs and with the orchestrator.

    - **Additional Note:** SmartSim and SmartRedis are completely seperable entities! It is 100% valid to use SmartSim to cordinate launching jobs without using SmartRedis, and it is possible to manually set up SmartRedis without using SmartSim.

6.  Can you create a dependency when scheduling the orchestrator and HPC application, so one is not waiting on the other?

    - **Answer:** Yes! It may require a bit of manual scheduling of process order depending on your needs, but SmartSim has the capability to let models run in the background or to block until their completion.


7.  Can you easily do checkpointing or restart the script, including building on or re-using previous results, or even restart mid-way a failed job?

    - **Answer:** Yes! While the Orchestrator is an in-memory data-store, it can be explicilty dumped to disk as an `.rdb` file. This file can then be picked up and reloaded into a new Orchestrator. Commonly, for long workflows where checkpointing is desired, we see people dump out a checkpoint file to disk every N iterations of workflow loop.


