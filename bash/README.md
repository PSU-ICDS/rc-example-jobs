# Bash Parallel SLURM Job Example for ICDS Roar Collab Cluster

## Overview

This directory contains an example of running parallel bash commands using SLURM on Roar Collab. The `srun` command is used to launch tasks across multiple nodes, demonstrating basic parallel job execution.

## Files

- `parjob.slurm` - SLURM submission script for parallel bash execution
- `simplecheck.sh` - Simple bash script that runs on each parallel task

## How to Run

Submit the job with:
```bash
sbatch parjob.slurm
```

Check job status:
```bash
squeue -j <job_id>
```

## Script Breakdown

### parjob.slurm

```bash
#!/bin/bash

#SBATCH --job-name=parallel_example        # Name of the job
#SBATCH --account=open                     # Use open account
#SBATCH --partition=open                   # Use open partition
#SBATCH --nodes=4-4                        # Request exactly 4 nodes
#SBATCH --ntasks-per-node=2                # Run 2 tasks on each node (8 total)
#SBATCH --mem-per-cpu=100mb                # Allocate 100 MB per CPU
#SBATCH --time=00:01:00                    # Allocate 1 minute of wall time
#SBATCH --output=%x.%j.out                 # Output log (x=job_name, j=job_id)
#SBATCH --error=%x.%j.err                  # Error log

srun -l bash simplecheck.sh                # Launch bash script on all tasks
                                           # -l flag labels output with task ID
```

### simplecheck.sh

This script runs on each parallel task. The `-l` flag in `srun` prepends each line of output with the task ID, making it easy to track which node/task produced the output.

## Notes

- `srun` is used to launch tasks across allocated resources in parallel
- The `-l` flag labels each output line with the task/node ID for easy tracking
- `--nodes=4-4` means request exactly 4 nodes (4 minimum and 4 maximum)
- Total number of parallel tasks = 4 nodes × 2 tasks per node = 8 parallel tasks
- This is useful for embarrassingly parallel workloads or running independent analyses in parallel
