# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# If you come from bash you might have to change your $PATH.
export PATH="$HOME/.local/share/nvim/bin:$HOME/.local/bin:$HOME/.bin:$HOME/bin:/usr/local/bin:$HOME/.cargo/bin:$PATH"


# Path to your oh-my-zsh installation.
# poke
export ZSH=$HOME/.oh-my-zsh
# Set name of the theme to load --- if set to "random", it will
# to know which # pokespecific one was loaded, run: echo $RANDOM_THEME
# load a random theme each time oh-my-zsh is loaded, in which case,
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k" # "ys" # "steeef"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME="spaceship"
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="false"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
    zsh-autosuggestions
    zsh-interactive-cd
    zsh-syntax-highlighting
    ansible
    github
    cp
    docker
    docker-compose
    sudo
    python
    rsync
    vscode
    vagrant
    vagrant-prompt
    terraform
    systemd
    copyfile
    copypath
    aws
    colored-man-pages
    git-escape-magic
    github
    gitignore
    golang
    helm
    history
    nmap
    node
    npm
    redis-cli
    pyenv
    pylint
    screen
    vscode
    virtualenv
    zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh

# User configuration


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='vim'
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi



# zsh
alias updzsh='source ~/.zshrc'
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export HISTCONTROL=ignoreboth:erasedups
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# file list
alias l='eza -1aglhOMm --icons'
alias lsd='lsd -lhaF'
#alias ls='ls -lah --color=auto'

# git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gaa='git add .'
alias gch='git checkout'
alias gcm='git commit -m'
alias gph='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gfp='git fetch && git pull'

alias v='vagrant'

#github

# Docker-compose
alias docekr='docker'
alias dc='docker'
alias dcd='docker-compose down'
alias dcu='docker-compose up'
alias dcud='docker-compose up -d'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

#readable output
alias df='df -h'

#free
alias free="free -mt"

#continue download
alias wget="wget -c"

#userlist
alias userlist="cut -d: -f1 /etc/passwd"

#search content with ripgrep
alias rg="rg --sort path"


# Apps
# iterm2
test -e $HOME/.iterm2_shell_integration.zsh && source $HOME/.iterm2_shell_integration.zsh || true
# zoxide
eval "$(zoxide init zsh)"

# Starship
eval "$(starship init zsh)"

[ -f "$HOME/.cargo/env"] && . "$HOME/.cargo/env"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fastfetch
pokeget random --hide-name | fastfetch -c $HOME/.dots/fastfetch-config-compact.jsonc --logo-padding "2" --logo-padding-top "1" --file-raw -

# Cowway
cowsay_path='/opt/homebrew/Cellar/cowsay/3.8.4/share/cowsay/cows/'
alias say='fortune | cowsay  -f "$(ls $cowsay_path | sort -R | head -1)" | lolcat'
#say

# vfetch
#vfetch

# pokemon-colorscripts
# pokemon-colorscripts --no-title -s -r

# onefetch
# git repository greeter
last_repository=
check_directory_for_new_repository() {
  current_repository=$(git rev-parse --show-toplevel 2> /dev/null)

if [ "$current_repository" ] && \
    [ "$current_repository" != "$last_repository" ]; then
  onefetch
  fi
  last_repository=$current_repository
}
cd() {
  builtin cd "$@"
  check_directory_for_new_repository
}
# optional, greet also when opening shell directly in repository directory
# adds time to startup
check_directory_for_new_repository

# personal
alias cd..='cd ..'
alias lzd='lazydocker'
alias s='sudo'
alias cl='clear'

# MAc Os setings
alias nnap='defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true'
alias enap='defaults delete NSGlobalDomain NSAppSleepDisabled'
alias dnap='defaults write NSGlobalDomain NSAppSleepDisabled -bool YES'
