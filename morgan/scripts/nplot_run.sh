#!/bin/bash

#SBATCH -D /mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/
#SBATCH -J nplot
#SBATCH --ntasks=1
#SBATCH --output nplot-morgan1.log
#SBATCH --cpus-per-task=24
#SBATCH --mail-type=END
#SBATCH --mail-user=devon.orourke@gmail.com

module purge
module load anaconda/colsa
source activate nanopack

FILE=/mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq/sequencing_summary.txt
NanoPlot -t 24 -o viz -p morgan1 --summary $FILE

