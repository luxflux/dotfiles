if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash zsh)"; fi

zplug "zsh-users/zsh-completions"
zplug "caarlos0/zsh-git-sync"
zplug "frmendes/geometry", as:theme
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

export GEOMETRY_PROMPT_PLUGINS=(exec_time git ruby node k8s)
export GEOMETRY_PROMPT_PREFIX=""
export PROMPT_GEOMETRY_EXEC_TIME="true"
export GEOMETRY_COLOR_PROMPT="red"
export PROMPT_GEOMETRY_COLORIZE_SYMBOL="true"
export GEOMETRY_PLUGIN_SEPARATOR=" | "
export GEOMETRY_SYMBOL_RUBY_RVM_VERSION=""
export GEOMETRY_COLOR_PACKAGER_VERSION="green"
export GEOMETRY_SYMBOL_PACKAGER_VERSION=""

# zplug load --verbose
zplug load

geometry_prompt_k8s_setup() {}
geometry_prompt_k8s_check() { $(echo $PWD | grep k8s) || return 1 }
geometry_prompt_k8s_render() {
   kubectl_current_context=$(kubectl config current-context)
   # kubectl_project=$(echo $kubectl_current_context | cut -d '_' -f 2)
   kubectl_cluster=$(echo $kubectl_current_context | cut -d '_' -f 4)
   kubectl_prompt="k8s:$kubectl_cluster"
   echo $kubectl_prompt
}

geometry_plugin_register k8s

source /Users/raf/.iterm2_shell_integration.zsh

if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc ]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

typeset -A key

key[Home]="$terminfo[khome]"
key[End]="$terminfo[kend]"
key[Insert]="$terminfo[kich1]"
key[Backspace]="$terminfo[kbs]"
key[Delete]="$terminfo[kdch1]"
key[Up]="$terminfo[kcuu1]"
key[Down]="$terminfo[kcud1]"
key[Left]="$terminfo[kcub1]"
key[Right]="$terminfo[kcuf1]"
key[PageUp]="$terminfo[kpp]"
key[PageDown]="$terminfo[knp]"

# setup key accordingly
[[ -n "$key[Home]"      ]] && bindkey -- "$key[Home]"      beginning-of-line
[[ -n "$key[End]"       ]] && bindkey -- "$key[End]"       end-of-line
[[ -n "$key[Insert]"    ]] && bindkey -- "$key[Insert]"    overwrite-mode
[[ -n "$key[Backspace]" ]] && bindkey -- "$key[Backspace]" backward-delete-char
[[ -n "$key[Delete]"    ]] && bindkey -- "$key[Delete]"    delete-char
[[ -n "$key[Up]"        ]] && bindkey -- "$key[Up]"        history-substring-search-up
[[ -n "$key[Down]"      ]] && bindkey -- "$key[Down]"      history-substring-search-down
[[ -n "$key[Left]"      ]] && bindkey -- "$key[Left]"      backward-char
[[ -n "$key[Right]"     ]] && bindkey -- "$key[Right]"     forward-char

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        echoti smkx
    }
    function zle-line-finish () {
        echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Aliases
alias netstat="sudo lsof -i -P"
alias stree="/Applications/SourceTree.app/Contents/MacOS/SourceTree \$(pwd)"
alias prettyjson="ruby -rjson -e 'puts JSON.pretty_generate(JSON.parse(STDIN.read))'"
alias vim="nvim"
alias mutt="cd ~/Downloads && mutt"
alias restart-offlineimap="kill -9 \$(pgrep -f offlineimap)"
alias ls="ls -G"
alias l="exa -lhga --git --time-style long-iso"

# Variables
export EDITOR="nvim"
export GIT_EDITOR=${EDITOR}
export VISUAL=${EDITOR}
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export SOCKET_DIR=/tmp
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

# Path
# add dotfilez bin to path
PATH=$PATH:~/dotfiles/bin
# add postgres app to path
PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"
# add npm modules to path
PATH="/usr/local/share/npm/bin:$PATH"
# mkdir .git/safe in the root of repositories you trust
PATH=".git/safe/../../bin:$PATH"
PATH=".git/safe/../../node_modules/.bin:$PATH"
PATH=".git/safe/../../client/node_modules/.bin:$PATH"
# homebrew sbin
PATH="$PATH:/usr/local/sbin"
# postgres
PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# ZSH config
# change path without specifying cd
setopt auto_cd

# History
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"       # The path to the history file.
HISTSIZE=10000                   # The maximum number of events to save in the internal history.
SAVEHIST=10000                   # The maximum number of events to save in the history file.
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.

if which kubectl > /dev/null; then source <(kubectl completion zsh); fi
