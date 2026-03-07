#
# ~/.zshrc
#
# this file is used for setting user's interactive shell configuration and executing commands, will be read when starting as an interactive shell. 

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt nobeep               # no beep
setopt autocd			    # change directory by simply typing dir name.
setopt globdots 		    # files beginning with a . will be matched without explicitly specifying the dot. 
setopt extendedglob		    # allows using regular expressions in globbing.
setopt interactivecomments	# turns on interactive comments; comments begin with a #.
setopt nomatch
setopt notify
bindkey -v                  # vi mode (vim keybinds), change to '-e' for emacs mode 
bindkey "^[[Z" magic-space  # shift-tab to bypass completion
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[[3;5~" kill-word
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/simone/.zshrc'
# enable autocompletion
autoload -Uz compinit && compinit -u
_comp_options+=(globdots) # autocomplete also dotfiles
# End of lines added by compinstall

# plugins
# autojump
source /etc/profile.d/autojump.sh

# autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

##################
### Extensions ###
##################
zmodload zsh/mapfile

################################
### Tools specifics settings ###
################################

# starship
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"

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

# ssh-agent
# see https://wiki.archlinux.org/title/SSH_keys#Start_ssh-agent_with_systemd_user
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"


###############
### ALIASES ###
###############
alias config='/usr/bin/git --git-dir=/home/simone/.cfg/ --work-tree=/home/simone'
alias ls='ls --color=auto'
alias lla='ls -lah'
alias cl='clear'
alias j='z' # "j-ump" just makes more sense
alias grep='grep --color=auto'
alias pgrep='pgrep --full'
alias pkill="pkill --echo --full"
alias tree="tree -C"
alias tn="tmux new-session -s"
alias tl="tmux list-sessions"
alias ta="tmux attach-session"
alias td="tmux detach"
alias tkill="tmux kill-session -t"
alias tquit="tmux kill-session"
alias gparted="sudo -E gparted"

#################
### FUNCTIONS ###
#################
battery() {
    echo "$(cat /sys/class/power_supply/BAT0/capacity)%"
}

mkvenv() {
    if python3 -m venv venv ; then
        source venv/bin/activate
    fi
}

export PATH="$PATH:/home/simone/.bifrost/bin"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"


## syntax highlighting
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
