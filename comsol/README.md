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
#SBATCH --time=10-00:00:00                 # Allocate 10 days of wall time
#SBATCH --mem-per-cpu=4gb                  # Allocate 4 GB per CPU
#SBATCH --error=comsol.%J.err              # Error log
#SBATCH --output=comsol.%J.out             # Output log
#SBATCH --partition=standard                # Using standard partition
#SBATCH --account=open                     # Charging to this account

module load comsol                          # Load COMSOL module

# Run COMSOL in batch mode with output specification
comsol batch -inputfile effective_diffusivity.mph \
             -outputfile effective_diffusivity_OUT.mph \
             -np ${SLURM_NTASKS_PER_NODE}  # Run with specified number of processors
```

## Notes

- COMSOL requires significant memory; adjust `--mem-per-cpu` based on your model complexity
- The `comsol batch` command runs COMSOL in non-interactive mode, suitable for HPC clusters
- Use the COMSOL GUI on your local machine to create and test the model file (`.mph`)
- Transfer the tested model file to Roar and submit it for batch processing
- The `standard` partition is used in this example; request `himem` partition for very large simulations
- Wall time (10 days in example) depends on model complexity; adjust `--time` accordingly
- The `-np` parameter specifies the number of processors for parallel COMSOL runs
- Output file is specified with `-outputfile` parameter and also written to the current directory
