#!/bin/bash
#SBATCH --partition=day
#SBATCH --job-name=down_sra_kal
#SBATCH -c 1
#SBATCH --mem=5G
#SBATCH --time=15:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alexis.weinreb@yale.edu

set -ue

echo "Starting $(date)"

module load SRA-Toolkit

fastqdir="/vast/palmer/scratch/hammarlund/aw853/2408_reanalysis/fastqs"


mapfile sampleList < <( cat metadata/sample_list_kaletsky_2018.csv | cut -f 1 -d"," | tail -n +2 )

#sampleList=(${sampleList[@]:21:27})

echo "${sampleList[@]}"
echo


for sample in "${sampleList[@]}"
do
  echo "Downloading $sample"
  fastq-dump --split-files --outdir $fastqdir $sample
  echo
  echo
done

echo "Done $(date)"

