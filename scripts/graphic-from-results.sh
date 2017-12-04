#!/bin/bash

uuid=$1

## Transform results in .jplace format to .newick format
../genesis/bin/apps/./labelled_tree results/$uuid/epa_result.jplace results/$uuid/epa_result.nw

## activate environment in order to use ete3
export PATH=~/anaconda_ete/bin:$PATH

## generate png image
ete3 view -t results/$uuid/epa_result.nw --image results/$uuid/tree.png --face 'value:@name, color:auto()' --face 'value:@dist, pos:b-top, color:steelblue, size:8'
