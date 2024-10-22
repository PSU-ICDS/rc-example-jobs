public class SerialMatrixMultiplication {

    public static void main(String[] args) {
        int size = 2048; // Adjust this to control matrix size
        double[][] A = new double[size][size];
        double[][] B = new double[size][size];
        double[][] C = new double[size][size]; // Result matrix

        // Initialize matrices A and B with random values
        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                A[i][j] = Math.random();
                B[i][j] = Math.random();
            }
        }

        long startTime = System.currentTimeMillis();
        
        // Perform the matrix multiplication
        multiplyMatrices(A, B, C);

        long endTime = System.currentTimeMillis();
        System.out.println("Matrix multiplication completed. Size: " + size + "x" + size);
        System.out.println("Total execution time: " + (endTime - startTime) + " ms");
        // Optionally print the result matrix
        // printMatrix(C);
    }

    public static void multiplyMatrices(double[][] A, double[][] B, double[][] C) {
        int rowsA = A.length;
        int colsA = A[0].length;
        int colsB = B[0].length;

        // Ensure that matrix dimensions are compatible
        if (colsA != B.length) {
            throw new IllegalArgumentException("Matrix dimensions are not compatible for multiplication.");
        }

        // Perform the multiplication using three nested loops
        for (int i = 0; i < rowsA; i++) { // Row of A
            for (int j = 0; j < colsB; j++) { // Column of B
                C[i][j] = 0; // Initialize the result cell
                for (int k = 0; k < colsA; k++) { // Column of A / Row of B
                    C[i][j] += A[i][k] * B[k][j];
                }
            }
        }
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
