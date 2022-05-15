#!/bin/bash

#We input the arguments to our script with $1 and $2

fastq_file=$1
genome=$2
name=$3

echo the fastq input is $fastq_file the genome file is $genome and our output name is $name

echo loading modules
module load bioinfo/bwa-0.7.17
module load bioinfo/samtools-1.14
module load bioinfo/bcftools-1.14

#this is the alignment function, look at the documentation for bwa for more information and parameters
echo indexing and aligning
bwa index $genome #bwa requires the genome to be indexed
bwa mem $genome $fastq_file > ${name}_aligned.sam

#now we use 'samtools' a common tool for aligned sequence data, but first we convert our 'sam' to a 'bam'
echo coverting sam to bam
samtools view -S -b ${name}_aligned.sam > ${name}_aligned.bam

#we have to sort the alignment
echo sorting the alignment
samtools sort -o ${name}_aligned_sorted.bam ${name}_aligned.bam 

#we can look at a histogram of coverage
echo making the coverage table
samtools coverage -m -o ${name}_aligned_sorted_coveragetables.txt ${name}_aligned_sorted.bam

#and we can call SNPs, which is a bit more complicated than it needs to be...

# first we have to unzip the genome , before re-zipping with 'bgzip'
echo unzipping
gunzip -c $genome | bgzip > $genome.bgz

#then we run samtools mpileup, which Collects summary information in the input BAMs, computes the likelihood of data given each possible genotype and stores the likelihoods in the BCF format, which then enables the snps to be called by bcftools 
echo snp calling
bcftools mpileup -Ou -f $genome.bgz ${name}_aligned_sorted.bam | bcftools call -mv -Ov -o ${name}_aligned_sorted_snps.vcf

echo the script is done

exit 
