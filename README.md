# Vector SLURM Example Scripts

## Running Single Jobs
If you'd like to run a single job, you can modify the example scripts `example_job.slrm` and `example_job.sh`. Changing the launch parameters and scripts manually might get time consuming, so we can generate these files automatically using the script `launch_slurm_job.sh`. The command line parameters can be changed to set different aspects and parameters of your job and slurm allocation.

## Running a Hyperparameter Sweep.
If you'd like to run a set of jobs, we will need to generate a separate `.slrm` and `.sh` script for each job, and launch each one with a different job name. We can do so by launching our `launch_slurm_job.sh` script inside a loop (for example in `hyperparameter_sweep.sh`). In this case I've written the script to do so in bash, but it would be just as easy to do so within python.

## Checkpointing for Preemption
Since your jobs will be liable to be preempted once they pass the hour mark of running time, we need to make sure we are checkpointing our code regularly and saving all relevant information. I have provided an example dummy training loop inside `train.py` that you can use as a template for your own checkpointing code. Inside this code, we
1. check if a checkpoint exists
2. if it does exist, load the relevant `state_dict` and set all our local variables and tensors
3. run our training loop
4. every epoch or every `n` updates, overwrite our checkpoint with our new `state_dict`

As a general guideline, you should be checkpointing every 10-15 minutes. If you are running a long job, make sure you are overwriting some running `checkpoint_last.pt` so that you don't fill up the hard drives! 

Remember that this state dict can hold more information than just your model. You might find it useful to store for example:
* model state
* optimizer state
* random seed
* epoch number
* iteration number
* training arguments
* etc.

Saving all of the relevant states will make sure we can restart our job from exactly where it left off.


## Running jobs with the Hydra Slurm Launcher
To run a job with the Hydra slurm launcher, download the [forked hydra repo](https://github.com/nng555/hydra). 

### Setting up the top-level .yaml
In your top level config.yaml, you need to set `hydra/launcher: slurm` as well as your sbatch options within the `slurm` object. Options will be converted from the corresponding key-value pairs to sbatch options. For example, to use 20G of memory on the `gpu` partition, we need to set

```yaml
slurm:
  mem: 20G
  partition: gpu
```

which will be converted to the following options in the generated sbatch slrm script

```bash
#SBATCH --mem=20G
#SBATCH --partition=gpu
```

### Logging
By default logs are output in `~/slurm/${date}/${job_name}/log/${SLURM_JOB_ID}.out/err`. 
