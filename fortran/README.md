# Fortran SLURM Job Examples for ICDS Roar Collab Cluster

## Overview

This directory contains example SLURM submission scripts for compiling and running Fortran programs on Roar Collab. The examples demonstrate both serial and MPI parallel execution.

## Files

- `demo_f_serial.f90` - Serial Fortran program (Fortran 90 syntax)
- `demo_f_mpi.f90` - MPI parallel Fortran program
- `submit_serial.slurm` - SLURM script for serial execution
- `submit_mpi.slurm` - SLURM script for MPI execution

## How to Run

### Serial Job
```bash
sbatch submit_serial.slurm
```

### MPI Parallel Job
```bash
sbatch submit_mpi.slurm
```

Check job status:
```bash
squeue -j <job_id>
```

## Script Breakdown

### submit_serial.slurm

```bash
#!/bin/bash
#SBATCH --ntasks=5                         # Number of tasks
#SBATCH --mem-per-cpu=1024                 # Allocate 1024 MB per CPU
#SBATCH --time=00:01:00                    # Allocate 1 minute
#SBATCH --job-name=Fortran                 # Name of the job
#SBATCH --error=Fortran.%J.err             # Error log
#SBATCH --output=Fortran.%J.out            # Output log

module load gcc                             # Load GCC compiler (includes gfortran)

gfortran demo_f_serial.f90                  # Compile Fortran 90 program
./a.out                                     # Run the compiled executable
```

### submit_mpi.slurm

```bash
#!/bin/bash
#SBATCH --ntasks=5                         # Run 5 MPI tasks
#SBATCH --mem-per-cpu=1024                 # Allocate 1024 MB per CPU
#SBATCH --time=00:01:00                    # Allocate 1 minute
#SBATCH --job-name=Fortran_MPI             # Name of the job
#SBATCH --error=Fortran_MPI.%J.err         # Error log
#SBATCH --output=Fortran_MPI.%J.out        # Output log

module load openmpi                         # Load OpenMPI library
module load gcc                             # Load GCC compiler (includes gfortran)

mpif90 demo_f_mpi.f90 -o demo_f_mpi        # Compile Fortran with MPI support
mpirun -np 5 ./demo_f_mpi                  # Run with 5 MPI processes
```

## Notes

- **gfortran**: The Fortran compiler from the GCC suite
- **mpif90**: MPI Fortran compiler wrapper that includes necessary MPI libraries and headers
- **F90 Format**: Modern Fortran with free-form syntax (as opposed to Fortran 77 fixed-form)
- **Serial**: Uses `gfortran` for single-process execution
- **MPI**: Uses `mpif90` to link MPI libraries; `mpirun` launches the processes
- `-np 5`: Number of MPI processes (must match `--ntasks=5` in SLURM)
- The compiled executable typically outputs to `a.out` by default
- For larger Fortran projects, consider using makefiles or build systems like CMake
