#!/bin/bash

uuid=$1
treeName=$2

fileSearchString="*"$uuid"*"

for QS_FILE in $(find uploads/ -name $fileSearchString); do
	echo $QS_FILE
done

