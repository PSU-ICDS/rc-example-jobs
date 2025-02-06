#!/bin/bash 

#SBATCH --job-name=starccm
#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=24 
#SBATCH --mem=16GB
#SBATCH --time=01:00:00 
#SBATCH --partition=open 
#SBATCH --output=starccm.%j.out
#SBATCH --output=starccm.%j.err

module load starccm/17.06.008-R8

starccm+ -batch -np $SLURM_NTASKS test.sim
