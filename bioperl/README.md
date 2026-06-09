# BioPerl Example

This script runs a basic GenBank query using the Perl BioPerl package from https://bioperl.org/howtos/Beginners_HOWTO.html#item4

Files:
 - setup.sh: this script sets up a user-level perl library and installs the package Bio::DB::GenBank
 - script.pl: This is a perl script that queries GenBank and prints out the display id and length of each query result
 - bioperl.submit: this is a Slurm submit script that submits the batch job to run the BioPerl script
