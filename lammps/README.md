# LAMMPS Molecular Dynamics Example for ICDS Roar Collab Cluster

## Overview
This directory contains example SLURM submission scripts for running LAMMPS (Large-scale Atomic/Molecular Massively Parallel Simulator) on the Roar Collab cluster. These examples demonstrate how to execute parallel molecular dynamics simulations using both the open queue and dedicated allocation/credit accounts.

## Files
- `lammps-open.submit` - Submission script for the open (public) queue.
- `lammps-paid.submit` - Submission script for users with a specific allocation or credit account.
- `lj_basic.in` - A sample LAMMPS input file (e.g., Lennard-Jones fluid simulation).

## How to Run

### Submit an Open Queue Job
Use `sbatch` to submit the open queue script:
```bash
sbatch lammps-open.submit
```

### Submit an Allocation/Credit Job
Edit the account ID in the script first, then submit:
```bash
sbatch lammps-paid.submit
```

Check Job Status
To monitor the progress of your job:
```bash
squeue --me --start
```


## Script Breakdown
lammps-open.submit

```bash
#!/bin/bash
#SBATCH --nodes=1                     # Request 1 compute node
#SBATCH --ntasks=4                    # Request 4 total MPI tasks
#SBATCH --mem=8GB                     # Allocate 8 GB of memory
#SBATCH --time=10:00                  # Set a 10-minute time limit
#SBATCH --output=lammps.%j.out        # Output log file (%j is the job ID)
#SBATCH --error=lammps.%j.err         # Error log file
#SBATCH --job-name=lammps_example     # Name of the job
#SBATCH --account=open
#SBATCH --partition=basic

# Load the LAMMPS module specifically built for the open queue
module load lammps/open-20240829

# Run LAMMPS using MPI for parallel execution
mpirun -np ${SLURM_NTASKS} lmp -in lj_basic.in

```
