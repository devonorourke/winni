#!/bin/bash

#SBATCH -D /mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq
#SBATCH -J pchopMorgan
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24

module purge
module load linuxbrew/colsa
DIR=/mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq/workspace/pass
porechop --input $DIR --barcode_dir trim --verbosity 0 --threads 24
