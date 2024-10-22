import java.util.concurrent.RecursiveTask;
import java.util.concurrent.ForkJoinPool;
import java.lang.Runtime;

public class ParallelMatrixMultiplication {

    static class MatrixMultiplyTask extends RecursiveTask<double[][]> {
        private static final int THRESHOLD = 64; // Threshold for splitting
        private final double[][] A;
        private final double[][] B;
        private final double[][] C;
        private final int rowStart;
        private final int rowEnd;
        private final int commonDim;

        public MatrixMultiplyTask(double[][] A, double[][] B, double[][] C, int rowStart, int rowEnd, int commonDim) {
            this.A = A;
            this.B = B;
            this.C = C;
            this.rowStart = rowStart;
            this.rowEnd = rowEnd;
            this.commonDim = commonDim;
        }

        @Override
        protected double[][] compute() {
            if (rowEnd - rowStart <= THRESHOLD) {
                // Perform multiplication for a small range of rows
                for (int i = rowStart; i < rowEnd; i++) {
                    for (int j = 0; j < B[0].length; j++) {
                        C[i][j] = 0; // Initialize the result cell
                        for (int k = 0; k < commonDim; k++) {
                            C[i][j] += A[i][k] * B[k][j];
                        }
                    }
                }
                return C;
            } else {
                int mid = (rowStart + rowEnd) / 2;
                MatrixMultiplyTask leftTask = new MatrixMultiplyTask(A, B, C, rowStart, mid, commonDim);
                MatrixMultiplyTask rightTask = new MatrixMultiplyTask(A, B, C, mid, rowEnd, commonDim);
                leftTask.fork(); // Fork left task
                rightTask.compute(); // Compute right task directly
                leftTask.join(); // Wait for left task to finish
                return C; // Return the resulting matrix
            }
        }
    }

    public static void main(String[] args) {
        final long startTime = System.currentTimeMillis();
        int size = 2048; // Size of the square matrices
        double[][] A = new double[size][size];
        double[][] B = new double[size][size];
        double[][] C = new double[size][size]; // Result matrix

        // Initialize matrices with sample values
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                A[i][j] = Math.random(); // Random values for matrix A
                B[i][j] = Math.random(); // Random values for matrix B
            }
        }
        System.out.println("Cores/processing units allocated to this job= " + Runtime.getRuntime().availableProcessors());

        int requestedCores = Runtime.getRuntime().availableProcessors(); // Number of desired concurrent tasks
        ForkJoinPool pool = new ForkJoinPool(requestedCores);
        MatrixMultiplyTask task = new MatrixMultiplyTask(A, B, C, 0, size, size);
        double[][] result = pool.invoke(task); // Start matrix multiplication

        System.out.println("Matrix multiplication completed. dimensions= " + result.length 
        + "," + result[0].length);
        final long endTime = System.currentTimeMillis();
        System.out.println("Total execution time: " + (endTime - startTime));
        // printMatrix(result);
    }

    private static void printMatrix(double[][] matrix) {
        for (double[] row : matrix) {
            for (double value : row) {
                System.out.printf("%.2f ", value);
            }
            System.out.println();
        }
    }
}
