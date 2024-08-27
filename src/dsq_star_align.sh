#!/bin/bash



# Prereq: download samples from and Koterniak (2020) with corresponding scripts
# This script runs STAR on each sample
# no sorting



set -ue

echo "Starting $(date)"

start=$1
echo "Start at $start"


refdir="/gpfs/ycga/work/hammarlund/aw853/references/WS289"


fastqdir='/vast/palmer/scratch/hammarlund/aw853/2408_reanalysis/fastqs'
bamdir='/vast/palmer/scratch/hammarlund/aw853/2408_reanalysis/bams_unsorted'

mapfile -t sampleList < <( cat metadata/sample_list_koterniak_2020.csv | cut -f 1 -d"," | tail -n +2 )

#sampleList=(${sampleList[@]:$start:1})

sample=${sampleList[$start]}


# if necessary, prepare index (see separate script)
STAR_index_dir=$refdir/"star_index_2-7-11a"



nsamples=0
nerrors=0

echo "----  Aligning $sample  ----"

if [ -f $fastqdir/${sample}_2.fastq ]
then
  
  echo "Paired end"

  STAR --runThreadN 10 \
       --genomeDir $STAR_index_dir \
       --readFilesIn $fastqdir/${sample}_1.fastq $fastqdir/${sample}_2.fastq \
       --outFileNamePrefix $bamdir/${sample}_ \
       --outSAMstrandField intronMotif \
       --outSAMtype BAM Unsorted \
      --outSAMunmapped Within \
       --outSAMattributes Standard \
       --outFilterMatchNminOverLread 0.3
 
  nsamples=$(( $nsamples + 1 ))
       
else

  echo "#####  File not found: $sample  #####"
  
  nerrors=$(( $nerrors + 1 ))
 
fi


echo "Done $(date)"
