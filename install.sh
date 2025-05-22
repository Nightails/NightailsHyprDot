#!/bin/bash

# Exit on error
set -e 

# Set variables
SOURCE_DIR="$(pwd)/configs/hypr"
TARGET_DIR="$HOME/.config/hypr"

# Check existing config
if [ -d "$TARGET_DIR" ]; then
    echo "⚠️  Existing Hyprland config found at $TARGET_DIR."
    echo "Choose an option:"
    echo "  [1] Overwrite"
    echo "  [2] Delete and install fresh"
    echo "  [3] Cancel"
    read -rp "Your choice [1/2/3]: " choice

    case "$choice" in
        1)
            echo "Overwriting existing config..."
            cp -rf "$SOURCE_DIR/" "$TARGET_DIR"
            ;;
        2)
            echo "Deleting existing config..."
            rm -rf "$TARGET_DIR"
            mkdir -p "$(dirname "$TARGET_DIR")"
            cp -r "$SOURCE_DIR" "$TARGET_DIR"
            ;;
        3)
            echo "Canceled."
            exit 0
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
else
    # No existing config, install directly
    echo "Installing Hyprland config..."
    mkdir -p "$(dirname "$TARGET_DIR")"
    cp -r "$SOURCE_DIR" "$TARGET_DIR"
fi 

echo "✅ Hyprland config installed to $TARGET_DIR"

# Reloading Hyprland
hyprctl reload

