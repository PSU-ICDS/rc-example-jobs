# Python Data Integrity Check

This repository contains a modular Python tool designed to validate the consistency of data within a CSV file configured for execution on the Roar ICDS cluster.

## Repository Structure

* `pycheck.py`: The main execution script that coordinates the version check, data loading, and validation.
* `functions.py`: A helper module containing specific logic for system checks, CSV parsing, and data integrity verification.
* `in_pycheck.csv`: The input data file containing strings and their associated metadata (lengths and checksums).
* `simple_submit_pycheck.submit`: The Slurm batch script used to submit the job to the cluster.

## Logic Overview

The tool performs a "cursory data check" by comparing different columns in the input CSV:
1.  **Version Check**: Logs the current Python environment details to the output.
2.  **CSV Parsing**: Extracts a description from the first line, headers from the second, and data from the remainder.
3.  **Integrity Validation**: For each entry, it ensures that the string length matches the provided "nominal length" and the sum of specific metadata columns. If a mismatch is found, a discrepancy error is reported.

## How to Run

Submit the job to the Slurm scheduler:

```
sbatch simple_submit_pycheck.submit
```

## Monitoring and Results

Once the job is submitted, the output is directed to a single text file as defined in the submit script:

* **`out_pycheck.txt`**: This file contains the job start/end timestamps, the hostname of the compute node, the Python version info, and the results of the data validation (either a success message or specific discrepancy errors).
