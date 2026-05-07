# R Parallel vs. Serial Matrix Multiplication

This repository demonstrates the performance difference between serial and parallel computation in R using a matrix multiplication workload on the Roar ICDS cluster.

## Repository Structure

* `serial_computation.R`: Performs matrix multiplication using a single core.
* `parallel_computation.R`: Uses the `parallel` library and `mclapply` to distribute matrix chunks across multiple CPU cores.
* `R_parallel.submit`: A Slurm batch script that runs both versions and generates a side-by-side time summary.

## Benchmarking Overview

The scripts generate two random $2000 \times 2000$ matrices and compute their product.
* **Serial**: Uses the standard `%*%` operator on a single thread.
* **Parallel**: Detects available cores, splits the matrix into row chunks, and processes them simultaneously using `mclapply`.

## How to Run

Submit the benchmarking job to the cluster:

``` 
sbatch R_parallel.submit
``` 

## Monitoring and Results

Once the job is submitted, Slurm will generate several log files based on the **Job ID** (`%j`):

* **`R-parallel_<jobid>.out`**: Contains the basic Slurm execution log.
* **`serial_computation_<jobid>.log`**: Detailed output and timing for the serial run.
* **`parallel_computation_<jobid>.log`**: Detailed output and timing for the parallel run.
* **`summary_<jobid>.log`**: A clean comparison showing the total seconds taken for each method.

## Customization Tips

* **Adjust Parallelism**: Modify `--ntasks-per-node` in the submit script to change the number of cores allocated for the parallel task.
* **Scale the Workload**: Increase the `N` variable (currently 2000) in both `.R` files to test how parallelization handles larger datasets.
* **Memory Management**: If you increase `N`, ensure you also increase `--mem` in the submit script, as matrix multiplication is memory-intensive.
* **Live Monitoring**: Use `tail -f summary_<JOB_ID>.log` to see the final comparison as soon as both scripts finish executing.
