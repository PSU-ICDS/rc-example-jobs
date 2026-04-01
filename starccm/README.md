```markdown
# STAR-CCM+ SLURM Job Scripts

This repository contains ready-to-use SLURM batch scripts for running **STAR-CCM+ (v2502.0001)** on the Roar ICDS cluster.

## Included Scripts

| Script                  | Description                                      | Mode        | Nodes | Cores/Node | Use Case                                      |
|-------------------------|--------------------------------------------------|-------------|-------|------------|-----------------------------------------------|
| `starccm.slurm`         | Single-node batch job                            | Batch       | 1     | 24         | Quick tests, small/medium simulations         |
| `starccm-mpi.slurm`     | Multi-node MPI batch job (recommended)           | Batch + MPI | 4     | 24         | Large simulations across multiple nodes       |
| `starccm-server.slurm`  | Multi-node server mode (remote GUI connection)   | Server      | 4     | 24         | Interactive / remote client connections       |

## Usage

These scripts run the STAR-CCM+ simulation `test.sim` in different configurations:

- **`starccm.slurm`** — runs on multiple cores within a **single node**
- **`starccm-mpi.slurm`** — runs across **multiple nodes using MPI (OpenMPI)**
- **`starccm-server.slurm`** — launches a **server session** for connection from the STAR-CCM+ GUI

## Submitting Jobs

Use `sbatch` to submit a job:

```bash
sbatch starccm.slurm
sbatch starccm-mpi.slurm
sbatch starccm-server.slurm



To connect to the StarCCM Server:

1. Launch an interactive StarCCM job on [the portal](https://portal.hpc.psu.edu) using 
same version as the batch job
2. From inside the StarCCM interface, select "File" -> "Connect to Server"
3. Place the host name (found from the `squeue -u $USER` output) in the "Host" box and 
click on "Scan"


