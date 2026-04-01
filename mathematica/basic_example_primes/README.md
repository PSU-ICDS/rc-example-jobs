# Mathematica SLURM Batch Job Example (Prime Numbers)

This repository contains a minimal example of running a Mathematica job on a SLURM-based cluster.

## Files

### 1. `math_primes.submit`
A SLURM batch script used to submit a Mathematica job.

**Key features:**
- Requests 1 task and 1 GB memory
- Sets a 10-minute runtime limit
- Uses the `basic` partition and `open` account
- Loads the Mathematica module

**Output files:**
- `math_primes_<jobid>.out`  standard output
- `math_primes_<jobid>.err`  error output


---

### 2. `math_primes.m`
A Mathematica script that computes and prints prime numbers.

**Steps performed:**
1. Generates numbers from 1 to 100
2. Selects prime numbers using `PrimeQ`
3. Prints the list of prime numbers
4. Exits the program

## How to Run

Submit the job to SLURM using:
```
sbatch math_primes.submit
```

## Monitoring and Results

Once the job is submitted, SLURM will generate two files based on the **Job ID** (`%j`):

* **`math_primes_<jobid>.out`**: Contains the printed list of prime numbers.
* **`math_primes_<jobid>.err`**: Contains any system errors or environment logs.
