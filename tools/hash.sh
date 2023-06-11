#!/bin/sh

application_name="flipper_hello_app"
repo_root=$(dirname $0)/..
mkdir -p ${repo_root}/hashes

for file in "$repo_root/dist/"*
do
    if [ -f "$file" ]; then
       echo -e "$(basename -- $file):$(md5sum "$file" | cut -d ' ' -f 1)" >> ${repo_root}/hashes/${application_name}.txt
    fi
done