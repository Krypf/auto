#!/bin/zsh

# Check if an argument is specified
if [[ "$ARGC" -ne 1 ]]; then
    echo "Usage: $0 <target_directory>"
    exit 1
fi

# Receive the argument as a directory
TARGET_DIR="$1"

# Check if the directory exists
if [[ ! -d "$TARGET_DIR" ]]; then
    echo "Error: Directory '$TARGET_DIR' does not exist."
    exit 1
fi

# Process MP4 files in the directory
for file in "$TARGET_DIR"/*.mp4; do
    # Check if there are no files
    if [[ ! -e "$file" ]]; then
        echo "No MP4 files found in '$TARGET_DIR'."
        exit 0
    fi

    # Get the filename without the extension
    base_name="${file:t:r}"  # Equivalent to basename without extension in Zsh
    
    # Generate a new M4A file in TARGET_DIR
    new_file="$TARGET_DIR/$base_name.m4a"
    
    # Rename the file (create a copy)
    # Preserve metadata with the -p option
    cp -p "$file" "$new_file"
    echo "Generated: $new_file"
done

echo "All files processed in '$TARGET_DIR'!"
