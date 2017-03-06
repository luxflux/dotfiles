if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-completions"
zplug "caarlos0/zsh-git-sync"
zplug "denysdovhan/spaceship-zsh-theme", as:theme
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# zplug load --verbose
zplug load

source /Users/raf/.iterm2_shell_integration.zsh

# History Search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Aliases
alias netstat="sudo lsof -i -P"
alias stree="/Applications/SourceTree.app/Contents/MacOS/SourceTree \$(pwd)"
alias prettyjson="ruby -rjson -e 'puts JSON.pretty_generate(JSON.parse(STDIN.read))'"
alias vim="nvim"
alias mutt="cd ~/Downloads && mutt"
alias restart-offlineimap="kill -9 \$(pgrep -f offlineimap)"

# Variables
export EDITOR="nvim"
export GIT_EDITOR=${EDITOR}
export VISUAL=${EDITOR}
export FZF_DEFAULT_COMMAND='ag -l -g ""'
export SOCKET_DIR=/tmp

# Nodenv
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init - --no-rehash zsh)"; fi

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
