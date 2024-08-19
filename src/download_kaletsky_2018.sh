#!/bin/bash
#SBATCH --partition=general
#SBATCH --job-name=down_sra_kal
#SBATCH -c 1
#SBATCH --mem=5G
#SBATCH --time=5:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alexis.weinreb@yale.edu

echo "Starting $(date)"
module load SRA-Toolkit


mapfile sampleList < <(cat sampleList | cut -f 1)

for sample in "${sampleList[@]}"
do
echo "Downloading $sample"
fastq-dump --split-files $sample
echo
echo
done

echo "Done $(date)"
