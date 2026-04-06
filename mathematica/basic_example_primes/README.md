# Mathematica Primes Example for ICDS Roar Collab Cluster

## Overview
This directory contains an example of how to execute a Mathematica script on the Roar Collab cluster. The script calculates and prints all prime numbers between 1 and 100, demonstrating a basic non-interactive batch job using the `math` command-line interface.

## Files
- `math_primes.submit` - SLURM submission script to run the Mathematica job.
- `math_primes.m` - The Mathematica source file containing the logic to find and print primes.

## How to Run

### Submit the Job
Use `sbatch` to submit the script to the cluster scheduler:
```bash
sbatch math_primes.submit
```

Check Job Status
To monitor the progress of your job:
```bash
squeue --me --start
```


## Script Breakdown
math_primes.submit

```bash
#!/bin/bash

#SBATCH --job-name=math_primes       # Name of the job
#SBATCH --mem=1GB                    # Allocate 1 GB of memory
#SBATCH --time=00:10:00              # Set a 10-minute time limit
#SBATCH --ntasks=1                   # Run a single task
#SBATCH --input=none                 # Specify no standard input
#SBATCH --account=open
#SBATCH --partition=basic
#SBATCH --output=math_primes_%j.out  # Output log file (%j is the job ID)
#SBATCH --error=math_primes_%j.err   # Error log file

# Load the Mathematica environment module
module load mathematica

# Execute the Mathematica script in batch mode
math -run < math_primes.m

```
