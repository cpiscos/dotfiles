autoload -Uz compinit && compinit
export EDITOR=nvim
# export STOW_DIR=$HOME/.dotfiles
export PATH=$HOME/scripts:$PATH

alias n=nvim
alias N=sudo -e
alias ls=exa
alias la="exa -a"
alias stow="stow --ignore='^(\.git|\.misc)$'"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

KEYTIMEOUT=5

bindkey -v

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

HISTORY_SUBSTRING_SEARCH_PREFIXED=1
HISTORY_SUBSTRING_SEARCH_FUZZY=1

setopt HIST_IGNORE_ALL_DUPS

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
(cat ~/.cache/wal/sequences &)
