#!/bin/bash

uuid=$1
queryLabelsArray=$2

## Transform results in .jplace format to .newick format
if [ ! -f results/$uuid/epa_result.nw ]; then
    ../genesis/bin/apps/./labelled_tree results/$uuid/epa_result.jplace results/$uuid/epa_result.nw
fi

## activate environment in order to use ete3
export PATH=~/anaconda_ete/bin:$PATH

## generate horizontal png image
if [ ! -f results/$uuid/horizontal-tree.png ]; then
	python scripts/graphical/horizontal-tree.py $uuid $queryLabelsArray
fi

## generate vertical png image
if [ ! -f results/$uuid/vertical-tree.png ]; then
	python scripts/graphical/vertical-tree.py $uuid $queryLabelsArray
fi

## generate circular png image
if [ ! -f results/$uuid/circular-tree.png ]; then
	python scripts/graphical/circular-tree.py $uuid $queryLabelsArray
fi



