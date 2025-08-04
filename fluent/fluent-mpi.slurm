#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=20
#SBATCH --time=10:00:00
#SBATCH --mem-per-cpu=4gb
#SBATCH --account=open
#SBATCH --partition=open
#SBATCH --error=fluent.%J.err
#SBATCH --output=fluent.%J.out

module load ansys openmpi

scontrol show hostnames > hosts.$SLURM_JOB_ID

export FLUENT_AFFINITY=0
export SLURM_ENABLED=1
export SCHEDULER_TIGHT_COUPLING=1
export ANSYS232_PRODUCT=aa_r

fluent 2ddp -t ${SLURM_NTASKS} -mpi=openmpi -slurm -g -p inifiniband -cnf=hosts.$SLURM_JOB_ID -i in.file >& out.dat
