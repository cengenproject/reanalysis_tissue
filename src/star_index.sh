#!/bin/bash
#SBATCH --partition=day
#SBATCH --job-name=starIndex
#SBATCH -c 1
#SBATCH --mem=5G
#SBATCH --time=15:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alexis.weinreb@yale.edu

refdir="/gpfs/ycga/work/hammarlund/aw853/references/WS289"

STAR --runThreadN $SLURM_CPUS_PER_TASK \
     --runMode genomeGenerate \
     --genomeDir $refdir/"star_index_2-7-11a" \
     --genomeFastaFiles $refdir/"c_elegans.PRJNA13758.WS289.genomic.fa.gz" \
     --sjdbGTFfile $refdir/"c_elegans.PRJNA13758.WS289.canonical_geneset.gtf.gz" \
     --genomeSAindexNbases 12