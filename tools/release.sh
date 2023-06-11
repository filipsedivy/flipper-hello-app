#!/bin/sh

tools_root=$(dirname $0)

cp ${tools_root}/release_template.md ${tools_root}/release.md

# Add New Lines
echo "" >> ${tools_root}/release.md
echo "" >> ${tools_root}/release.md

# Count File Hashes
echo "# File Hashes" >> ${tools_root}/release.md

# Generate table
echo "| File | Firmware name | Firmware version | md5 hash |" >> ${tools_root}/release.md
echo "|------|---------------|------------------|----------|" >> ${tools_root}/release.md

for file in "$tools_root/../temp/"*
do
    if [ -f "$file" ]; then
      app_name=$(sed -n '1p' "$file")
      app_hash=$(sed -n '6p' "$file")
      firmware_version=$(sed -n '2p' "$file")
      firmware_name=$(sed -n '3p' "$file")

      echo "| ${app_name} | ${firmware_name} | ${firmware_version} | ${app_hash} |"
    fi
done
