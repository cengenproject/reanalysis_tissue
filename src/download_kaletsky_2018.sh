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

fastqdir="/vast/palmer/scratch/hammarlund/aw853/2408_reanalysis/fastqs/kaletsky_split3"


mapfile sampleList < <( cat metadata/sample_list_kaletsky_2018.csv | cut -f 1 -d"," | tail -n +2 )

#sampleList=(${sampleList[@]:0:1})

echo "${sampleList[@]}"
echo

cd $fastqdir

for sample in "${sampleList[@]}"
do
  echo "Downloading $sample"
  
  prefetch $sample
  echo
  
  fasterq-dump --threads $SLURM_CPUS_PER_TASK --split-files $sample
  echo
  
done

echo "Done $(date)"

