#!/bin/sh

file="F3D0_S188_L001_stat" 
loc="/work/anemone/bash_slurm_training/slurm/metabarcoding/results"
module load system/R-3.5.1

Rscript /work/anemone/bash_slurm_training/slurm/metabarcoding/analyses/my_R_script.R $file $loc

