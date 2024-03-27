#!/bin/bash

echo "Count the number of sequence in the file F3D1_S189_L001_R1_001.fastq:"

nlines=`grep -c "^+$" ../../data/MiSeq_SOP/fastq_files/F3D1_S189_L001_R1_001.fastq`

echo $nlines