# Normalization with R on Slurm

This repository contains an R-based workflow for processing and normalizing Operational Taxonomical Unit (OTU) tables on the Roar ICDS cluster.

## Repository Structure

* `normalize.R`: An R script that loads microbial abundance counts, handles missing values, and performs scaling and log transformations.
* `R-normalize.submit`: A Slurm batch script configured to load the R environment and execute the normalization script.
* `otu_table.csv.gz`: The input dataset (compressed microbial abundance counts).

## Analysis Overview

The R script (`normalize.R`) performs the following data processing steps:
1.  **Data Ingestion**: Reads the compressed OTU table as a matrix.
2.  **Missing Value Handling**: Replaces any `NA` entries with a nominal value of 0.1.
3.  **Scaling**: Standardizes the matrix using the `scale()` function.
4.  **Transformation**: Applies absolute value and $log_{2}$ transformations to the data.
5.  **Output**: Exports the processed data to `normalized_otu_matrix.csv`.

## How to Run

Submit the job to the Slurm scheduler using:

```
sbatch R-normalize.submit
```

## Monitoring and Results

Once the job is submitted, Slurm will generate two files based on the **Job ID** (`%j`):

* **`R-normalize.<JobID>.out`**: Contains the standard output, including "message" checkpoints from the R script (e.g., "data loaded", "normalization complete").
* **`R-normalize.<JobID>.err`**: Contains any system errors or R-specific warnings.

## Customization Tips

* **Modify Resource Directives**: Adjust `--mem` , `--nodes` , `--partition` and `--time` in `R-normalize.submit` based on the size of your OTU table.
* **Update R Version**: Change `module load r/4.4.0` if your cluster requires a different version of R for specific package dependencies.
* **File Naming**: If your input file is not compressed (e.g., `.csv` instead of `.csv.gz`), ensure you update the `read.table` path in `normalize.R`.
* **Live Monitoring**: Use `tail -f R-normalize.<JobID>.out` to track the progress of the transformation steps in real-time.
