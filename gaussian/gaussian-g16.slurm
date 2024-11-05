#!/bin/bash
#SBATCH --job-name g16
#SBATCH --nodes=1 --ntasks-per-node=4
#SBATCH --mem-per-cpu=2000
#SBATCH --time=10:00
#SBATCH --error=gaussian.%J.err
#SBATCH --output=gaussian.%J.out


module load gaussian/g16c01

g16 test_g98.com
