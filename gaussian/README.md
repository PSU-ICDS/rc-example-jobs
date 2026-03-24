# Gaussian SLURM Job Example for ICDS Roar Collab Cluster

## Overview

This directory contains an example SLURM submission script for running Gaussian (quantum chemistry software) on Roar Collab. Gaussian is used for molecular orbital calculations, thermochemistry, and other quantum mechanics computations.

## Files

- `gaussian-g16.slurm` - SLURM submission script for Gaussian G16
- `test_g98.com` - Sample Gaussian input file

## How to Run

Submit the job with:
```bash
sbatch gaussian-g16.slurm
```

Check job status:
```bash
squeue -j <job_id>
```

Monitor output:
```bash
tail -f test_g98.log
```

## Script Breakdown

### gaussian-g16.slurm

```bash
#!/bin/bash
#SBATCH --nodes=1                          # Use 1 compute node
#SBATCH --ntasks-per-node=8                # Allocate 8 processors on the node
#SBATCH --mem=16gb                         # Allocate 16 GB of memory
#SBATCH --time=24:00:00                    # Allocate 24 hours
#SBATCH --job-name=gaussian_g16            # Name of the job
#SBATCH --account=test_credits_iask        # Charge to this account
#SBATCH --partition=himem                  # Use high-memory partition
#SBATCH --error=gaussian.%J.err            # Error log
#SBATCH --output=gaussian.%J.out           # Output log

# Set Gaussian environment variables
export GAUSS_SCRDIR=/scratch/$USER/$SLURM_JOB_ID  # Temporary scratch directory
export GAUSS_MDEF=$((SLURM_NTASKS_PER_NODE))      # Number of Gaussian processes

mkdir -p $GAUSS_SCRDIR                     # Create scratch directory

module load gaussian/g16                    # Load Gaussian G16 module

# Run Gaussian on the input file
g16 test_g98.com                            # Input file (uses test_g98.log for output)
```

## Notes

- **GAUSS_SCRDIR**: Points to temporary scratch space for intermediate calculations; should be on fast storage
- **GAUSS_MDEF**: Specifies the number of processes Gaussian will use internally
- Gaussian creates `.log` output files based on the input filename (e.g., `test_g98.com` → `test_g98.log`)
- `--ntasks-per-node=8`: Instructs Gaussian to use 8 processors for parallel calculations
- The `himem` partition is recommended for large molecular systems or high-level of theory calculations
- Input files (`.com` files) follow Gaussian's input format with route section (`#`), link0 commands, etc.
- Output includes all quantum chemistry results, orbital energies, geometries, frequencies, etc.
- Adjust memory (`--mem`) and wall time based on system size and computational level of theory
- For very large systems, consider multi-node jobs with Linda parallelization (requires additional setup)
