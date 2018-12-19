#!/bin/bash

#SBATCH -D /mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci
#SBATCH -J winpore
#SBATCH --ntasks=1
#SBATCH --output albout-morgan1.log
#SBATCH --cpus-per-task=24
#SBATCH --mail-type=END
#SBATCH --mail-user=devon.orourke@gmail.com

module purge
module load linuxbrew/colsa

srun echo "starting `date`"

read_fast5_basecaller.py \
--flowcell FLO-MIN106 --kit SQK-RAB204 --barcoding \
--input /mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fast5 \
--worker_threads 24 \
--save_path /mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq \
--recursive \
--output_format fastq \
--reads_per_fastq_batch 0 \
--files_per_batch_folder 0

srun echo "ending `date`"
