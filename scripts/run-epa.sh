#!/bin/bash

uuid=$1
treeFamilyName=$2

fileSearchString="*"$uuid"*"

TREES_INDEX="trees/index.json"

alignmentFile=$(jq '.trees[], .family_name' trees/index.json | jq --arg v $treeFamilyName 'select(.family_name==$v)' | jq -r '.alignment_file')

treeFile=$(jq '.trees[], .family_name' trees/index.json | jq --arg v $treeFamilyName 'select(.family_name==$v)' | jq -r '.tree_file')

qsFile=""
for QS_FILE in $(find uploads/ -name $fileSearchString); do
	qsFile=$QS_FILE
done

mkdir results/$uuid/

./epa-ng -s $alignmentFile -t $treeFile -q $qsFile -w results/$uuid/

rm -rf results/$uuid/epa_info.log
rm -rf results/$uuid/stat
rm -rf results/$uuid/pepa.status

echo results/$uuid/epa_result.jplace

