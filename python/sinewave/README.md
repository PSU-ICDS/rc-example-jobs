# Python SLURM Batch Job Example (Noisy Sine Plot)

This repository contains a minimal example of generating and visualizing a noisy sine wave using Python on a SLURM-based cluster.

## Files

### 1. `sub_nsin_py.submit`
A SLURM batch script used to submit a Python job.

**Key features:**
- Requests 1 node, 2 CPU tasks, 1 GB memory per CPU
- Sets a 1-minute runtime limit
- Uses the `basic` partition and `open` account
- Loads the Anaconda Python environment

**Output files:**
- `nsin_py.<jobid>.out` --- standard output
- `nsin_py.<jobid>.err` --- error output

---

### 2. `generate_nsin.py`
A Python script that generates noisy sine wave data.

**Steps performed:**
1. Creates a sine wave signal
2. Adds Gaussian noise
3. Combines signal and noise
4. Saves the data to:
 - `noiseysine.csv`

---

### 3. `read_nsin.py`
A Python script that reads the generated data and creates a plot.

**Steps performed:**
1. Loads data from `noiseysine.csv`
2. Extracts `x` and `y` values
3. Plots the noisy sine signal
4. Formats x-axis in terms of ?
5. Saves the figure as:
 - `py_noiseysine.png`

---

### 4. `noiseysine.csv`
A CSV file containing noisy sine wave data.

**Contents:**
- Column `x`: Input values
- Column `y`: Noisy sine values

## How to Run

Submit the job to SLURM using:

```
sbatch sub_nsin_py.submit
```


## Monitoring and Results

Once the job is submitted, SLURM will generate two files based on the **Job ID** (`%j`):

* **`nsin_py.<jobid>.out`**: Contains the Python execution output.
* **`nsin_py.<jobid>.err`**: Contains any system errors or environment logs.

### Generated Output

- `noiseysine.csv`: Generated dataset (if running `generate_nsin.py`)
- `py_noiseysine.png`: Plot of the noisy sine function
