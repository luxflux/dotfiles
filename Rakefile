require 'fileutils'

desc 'Link dotfiles'
task :link do
  link_dir = Dir.pwd

  Dir.chdir ENV['HOME']

  files = %w[.vimrc .vim]
  files += %w[.tmux.conf .tmux .tmux.status.conf]
  files += %w[.zshrc]
  files += %w[.ackrc]
  files += %w[.slate]
  files += %w[.powconfig]
  files += %w[.pryrc .pry .irbrc]
  files += %w[.rubocop.yml .scss-lint.yml]
  files += %w[.ledgerrc]
  files += %w[.bundle]
  files += %w[.mutt .offlineimaprc .urlview .msmtprc .notmuch-config .muttqt]
  files += %w[.taskrc]
  files += %w[.gitconfig]

  files.each do |file_or_dir|
    sh "ln -nfs #{link_dir}/#{file_or_dir}"
  end

  sh "mkdir -p .config"
  sh "ln -nfs #{link_dir}/nvim .config/nvim"

  sh "mkdir -p Library/LaunchAgents"
  Dir.glob("#{link_dir}/LaunchAgents/*").each do |agent|
    name = File.basename(agent)
    sh "cp #{agent} Library/LaunchAgents/#{name}"
    sh "launchctl load Library/LaunchAgents/#{name}"
    sh "launchctl start #{name.gsub('.plist', '')}"
  end
end

namespace :bootstrap do
  desc "Bootstrap vim"
  task :vim do
    sh "vim -c ':PlugInstall' -c ':quitall'"
  end

  desc "Bootstrap zsh"
  task :zsh do
    prezto_dir = File.join('.zprezto')
    sh "git clone git@github.com:luxflux/prezto.git #{prezto_dir}" unless File.exists?(prezto_dir)

    Dir.chdir prezto_dir do
      sh 'git submodule init'
      sh 'git submodule update'
    end
  end
end
