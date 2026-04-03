# ANSYS SLURM Job Examples for ICDS Roar Collab Cluster

## Overview

This directory contains example SLURM submission scripts for running ANSYS jobs on Roar Collab. ANSYS is a comprehensive finite element analysis (FEA) software suite used for structural analysis, computational fluid dynamics (CFD), and electromagnetic simulations.

## Files

- `ansys.submit` - Serial ANSYS job example with job array capability
- `ansys-mpi.submit` - MPI-parallel ANSYS job example
- `example.inp` - Sample ANSYS input file

## How to Run

### Serial Job with Job Arrays

Submit the serial job with:
```bash
sbatch ansys.submit
```

For checking job status:
```bash
scontrol show job <jobid>
```

### MPI Parallel Job

Submit the MPI job with:
```bash
sbatch ansys-mpi.submit
```

## Script Breakdown

### ansys.submit

```bash
#!/bin/bash
#SBATCH --nodes=1                          # Use 1 compute node
#SBATCH --ntasks-per-node=1                # Run 1 task per node
#SBATCH --time=10:00                       # Allocate 10 minutes of wall time
#SBATCH --mem=2gb                          # Allocate 2 GB of memory
#SBATCH --account=test_credits_iask        # Charge to this account
#SBATCH --partition=himem                  # Use high memory partition
#SBATCH --output=ansys.%j.%a.out           # Output log (j=job_id, a=array_index)
#SBATCH --error=ansys.%j.%a.err            # Error log
#SBATCH --array=1-100                      # Create 100 array jobs

module load ansys/2023R2                   # Load ANSYS version 2023 R2

# Create unique input file for each array task
cp example.inp example.$SLURM_JOB_ID.$SLURM_ARRAY_TASK_ID.inp

# Run ANSYS in batch mode
ansys232 -b \                               # Run ANSYS in batch mode (no GUI)
         -np $SLURM_NTASKS \               # Use number of processors
         -i example.$SLURM_JOB_ID.$SLURM_ARRAY_TASK_ID.inp \  # Input file
         -o example.$(hostname).$SLURM_JOB_ID.$SLURM_ARRAY_TASK_ID.out  # Output file
```

## Notes

- The `#SBATCH --array=1-100` directive creates 100 parallel job array tasks, useful for parameter sweeps
- Each array task gets its own unique input and output files to prevent conflicts
- The `himem` partition provides high-memory nodes suitable for large ANSYS simulations
- Modify the input file `example.inp` with your own ANSYS commands
