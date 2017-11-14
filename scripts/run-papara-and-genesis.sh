#!/bin/bash

uuid=$1
aligmentFile=$2
treeFile=$3
qsFile=$4

## TODO find best value here
NUM_TASKS=4

papara -r -t $treeFile -s $alignmentFile -q $qsFile -j $NUM_TASKS -n /results/$uuid/chunk_1_0

