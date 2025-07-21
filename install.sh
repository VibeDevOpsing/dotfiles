#!/usr/bin/env bash
# =============================================================================
# Quick Install Script for Dotfiles
# Can be run with: curl -fsSL https://raw.githubusercontent.com/yourusername/dotfiles/main/install.sh | bash
# =============================================================================

set -euo pipefail

DOTFILES_REPO="https://github.com/yourusername/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "🚀 Starting dotfiles installation..."

# Clone the repository
if [ -d "$DOTFILES_DIR" ]; then
    echo "📁 Dotfiles directory already exists at $DOTFILES_DIR"
    read -p "Do you want to update it? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        cd "$DOTFILES_DIR"
        git pull origin main
    else
        echo "❌ Installation cancelled"
        exit 1
    fi
else
    echo "📥 Cloning dotfiles repository..."
    git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

# Run the setup script
cd "$DOTFILES_DIR"
./setup.sh "$@" 