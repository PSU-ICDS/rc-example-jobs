# GAMS SLURM Job Example for ICDS Roar Collab Cluster
### Created by Carrie Brown - 7/1/2025

This example uses the input from the [GAMS Quick Start Tutorial](https://www.gams.com/latest/docs/UG_TutorialQuickstart.html)

Input Files:
 - example.gms - this is a GAMS input file for a linear programming problem representing a farm model where profit is maximized
 - gams.submit - this is a SLURM submit script to run the example file in batch mode

Output files generated:
 - gams.##.out - this is the SLURM output file created from the STDOUT of the job. the ### will be populated with your SLURM job ID. This file should contain the GAMS analysis output (as also seen in example.lst)
 - gams.##.err - this is the SLURM output file created from the STDERR of the job. The ## will be populated with your SLURM job ID. This file should be empty, but may have content if something went wrong with your job
 - example.lst - this is the GAMS output file containing the results of the GAMS analysis of the example.gms file
