#!/bin/bash

template="flipper_hello_app_{firmware}_{api_version}.fap"
string="flipper_hello_app_rogue-master_30.1.fap"

# Escape special characters in the template
escaped_template=${template//\{/\{}}
escaped_template=${escaped_template//\}/\}}

# Generate the regular expression pattern
pattern=${escaped_template//\{[a-zA-Z_]+\}/([^./]+)}

# Extract the firmware and api_version from the string
if [[ $string =~ ^$pattern$ ]]; then
    firmware=${BASH_REMATCH[1]}
    api_version=${BASH_REMATCH[2]}
    echo "Firmware: $firmware"
    echo "API Version: $api_version"
else
    echo "String does not match the template."
fi