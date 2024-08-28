#!/bin/bash
#SBATCH --partition=day
#SBATCH --job-name=str_q
#SBATCH -c 15
#SBATCH --mem=8G
#SBATCH --time=20:10:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=alexis.weinreb@yale.edu

set -e

pipeline_version="str_q8"


# Inputs:
#     * alignments bam (e.g. bsn9)
#     * GTF (e.g. collapsed GTF or Wormbase GTF)
# 
# 
# Output:
# 			 * sample-wise quantifications (subdir quantifications)
# 			 * summary transcript and gene tables (subdir summaries)



echo "Starting $pipeline_version on $(date)"
echo



#-------------------------------------------------------------------------------------------------------------
# Create workspace paths
ref_dir="/gpfs/ycga/project/ysm/hammarlund/aw853/references"

WSversion="WS289"

ref_gtf=$ref_dir/${WSversion}/"c_elegans.PRJNA13758."${WSversion}".canonical_geneset.gtf"


# bam files
bam_dir="/gpfs/gibbs/pi/hammarlund/CeNGEN/bulk/bulk_alignments/koterniak_bams"

out_dir="intermediates/240827_strq_outs"


## Check inputs

if [ ! -d $bam_dir ]
then
echo "Error: bam directory does not exist: $bam_dir"
exit 1
fi


mkdir -p $out_dir

mkdir -p $out_dir/quantifications
mkdir -p $out_dir/summaries


echo "--------------------------------------------------------------"
## Read sample list and remove trailing extension

echo "Reading samples from $bam_dir"
mapfile -t sampleList < <(ls $bam_dir/*.bam | xargs basename -a -s .bam)
mapfile -t tissueList < <(ls $bam_dir/*.bam | xargs basename -a -s .bam | cut -f1 -d"_")

sampleList=(${sampleList[@]:4:6})
tissueList=(${tissueList[@]:4:6})

if [ ${#sampleList[@]} -lt 1 ]
  then
  echo "Error: failed to find samples."
  exit 1
fi
  
if [ ${#tissueList[*]} -ne ${#sampleList[*]} ]
  then
  echo "Error: number of samples and number of neurons do not match."
  exit 1
fi
    
    
# make lists of paths
for((i=0; i<${#sampleList[@]}; i++))
do
  samplePath[i]=$bam_dir/${sampleList[i]}".bam"
done


nb_samples=${#sampleList[@]}
  
if [ $nb_samples -ne ${#sampleList[*]} ]
  then
  echo "Error while making list of samples."
  exit 1
fi
    
if [ ${#samplePath[@]} -ne $nb_samples ]
  then
  echo "Error while building paths."
  exit 1
fi
      
      
# list neurons
mapfile -t neurons < <(printf '%s\n' "${tissueList[@]}" | uniq)
nb_neurons=${#neurons[@]}

echo " Will treat ${#sampleList[@]} samples from $nb_neurons neurons"









echo "------------------------------------------------------------------------------------------"
echo "--------------------------------    StringTie2 quantify    -------------------------------"
echo "------------------------------------------------------------------------------------------"
echo

for((i=0; i<$nb_samples; i++))
do
  sample=${sampleList[i]}
  
  echo "###################      Processing sample: $sample      ###################"
  echo
  
  mkdir -p $out_dir/quantifications/$sample
  
  stringtie2 -eB \
             -p $SLURM_CPUS_PER_TASK \
             -G $ref_gtf \
             -o $out_dir/quantifications/$sample/$sample.gtf \
             ${samplePath[i]}
  
  
done

echo
echo "-----------     Making tables     ------------"
echo

module load R

# this part is for the app, not using here
# Rscript src/summarize_stringtie_q_output.R $out_dir/quantifications $out_dir/summaries


echo
echo " > command: ~/.utilities/prepDE.py3 -i $out_dir"
cd $out_dir/summaries
~/.utilities/prepDE.py3 -i ../quantifications




echo
echo
echo "----------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "Done: $(date)"
              
