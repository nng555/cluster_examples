# Vector SLURM Example Scripts

## Running Single Jobs
If you'd like to run a single job, you can modify the example scripts `example_job.slrm` and `example_job.sh`. Changing the launch parameters and scripts manually might get time consuming, so we can generate these files automatically using the script `launch_slurm_job.sh`. The command line parameters can be changed to set different aspects and parameters of your job and slurm allocation.

## Running a Hyperparameter Sweep.
If you'd like to run a set of jobs, we will need to generate a separate `.slrm` and `.sh` script for each job, and launch each one with a different job name. We can do so by launching our `launch_slurm_job.sh` script inside a loop. In this case I've written the script to do so in bash, but it would be just as easy to do so within python.

