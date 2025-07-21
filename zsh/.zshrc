# =============================================================================
# Powerlevel10k Instant Prompt
# =============================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# =============================================================================
# Environment Variables
# =============================================================================
export PATH="$HOME/.local/share/nvim/bin:$HOME/.local/bin:$HOME/.bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH"
export ZSH=$HOME/.oh-my-zsh
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# History settings
export HISTSIZE=50000
export SAVEHIST=50000
export HISTFILE="$HOME/.zsh_history"
export HISTCONTROL=ignoreboth:erasedups

# =============================================================================
# Oh My Zsh Configuration
# =============================================================================
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="true"
export UPDATE_ZSH_DAYS=7
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# =============================================================================
# Plugins
# =============================================================================
plugins=(
    # ZSH enhancements
    zsh-autosuggestions
    zsh-interactive-cd
    zsh-syntax-highlighting
    zsh-navigation-tools

    # Development tools
    git
    git-escape-magic
    github
    gitignore
    docker
    docker-compose
    python
    pyenv
    pylint
    virtualenv
    golang
    node
    npm

    # DevOps tools
    ansible
    terraform
    vagrant
    vagrant-prompt
    helm
    aws

    # System utilities
    sudo
    systemd
    rsync
    cp
    copyfile
    copypath

    # Other utilities
    colored-man-pages
    history
    nmap
    redis-cli
    screen
    vscode
)

source $ZSH/oh-my-zsh.sh

# =============================================================================
# Shell Options
# =============================================================================
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_REDUCE_BLANKS        # Remove extra blanks from each command line being added to history.

# =============================================================================
# Load Custom Files
# =============================================================================
# Load aliases
[ -f ~/.aliases ] && source ~/.aliases

# Load functions
[ -f ~/.functions ] && source ~/.functions

# =============================================================================
# Tool Initialization
# =============================================================================
# iTerm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Zoxide (better cd)
eval "$(zoxide init zsh)"

# Starship prompt (comment out if using p10k)
# eval "$(starship init zsh)"

# Cargo/Rust
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --preview-window=:hidden'

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# =============================================================================
# Interactive Shell Greeting
# =============================================================================
# Only run in interactive shells
if [[ $- == *i* ]]; then
    # Pokemon greeting with fastfetch
    if command -v pokeget &> /dev/null && command -v fastfetch &> /dev/null; then
        pokeget random --hide-name | fastfetch -c $HOME/.config/fastfetch/config.jsonc --logo-padding "2" --logo-padding-top "1" --file-raw -
    fi

    # Git repository greeter with onefetch
    last_repository=
    check_directory_for_new_repository() {
        current_repository=$(git rev-parse --show-toplevel 2> /dev/null)

        if [ "$current_repository" ] && [ "$current_repository" != "$last_repository" ]; then
            if command -v onefetch &> /dev/null; then
                onefetch
            fi
        fi
        last_repository=$current_repository
    }

    # Override cd to check for git repositories
    cd() {
        builtin cd "$@"
        check_directory_for_new_repository
    }

    # Check current directory on shell start
    check_directory_for_new_repository
fi

# =============================================================================
# Aliases - Shortcuts (Personal)
# =============================================================================
alias lzd='lazydocker'
alias lzg='lazygit'
alias updzsh='source ~/.zshrc'
alias say='fortune | cowsay -f $(cowsay -l | tail -n +2 | tr " " "\n" | shuf -n 1) | lolcat'

# =============================================================================
# Local Configuration
# =============================================================================
# Source local configuration if it exists
[ -f ~/.zshrc.local ] && source ~/.zshrc.local