# GAMS SLURM Job Example for ICDS Roar Collab Cluster

## Overview

This directory contains an example SLURM submission script for running GAMS (General Algebraic Modeling System) on Roar Collab. GAMS is a high-level modeling system for mathematical programming and optimization problems, including linear programming, nonlinear programming, and mixed-integer programming.

This example uses the input from the [GAMS Quick Start Tutorial](https://www.gams.com/latest/docs/UG_TutorialQuickstart.html).

## Files

- `example.gms` - GAMS input file for a linear programming problem (farm model maximizing profit)
- `gams.submit` - SLURM submission script to run the example in batch mode

## How to Run

Submit the job with:
```bash
sbatch gams.submit
```

Check job status:
```bash
scontrol show job <jobid>
```

## Script Breakdown

### gams.submit

```bash
#!/bin/bash
#SBATCH --nodes=1                          # Use 1 compute node
#SBATCH --ntasks=4                         # Run 4 tasks
#SBATCH --time=10:00                       # Allocate 10 hours of wall time
#SBATCH --mem=8GB                          # Allocate 8 GB of memory
#SBATCH --output=gams.%j.out               # Output log (j=job_id)
#SBATCH --error=gams.%j.err                # Error log
#SBATCH --job-name=gams_example            # Job name
#SBATCH --account=open                     # Charge to this account

module load gams                            # Load GAMS module

gams example.gms                            # Run GAMS on the example file
```

## Output Files

- `gams.*.out` - SLURM output file containing GAMS analysis output (also in `example.lst`)
- `gams.*.err` - SLURM error log (should be empty if job runs successfully)
- `example.lst` - GAMS output file containing detailed model results and diagnostics

## Notes

- GAMS solves mathematical optimization problems defined in the `.gms` input file
- The example provided is a farm profit optimization problem demonstrating GAMS capabilities
- Output includes model statistics, solver status, and solution values
- Modify `example.gms` with your own GAMS model for different optimization problems
- GAMS requires a license; check with ICDS if your account has access
- For large optimization problems, you may need to increase `--time` and `--mem` allocations
