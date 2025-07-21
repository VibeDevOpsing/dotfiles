#!/usr/bin/env bash

# =============================================================================
# Dotfiles Setup Script
# =============================================================================

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Configuration
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
LOG_FILE="$DOTFILES_DIR/setup.log"

# Available modules
ALL_MODULES=(bash zsh git vim ssh fzf fastfetch)
MODULES_TO_INSTALL=()

# =============================================================================
# Helper Functions
# =============================================================================

log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

info() {
    echo -e "${BLUE}[INFO]${NC} $*" | tee -a "$LOG_FILE"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $*" | tee -a "$LOG_FILE"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $*" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR]${NC} $*" | tee -a "$LOG_FILE" >&2
}

# =============================================================================
# Dependency Checking
# =============================================================================

check_os() {
    info "Detecting operating system..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
        PACKAGE_MANAGER="brew"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command -v apt-get &>/dev/null; then
            OS="debian"
            PACKAGE_MANAGER="apt"
        elif command -v pacman &>/dev/null; then
            OS="arch"
            PACKAGE_MANAGER="pacman"
        elif command -v dnf &>/dev/null; then
            OS="fedora"
            PACKAGE_MANAGER="dnf"
        else
            OS="linux"
            PACKAGE_MANAGER="unknown"
        fi
    else
        error "Unsupported operating system: $OSTYPE"
        exit 1
    fi
    info "Detected OS: $OS (Package manager: $PACKAGE_MANAGER)"
}

check_dependencies() {
    local missing_deps=()
    
    info "Checking dependencies..."
    
    # Check for stow
    if ! command -v stow &>/dev/null; then
        missing_deps+=("stow")
    fi
    
    # Check for git
    if ! command -v git &>/dev/null; then
        missing_deps+=("git")
    fi
    
    # Check for curl
    if ! command -v curl &>/dev/null; then
        missing_deps+=("curl")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        error "Missing dependencies: ${missing_deps[*]}"
        
        read -p "Would you like to install missing dependencies? (y/n) " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            install_dependencies "${missing_deps[@]}"
        else
            error "Please install the missing dependencies and run the script again."
            exit 1
        fi
    else
        success "All required dependencies are installed."
    fi
}

install_dependencies() {
    local deps=("$@")
    
    info "Installing dependencies: ${deps[*]}"
    
    case $PACKAGE_MANAGER in
        brew)
            brew install "${deps[@]}"
            ;;
        apt)
            sudo apt update
            sudo apt install -y "${deps[@]}"
            ;;
        pacman)
            sudo pacman -Sy --noconfirm "${deps[@]}"
            ;;
        dnf)
            sudo dnf install -y "${deps[@]}"
            ;;
        *)
            error "Unknown package manager. Please install dependencies manually."
            exit 1
            ;;
    esac
}

# =============================================================================
# Backup Functions
# =============================================================================

create_backup() {
    local file=$1
    local backup_file="$BACKUP_DIR/$(basename "$file")"
    
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        cp -r "$file" "$backup_file"
        info "Backed up $file to $backup_file"
    fi
}

backup_existing_configs() {
    info "Backing up existing configurations..."
    
    for module in "${MODULES_TO_INSTALL[@]}"; do
        case $module in
            bash)
                create_backup "$HOME/.bashrc"
                create_backup "$HOME/.bash_profile"
                ;;
            zsh)
                create_backup "$HOME/.zshrc"
                create_backup "$HOME/.zprofile"
                create_backup "$HOME/.zshenv"
                create_backup "$HOME/.aliases"
                create_backup "$HOME/.functions"
                ;;
            git)
                create_backup "$HOME/.gitconfig"
                create_backup "$HOME/.gitignore_global"
                ;;
            vim)
                create_backup "$HOME/.vimrc"
                create_backup "$HOME/.vim"
                ;;
            ssh)
                create_backup "$HOME/.ssh/config"
                ;;
            fzf)
                create_backup "$HOME/.fzf.bash"
                create_backup "$HOME/.fzf.zsh"
                ;;
            fastfetch)
                create_backup "$HOME/.config/fastfetch"
                ;;
        esac
    done
    
    if [ -d "$BACKUP_DIR" ]; then
        success "Backup completed at: $BACKUP_DIR"
    fi
}

# =============================================================================
# Installation Functions
# =============================================================================

install_module() {
    local module=$1
    
    info "Installing $module configuration..."
    
    # Create necessary directories
    case $module in
        ssh)
            mkdir -p "$HOME/.ssh/sockets"
            chmod 700 "$HOME/.ssh"
            ;;
        vim)
            mkdir -p "$HOME/.vim/undo"
            ;;
        fastfetch)
            mkdir -p "$HOME/.config"
            ;;
    esac
    
    # Use stow to create symlinks
    if stow -v -R -t "$HOME" -d "$DOTFILES_DIR" "$module" 2>&1 | tee -a "$LOG_FILE"; then
        success "Successfully installed $module"
        
        # Post-installation tasks
        case $module in
            vim)
                info "Installing Vim plugins..."
                vim +PlugInstall +qall &>/dev/null || true
                ;;
            zsh)
                if [ "$SHELL" != "$(which zsh)" ]; then
                    warning "Your default shell is not zsh. Run 'chsh -s $(which zsh)' to change it."
                fi
                ;;
        esac
    else
        error "Failed to install $module"
        return 1
    fi
}

