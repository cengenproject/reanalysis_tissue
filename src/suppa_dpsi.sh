#!/bin/bash
#SBATCH --partition=day
#SBATCH --job-name=suppa_dpsi
#SBATCH -c 1
#SBATCH --mem=5G
#SBATCH --time=5:30:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alexis.weinreb@yale.edu

set -ue

echo "Start $(date)"




WS="WS289"


events_file="../suppa_events/data/events/${WS}_all_strict.ioe"
tx_tpm="intermediates/240827_strq_outs/summaries/240828_tx_TPM.tsv"
psi_file="intermediates/240918_psiPerEvent.psi"

# note, the "prefix" should not be a separate directory!
out_dpsi="intermediates/240918_dpsi/"
out_prefix="240918"

split_psi_dir="intermediates/240918_split_psi"


mkdir -p $out_dpsi
mkdir -p $split_psi_dir




echo "Splitting PSI/TPM"

module load R/4.2.0-foss-2020b
Rscript src/split_events.R \
    --input_path $psi_file \
    --output_path $split_psi_dir \
    --extension psi

Rscript src/split_events.R \
    --input_path $tx_tpm \
    --output_path $split_psi_dir \
    --extension tpm






echo "check match of PSI and TPM"

DIFF=$(\
  diff \
    <( basename -s .psi $(ls $split_psi_dir/*.psi) ) \
    <( basename -s .tpm $(ls $split_psi_dir/*.tpm) ) \
  )

if [ "$DIFF" != "" ]
then
  echo "PSI and TPM do not match: $DIFF"
  exit 1
fi






echo "diffSplice"

module switch R miniconda
#module load miniconda
conda activate SUPPA2


echo "Running suppa with $events_file "

suppa.py diffSplice \
    --method empirical \
    --psi $split_psi_dir/*.psi \
    --tpm $split_psi_dir/*.tpm \
    --input $events_file \
    --lower-bound 0.3 \
    --combination \
    --gene-correction \
    --output $out_prefix

echo "done, moving files"

mv ${out_prefix}* $out_dpsi



echo "End $(date)"




