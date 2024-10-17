#!/bin/bash
#SBATCH --mem-per-cpu=1024
#SBATCH --ntasks=5
#SBATCH --time=00:01:00
#SBATCH --job-name=mpi
#SBATCH --error=mpi.%J.err
#SBATCH --output=mpi.%J.out

module load openmpi/4.1.1-pmi2
mpicc demo_c_mpi.c -o demo_c_mpi
mpirun -np 5 ./demo_c_mpi
rm demo_c_mpi