# =============================================================================
# Interactive Mode
# =============================================================================

interactive_mode() {
    echo -e "${PURPLE}=== Dotfiles Setup - Interactive Mode ===${NC}"
    echo
    echo "Available modules:"
    
    for i in "${!ALL_MODULES[@]}"; do
        echo "  $((i+1)). ${ALL_MODULES[$i]}"
    done
    echo "  a. All modules"
    echo "  q. Quit"
    echo
    
    read -p "Select modules to install (e.g., 1,3,5 or 'a' for all): " selection
    
    if [[ "$selection" == "q" ]]; then
        info "Setup cancelled."
        exit 0
    elif [[ "$selection" == "a" ]]; then
        MODULES_TO_INSTALL=("${ALL_MODULES[@]}")
    else
        IFS=',' read -ra SELECTIONS <<< "$selection"
        for sel in "${SELECTIONS[@]}"; do
            sel=$(echo "$sel" | tr -d ' ')
            if [[ "$sel" =~ ^[0-9]+$ ]] && [ "$sel" -ge 1 ] && [ "$sel" -le "${#ALL_MODULES[@]}" ]; then
                MODULES_TO_INSTALL+=("${ALL_MODULES[$((sel-1))]}")
            else
                warning "Invalid selection: $sel"
            fi
        done
    fi
    
    if [ ${#MODULES_TO_INSTALL[@]} -eq 0 ]; then
        error "No modules selected."
        exit 1
    fi
    
    echo
    info "Selected modules: ${MODULES_TO_INSTALL[*]}"
    read -p "Continue with installation? (y/n) " -n 1 -r
    echo
    
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "Setup cancelled."
        exit 0
    fi
}

# =============================================================================
# Main Setup Function
# =============================================================================

main() {
    echo -e "${PURPLE}=== Dotfiles Setup Script ===${NC}"
    echo
    
    # Initialize log
    log "Starting dotfiles setup..."
    
    # Check OS
    check_os
    
    # Check dependencies
    check_dependencies
    
    # Interactive mode or install all
    if [ $# -eq 0 ]; then
        interactive_mode
    else
        case $1 in
            --all|-a)
                MODULES_TO_INSTALL=("${ALL_MODULES[@]}")
                ;;
            --help|-h)
                echo "Usage: $0 [OPTIONS] [MODULES]"
                echo
                echo "Options:"
                echo "  --all, -a     Install all modules"
                echo "  --help, -h    Show this help message"
                echo
                echo "Modules:"
                echo "  ${ALL_MODULES[*]}"
                echo
                echo "Examples:"
                echo "  $0              # Interactive mode"
                echo "  $0 --all        # Install all modules"
                echo "  $0 zsh git vim  # Install specific modules"
                exit 0
                ;;
            *)
                # Install specific modules
                for module in "$@"; do
                    if [[ " ${ALL_MODULES[*]} " =~ " $module " ]]; then
                        MODULES_TO_INSTALL+=("$module")
                    else
                        warning "Unknown module: $module"
                    fi
                done
                ;;
        esac
    fi
    
    # Backup existing configurations
    backup_existing_configs
    
    # Install modules
    echo
    info "Installing dotfiles..."
    
    local failed_modules=()
    for module in "${MODULES_TO_INSTALL[@]}"; do
        if ! install_module "$module"; then
            failed_modules+=("$module")
        fi
    done
    
    # Summary
    echo
    echo -e "${PURPLE}=== Setup Summary ===${NC}"
    
    if [ ${#failed_modules[@]} -eq 0 ]; then
        success "All modules installed successfully!"
    else
        warning "The following modules failed to install: ${failed_modules[*]}"
    fi
    
    # Post-installation instructions
    echo
    echo -e "${CYAN}Post-installation steps:${NC}"
    echo "1. Restart your terminal or run: source ~/.${SHELL##*/}rc"
    echo "2. Install recommended tools:"
    echo "   - Oh My Zsh: sh -c \"\$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)\""
    echo "   - Vim plugins: vim +PlugInstall +qall"
    echo "3. Generate SSH keys if needed: ssh-keygen -t ed25519"
    echo
    echo "Log file: $LOG_FILE"
    
    if [ -d "$BACKUP_DIR" ]; then
        echo "Backups: $BACKUP_DIR"
    fi
    
    log "Setup completed."
}

# =============================================================================
# Script Entry Point
# =============================================================================

# Handle script errors
trap 'error "Script failed at line $LINENO"' ERR

# Run main function
main "$@"