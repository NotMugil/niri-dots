#!/bin/bash

# Directory where your wallpapers are stored
WALLPAPER_DIR="$HOME/.wallpapers"

# List wallpapers in the directory and extract filenames
wallpapers=()
while IFS= read -r -d $'\0' file; do
    wallpapers+=("$(basename "$file")")
done < <(find "$WALLPAPER_DIR" -type f -print0)

# Function to display menu using wofi
select_wallpaper() {
    selected=$(printf '%s\n' "${wallpapers[@]}" | wofi --dmenu --insensitive --prompt="Select wallpaper:" --style="$HOME/.config/wofi/wallpaper.css")

    # If user cancels, exit without changing wallpaper
    if [ -z "$selected" ]; then
        exit 0
    fi

    # Find full path of selected wallpaper
    selected_path=$(find "$WALLPAPER_DIR" -type f -name "$selected")

    # Change wallpaper using the selected file
    swww img "$selected_path"

    # Update the .current_wallpaper symbolic link
    ln -sf "$selected_path" "$HOME/.current_wallpaper"
}

# Main execution
select_wallpaper
