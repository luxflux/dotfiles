test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

status --is-interactive; and source (nodenv init -|psub)

export HTTPS_DEVELOPMENT=true
export WEBPACKER_DEV_SERVER_HTTPS=true

export EDITOR="nvim"
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob \!.git'

test -e {$HOME}/.local_config.fish ; and source {$HOME}/.local_config.fish
set -g fish_user_paths "/usr/local/opt/terraform@0.11/bin" $fish_user_paths
