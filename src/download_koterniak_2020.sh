#!/bin/bash
#SBATCH --partition=day
#SBATCH --job-name=downSraKoter
#SBATCH -c 1
#SBATCH --mem=5G
#SBATCH --time=15:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alexis.weinreb@yale.edu

set -ue

echo "Starting $(date)"

fastqdir="/vast/palmer/scratch/hammarlund/aw853/2408_reanalysis/fastqs"

module load SRA-Toolkit


mapfile sampleList < <( cat metadata/sample_list_koterniak_2020.csv | cut -f 1 -d"," | tail -n +2 )

#sampleList=(${sampleList[@]:19:20})

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
