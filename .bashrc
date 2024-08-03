#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

################################
### Tools specifics settings ###
################################

# Rust
. "$HOME/.cargo/env"

# Firefox
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi


###############
### ALIASES ###
###############
alias config='/usr/bin/git --git-dir=/home/simone/.cfg/ --work-tree=/home/simone'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pkill="pkill -f"
