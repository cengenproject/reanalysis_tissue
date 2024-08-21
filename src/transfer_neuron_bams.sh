#!/bin/bash
#SBATCH --partition=day
#SBATCH --job-name=transferNeurBams
#SBATCH -c 5
#SBATCH --mem=15G
#SBATCH --time=23:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alexis.weinreb@yale.edu


set -ue

origdir="/gpfs/gibbs/pi/hammarlund/CeNGEN/bulk/bulk_alignments/bsn12_bams"
bamdir='/vast/palmer/scratch/hammarlund/aw853/2408_reanalysis/bams'


echo "Merge dopaminergic neurons"

samtools merge \
  --threads $SLURM_CPUS_PER_TASK \
  -o $bamdir/neurons_sero.bam \
  $origdir/CEP*.bam




echo "Merge serotonergic neurons"

samtools merge \
  --threads $SLURM_CPUS_PER_TASK \
  -o $bamdir/neurons_sero.bam \
  $origdir/ADF*.bam $origdir/AFD*.bam $origdir/HSN*.bam $origdir/NSM*.bam




echo "Merge all neurons"

samtools merge \
  --threads $SLURM_CPUS_PER_TASK \
  -o $bamdir/neurons_all.bam \
  $origdir/*.bam 