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

### fluent.slurm (Parallel)

```bash
#!/bin/bash
#SBATCH --ntasks=10                         # Run 10 parallel tasks
#SBATCH --nodes=1                          # Use 1 node
#SBATCH --time=10:00:00                    # Allocate 10 hours
#SBATCH --mem-per-cpu=4gb                  # Allocate 4 GB per CPU
#SBATCH --error=fluent.%J.err              # Error log
#SBATCH --output=fluent.%J.out             # Output log

module load ansys                           # Load ANSYS module (includes Fluent)

FLUENTNODES="$(scontrol show hostnames)"   # Get list of allocated nodes

fluent 2ddp -t${SLURM_NTASKS} \
            -i in.file \
            -cnf=$FLUENTNODES \
            -g                              # Run Fluent in 2D double precision
                                            # -t: number of processors
                                            # -i: input journal file
                                            # -cnf: node configuration for MPI
                                            # -g: graphics off (batch mode)
```

### fluent-mpi.slurm (Multi-Node MPI Parallel)

```bash
#!/bin/bash
#SBATCH --nodes=2                          # Use 2 nodes
#SBATCH --ntasks-per-node=20               # Run 20 MPI tasks per node (total 40)
#SBATCH --time=10:00:00                    # Allocate 10 hours
#SBATCH --mem-per-cpu=4gb                  # Allocate 4 GB per CPU
#SBATCH --account=open                     # Charging to this account
#SBATCH --error=fluent.%J.err              # Error log
#SBATCH --output=fluent.%J.out             # Output log

module load ansys openmpi                   # Load ANSYS and OpenMPI modules

scontrol show hostnames > hosts.$SLURM_JOB_ID  # Write node names to file

export FLUENT_AFFINITY=0                    # Disable FLUENT affinity
export SLURM_ENABLED=1                      # Enable SLURM integration
export SCHEDULER_TIGHT_COUPLING=1           # Enable tight coupling
export ANSYS232_PRODUCT=aa_r                # Set ANSYS product

# Run Fluent with MPI parallelization across nodes
fluent 2ddp -t ${SLURM_NTASKS} \
            -mpi=openmpi \
            -slurm \
            -g \
            -p inifiniband \
            -cnf=hosts.$SLURM_JOB_ID \
            -i in.file >& out.dat           # 2D double precision with OpenMPI
                                            # -t: total number of processors
                                            # -mpi=openmpi: use OpenMPI
                                            # -slurm: enable SLURM
                                            # -cnf: node configuration file
                                            # -i: input journal file
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
