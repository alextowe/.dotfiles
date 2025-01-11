#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Variables
export PATH=$HOME/.local/bin
export EDITOR=/usr/bin/vim
export SUDO_EDITOR=/usr/bin/vim
export DEV_DIR=$HOME/dev/

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100 # limits recursive functions, see 'man bash'

# Use the up and down arrow keys for finding a command in history
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
