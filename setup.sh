#!/usr/bin/env bash

echo "Starting dotfiles setup..."

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "Error: stow is not installed or not in your PATH. Please install stow to continue." >&2
    exit 1
fi

MODULES=(bash fastfetch fzf git ssh vim zsh)
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

for module_name in "${MODULES[@]}"; do
    echo "Processing module: $module_name..."
    stow -R -t "$HOME" -d "$SCRIPT_DIR" "$module_name"
    if [ $? -eq 0 ]; then
        echo "Successfully stowed $module_name."
    else
        echo "Warning: stow command failed for module $module_name with exit code $?. Check stow's output for details." >&2
    fi
done

echo "Dotfiles setup script completed."