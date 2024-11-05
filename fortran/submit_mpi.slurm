#!/bin/bash
#SBATCH --ntasks=5
#SBATCH --mem-per-cpu=1024
#SBATCH --time=00:01:00
#SBATCH --job-name=Fortran
#SBATCH --error=Fortran.%J.err
#SBATCH --output=Fortran.%J.out

module load gcc
module load openmpi

mpifort demo_f_mpi.f90
mpirun -np 5 a.out
