#!/bin/bash
json=""
sep=""
for file in $(jq '."trees"[] | ."family_name"' trees/index.json ); do
    file=${file//\\/\\\\} 
    printf -v json '%s%s%s' "$json" "$sep" "$file"
    sep=,
done
echo $json | tr -d '\n' | tr -d '\"'
