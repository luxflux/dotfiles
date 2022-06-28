test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

status --is-interactive; and source (nodenv init -|psub)

export HTTPS_DEVELOPMENT=true
export WEBPACKER_DEV_SERVER_HTTPS=true

export EDITOR="nvim"
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob \!.git'

test -e {$HOME}/.local_config.fish ; and source {$HOME}/.local_config.fish

set -x PATH "/usr/local/opt/terraform@0.11/bin" $PATH
set -x PATH /Users/raf/.platformsh/bin $PATH
set -x PATH .git/safe/../../bin $PATH
set -x PATH .git/safe/../../node_modules/.bin $PATH

set -x GOPATH $HOME/.go
set -x GOROOT /usr/local/opt/go/libexec
set -x PATH $GOPATH/bin $PATH
set -x PATH $GOROOT/bin $PATH
set -x PATH $HOME/.gem/ruby/2.4.0/bin $PATH

set -g fish_greeting
