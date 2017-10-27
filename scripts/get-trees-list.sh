#!/bin/bash
json="["
sep=""
for file in $(jq '."trees"[] | ."family"' trees/index.json ); do
    file=${file//\\/\\\\} 
    printf -v json '%s%s%s' "$json" "$sep" "$file"
    sep=,
done
json+="]"
echo $json | tr -d '\n'
