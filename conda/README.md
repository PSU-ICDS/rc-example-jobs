# Conda Environment SLURM Job Example for ICDS Roar Collab Cluster

## Overview

This directory contains an example SLURM submission script for running Python code with a Conda environment on Roar Collab. This example demonstrates environment creation, activation, and running Python scripts within a managed dependency environment.

## Files

- `conda_plot_lib.submit` - SLURM submission script that manages conda environment
- `conda_plot_lib_create_env.sh` - Bash script to create the conda environment
- `conda_plot_lib_example.py` - Python script that uses libraries from the conda environment

## How to Run

Submit the job with:
```bash
sbatch conda_plot_lib.submit
```

Check job status:
```bash
squeue -j <job_id>
```

View results:
```bash
cat conda_plot_lib.*.out
```

## Script Breakdown

### conda_plot_lib.submit

```bash
#!/bin/bash
#SBATCH --nodes=1                          # Use 1 compute node
#SBATCH --ntasks-per-node=1                # Run 1 task per node
#SBATCH --mem=4gb                          # Allocate 4 GB of memory
#SBATCH --time=00:10:00                    # Allocate 10 minutes
#SBATCH --job-name=conda_plot_lib          # Name of the job
#SBATCH --error=conda_plot_lib.%J.err      # Error log
#SBATCH --output=conda_plot_lib.%J.out     # Output log

module purge                                # Clear all existing modules
module load anaconda3                       # Load Anaconda Python

# Initialize conda
source ~/.bashrc                            # Source bashrc to set up conda
conda init bash                             # Initialize bash for conda

# Check if the environment already exists, create if it doesn't
if conda env list | grep -q "test_env"; then
    echo "Conda environment 'test_env' already exists."
else
    echo "Conda environment 'test_env' does not exist. Creating..."
    bash conda_plot_lib_create_env.sh       # Run script to create the environment
fi

# Activate the conda environment
echo "Activating test_env"
conda activate test_env

# Run your Python script
echo "Running conda plot example"
python conda_plot_lib_example.py            # Execute the Python script

echo "Done"
```

### conda_plot_lib_create_env.sh

This script typically contains:
```bash
#!/bin/bash
conda create -n test_env python=3.10 numpy matplotlib pandas -y
```

This creates a conda environment named `test_env` with Python 3.10 and popular libraries.

## Notes

- The script checks if the conda environment exists before creating it, avoiding redundant creation
- Conda environments are persistent across job submissions, so creation happens only once
- Always `module purge` before loading anaconda to avoid module conflicts
- `source ~/.bashrc` initializes the conda setup in your environment
- Modify `conda_plot_lib_create_env.sh` to install the specific packages your code requires
- Conda environments are stored in `~/.conda/envs/` by default
- This approach is cleaner than using `pip install` in every job submission
