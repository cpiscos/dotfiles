# autoload -U promptinit && promptinit
# autoload -U colors && colors
source $HOME/env
source /etc/profile.d/google-cloud-cli.sh
autoload -Uz compinit
# export EDITOR=socketed_neovide
export EDITOR=nvim
export PATH=$HOME/scripts:$HOME/.cargo/bin:$PATH
# export MANPAGER="nvim +Man!"
# export MANWIDTH=999

alias q="exit"
# alias n="socketed_neovide"
alias n="nvim"
alias N="sudo -e"
alias ls=exa
alias la="exa -a"
alias stow="stow --ignore='^(\.git|\.misc)$'"
alias lg="lazygit"
alias fm="vifm"
alias lf="vifm ."
alias wev="kitty wev"
alias rt="launch_rtorrent"
alias grep='grep --color=auto'
alias sp="spotify_player"
alias wtr="curl 'wttr.in/Las+Vegas?u'"
alias :q="exit"
function man() {
    socketed_neovide -c ":silent enew | silent Man $* | only"
}
function q() {
  exit
}
zle -N q

HISTFILE=~/.zsh/history/global_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

KEYTIMEOUT=5

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

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

eval "$(github-copilot-cli alias -- "$0")"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
(cat $HOME/.config/wpg/sequences &)


function auto_activate_venv() {
    local project_root="$PWD"
    local venv_path=""

    while [[ $project_root != '/' ]]; do
        if [[ -f "$project_root/.venv" || -d "$project_root/.venv" ]]; then
            venv_path="$project_root/.venv/bin/activate"
            break
        elif [[ -d "$project_root/venv" ]]; then
            venv_path="$project_root/venv/bin/activate"
            break
        fi
        project_root=$(dirname "$project_root")
    done

    if [[ -n $venv_path && -z $VIRTUAL_ENV ]]; then
        source "$venv_path"
    elif [[ -n $VIRTUAL_ENV && -z $venv_path ]]; then
        deactivate
    fi
}

add-zsh-hook chpwd auto_activate_venv
