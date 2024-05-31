# Hands-on: Hyper-parameter tuning the PyTorch model using Ray

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/ai-202405291/09_Hyper-parameter_tuning_using_Ray_on_LUMI).

<video src="https://462000265.lumidata.eu/ai-20240529/recordings/E09_Ray.mp4" controls="controls">
</video>


## Q&A

6.  In `run.sh` in the reference solution, memory is specified to be 0 (`#SBATCH --mem=0`). Why does this work? Why do we not need to specify e.g. 480G?

    -   (Gregor) `--mem=0` will use all the available memory on the node, it's just a faster way of specifying "use all the available memory on the node". `--mem=480G` works as well.

    -   (Kurt) but it is actually better to specify that you want 480G as there is a subtle difference: Asking for 480G guarantees that you will get 480G. You can get a lot less with `--mem=0` if, e.g., due to a memory leak in the system software - which has happened - more memory is consumed by the OS. So asking `--mem=480G` guarantees you a node that is healthy at least in that respect.

