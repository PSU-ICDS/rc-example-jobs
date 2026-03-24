# ANSYS Fluent SLURM Job Examples for ICDS Roar Collab Cluster

## Overview

This directory contains example SLURM submission scripts for running ANSYS Fluent (Computational Fluid Dynamics software) on Roar Collab. The examples demonstrate both serial and MPI parallel execution.

## Files

- `fluent.slurm` - Serial Fluent job example
- `fluent-mpi.slurm` - MPI parallel Fluent job example
- `in.file` - Fluent input journal file
- `inlet.cas` - Fluent case file
- `inlet.dat` - Fluent data file

## How to Run

### Serial Job
```bash
sbatch fluent.slurm
```

### MPI Parallel Job
```bash
sbatch fluent-mpi.slurm
```

Check job status:
```bash
squeue -j <job_id>
```

## Script Breakdown

### fluent.slurm (Serial)

```bash
#!/bin/bash
#SBATCH --ntasks=1                         # Run 1 task (serial)
#SBATCH --nodes=1                          # Use 1 node
#SBATCH --time=10:00:00                    # Allocate 10 hours
#SBATCH --mem-per-cpu=4gb                  # Allocate 4 GB per CPU
#SBATCH --error=fluent.%J.err              # Error log
#SBATCH --output=fluent.%J.out             # Output log

module load ansys                           # Load ANSYS module (includes Fluent)

fluent 2ddp -i in.file -g                   # Run Fluent in 2D double precision
                                            # -i: input journal file
                                            # -g: graphics off (batch mode)
```

### fluent-mpi.slurm (MPI Parallel)

```bash
#!/bin/bash
#SBATCH --ntasks=10                        # Run 10 MPI tasks
#SBATCH --nodes=1                          # Use 1 node (all on same node)
#SBATCH --time=10:00:00                    # Allocate 10 hours
#SBATCH --mem-per-cpu=4gb                  # Allocate 4 GB per CPU
#SBATCH --error=fluent.%J.err              # Error log
#SBATCH --output=fluent.%J.out             # Output log

module load ansys                           # Load ANSYS module

FLUENTNODES="$(scontrol show hostnames)"   # Get list of allocated nodes

# Run Fluent with MPI parallelization
fluent 2ddp \                               # 2D, double precision
       -t${SLURM_NTASKS} \                  # Number of processors (-t = total)
       -i in.file \                         # Input journal file
       -cnf=$FLUENTNODES \                  # Node configuration for MPI
       -g                                   # Graphics off (batch mode)
```

## Notes

- **2ddp**: Specifies 2D simulation with double precision. Use `3ddp` for 3D or `2d`/`3d` for single precision
- **Serial**: Use for smaller simulations or debugging
- **MPI Parallel**: Use for larger simulations requiring distributed computing
- `-i in.file`: Input file contains journal commands (Fluent commands executed in batch)
- `-g`: Graphics off flag for batch mode (no GUI)
- `-cnf=$FLUENTNODES`: Specifies node configuration for MPI jobs; must be used for multi-node jobs
- Prepare and test your case file (`.cas`) and data file (`.dat`) on your local machine first
- The input journal file (`in.file`) should contain all commands needed for your simulation
- Adjust `--ntasks` and wall time based on your simulation complexity and available resources
