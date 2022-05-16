#!/bin/bash

# get to the right directory
cd ~/work/bash_slurm_training/slurm
mkdir -p genomics/results genomics/analyses
cd genomics

##############################################
#### Download the genome and RNAseq files ####
##############################################

# You should have the genome from the wget / curl exercise but run this command if not ;
curl -L "https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/015/336/265/GCF_015336265.1_ASM1533626v1/GCF_015336265.1_ASM1533626v1_genomic.fna.gz"  -o analyses/GCF_015336265.1_ASM1533626v1_genomic.fna.gz

# Is sra toolkit on the cluster ?
search_module sra

# Get this version -> the others may not be configured!
module load bioinfo/sratoolkit.2.8.2-1

# Download the SRA (fastq) files of our chosen accession ; here some RNAseq reads SRR18369392
fastq-dump -X 5 -Z SRR18369392 #check this is a file we want by printing the first 5 lines
fastq-dump -X 200000 analyses/SRR18369392 #now we download the first 200,000 spots (all of it would take too long for the purposes of training!)

################################################
#### Now lets align our reads to the genome ####
################################################
#Have a good look at this script file - look at how modules are loaded and see that multiple functions are running

wget https://raw.githubusercontent.com/Imogen-D/Bases_De_Bash_Workshop/main/Ypestis_align.sh -P analyses/
ls analyses #check your file is there
less analyses/Ypestis_align.sh  #whats in the file? press 'q' to quit
chmod +x analyses/Ypestis_align.sh #make the script executable

#lets give our output a name with a variable
output_name=Ypestis

#these are very small files so we manage with only requesting 1 cpu and 4G memory
sbatch --cpus-per-task=1 --mem=4G  -J align.$output_name -o align.${output_name}.log analyses/Ypestis_align.sh SRR18369392.fastq GCF_015336265.1_ASM1533626v1_genomic.fna.gz  $output_name #run the script, giving it the genome and the fastq file

#check if the job is running, change $user to your username
squeue -u $user -o "%.15i %.30j %.8u %.2t %.10M %.6D %.6C %.6m %R"

#you can recheck squeue or the log file to see when the job finished, it should take less than 5 minutes

#################################
#### Looking at output files ####
#################################

#first check what files were produced
ls results

#then check the log file (always important to make sure everything ran correctly) 
less results/align.${output_name}.log #press q to quit

#and then look at the table of coverage
less results/${output_name}_aligned_sorted_coveragetables.txt #press q to quit

#the SNP calling is a big file, how big?
wc -l results/${output_name}_aligned_sorted_snps.vcf

#lets scroll through it, press 'q' to quit
less results/${output_name}_aligned_sorted_snps.vcf

#Well done, you've reached the end of the bash workshop!
