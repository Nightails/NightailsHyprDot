#!/usr/bin/env fish

# === VARIABLES ===
set SOURCE_HYPR (pwd)/configs/hypr
set TARGET_HYPR "$HOME/.config/hypr"

function install_config
    if not test -d "$SOURCE_HYPR"
        echo "❌ Source Hyprland config not found at $SOURCE_HYPR"
        return
    end

    if test -d "$TARGET_HYPR"
        echo "⚠️  Existing Hyprland config found at $TARGET_HYPR."
        echo "Choose an option:"
        echo "  [1] Overwrite"
        echo "  [2] Delete and install fresh"
        echo "  [3] Cancel"
        echo -n "Your choice [1/2/3]: "
        read choice

        switch $choice
            case 1
                echo "Overwriting existing Hyprland config..."
                cp -Rf "$SOURCE_HYPR/." "$TARGET_HYPR"
            case 2
                echo "Deleting and reinstalling Hyprland config..."
                rm -rf "$TARGET_HYPR"
                mkdir -p (dirname "$TARGET_HYPR")
                cp -R "$SOURCE_HYPR" "$TARGET_HYPR"
            case 3
                echo "Canceled."
                return
            case '*'
                echo "Invalid option. Canceling."
                return
        end
    else
        echo "Installing Hyprland config..."
        mkdir -p (dirname "$TARGET_HYPR")
        cp -R "$SOURCE_HYPR" "$TARGET_HYPR"
    end

    echo "✅ Hyprland config installed to $TARGET_HYPR"
end

function reload_hyprland
    if not type -q hyprctl
        echo "⚠️  hyprctl not found; cannot reload Hyprland"
        return
    end

    echo -n "Do you want to reload Hyprland now? [y/N]: "
    read answer
    switch (string lower $answer)
        case y yes
            echo "🔄 Reloading Hyprland..."
            hyprctl reload
            and echo "✅ Hyprland reloaded"
        case '*'
            echo "⏭️  Skipping reload."
    end
end

# === RUN ===
echo "=== Hyprland Config Installer ==="
install_config
reload_hyprland
echo "🎉 Done!"
