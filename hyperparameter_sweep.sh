#!/bin/bash

for dropout in 0.1 0.2 0.3; do
  for lr in 0.001 0.0001 0.00001; do
    bash launch_slurm_job.sh gpu example_job_${dropout}_${lr} 1 "python3 train.py --dropout ${dropout} --lr ${lr}"
  done
done
