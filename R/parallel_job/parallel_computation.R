# Parallel R Script: parallel_matrix_multiplication.R
# This script performs matrix multiplication using parallelization

library(parallel)

N <- 2000  # Size of the matrix
num_cores <- detectCores() - 1  # Use all available cores minus one

# Create two random matrices
matrix_a <- matrix(runif(N * N), nrow = N, ncol = N)
matrix_b <- matrix(runif(N * N), nrow = N, ncol = N)

start_time <- Sys.time()

# Function to compute a part of the matrix multiplication
matrix_multiply_chunk <- function(rows, matrix_a, matrix_b) {
  return(matrix_a[rows, ] %*% matrix_b)
}

# Split rows for parallel computation
row_chunks <- split(1:N, cut(1:N, num_cores, labels = FALSE))

# Parallel matrix multiplication
result_chunks <- mclapply(row_chunks, matrix_multiply_chunk, matrix_a = matrix_a, matrix_b = matrix_b, mc.cores = num_cores)

# Combine results
result_matrix <- do.call(rbind, result_chunks)

end_time <- Sys.time()

cat("Matrix multiplication completed (Parallel).\n")
cat("Time taken (Parallel):", end_time - start_time, "\n")
