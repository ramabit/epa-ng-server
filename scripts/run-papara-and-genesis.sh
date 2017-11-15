#!/bin/bash

uuid=$1
phylipAlignmentFile=$2
treeFile=$3
qsFile=$4

## TODO find best value here
NUM_TASKS=4

## create directory for results if doesn't exist
mkdir results/$uuid/

## run papara to align sequences
papara -r -t $treeFile -s $phylipAlignmentFile -q $qsFile 
#-j $NUM_TASKS -n chunk_1_0

## move files to correct folder
mv papara_alignment.default results/$uuid/papara_alignment.default
mv papara_log.default results/$uuid/papara_log.default
mv papara_quality.default results/$uuid/papara_quality.default

## separate reference and query
../genesis/bin/apps/./phylip_to_fasta_without_reference results/$uuid/aligned_query.fasta $phylipAlignmentFile results/$uuid/papara_alignment.default
