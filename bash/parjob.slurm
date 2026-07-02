#!/bin/bash

#SBATCH --job-name=parallel_example
#SBATCH --account=open
#SBATCH --nodes=4-4
#SBATCH --ntasks-per-node=2
#SBATCH --mem-per-cpu=100mb
#SBATCH --time=00:01:00
#SBATCH --output=%x.%j.out
#SBATCH --error=%x.%j.err

srun -l bash simplecheck.sh
