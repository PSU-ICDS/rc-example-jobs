#!/bin/bash 

#SBATCH --job-name=starccm-server
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=6 
#SBATCH --mem-per-cpu=4GB
#SBATCH --time=01:00:00 
#SBATCH --partition=open 
#SBATCH --output=starccm-server.%j.out
#SBATCH --error=starccm-server.%j.err

module load starccm/2502.0001

scontrol show hostname $SLURM_NODELIST > machinefile.txt

starccm+ -server -np $SLURM_NTASKS -mpi openmpi -machinefile machinefile.txt -rsh ssh
