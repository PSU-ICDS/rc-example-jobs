# SAS Job Example for ICDS Roar Collab Cluster

## Overview
This directory contains an example SLURM submission script for running SAS (Statistical Analysis System) on the Roar Collab cluster. SAS is a powerful software suite used for advanced analytics, multivariate analysis, business intelligence, and data management.

## Files
- `sas.submit` - SLURM submission script for executing SAS in batch mode.
- `t-test.sas` - A sample SAS program file (e.g., performing a t-test analysis).

## How to Run

### Submit the Job
Use `sbatch` to submit the script to the cluster scheduler:
```bash
sbatch sas.submit
```

Check Job Status
To monitor the progress of your job:
```bash
squeue --me --start
```

## Script Breakdown
sas.submit

```bash

#!/bin/bash
#SBATCH --partition=basic        
#SBATCH --account=open           
#SBATCH --nodes=1                # Run on a single compute node
#SBATCH --ntasks-per-node=1      # Run a single task
#SBATCH --mem=1gb                # Allocate 1 GB of memory
#SBATCH --time=00:10:00          # Set a 10-minute time limit
#SBATCH --job-name=sas_example   # Name of the job
#SBATCH --error=sas_example.%j.err  # Error log file (%j is the job ID)
#SBATCH --output=sas_example.%j.out # Output log file

# Load the SAS environment module
module load sas/9.4

# Execute the SAS program in batch mode
sas t-test.sas

```
