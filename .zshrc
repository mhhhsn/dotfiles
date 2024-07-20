# [name@machine ~/some/dir]$    for non-root
# [machine ~/some/dir]#         for root (but in red)
# Also includes error code between ]$
PS1="%B%(!.%F{red}.%F{cyan})[%(!..%F{green}%n%F{cyan}@%F{magenta})%M %(!.%F{default}.%F{green})%~%(!.%F{red}.%F{cyan})]%(?.. %F{red}%? )%f%b%(!.#.$) "

# Some coloured commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# History
HISTSIZE=10000
HISTFILE=~/.history
SAVEHIST=$HISTSIZE
setopt hist_ignore_space

# Environment variables
LANG=en_GB.UTF-8

# Autocompletion and tabcompletion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins 
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'

preexec() { echo -ne '\e[5 q' ;}

# Bind Ctrl-R to reverse history search
bindkey '^R' history-incremental-search-backward
# Bind Delete to delete
bindkey '^[[3~' backward-delete-char
# Bind Ctrl-Left, Ctrl-Right to noob navigation
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5D' backward-word

# Syntax highlighting plugin
source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh

