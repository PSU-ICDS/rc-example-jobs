# MATLAB SLURM Batch Job Example

This repository contains a minimal example of running a MATLAB job on the Roar ICDS cluster.

## Files

### 1. `combo.submit`
A SLURM batch script used to submit a MATLAB job.

**Key features:**
- Requests 1 node, 1 CPU task, 10 GB memory
- Sets a 10-minute runtime limit
- Loads MATLAB R2022a module

**Output files:**
- `matlab.<jobid>.out`  standard output
- `matlab.<jobid>.err`  error output


---

### 2. `mygnrun.m`
A MATLAB script that performs a simulation and regression analysis.

**Steps performed:**
1. Defines a range of sample sizes
2. Simulates random walk data for `x` and `y`
3. Runs OLS regression with Newey-West correction
4. Computes average statistics across simulations
5. Generates and saves figures:
 - `figure1.jpg` (Betas)
 - `figure2.jpg` (OLS vs Newey-West t-stats)

## How to Run

Submit the job to SLURM using:

```
sbatch combo.submit
```

## Monitoring and Results

Once the job is submitted, SLURM will generate two files based on the **Job ID** (`%j`):

* **`matlab.<jobid>.out`**: Contains the standard output and MATLAB results.
* **`matlab.<jobid>.err`**: Contains any system errors or environment logs.
