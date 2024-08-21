#!/bin/bash
#SBATCH --partition=day
#SBATCH --job-name=align_star
#SBATCH -c 10
#SBATCH --mem=15G
#SBATCH --time=23:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alexis.weinreb@yale.edu



# Prereq: download samples from Kaletsky (2018) and Koterniak (2020) with corresponding scripts
# This script runs STAR on each sample
#
# Note: Kaletsky (2018) is mix of single and paired-end



set -ue

echo "Starting $(date)"

refdir="/gpfs/ycga/work/hammarlund/aw853/references/WS289"


fastqdir='/vast/palmer/scratch/hammarlund/aw853/2408_reanalysis/fastqs'
bamdir='/vast/palmer/scratch/hammarlund/aw853/2408_reanalysis/bams'

mapfile -t sampleListKal < <( cat metadata/sample_list_kaletsky_2018.csv | cut -f 1 -d"," | tail -n +2 )
mapfile -t sampleListKot < <( cat metadata/sample_list_koterniak_2020.csv | cut -f 1 -d"," | tail -n +2 )

sampleList=( "${sampleListKal[@]}" "${sampleListKot[@]}")



# if necessary, prepare index (see separate script)
STAR_index_dir=$refdir/"star_index_2-7-11a"

module load STAR/2.7.11a-GCC-12.2.0


nsamples=0
nerrors=0

for sample in "${sampleList[@]}"
do
  echo "----  Aligning $sample  ----"
  
  if [ -f $fastqdir/${sample}_2.fastq ]
  then
    
    echo "Paired end"
  
    STAR --runThreadN $SLURM_CPUS_PER_TASK \
         --genomeDir $STAR_index_dir \
         --readFilesIn $fastqdir/${sample}_1.fastq $fastqdir/${sample}_2.fastq \
         --outFileNamePrefix $bamdir/${sample}_ \
         --outSAMstrandField intronMotif \
         --outSAMtype BAM SortedByCoordinate \
         --outSAMunmapped Within \
         --outSAMattributes Standard \
         --outFilterMatchNminOverLread 0.3
   
    nsamples=$(( $nsamples + 1 ))
         
  elif [ -f $fastqdir/${sample}_1.fastq ]
  then
    echo "Single end"
     
    STAR --runThreadN $SLURM_CPUS_PER_TASK \
         --genomeDir $STAR_index_dir \
         --readFilesIn $fastqdir/${sample}_1.fastq \
         --outFileNamePrefix $bamdir/${sample}_ \
         --outSAMstrandField intronMotif \
         --outSAMtype BAM SortedByCoordinate \
         --outSAMunmapped Within \
         --outSAMattributes Standard \
         --outFilterMatchNminOverLread 0.3
       
    nsamples=$(( $nsamples + 1 ))
   
  else
  
    echo "#####  File not found: $sample  #####"
    
    nerrors=$(( $nerrors + 1 ))
   
  fi

  echo
  echo
done

echo
echo
echo "Nb samples: $samples"
echo "Nb errors: $nerrors"

echo "Done $(date)"
