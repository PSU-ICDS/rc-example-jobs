# SAS Paired T-Test on Slurm HPC

This repository contains a sample workflow for running a SAS analysis on the Roar ICDS cluster. The example performs a paired t-test on a small dataset.

## Repository Structure

* `t-test.sas`: The SAS program containing the data and the `PROC TTEST` analysis.
* `sas.submit`: A Slurm batch script configured to load the SAS module and execute the analysis.

## Analysis Overview

The SAS script (`t-test.sas`) performs the following:
1.  **Data Ingestion**: Creates a dataset named `pulse` with `pre` and `post` measurements.
2.  **Data Verification**: Uses `proc print` to output the dataset to the log/listing.
3.  **Statistical Analysis**: Uses `proc ttest` with the `paired` statement to compare the means of the two related groups.

## How to Run

### 1. Prerequisites
Ensure you are logged into your HPC environment and have access to the Slurm scheduler and the SAS module.

### 2. Submit the Job
Use the `sbatch` command to submit the job script to the cluster queue:

```
sbatch sas.submit
```

## Monitoring and Results

Once the job is submitted, Slurm will generate two files based on the **Job ID** (`%J`):

* **`sas_example.<JobID>.out`**: Contains the standard output and SAS listing.
* **`sas_example.<JobID>.err`**: Contains any system errors or logs.

