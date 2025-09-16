#!/bin/bash 

#SBATCH --job-name=starccm-mpi
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=6 
#SBATCH --mem-per-cpu=4GB
#SBATCH --time=01:00:00 
#SBATCH --partition=open 
#SBATCH --output=starccm-mpi.%j.out
#SBATCH --error=starccm-mpi.%j.err

module load starccm/2502.0001 openmpi

scontrol show hostname $SLURM_NODELIST > machinefile.txt

starccm+ -batch -np $SLURM_NTASKS -mpi openmpi -machinefile machinefile.txt test.sim
