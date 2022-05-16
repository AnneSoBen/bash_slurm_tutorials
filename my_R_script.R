#!/bin/sh
#!/usr/bin/env Rscript

# to pass parameters to the R session
args = commandArgs(trailingOnly=TRUE)
file<-args[1]
loc<-args[2]

# parameters
# file="FD0_S188_L001_stat" ; loc="/work/anemone/bash_slurm_training/slurm/metabarcoding/results"

# change working directory
setwd(loc)

# read the scores table
scores<-read.table(paste0(file,".txt"),header=T)

# open a pdf document
pdf(paste0(file,".pdf"), 10, 6)
# plot a histogram of the score values
hist(scores[,1],nclass=50,col=rainbow(50))
# close the pdf document
dev.off()

# quit R without saving 
q(save="no")
