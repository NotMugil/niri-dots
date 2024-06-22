#!/bin/bash

# Directory where the .kdl files are located
CONFIG_DIR="$HOME/.config/niri/configs"
THEMES_DIR="$HOME/.config/niri/themes"
OUTPUT_FILE="$HOME/.config/niri/config.kdl"

# Check if a valid theme argument is provided
if [ "$1" != "light" ] && [ "$1" != "dark" ]; then
    echo "Invalid theme specified. Use 'light' or 'dark'."
    exit 1
fi

# Array to store all .kdl files to be concatenated
files=()

# Add common.kdl to the files array
files+=("$CONFIG_DIR/common.kdl")

# Add theme-specific .kdl file from themes directory based on the theme argument
if [ "$1" == "light" ]; then
    files+=("$THEMES_DIR/light.kdl")
elif [ "$1" == "dark" ]; then
    files+=("$THEMES_DIR/dark.kdl")
fi

# Add all other .kdl files from the configs directory (excluding common.kdl)
for file in "$CONFIG_DIR"/*.kdl; do
    filename=$(basename "$file")
    if [ "$filename" != "common.kdl" ]; then
        files+=("$file")
    fi
done

# Concatenate all files into config.kdl
cat "${files[@]}" > "$OUTPUT_FILE"

echo "Configuration files combined into $OUTPUT_FILE"
