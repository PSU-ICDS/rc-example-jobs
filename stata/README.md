# Stata SLURM Batch Job Example

This repository contains a minimal example of running a Stata job on the Roar ICDS cluster.

## Files

### 1. `stata.submit`
A SLURM batch script used to submit a Stata job.

**Key features:**
- Requests 1 node, 4 CPU tasks, 2 GB memory
- Sets a 5-minute runtime limit
- Loads Stata 19 module

**Output files:**
- `stata_test_<jobid>.out` — standard output
- `stata_test_<jobid>.err` — error output


---

### 2. `auto_analysis.do`
A Stata do-file that performs a simple analysis.

**Steps performed:**
1. Clears memory and disables output pauses
2. Loads Stata’s built-in `auto` dataset
3. Generates summary statistics for:
 - price
 - mpg
 - weight

## How to Run

Submit the job to SLURM using:

```
sbatch stata.submit
```

## Monitoring and Results

Once the job is submitted, SLURM will generate two files based on the **Job ID** (`%J`):

* **`stata_test_<jobid>.out`**: Contains the standard output and the Stata results log.
* **`stata_test_<jobid>.err`**: Contains any system errors or environment logs.

