# LAMMPS SLURM Batch Job Example (Lennard-Jones Simulation)

This repository contains a minimal example of running a LAMMPS molecular dynamics simulation on a SLURM-based cluster.

## Files

### 1. `lammps-open.submit`
A SLURM batch script for running LAMMPS using the open (free) account.

**Key features:**
- Requests 1 node, 4 CPU tasks, 8 GB memory
- Sets a 10-minute runtime limit
- Uses the `basic` partition and `open` account
- Loads LAMMPS open module

**Output files:**
- `lammps.<jobid>.out`  standard output
- `lammps.<jobid>.err`  error output


---

### 2. `lammps-paid.submit`
A SLURM batch script for running LAMMPS using a paid allocation account.

**Key features:**
- Requests 1 node, 4 CPU tasks, 8 GB memory
- Sets a 10-minute runtime limit
- Uses a user-provided allocation account (`acct_id`)
- Uses `sla_prio` partition (or others depending on account type)
- Constrains job to `icelake` architecture
- Loads standard LAMMPS module

**Output files:**
- `lammps.<jobid>.out`  standard output
- `lammps.<jobid>.err`  error output


---

### 3. `lj_basic.in`
A LAMMPS input script that performs a basic Lennard-Jones (LJ) fluid simulation.

**Steps performed:**
1. Sets simulation units to Lennard-Jones (`lj`)
2. Defines a 3D periodic simulation box
3. Creates atoms on an FCC lattice
4. Assigns atomic mass
5. Initializes velocities
6. Defines Lennard-Jones pair potential
7. Configures neighbor lists
8. Runs NVE (constant energy) integration
9. Outputs thermodynamic data every 100 steps
10. Runs the simulation for 1000 timesteps

## How to Run

Submit the job to SLURM using one of the following:

**Open account:**

```
sbatch lammps-open.submit
```

**Paid allocation account:**

```
sbatch lammps-paid.submit
```

## Monitoring and Results

Once the job is submitted, SLURM will generate two files based on the **Job ID** (`%j`):

* **`lammps.<jobid>.out`**: Contains simulation progress and thermodynamic output.
* **`lammps.<jobid>.err`**: Contains any system errors or environment logs.
