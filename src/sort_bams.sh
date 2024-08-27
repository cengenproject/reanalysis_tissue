

set -ue

echo "Starting $(date)"

start=$1
echo "Start at $start"

in_dir="/vast/palmer/scratch/hammarlund/aw853/2408_reanalysis/bams_unsorted"
out_dir="/vast/palmer/scratch/hammarlund/aw853/2408_reanalysis/bams_sorted"

sampleList=( $( basename -a $( ls $in_dir/*.bam ) ) )

sampleList=(${sampleList[@]:$start:4})

echo "${#sampleList[@]} samples: ${sampleList[@]}"


for sample in ${sampleList[@]}
do
  echo "$sample"
  samtools sort \
    -@ 5 \
    -O bam \
    -o $out_dir/$sample \
    $in_dir/$sample
  
  samtools index -@ 5 $out_dir/$sample
  
done


echo "Done $(date)"



