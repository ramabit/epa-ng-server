#!/bin/bash

uuid=$1

## Transform results in .jplace format to .newick format
../genesis/bin/apps/./labelled_tree results/$uuid/epa_result.jplace results/$uuid/epa_result.nw

## activate environment in order to use ete3
export PATH=~/anaconda_ete/bin:$PATH

## generate image
echo results/$uuid/epa_result.nw | ete3 view --image results/$uuid/tree.png
