#!/bin/bash

#SBATCH -D /mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq/workspace/pass
#SBATCH -J compressn
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24

module purge
module load linuxbrew/colsa

for i in $(find . -type f -name "*.fastq"); do
pigz --best -p 24 "$i";
done
