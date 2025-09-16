# StarCCM Simulation Example
Created by Carrie Brown
Last Modified - September 16, 2025

This job runs StarCCM simulation `test.sim` in three different ways.

 - `starccm.slurm` runs the simulation using multiple cores on a single machine/node
 - `starccm-mpi.slurm` uses OpenMPI to run the simulation across multiple machines
 - `starccm-server.slurm` launches a StarCCM server which is connected to by the GUI

To connect to the StarCCM Server:

1. Launch an interactive StarCCM job on [the portal](https://portal.hpc.psu.edu) using 
same version as the batch job
2. From inside the StarCCM interface, select "File" -> "Connect to Server"
3. Place the host name (found from the `squeue -u $USER` output) in the "Host" box and 
click "Scan"
