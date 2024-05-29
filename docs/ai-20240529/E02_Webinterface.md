# Hands-on: Run a simple PyTorch example notebook

[Exercises on the course GitHub](https://github.com/Lumi-supercomputer/Getting_Started_with_AI_workshop/tree/main/02_Using_the_LUMI_web_interface).


## Q&A

6.  Not directly related to the exercise, but is it possible to view the GPU / memory utilization in real time when running jobs ? Perhaps something similar to C3se implementation like this https://www.c3se.chalmers.se/documentation/monitoring/

    -   We will discuss some methods later today.

7.  I already have a project on LUMI that I wanted to carry the exercises out on, but I run into some problems. I changed the "HF_HOME" variable to my own project ("/scratch/project_465000956/hf-cache"), but I get an error of `OSError: [Errno 122] Disk quota exceeded`. What am I doing wrong?

   -   Check your disk quota with the `lumi-workspaces` command. You likely have a too large volume or too many files in your scratch or home folder.

   -   **UPDATE**: (Lukas) There was an issue in the notebook that could cause this. This is now fixed, so you can update via `git pull`.
