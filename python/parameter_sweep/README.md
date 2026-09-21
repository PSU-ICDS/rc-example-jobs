# Parameter Sweep with Job Arrays Example for ICDS Roar Collab Cluster

## Overview
This directory contains a Python-based parameter sweep that runs as a SLURM
**job array**. Ten config files in `inputs/` each hold one integer parameter.
A single submit script launches ten independent tasks; each task reads one
config, runs a small calculation, and writes its own one-row CSV to `results/`.
It demonstrates `#SBATCH --array`, the `$SLURM_ARRAY_TASK_ID` variable, and the
`%A`/`%a` log-file placeholders. Only the Python standard library is used.

## Files
- `sub_sweep_py.submit` - SLURM submission script that launches a 10-task job array.
- `run_sweep.py` - Script that reads one config file and writes one result CSV.
- `inputs/config_1.txt` ... `inputs/config_10.txt` - One config file per array task.
- `logs/` - Where SLURM writes each task's stdout/stderr (must exist before submitting).
- `results/` - Where each task writes its `result_N.csv`.

## How to Run

### Submit the Job
Use `sbatch` to submit the execution script. The `logs/` directory must
already exist because SLURM will not create it for you:
```bash
mkdir -p logs
sbatch sub_sweep_py.submit
```

`sbatch` prints a single job ID (for example `Submitted batch job 123456`).
That is the *array* job ID; the ten tasks are `123456_1` through `123456_10`.

### Check Job Status
To monitor the progress of the array:
```bash
squeue --me
```
Each task shows up as its own row, e.g. `123456_3`. Tasks that are still
pending are collapsed into one row such as `123456_[4-10]`.

### Check the Results
When all tasks finish you should have ten CSVs and ten log files:
```bash
ls results/
# result_1.csv  result_2.csv ... result_10.csv

ls logs/
# sweep_123456_1.out  sweep_123456_2.out ... sweep_123456_10.out

cat results/result_7.csv
# config_id,parameter,result
# 7,13,0.137877033864
```

To see the whole sweep at once:
```bash
head -n 1 results/result_1.csv; tail -q -n 1 results/result_*.csv
```

## Script Breakdown
sub_sweep_py.submit

```bash
#!/bin/bash

#SBATCH --job-name=sweep_py               # Name of the job in the queue
#SBATCH --account=open
#SBATCH --partition=basic
#SBATCH --nodes=1                         # Each task gets 1 node ...
#SBATCH --ntasks=1                        # ... and 1 task (the tasks are independent)
#SBATCH --mem-per-cpu=1GB                 # Allocate 1GB of RAM per CPU core
#SBATCH --time=00:05:00                   # 5-minute limit *per task*, not for the whole array
#SBATCH --array=1-10                      # Run 10 copies of this script, task IDs 1..10
#SBATCH --output=logs/sweep_%A_%a.out     # %A = array job ID, %a = task ID
#SBATCH --error=logs/sweep_%A_%a.err

# Load the Anaconda environment to get python
module load anaconda3

# Every task in the array runs this same script.  The only thing that differs
# is $SLURM_ARRAY_TASK_ID (1..10), which we use to pick the input config and
# name the output file so tasks never overwrite each other.
INPUT=inputs/config_${SLURM_ARRAY_TASK_ID}.txt
OUTPUT=results/result_${SLURM_ARRAY_TASK_ID}.csv

# run_sweep.py refuses to write into a directory that does not exist
mkdir -p results

echo "Array job ${SLURM_ARRAY_JOB_ID}, task ${SLURM_ARRAY_TASK_ID}: ${INPUT} -> ${OUTPUT}"

srun python run_sweep.py --config ${INPUT} --out ${OUTPUT}
```

### Key points about job arrays
- The `#SBATCH` resource requests (`--nodes`, `--ntasks`, `--mem-per-cpu`,
  `--time`) apply to **each task individually**, not to the array as a whole.
- `--array=1-10` is what turns one script into ten jobs. Other useful forms:
  `--array=1-10%3` limits it to 3 tasks running at once; `--array=1,4,7`
  runs only those tasks (handy for re-running a few failures).
- `%A` in `--output`/`--error` is the array job ID and `%a` is the task ID.
  Using `%j` instead would give every task a *different* job ID, which makes the
  logs harder to match up with the array.
- Inside the script, `$SLURM_ARRAY_TASK_ID` is the only thing that differs
  between tasks. Building input and output paths from it is what keeps the
  tasks from stepping on each other.
