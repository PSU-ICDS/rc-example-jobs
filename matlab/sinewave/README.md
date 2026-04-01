# MATLAB SLURM Batch Job Example (Noisy Sine Plot)

This repository contains a minimal example of running a MATLAB job to visualize data from a CSV file on a SLURM-based cluster.

## Files

### 1. `sub_nsin_mat.submit`
A SLURM batch script used to submit a MATLAB plotting job.

**Key features:**
- Requests 1 node, 2 CPU tasks, 1 GB memory per CPU
- Sets a 1-minute runtime limit
- Uses the `basic` partition and `open` account
- Loads the default MATLAB module

**Output files:**
- `nsin_mat.<jobid>.out`  standard output
- `nsin_mat.<jobid>.err`  error output


---

### 2. `read_nsin.m`
A MATLAB script that reads data and generates a plot.

**Steps performed:**
1. Reads data from `noiseysine.csv`
2. Extracts:
 - `x` values (column 1)
 - `y` values (column 2)
3. Plots `y` versus `x`
4. Adds title and axis labels
5. Saves the figure as:
 - `mat_noiseysine.png`

---

### 3. `noiseysine.csv`
A CSV file containing noisy sine wave data.

**Contents:**
- Column 1: `x` values
- Column 2: `y` values (noisy sine function)

## How to Run

Submit the job to SLURM using:

```
sbatch sub_nsin_mat.submit
```


## Monitoring and Results

Once the job is submitted, SLURM will generate two files based on the **Job ID** (`%j`):

* **`nsin_mat.<jobid>.out`**: Contains the MATLAB execution output.
* **`nsin_mat.<jobid>.err`**: Contains any system errors or environment logs.

### Generated Output

- `mat_noiseysine.png`: Plot of the noisy sine function
