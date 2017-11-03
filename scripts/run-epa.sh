#!/bin/bash
UUID = $1
TREE_NAME = $2

FILE_SEARCH_STRING = "*" + $UUID + "*"

for QS_FILE in $(find ../uploads -name $FILE_SEARCH_STRING); do
	echo $QS_FILE
done

