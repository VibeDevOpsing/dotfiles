# =============================================================================
# Dotfiles Makefile
# =============================================================================

.PHONY: help install update backup clean test lint all zsh git vim ssh

# Default target
.DEFAULT_GOAL := help

# =============================================================================
# Variables
# =============================================================================
SHELL := /bin/bash
DOTFILES_DIR := $(shell pwd)
BACKUP_DIR := $(HOME)/.dotfiles_backup/$(shell date +%Y%m%d_%H%M%S)

# =============================================================================
# Help
# =============================================================================
help: ## Show this help message
	@echo "Dotfiles Management"
	@echo "=================="
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-15s %s\n", $$1, $$2}'

# =============================================================================
# Installation
# =============================================================================
install: ## Install all dotfiles
	@./setup.sh --all

update: ## Update dotfiles from repository
	@echo "Updating dotfiles..."
	@git pull origin main
	@echo "Reinstalling configurations..."
	@./setup.sh --all

backup: ## Backup current dotfiles
	@echo "Creating backup in $(BACKUP_DIR)..."
	@mkdir -p $(BACKUP_DIR)
	@cp -r ~/.zshrc $(BACKUP_DIR)/ 2>/dev/null || true
	@cp -r ~/.gitconfig $(BACKUP_DIR)/ 2>/dev/null || true
	@cp -r ~/.vimrc $(BACKUP_DIR)/ 2>/dev/null || true
	@cp -r ~/.ssh/config $(BACKUP_DIR)/ 2>/dev/null || true
	@echo "Backup complete!"

# =============================================================================
# Module Installation
# =============================================================================
all: ## Install all modules
	@./setup.sh --all

zsh: ## Install ZSH configuration
	@./setup.sh zsh

git: ## Install Git configuration
	@./setup.sh git

vim: ## Install Vim configuration
	@./setup.sh vim

ssh: ## Install SSH configuration
	@./setup.sh ssh

bash: ## Install Bash configuration
	@./setup.sh bash

fzf: ## Install FZF configuration
	@./setup.sh fzf

fastfetch: ## Install Fastfetch configuration
	@./setup.sh fastfetch

# =============================================================================
# Maintenance
# =============================================================================
clean: ## Remove broken symlinks
	@echo "Removing broken symlinks..."
	@find $(HOME) -maxdepth 1 -type l -exec test ! -e {} \; -delete
	@echo "Clean complete!"

test: ## Test dotfiles configuration
	@echo "Testing dotfiles configuration..."
	@echo "Checking for stow..."
	@command -v stow >/dev/null 2>&1 || (echo "stow is not installed" && exit 1)
	@echo "Checking symlinks..."
	@for module in zsh git vim ssh bash fzf fastfetch; do \
		echo -n "Checking $$module... "; \
		if stow -n -v -R -t $(HOME) -d $(DOTFILES_DIR) $$module 2>&1 | grep -q "^LINK:"; then \
			echo "✓"; \
		else \
			echo "✗"; \
		fi; \
	done
	@echo "Test complete!"

lint: ## Lint shell scripts
	@echo "Linting shell scripts..."
	@if command -v shellcheck >/dev/null 2>&1; then \
		shellcheck setup.sh install.sh; \
		echo "Lint complete!"; \
	else \
		echo "shellcheck not installed, skipping..."; \
	fi

# =============================================================================
# Dependencies
# =============================================================================
deps: ## Install required dependencies
	@echo "Installing dependencies..."
	@if [[ "$$(uname)" == "Darwin" ]]; then \
		brew install stow git zsh neovim fzf ripgrep eza bat fd zoxide starship; \
	elif command -v apt-get >/dev/null 2>&1; then \
		sudo apt update && sudo apt install -y stow git zsh neovim fzf ripgrep exa bat fd-find zoxide; \
		curl -sS https://starship.rs/install.sh | sh; \
	elif command -v pacman >/dev/null 2>&1; then \
		sudo pacman -S stow git zsh neovim fzf ripgrep eza bat fd zoxide starship; \
	else \
		echo "Unsupported package manager"; \
		exit 1; \
	fi

# =============================================================================
# Development
# =============================================================================
edit: ## Open dotfiles in editor
	@$${EDITOR:-nvim} .

push: ## Commit and push changes
	@echo "Committing changes..."
	@git add -A
	@git commit -m "Update dotfiles $$(date +%Y-%m-%d)" || true
	@git push origin main

pull: ## Pull latest changes
	@git pull origin main

status: ## Show git status
	@git status

# =============================================================================
# Uninstall
# =============================================================================
uninstall: ## Uninstall all dotfiles (restore from backup if available)
	@echo "Uninstalling dotfiles..."
	@for module in zsh git vim ssh bash fzf fastfetch; do \
		stow -D -t $(HOME) -d $(DOTFILES_DIR) $$module 2>/dev/null || true; \
	done
	@echo "Dotfiles uninstalled!"
	@echo "Your original files may be in ~/.dotfiles_backup/" 