#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

alias config='/usr/bin/git --git-dir=/home/simone/.cfg/ --work-tree=/home/simone'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
