# STAR-CCM+ SLURM Job Examples for ICDS Roar Collab Cluster

## Overview
This directory contains example SLURM submission scripts for running Siemens STAR-CCM+ on the Roar Collab cluster. These examples cover single-node batch execution, multi-node MPI execution, and starting a STAR-CCM+ server for remote client connection.

## Files
- `starccm.slurm` - Basic single-node batch execution script.
- `starccm-mpi.slurm` - Multi-node execution using OpenMPI and a machinefile.
- `starccm-server.slurm` - Script to start a STAR-CCM+ server for interactive use.
- `test.sim` - Sample STAR-CCM+ simulation file.

## How to Run

### Submit a Batch Job
To run a standard simulation in the background:
```bash
sbatch starccm.slurm
```

### Submit a Multi-Node MPI Job
To run a simulation across multiple nodes:
```bash
sbatch starccm-mpi.slurm
```

### Start a STAR-CCM+ Server
To start a server instance (useful for connecting via a local STAR-CCM+ GUI):
```bash
sbatch starccm-server.slurm
```

## Script Breakdown

### Single Node Batch (starccm.slurm)

Designed for jobs fitting within one compute node (24 cores).
Uses starccm+ -batch to run without a GUI.
Allocates 16GB of shared memory.

### Multi-Node MPI (starccm-mpi.slurm)

Scales the simulation across 4 nodes (24 total tasks).
scontrol show hostname $SLURM_NODELIST > machinefile.txt: Generates a list of assigned compute nodes.
-mpi openmpi: Specifies the MPI ecosystem.
-machinefile machinefile.txt: Tells STAR-CCM+ exactly which nodes to use.

### Server Mode (starccm-server.slurm)

Starts the simulation engine and waits for a connection.
-server: Instead of executing a file, it listens for an incoming connection from the STAR-CCM+ client.

## Notes
Modules: These scripts load starccm/2502.0001. Ensure this version is available or update the version string accordingly.
Partitions: Scripts are set to --partition=basic and --account=open. Change these if you have access to a specific allocation or priority queue.
Memory: The MPI and Server scripts use --mem-per-cpu=4GB, whereas the single-node script uses a flat --mem=16GB. Adjust based on your simulation's mesh size and physics complexity.
