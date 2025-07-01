#!/bin/bash
#SBATCH --ntasks=10
#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=4gb
#SBATCH --error=fluent.%J.err
#SBATCH --output=fluent.%J.out

rm -f *.trn *.hosts cleanup*

module load ansys openmpi

srun hostname | sort | uniq -c | awk '{print $2":"$1}' > fluent.cfg

fluent 2ddp -t ${SLURM_NTASKS} -i in.file -mpi=openmpi -cnf=fluent.cfg -g
