#!/bin/bash

cat ../trees/index.json | jq '."trees"[] | ."family"' | jq -s -c

