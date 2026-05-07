# Stata SLURM Job Example for ICDS Roar Collab Cluster

## Overview

This directory contains an example of submitting a **Stata** job using SLURM on the ICDS Roar Collab cluster. The script loads the Stata module and runs a Stata do-file in batch mode (`-b` flag) for non-interactive execution.

This is a simple single-node, multi-core Stata job suitable for most standard statistical analyses.

## Files

- `stata.submit` - SLURM submission script for running Stata
- `auto_analysis.do` - Example Stata do-file (assumed to exist in the same directory)

## How to Run

Submit the job with:

```bash
sbatch stata.submit
```

Check job status:

```bash
squeue --me --start
```

or for the specific job:

```bash
squeue -j <job_id>
```

View output once the job completes:

```bash
cat stata_test_<job_id>.out
```

## Script Breakdown

stata.submit

```bash

#!/bin/bash
#SBATCH --job-name=stata_test
#SBATCH --time=00:05:00
#SBATCH --ntasks-per-node=4
#SBATCH --nodes=1
#SBATCH --mem=2G
#SBATCH --output=stata_test_%j.out
#SBATCH --error=stata_test_%j.err
#SBATCH --partition=basic
#SBATCH --account=open

# Load Stata module (adjust version to your requirements)
module load stata/19

# Run Stata in batch (non-interactive) mode
stata-se -b do auto_analysis.do

```
