#!/bin/bash

# let's now build a proper exercise to prepare later work and wrap-up most of what we just saw

cd ~/work
cd bash_slurm_training
mkdir data slumr # creates 3 folders
mv slumr slurm # oops we mispelled the folder, we rename it
cd data
wget https://mothur.s3.us-east-2.amazonaws.com/wiki/miseqsopdata.zip 
unzip miseqsopdata.zip # files unzip in a folder named ‘MiSeq_SOP’
cd MiSeq_SOP
ls -lh # have a look at the files - look at the structure of the output
# let’s organize our data:
mkdir fastq_files
mv *.fastq fastq_files # moves all fasta files
pwd # check were we are
cd .. # go back to the parent folder
tree # have a look at how are organized the files in MiSeq_SOP folder
# now look at the content of the files:
head -n 20 MiSeq_SOP/fastq_files/F3D1_S189_L001_R1_001.fastq
head -n 5 MiSeq_SOP/fastq_files/*.fastq
less MiSeq_SOP/HMP_MOCK.v35.fasta
# extract the first lines of this file and write them in another file:
head MiSeq_SOP/HMP_MOCK.v35.fasta > head_file.txt
cat head_file.txt
echo “THE END” >> head_file.txt # print “THE END” at the end of the file
rm head_file.txt # delete the file
# change permissions for others on MiSeq_SOP:
chmod -R o-rwx MiSeq_SOP/
