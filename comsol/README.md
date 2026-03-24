# COMSOL SLURM Job Example for ICDS Roar Collab Cluster

## Overview

This directory contains an example SLURM submission script for running COMSOL Multiphysics on Roar Collab. COMSOL is a finite element analysis (FEA) software used for simulating physics and engineering applications.

## Files

- `comsol.slurm` - SLURM submission script for COMSOL batch execution
- `effective_diffusivity.mph` - Sample COMSOL model file

## How to Run

Submit the job with:
```bash
sbatch comsol.slurm
```

Check job status:
```bash
squeue -j <job_id>
```

## Script Breakdown

### comsol.slurm

```bash
#!/bin/bash
#SBATCH --nodes=1                          # Use 1 compute node
#SBATCH --ntasks-per-node=1                # Run 1 task per node
#SBATCH --time=10:00:00                    # Allocate 10 hours of wall time
#SBATCH --mem=20gb                         # Allocate 20 GB of memory
#SBATCH --account=test_credits_iask        # Charge to this account
#SBATCH --partition=himem                  # Use high-memory partition
#SBATCH --output=comsol.%J.out             # Output log
#SBATCH --error=comsol.%J.err              # Error log

module load comsol                          # Load COMSOL module

# Run COMSOL in batch mode (non-interactive)
comsol batch -inputfile effective_diffusivity.mph  # Input COMSOL model file
```

## Notes

- COMSOL requires significant memory; adjust `--mem` based on your model complexity
- The `comsol batch` command runs COMSOL in non-interactive mode, suitable for HPC clusters
- Use the COMSOL GUI on your local machine to create and test the model file (`.mph`)
- Transfer the tested model file to Roar and submit it for batch processing
- The `himem` partition is recommended for large COMSOL simulations
- Wall time requirement depends on model complexity; adjust `--time` accordingly
- Output files will be generated in the model's output directory (typically defined within the `.mph` file)
