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
#SBATCH --job-name g16                     # Name of the job
#SBATCH --nodes=1                          # Use 1 compute node
#SBATCH --ntasks-per-node=4                # Allocate 4 processors on the node
#SBATCH --mem-per-cpu=2000                 # Allocate 2000 MB of memory per CPU
#SBATCH --time=10:00                       # Allocate 10 hours
#SBATCH --error=gaussian.%J.err            # Error log
#SBATCH --output=gaussian.%J.out           # Output log

module load gaussian/g16c01                 # Load Gaussian G16 module (c01 version)

# Run Gaussian on the input file
g16 test_g98.com                            # Input file (uses test_g98.log for output)
```

## Notes

- Gaussian creates `.log` output files based on the input filename (e.g., `test_g98.com` → `test_g98.log`)
- `--ntasks-per-node=4`: Instructs Gaussian to use 4 processors for parallel calculations
- The module loaded is `gaussian/g16c01` which is the Gaussian G16 version c01
- Input files (`.com` files) follow Gaussian's input format with route section (`#`), link0 commands, etc.
- Output includes all quantum chemistry results, orbital energies, geometries, frequencies, etc.
- Adjust memory (`--mem-per-cpu`) and wall time (`--time`) based on system size and computational level of theory
- For large molecular systems, increase `--ntasks-per-node` and memory to enable parallel calculations
- For very large systems, consider multi-node jobs with Linda parallelization (requires additional setup)
