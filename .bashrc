#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

# Added aliases
alias discord='/usr/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
