#!/bin/bash
#SBATCH --ntasks=5
#SBATCH --mem-per-cpu=1024
#SBATCH --time=00:01:00
#SBATCH --job-name=omp
#SBATCH --error=omp.%J.err
#SBATCH --output=omp.%J.out

export OMP_NUM_THREADS=5
module load gcc
gcc demo_c_openmp.c -o demo_c_openmp -fopenmp
./demo_c_openmp
rm demo_c_openmp
