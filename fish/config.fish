test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

set -g fish_user_paths "/usr/local/opt/terraform@0.11/bin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/bin" $fish_user_paths
set -g fish_user_paths "/opt/homebrew/sbin" $fish_user_paths
set -g fish_user_paths "$HOME/projects/lf/dotfiles/bin" $fish_user_paths
set -g fish_user_paths "$HOME/.local/bin" $fish_user_paths

set -g fish_greeting

export EDITOR="nvim"
export GIT_EDITOR=$EDITOR
export VISUAL=$EDITOR
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob \!.git'

test -e {$HOME}/.local_config.fish ; and source {$HOME}/.local_config.fish

set google_cloud_config /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
test -e {$google_cloud_config} ; and source {$google_cloud_config}
set -g fish_user_paths "/opt/homebrew/opt/terraform@0.11/bin" $fish_user_paths
