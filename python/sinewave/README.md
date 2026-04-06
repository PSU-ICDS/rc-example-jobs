# Sine Wave Generation and Analysis Example for ICDS Roar Collab Cluster

## Overview
This directory contains a Python-based workflow for generating a noisy sine wave signal, saving the data to a CSV, and subsequently reading that data to produce a visualization. It demonstrates the use of `numpy`, `pandas`, and `matplotlib` within the Anaconda environment on Roar Collab.

## Files
- `sub_nsin_py.submit` - SLURM submission script using `srun` to execute the Python analysis.
- `generate_nsin.py` - Script to generate synthetic sine wave data with Gaussian noise.
- `read_nsin.py` - Script to read the generated CSV and plot the resulting signal.
- `noiseysine.csv` - The intermediate data file containing coordinates.

## How to Run

### Submit the Job
Use `sbatch` to submit the execution script:
```bash
sbatch sub_nsin_py.submit
```

Check Job Status
To monitor the progress of your job:
```bash
squeue --me --start
```

## Script Breakdown
sub_nsin_py.submit

```bash
#!/bin/bash

#SBATCH --job-name=nsin_py           # Name of the job in the queue
#SBATCH --account=open                
#SBATCH --partition=basic             
#SBATCH --nodes=1                     # Request 1 compute node
#SBATCH --ntasks-per-node=2           # Request 2 tasks on the node
#SBATCH --mem-per-cpu=1GB             # Allocate 1GB of RAM per CPU core
#SBATCH --time=00:01:00               # Set a 1-minute time limit
#SBATCH --output=nsin_py.%j.out       # Standard output log (%j = job ID)
#SBATCH --error=nsin_py.%j.err        # Standard error log

# Load the Anaconda environment to access scientific libraries
module load anaconda3

# Execute the reading and plotting script using srun
srun python read_nsin.py

```
