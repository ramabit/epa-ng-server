#!/bin/bash

uuid=$1
queryLabelsArray=$2

## Transform results in .jplace format to .newick format
if [ ! -f results/$uuid/epa_result.nw ]; then
    ../genesis/bin/apps/./labelled_tree results/$uuid/epa_result.jplace results/$uuid/epa_result.nw
fi

## activate environment in order to use ete3
export PATH=~/anaconda_ete/bin:$PATH

## generate png image
if [ ! -f results/$uuid/tree.png ]; then
ete3 view -t results/$uuid/epa_result.nw --image results/$uuid/tree.png --face 'value:@name, color:auto()' --face 'value:@dist, pos:b-top, color:steelblue, size:8'
fi

python scripts/graphic.py $uuid $queryLabelsArray
