# Java Serial Matrix Multiplication Example for ICDS Roar Collab Cluster

## Overview
This directory contains a Java-based example of serial matrix multiplication. Unlike the parallel version, this implementation uses a traditional triple-nested loop to multiply two $2048 \times 2048$ matrices on a single CPU core. This is primarily used as a baseline for performance benchmarking on the Roar Collab cluster.

## Files
- `SerialMatrixMultiplication.java` - The Java source code containing the serial multiplication logic.
- `run_serial_matrix.submit` - The SLURM submission script used to execute the Java application on a single core.

## How to Run

### Submit the Job
Use `sbatch` to submit the execution script to the cluster scheduler:
```bash
sbatch run_serial_matrix.submit
```

Check Job Status
To monitor the progress of your job:
```bash
squeue --me --start
```


## Script Breakdown
run_serial_matrix.submit

```bash
#!/bin/bash

#SBATCH --job-name=serial_matrix_multiplication    # Name of the job
#SBATCH --output=serial_matrix_multiplication.%J.out # Output log file (%J = job ID)
#SBATCH --error=serial_matrix_multiplication.%J.err  # Error log file
#SBATCH --ntasks=1                                   # Run a single task
#SBATCH --cpus-per-task=1                            # Request exactly 1 CPU core
#SBATCH --time=00:25:00                              # Set a 25-minute time limit
#SBATCH --mem=16G                                    # Allocate 16 GB of memory
#SBATCH -A open
#SBATCH -p basic

# Load the Java Development Kit (JDK) module
module load jdk

# Execute the Java source file
# This performs a serial multiplication of two 2048x2048 matrices
java SerialMatrixMultiplication.java

```

