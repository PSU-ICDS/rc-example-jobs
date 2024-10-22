#!/bin/bash

# Load Anaconda3 module
module load anaconda3

# Create a new conda environment named 'test_env'
conda create -n "test_env" -y

# Install matplotlib in the new environment
conda install -n test_env matplotlib -y

# matplotlib should install numpy automatically, but just in case.
conda install -n test_env numpy -y

# echo when done
echo "Conda environment 'test_env' created and matplotlib installed."
