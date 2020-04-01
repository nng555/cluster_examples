#!/bin/bash

# set up environment
. ~/path/to/my/environment/activate

# symlink checkpoint directory to run directory
ln -s /checkpoint/$USER/$SLURM_JOB_ID /path/to/my/save/dir

python3 train.py
