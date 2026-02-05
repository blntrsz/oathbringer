# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git vi-mode)
source $ZSH/oh-my-zsh.sh

# keys
bindkey ^R history-incremental-search-backward
bindkey -s ^F "~/.config/tmux/tmux-sessionizer\n"

# Load aliasses
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
