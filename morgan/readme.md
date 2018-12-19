# Morgan

1. Collected raw sequence data from Nanopore (.fast5 files) using MinION, [v9.4.1 flow cell](https://store.nanoporetech.com/flowcells/spoton-flow-cell-mk-i-r9-4.html), and [RAB204 kit](https://store.nanoporetech.com/16s-barcoding-kit.html).

2. Used Albacore (Nanopore-owned) [software](https://nanoporetech.com/about-us/news/new-basecaller-now-performs-raw-basecalling-improved-sequencing-accuracy) to convert .fast5 to .fastq files: converts raw data to "A", "T", "C", "G" bases:

```
read_fast5_basecaller.py \
--flowcell FLO-MIN106 --kit SQK-RAB204 --barcoding \
--input /mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fast5 \
--worker_threads 24 \
--save_path /mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq \
--recursive \
--output_format fastq \
--reads_per_fastq_batch 0 \
--files_per_batch_folder 0
```

The output of this workflow is to create a single `.fastq` file for each barcode: thus `BC01.fastq` represents all the sequences attriubuted to the sample which was prepared with barcode01, `BC02.fastq` represents all the 16S sequences with barcode02, etc. Notably, some sequences we collected did not have any detectable barcode - these may still contain 16S sequences, but we don't know which samples they are assigned to; these are collected in `none.fastq`. 
In addition, there is a `sequencing_summary.txt` file which contains many details about the sequencing process (in Step1) - this tab-delimited file contains per-sequence information like the time in which a sequence was detected, the length of the sequence, the mean quality score, and much more. This file is used to create a visualiztion in Step 3.

3. Use [Nanoplot](http://nanoplot.bioinf.be/) to assess run performance and produce visualizations:
```
FILE=/mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq/sequencing_summary.txt
NanoPlot -t 24 -o viz -p morgan1 --summary $FILE
```

4. Used Porechop [software](https://github.com/rrwick/Porechop) to remove adapters from sequence data. This results in our .fastq files containing only sequence data associated with the 16S gene of interest.

```
DIR=/mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq/workspace/pass
porechop --input $DIR --barcode_dir trim --verbosity 0 --threads 24
```

These per-sample, trimmed `.fastq` files are what serve as input in our subsequent QIIME analyses.

5. Converted the .fastq files into QIIME-compatible format (a `.qza` file): nothing changes about the information content (the sequences) - it's simply a conversion of format so that software in QIIME can function with the data. 
> All 12 barcoded samples were imported in addition to the Unclassified reads:

```
qiime tools import \
--type SampleData[SequencesWithQuality] \
--input-format SingleEndFastqManifestPhred33 \
--input-path morgan_manifest.txt \
--output-path morgan_rawseqs.qza
```

> The manifest file looked like this:

```
sample-id,absolute-filepath,direction
bc01,/mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq/trim/BC01.fastq.gz,forward
bc02,/mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq/trim/BC02.fastq.gz,forward
## ... {10 other sequences following same format)...
bc12,/mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq/trim/BC12.fastq.gz,forward
none,/mnt/lustre/macmaneslab/devon/nanoPore/reads/hssci/fastq/trim/none.fastq.gz,forward
```

The resulting `morgan_rawseqs.qza` served as input into the remainder of the analyses, performed with QIIME2 [software](https://docs.qiime2.org)
