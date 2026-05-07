# Julia Programming Examples for ICDS Roar Collab Cluster

## Overview
This directory contains Julia programming examples for the Roar Collab cluster. The included scripts demonstrate fundamental Julia syntax, including various loop structures (for, while, enumerate, map) and advanced string manipulation (interpolation, indexing, and concatenation).

## Files
- `loop.submit` - SLURM submission script for the loops and arrays example.
- `string.submit` - SLURM submission script for the string manipulation example.
- `loop.jl` - Julia source code demonstrating loops, dictionaries, and array operations.
- `string.jl` - Julia source code demonstrating string interpolation, indexing, and character handling.

## How to Run

### Submit the Job
You can submit either example using `sbatch`:
```bash
sbatch loop.submit
sbatch string.submit
```

Check Job Status
To monitor the progress of your job:
```bash
squeue --me --start
```


## Script Breakdown
loop.submit

```bash
#!/bin/bash
#SBATCH -A open
#SBATCH -p basic
#SBATCH --time=10:00                  # Set a 10-minute time limit
#SBATCH --ntasks=1                    # Request 1 task
#SBATCH --mem=4GB                     # Allocate 4 GB of memory
#SBATCH --job-name=julia              # Name of the job
#SBATCH --error=julia.%J.err          # Error log file (%J is the job ID)
#SBATCH --output=julia.%J.out         # Output log file

# Load the Julia environment module
module load julia

# Execute the Julia script
julia loop.jl

```

