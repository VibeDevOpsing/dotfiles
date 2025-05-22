# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


# Git status function with branch and counts
git_prompt_info() {
    git rev-parse --is-inside-work-tree &>/dev/null || return

    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD)
    local staged=$(git diff --cached --name-only | wc -l | tr -d '[:space:]')
    local unstaged=$(git diff --name-only | wc -l | tr -d '[:space:]')
    local untracked=$(git ls-files --others --exclude-standard | wc -l | tr -d '[:space:]')

    local status=""
    [[ $staged -gt 0 || $unstaged -gt 0 ]] && status+="!$((staged + unstaged)) "
    [[ $untracked -gt 0 ]] && status+="?$untracked "

    printf "(git:${branch}${status:+ $status})"
}

# Capture command status, ignoring empty commands
update_last_status() {
    local current_exit=$?
    local hist_cmd=$(history 1 | sed 's/ *[0-9]* *//')
    if [[ -n "$hist_cmd" ]]; then
        last_exit_status=$current_exit
    fi
}
PROMPT_COMMAND="update_last_status"

last_cmd_status() {
    if [[ $last_exit_status -eq 0 ]]; then
        printf "\e[0;32m■"
    else
        printf "\e[0;31m■"
    fi
}

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/bash lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# ANSI Colors
ORANGE='\[\e[1;33m\]'
GREEN='\[\e[1;32m\]'
RED='\[\e[1;31m\]'
BLUE='\[\e[1;34m\]'
CYAN='\[\e[1;36m\]'
RESET='\[\e[0m\]'

# Set Custom PS1 prompt
custom_PS1="${ORANGE} \$(date +%H:%M:%S) ${BLUE}${debian_chroot:+($debian_chroot)}\u@\h ${CYAN}\w${RESET} ${GREEN}\$(git_prompt_info) \$(last_cmd_status)${RESET} \$ "
simple_PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="${custom_PS1}"
else
    PS1="${simple_PS1}"
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# Set PS1 for sudo user
if ! [ -n "${SUDO_USER}" -a -n "${SUDO_PS1}" ]; then
    PS1="${PS1}"
fi

# Loads all scripts from default profile directory
if [ -d /etc/profile.d ]; then
    for i in /etc/profile.d/*.sh; do
        [ -r "$i" ] && . "$i"
    done
    unset i
fi

# Check available gcc
if ! command -v arm-none-eabi-gcc &>/dev/null; then
    export PATH="${PATH}:/opt/gcc-arm-none-eabi-10.3-2021.10/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
fi

# ── Aliases ───
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
