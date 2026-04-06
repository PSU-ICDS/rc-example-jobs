# Java Parallel Matrix Multiplication Example for ICDS Roar Collab Cluster

## Overview
This directory contains a Java-based example demonstrating parallel matrix multiplication using the `ForkJoinPool` and `RecursiveTask` framework. The application performs a multiplication of two $2048 \times 2048$ matrices, automatically distributing the workload across the CPU cores allocated by the SLURM scheduler.

## Files
- `ParallelMatrixMultiplication.java` - The Java source code implementing the parallelized multiplication logic.
- `run_parallel_matrix.submit` - The SLURM submission script used to compile and execute the Java application.

## How to Run

### Submit the Job
Use `sbatch` to submit the execution script to the Roar Collab scheduler:
```bash
sbatch run_parallel_matrix.submit
```

Check Job Status
To monitor the progress of your job:
```bash
squeue --me --start
```


## Script Breakdown
run_parallel_matrix.submit

```bash
#!/bin/bash

#SBATCH --job-name=parallel_matrix_multiplication   # Name of the job
#SBATCH --output=matrix_multiplication.%J.out          # Output log file (%J = job ID)
#SBATCH --error=matrix_multiplication.%J.err           # Error log file
#SBATCH --ntasks=1                                   # Number of tasks
#SBATCH --cpus-per-task=64                           # Number of CPU cores per task
#SBATCH --time=02:00:00                             # Set a 2-hour time limit
#SBATCH --mem=16G                                    # Allocate 16 GB of memory
#SBATCH -A open
#SBATCH -p basic

# Load the Java Development Kit (JDK) module
module load jdk

# Execute the Java source file directly
# Modern JDKs allow running source files without manual compilation steps
java ParallelMatrixMultiplication.java

```

