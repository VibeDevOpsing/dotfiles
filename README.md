# 🚀 My Dotfiles

A collection of my personal configuration files (dotfiles) for macOS and Linux systems. These dotfiles are managed using GNU Stow for easy installation and management.

## 📋 Table of Contents

- [Features](#-features)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [What's Included](#-whats-included)
- [Customization](#-customization)
- [Key Bindings & Aliases](#-key-bindings--aliases)
- [Updating](#-updating)
- [Troubleshooting](#-troubleshooting)

## ✨ Features

- **Modular Configuration**: Organized by application using GNU Stow
- **Cross-Platform**: Works on macOS and Linux
- **Rich Aliases**: 200+ useful aliases for common tasks
- **Powerful Functions**: 50+ shell functions for productivity
- **Git Integration**: Comprehensive git aliases and functions
- **Docker Support**: Extensive Docker and Docker Compose shortcuts
- **FZF Integration**: Fuzzy finding for files, history, and more
- **Modern Tools**: Configured for modern CLI tools (eza, bat, ripgrep, etc.)

## 📦 Prerequisites

### Required Tools

```bash
# Package manager (choose one)
# macOS
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Ubuntu/Debian
sudo apt update && sudo apt install -y curl git

# Arch Linux
sudo pacman -S curl git
```

### Essential Dependencies

```bash
# macOS
brew install stow zsh git neovim fzf ripgrep eza bat fd zoxide starship

# Ubuntu/Debian
sudo apt install stow zsh git neovim fzf ripgrep exa bat fd-find zoxide
# Install starship separately
curl -sS https://starship.rs/install.sh | sh

# Arch Linux
sudo pacman -S stow zsh git neovim fzf ripgrep eza bat fd zoxide starship
```

### Optional Dependencies

```bash
# Development tools
brew install node python3 go rust docker docker-compose kubectl helm terraform

# Additional CLI tools
brew install htop bottom lazygit lazydocker jq yq tree tldr ncdu duf
brew install cowsay fortune lolcat cmatrix asciiquarium

# macOS specific
brew install --cask iterm2 rectangle alfred
```

## 🛠️ Installation

### Quick Install

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the setup script
./setup.sh
```

### Manual Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install individual configurations
stow zsh       # ZSH configuration
stow git       # Git configuration
stow vim       # Vim configuration
stow fzf       # FZF configuration
stow ssh       # SSH configuration
stow bash      # Bash configuration (backup)
stow fastfetch # Fastfetch configuration
```

## 📁 What's Included

### ZSH Configuration (`zsh/`)
- `.zshrc` - Main ZSH configuration with organized sections
- `.aliases` - 200+ command aliases organized by category
- `.functions` - 50+ useful shell functions
- `.zprofile` - ZSH profile settings
- `.zshenv` - ZSH environment variables

### Git Configuration (`git/`)
- `.gitconfig` - Comprehensive git configuration with 100+ aliases
- `.gitignore_global` - Global gitignore patterns

### Vim Configuration (`vim/`)
- `.vimrc` - Vim configuration with plugins and settings
- `.viminfo` - Vim history and registers

### Other Configurations
- `fzf/` - FZF fuzzy finder settings
- `ssh/` - SSH client configuration
- `bash/` - Bash configuration (as fallback)
- `fastfetch/` - System information display configuration

## 🎨 Customization

### Local Overrides

The configuration supports local overrides that won't be tracked by git:

```bash
# ZSH local configuration
~/.zshrc.local

# Git local configuration
~/.gitconfig.local

# Local aliases
~/.aliases.local

# Local functions
~/.functions.local
```

### Environment Variables

Key environment variables you can customize:

```bash
# Editor preference
export EDITOR='nvim'
export VISUAL='nvim'

# Development paths
export WORKSPACE="$HOME/workspace"
export PROJECTS="$HOME/projects"
```

## ⌨️ Key Bindings & Aliases

### Navigation Aliases
- `..` - Go up one directory
- `...` - Go up two directories
- `....` - Go up three directories
- `l` - Detailed list with icons
- `ll` - List with details
- `la` - List all files
- `lt` - Tree view (2 levels)

### Git Aliases
- `gs` - Git status
- `ga` - Git add
- `gc` - Git commit
- `gph` - Git push
- `gpl` - Git pull
- `gl` - Git log (pretty)
- `gd` - Git diff

### Docker Aliases
- `d` - Docker
- `dc` - Docker compose
- `dps` - Docker ps (formatted)
- `dcu` - Docker compose up
- `dcd` - Docker compose down
- `dlogs` - Docker logs

### Useful Functions
- `mkcd <dir>` - Create directory and cd into it
- `extract <file>` - Extract any archive
- `backup <file>` - Create timestamped backup
- `fkill` - Interactive process killer
- `weather [location]` - Get weather info
- `cheat <command>` - Get command cheatsheet

## 🔄 Updating

### Update Dotfiles

```bash
cd ~/dotfiles
git pull
./setup.sh
```

### Update Dependencies

```bash
# macOS
brew update && brew upgrade

# Ubuntu/Debian
sudo apt update && sudo apt upgrade

# Update Oh My Zsh
omz update
```

## 🐛 Troubleshooting

### Common Issues

1. **Stow conflicts**: Remove existing files before stowing
   ```bash
   rm ~/.zshrc
   stow zsh
   ```

2. **Missing commands**: Install missing dependencies
   ```bash
   # Check if command exists
   command -v eza || brew install eza
   ```

3. **Slow shell startup**: Profile your startup
   ```bash
   zsh -xvs
   ```

4. **Plugin errors**: Update Oh My Zsh plugins
   ```bash
   omz update
   ```

### Debug Mode

Enable debug mode in ZSH:
```bash
# Add to ~/.zshrc.local
setopt XTRACE VERBOSE
```

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Feel free to fork this repository and customize it for your own use. If you have suggestions for improvements, please open an issue or submit a pull request.

## 📞 Contact

- GitHub: [@yourusername](https://github.com/yourusername)
- Email: your.email@example.com

---

⭐ If you find this helpful, please consider giving it a star!
