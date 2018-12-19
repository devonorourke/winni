#!/bin/bash

#SBATCH -D /mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq/trim
#SBATCH -J compressn
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24

module purge
module load linuxbrew/colsa

pigz --best -p 24 BC01.fastq
pigz --best -p 24 BC02.fastq
pigz --best -p 24 BC03.fastq
pigz --best -p 24 BC04.fastq
pigz --best -p 24 BC05.fastq
pigz --best -p 24 BC06.fastq
pigz --best -p 24 BC07.fastq
pigz --best -p 24 BC08.fastq
pigz --best -p 24 BC09.fastq
pigz --best -p 24 BC10.fastq
pigz --best -p 24 BC11.fastq
pigz --best -p 24 BC12.fastq
pigz --best -p 24 none.fastq
