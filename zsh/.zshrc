autoload -Uz compinit
export PATH="$HOME/scripts:$PATH"
export EDITOR=socketed_neovide.sh
# export MANPAGER="nvim +Man!"
# export MANWIDTH=999

alias q="exit"
alias n="socketed_neovide.sh"
alias N="sudo -e"
alias ls=exa
alias la="exa -a"
alias stow="stow --ignore='^(\.git|\.misc)$'"
alias r="ranger"
alias wev="kitty wev"
function man() {
    socketed_neovide.sh -c ":silent enew | silent Man $* | only"
}
function q() {
  exit
}
zle -N q

HISTFILE=~/.zsh/history/global_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

KEYTIMEOUT=5

# bindkey -v

HISTORY_SUBSTRING_SEARCH_PREFIXED=1
HISTORY_SUBSTRING_SEARCH_FUZZY=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
PER_DIRECTORY_HISTORY_BASE=$HOME/.zsh/history

setopt HIST_IGNORE_ALL_DUPS EXTENDED_HISTORY INC_APPEND_HISTORY SHARE_HISTORY

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
source $HOME/.zsh/plugins/per-directory-history/per-directory-history.zsh

# bindkey '^G' per-directory-history-toggle-history
# bindkey -M vicmd '^G' per-directory-history-toggle-history

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
(cat $HOME/.config/wpg/sequences &)

