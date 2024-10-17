#!/bin/bash
#SBATCH --ntasks=10
#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=4gb
#SBATCH --error=fluent.%J.err
#SBATCH --output=fluent.%J.out

rm -f *.trn *.hosts cleanup*

module load ansys
FLUENTNODES="$(scontrol show hostnames)"

fluent 2ddp -t${SLURM_NTASKS} -i in.file -cnf=$FLUENTNODES -g
