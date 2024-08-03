#
# ~/.zshrc
#
# this file is used for setting user's interactive shell configuration and executing commands, will be read when starting as an interactive shell. 

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt autocd nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/simone/.zshrc'
# enable autocompletion
autoload -Uz compinit
compinit
# End of lines added by compinstall


################################
### Tools specifics settings ###
################################

# rust
. "$HOME/.cargo/env"

# firefox
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi

# zoxide
eval "$(zoxide init zsh)"

# fzf
source <(fzf --zsh)


###############
### ALIASES ###
###############
alias config='/usr/bin/git --git-dir=/home/simone/.cfg/ --work-tree=/home/simone'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias pkill="pkill -f"
