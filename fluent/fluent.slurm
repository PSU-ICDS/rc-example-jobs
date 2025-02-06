#!/bin/bash
#SBATCH --ntasks=10
#SBATCH --nodes=1
#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=4gb
#SBATCH --error=fluent.%J.err
#SBATCH --output=fluent.%J.out

module load ansys

fluent 2ddp -t${SLURM_NTASKS} -i in.file -g
