#!/bin/bash 

#SBATCH --job-name=starccm
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=24 
#SBATCH --mem=16GB
#SBATCH --time=01:00:00 
#SBATCH --partition=basic
#SBATCH --account=open
#SBATCH --output=starccm.%j.out
#SBATCH --error=starccm.%j.err

module load starccm/2510

starccm+ -batch -np $SLURM_NTASKS test.sim
