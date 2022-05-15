#!/bin/bash
#SBATCH -p workq
#SBATCH --mem=2M
#SBATCH --array=0-19
#SBATCH -o align_reads_output_%j.out
#SBATCH -e align_reads_error_%j.err
#SBATCH --mail-type=BEGIN,END,FAIL

module load bioinfo/obitools-v1.2.11

data_folder="../../data/MiSeq_SOP/fastq_files"
results_folder="results"
fastq_R1=("${data_folder}"/*_R1_001.fastq)
fastq_R1_id=$(basename -s .fastq "${fastq_R1[$SLURM_ARRAY_TASK_ID]}")
fastq_R2=("${data_folder}"/*R2_001.fastq)
fastq_R2_id=$(basename -s .fastq "${fastq_R2[$SLURM_ARRAY_TASK_ID]}")

ipe_res=$(echo "$fastq_R1_id.fastq" | sed 's/R1/R1R2/g') 
grep_res=$(echo $ipe_res | sed 's/.fastq/.ali.fastq/g')
obi_res=$(echo "$fastq_R1_id.fastq" | sed 's/R1_001.fastq/stat.txt/g')

srun -J "${fastq_R1_id} alignment" illuminapairedend --score-min=40 -r  "$data_folder"/"$fastq_R1_id.fastq" "$data_folder"/"$fastq_R1_id.fastq" > "$results_folder"/"${ipe_res}"
srun -J "${fastq_R1_id} obigrep" obigrep -p 'mode!="joined"' "$results_folder"/"${ipe_res}" > "$results_folder"/"${grep_res}" 
srun -J "${fastq_R1_id} obistat" obistat -c score "$results_folder"/"${grep_res}" > "$results_folder"/"${obi_res}"
