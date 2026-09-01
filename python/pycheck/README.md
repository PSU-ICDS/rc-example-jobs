# Python Data Validation Example for ICDS Roar Collab Cluster

## Overview
This directory contains an example of how to run a Python-based data validation workflow on the Roar Collab cluster. The example demonstrates how to modularize Python code across multiple files and process a CSV input file using a SLURM submission script.

## Files
- `submit_pycheck.submit` - SLURM submission script to run the Python job.
- `pycheck.py` - The main Python execution script.
- `functions.py` - A module containing helper functions for reading and validating data.
- `in_pycheck.csv` - The input CSV data file to be processed.

## How to Run

### Submit the Job
Use `sbatch` to submit the script to the cluster scheduler:
```bash
sbatch simple_submit_pycheck.submit
```

Check Job Status
To monitor the progress of your job:
```bash
squeue --me
```

