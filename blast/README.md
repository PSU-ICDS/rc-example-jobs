# BLAST SLURM Job Example for ICDS Roar Collab Cluster

## Overview

This directory contains an example SLURM submission script for running BLAST (Basic Local Alignment Search Tool) on Roar Collab. BLAST is a widely used bioinformatics tool for comparing biological sequences.

## Files

- `blast_aa_multi.slurm` - SLURM submission script for parallel BLAST sequence alignment
- `yeast.aa` - FASTA file containing yeast amino acid sequences (database)
- `yeast.aa.fasta` - FASTA file containing query sequences for BLAST search

## How to Run

Submit the job with:
```bash
sbatch blast_aa_multi.slurm
```

Check job status:
```bash
squeue -j <job_id>
```

Monitor output:
```bash
tail -f blast_aa_multi.alignments
```

## Script Breakdown

### blast_aa_multi.slurm

```bash
#!/bin/bash
#SBATCH --nodes=1                          # Use 1 compute node
#SBATCH --ntasks-per-node=2                # Allocate 2 processors on the node
#SBATCH --mem=5gb                          # Allocate 5 GB of memory
#SBATCH --time=00:10:00                    # Allocate 10 minutes of wall time
#SBATCH --job-name=blast_aa_multi          # Name of the job
#SBATCH --error=blast.aa.multi.%J.err      # Error log (J=job_id)
#SBATCH --output=blast.aa.multi.%J.out     # Output log

module purge                                # Clear any existing modules
module load blast                           # Load BLAST module

# Copy input files to scratch directory for faster I/O
cp yeast.aa ~/scratch
cp yeast.aa.fasta ~/scratch

# Create BLAST database from the FASTA file
makeblastdb -in ~/scratch/yeast.aa \       # Input database file
            -dbtype prot \                  # Database type is protein sequences
            -out ~/scratch/yeast.aa.db      # Output database name

# Run BLAST search with multi-threaded support
blastp -db ~/scratch/yeast.aa.db \         # Use the created database
       -query ~/scratch/yeast.aa.fasta \   # Query sequence file
       -out ~/scratch/blast_aa_multi.alignments \  # Output alignments file
       -num_threads $SLURM_NTASKS_PER_NODE  # Use 2 threads for parallel search

# Copy results back to job directory
cp ~/scratch/blast_aa_multi.alignments .
```

## Notes

- Files are copied to `~/scratch` for faster I/O during processing (scratch is optimized for fast I/O)
- `makeblastdb` creates a searchable database from the subject sequences
- `blastp` performs protein-protein BLAST searches
- The `-num_threads` parameter enables multi-threaded execution for faster searches
- Output alignments are copied back to the current directory for easy access
- Modify `yeast.aa` and `yeast.aa.fasta` with your own sequence data
