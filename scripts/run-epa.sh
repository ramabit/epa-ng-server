#!/bin/bash

uuid=$1
treeFamilyName=$2

fileSearchString="*"$uuid"*"

TREES_INDEX="trees/index.json"

## find alignment file
alignmentFile=$(jq '.trees[], .family_name' trees/index.json | jq --arg v $treeFamilyName 'select(.family_name==$v)' | jq -r '.alignment_file')

## find tree file
treeFile=$(jq '.trees[], .family_name' trees/index.json | jq --arg v $treeFamilyName 'select(.family_name==$v)' | jq -r '.tree_file')

## find QS (query secuences) file
qsFile=""
for QS_FILE in $(find uploads/ -name $fileSearchString); do
	qsFile=$QS_FILE
done


## TODO call papara and genesis preprocess script
## /scripts/./run-papara-and-genesis.sh $uuid $alignmentFile $treeFile $qsFile

## TODO get new alignment, tree and QS files


## create directory for results
mkdir results/$uuid/

## run EPA-ng algorithm
epa-ng -s $alignmentFile -t $treeFile -q $qsFile -w results/$uuid/

## remove unnecessary temporary generated files
rm -rf results/$uuid/epa_info.log
rm -rf results/$uuid/stat
rm -rf results/$uuid/pepa.status
rm -rf results/$uuid/*.bin

