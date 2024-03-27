#!/bin/bash
#SBATCH -p workq
#SBATCH --mem=2M
#SBATCH --cpus-per-task=1
#SBATCH -o align_reads_output_%j.out
#SBATCH -e align_reads_error_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL

module load devel/Miniconda/Miniconda3
module load bioinfo/OBITools/1.2.11

fastq_R1="../../data/MiSeq_SOP/fastq_files/F3D141_S207_L001_R1_001.fastq"
fastq_R2="../../data/MiSeq_SOP/fastq_files/F3D141_S207_L001_R2_001.fastq"
ipe_res="results/F3D141_S207_L001_R1R2_001.fastq"
grep_res="results/F3D141_S207_L001_R1R2_001.ali.fastq"
stat="results/F3D0_S188_L001_stat.txt"

srun -J "alignment" illuminapairedend --score-min=40 -r "${fastq_R1}" "${fastq_R2}" > "${ipe_res}"
srun -J "obigrep" obigrep -p 'mode!="joined"' "${ipe_res}" > "${grep_res}"
srun -J "stat" obistat -c score "${grep_res}" > "${stat}"
