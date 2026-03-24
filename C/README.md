# C Language SLURM Job Examples for ICDS Roar Collab Cluster

## Overview

This directory contains example SLURM submission scripts for compiling and running C programs on Roar Collab. The examples demonstrate serial execution, OpenMP multi-threading, and MPI parallelization.

## Files

- `demo_c_serial.c` - Serial C program
- `demo_c_openmp.c` - C program using OpenMP for shared-memory parallelization
- `demo_c_mpi.c` - C program using MPI for distributed-memory parallelization
- `serial.slurm` - SLURM script for serial execution
- `openmp.slurm` - SLURM script for OpenMP execution
- `mpi.slurm` - SLURM script for MPI execution

## How to Run

### Serial Job
```bash
sbatch serial.slurm
```

### OpenMP Parallel Job
```bash
sbatch openmp.slurm
```

### MPI Parallel Job
```bash
sbatch mpi.slurm
```

## Script Breakdown

### serial.slurm
```bash
#!/bin/bash
#SBATCH --mem-per-cpu=1024                 # Allocate 1024 MB per CPU
#SBATCH --ntasks=1                         # Run 1 task
#SBATCH --time=00:01:00                    # Allocate 1 minute of wall time
#SBATCH --job-name=serial                  # Name of the job
#SBATCH --error=serial.%J.err              # Error log
#SBATCH --output=serial.%J.out             # Output log

module load gcc                             # Load GCC compiler

gcc demo_c_serial.c -o demo_c_serial        # Compile the program
./demo_c_serial                             # Run the program
rm demo_c_serial                            # Clean up executable
```

### openmp.slurm
```bash
#!/bin/bash
#SBATCH --mem-per-cpu=1024                 # Allocate 1024 MB per CPU
#SBATCH --ntasks=1                         # Run 1 task
#SBATCH --time=00:01:00                    # Allocate 1 minute
#SBATCH --job-name=openmp                  # Name of the job
#SBATCH --error=openmp.%J.err              # Error log
#SBATCH --output=openmp.%J.out             # Output log

module load gcc                             # Load GCC compiler

gcc -fopenmp demo_c_openmp.c -o demo_c_openmp  # Compile with OpenMP support
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK   # Set OpenMP threads
./demo_c_openmp                             # Run the program
rm demo_c_openmp                            # Clean up executable
```

### mpi.slurm
```bash
#!/bin/bash
#SBATCH --mem-per-cpu=1024                 # Allocate 1024 MB per CPU
#SBATCH --ntasks=5                         # Run 5 MPI tasks
#SBATCH --time=00:01:00                    # Allocate 1 minute
#SBATCH --job-name=mpi                     # Name of the job
#SBATCH --error=mpi.%J.err                 # Error log
#SBATCH --output=mpi.%J.out                # Output log

module load openmpi/4.1.1-pmi2              # Load OpenMPI library

mpicc demo_c_mpi.c -o demo_c_mpi           # Compile with MPI support
mpirun -np 5 ./demo_c_mpi                  # Run with 5 MPI processes
rm demo_c_mpi                               # Clean up executable
```

## Notes

- **Serial**: Uses GCC to compile and run a simple C program
- **OpenMP**: Enables shared-memory parallelization using compiler flags (`-fopenmp`). All threads share the same memory
- **MPI**: Enables distributed-memory parallelization where each process has its own memory and communicates via message passing
- `mpicc` is the MPI C compiler wrapper that automatically includes necessary MPI libraries
- `mpirun` launches MPI processes across allocated nodes
- Choose the appropriate parallelization method based on your problem:
  - Serial: Single-threaded execution
  - OpenMP: Multi-core on a single node (shared memory)
  - MPI: Multiple nodes or fine-grained control over communication
