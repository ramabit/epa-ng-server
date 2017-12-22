#!/bin/bash

uuid=$1
treeFamilyName=$2

fileSearchString="*"$uuid"*"

TREES_INDEX="trees/index.json"

## find .fasta alignment file
fastaAlignmentFile=$(jq '.trees[], .family_name' trees/index.json | jq --arg v $treeFamilyName 'select(.family_name==$v)' | jq -r '.alignment_file_fasta')

## find .phylip alignment file
phylipAlignmentFile=$(jq '.trees[], .family_name' trees/index.json | jq --arg v $treeFamilyName 'select(.family_name==$v)' | jq -r '.alignment_file_phylip')

## find tree file
treeFile=$(jq '.trees[], .family_name' trees/index.json | jq --arg v $treeFamilyName 'select(.family_name==$v)' | jq -r '.tree_file')

## find QS (query secuences) file
qsFile=""
for QS_FILE in $(find uploads/ -name $fileSearchString); do
	qsFile=$QS_FILE
done

## create directory for results if doesn't exist
if [ ! -f results ]; then
	mkdir results/
fi

if [ ! -f results/$uuid ]; then	
	mkdir results/$uuid/
fi

## call papara and genesis preprocess script
/bin/bash scripts/./run-papara-and-genesis.sh $uuid $phylipAlignmentFile $treeFile $qsFile

## get new aligned QS file
alignedQSFile=results/$uuid/aligned_query.fasta

## run EPA-ng algorithm
epa-ng -s $fastaAlignmentFile -t $treeFile -q $alignedQSFile -w results/$uuid/

## remove unnecessary temporary generated files
rm -rf results/$uuid/epa_info.log
rm -rf results/$uuid/stat
rm -rf results/$uuid/pepa.status
rm -rf results/$uuid/*.bin

## obtain array of query labels
queryLabelsArray=$(../genesis/bin/apps/./fasta_labels $qsFile |tr '\n' ',')
queryLabelsArray="${queryLabelsArray::-1}"

## generate png image
/bin/bash scripts/./graphic-from-results.sh $uuid $queryLabelsArray

