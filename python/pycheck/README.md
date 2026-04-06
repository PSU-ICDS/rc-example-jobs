# Python Data Validation Example for ICDS Roar Collab Cluster

## Overview
This directory contains an example of how to run a Python-based data validation workflow on the Roar Collab cluster. The example demonstrates how to modularize Python code across multiple files and process a CSV input file using a SLURM submission script.

## Files
- `simple_submit_pycheck.submit` - SLURM submission script to run the Python job.
- `pycheck.py` - The main Python execution script.
- `functions.py` - A module containing helper functions for reading and validating data.
- `in_pycheck.csv` - The input CSV data file to be processed.

## How to Run

### Submit the Job
Use `sbatch` to submit the script to the cluster scheduler:
```bash
sbatch simple_submit_pycheck.submit
```

Check Job Status
To monitor the progress of your job:
```bash
squeue --me --start
```

## Script Breakdown
simple_submit_pycheck.submit

```bash

#!/bin/bash

#### Scheduler Directives ####

#SBATCH -A open              
#SBATCH -p basic             
#SBATCH -N 1                 # Request 1 compute node
#SBATCH -n 1                 # Request 1 task/CPU core
#SBATCH -t 00:01:00          # Set a 1-minute time limit
#SBATCH --mem=1gb            # Allocate 1 GB of memory
#SBATCH -o pycheck_%j.out    # Output log file (%j is the job ID)
#SBATCH -e pycheck_%j.err    # Error log file

#### Job is launched when placed on compute nodes ####
echo " "
echo "Job started at `date` on `hostname`"
echo " "

#### Execute your job ####
# Run the main Python script
python pycheck.py

#### Job Output ####
echo " "
echo "Job ended at `date`"
echo " "

```
