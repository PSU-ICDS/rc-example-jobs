#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=10-00:00:00
#SBATCH --mem-per-cpu=4gb
#SBATCH --error=comsol.%J.err
#SBATCH --output=comsol.%J.out
#SBATCH --partition=standard
#SBATCH --account=test_credits_iask

module load comsol
comsol batch -inputfile effective_diffusivity.mph -outputfile effective_diffusivity_OUT.mph -np ${SLURM_NTASKS_PER_NODE}
