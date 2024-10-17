#!/bin/bash
#SBATCH --mem-per-cpu=1024
#SBATCH --time=00:01:00
#SBATCH --job-name=C
#SBATCH --error=C.%J.err
#SBATCH --output=C.%J.out

module load gcc
gcc demo_c_serial.c -o demo_c_serial
./demo_c_serial
rm demo_c_serial
