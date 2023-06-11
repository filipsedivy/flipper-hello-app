#!/bin/sh

tools_root=$(dirname $0)

cp ${tools_root}/release_template.md ${tools_root}/release.md

# Add New Lines
echo "" >> ${tools_root}/release.md
echo "" >> ${tools_root}/release.md

# Count File Hashes
echo "# File Hashes" >> ${tools_root}/release.md

for file in "$tools_root/dist/"*
do
    if [ -f "$file" ]; then
       echo "$(basename -- $file): $(md5sum "$file" | cut -d ' ' -f 1)" >> ${tools_root}/release.md
    fi
done
