#!/bin/bash

module load devel/Miniconda/Miniconda3
module load bioinfo/OBITools/1.2.11

# align reads that have a minimum alignment score of 40 + concatenate other reads:
srun illuminapairedend --score-min=40 -r ../../data/MiSeq_SOP/fastq_files/F3D0_S188_L001_R1_001.fastq ../../data/MiSeq_SOP/fastq_files/F3D0_S188_L001_R2_001.fastq > results/F3D0_S188_L001_R1R2_001.fastq
# remove unaligned reads:
srun obigrep -p 'mode!="joined"' results/F3D0_S188_L001_R1R2_001.fastq > results/F3D0_S188_L001_R1R2_001.ali.fastq
# compute stats:
srun obistat -c score results/F3D0_S188_L001_R1R2_001.ali.fastq > results/F3D0_S188_stats.txt
