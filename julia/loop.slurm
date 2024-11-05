#!/bin/bash
#SBATCH -A open
#SBATCH --time=10:00
#SBATCH --ntasks=1
#SBATCH --job-name=julia
#SBATCH --error=julia.%J.err
#SBATCH --output=julia.%J.out


module load julia
julia loop.jl
