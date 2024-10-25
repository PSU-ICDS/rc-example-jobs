# Serial R Script: serial_matrix_multiplication.R
# This script performs matrix multiplication without parallelization

N <- 2000  # Size of the matrix

# Create two random matrices
matrix_a <- matrix(runif(N * N), nrow = N, ncol = N)
matrix_b <- matrix(runif(N * N), nrow = N, ncol = N)

start_time <- Sys.time()

# Serial matrix multiplication
result_matrix <- matrix_a %*% matrix_b

end_time <- Sys.time()

cat("Matrix multiplication completed (Serial).\n")
cat("Time taken (Serial):", end_time - start_time, "\n")
