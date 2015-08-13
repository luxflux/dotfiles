require 'fileutils'

desc 'Link dotfiles'
task :link do
  link_dir = Dir.pwd

  Dir.chdir ENV['HOME']

  files = %w[.vimrc .vim]
  files += %w[.nvimrc .nvim]
  files += %w[.tmux.conf .tmux .tmux.status.conf]
  files += %w[.zlogin .zlogout .zpreztorc .zprofile .zshenv .zshrc .zprezto .zpreztorc.last]
  files += %w[.ackrc]
  files += %w[.slate]
  files += %w[.powconfig]
  files += %w[.pryrc .pry .irbrc]
  files += %w[.rubocop.yml .scss-lint.yml]

  files.each do |file_or_dir|
    if File.exists?(file_or_dir)
      print "Remove #{file_or_dir} (y/N)? "
      answer = STDIN.gets
      if answer.chomp == 'y'
        FileUtils.rm_rf file_or_dir
      else
        next
      end
    end
    sh "ln -s #{link_dir}/#{file_or_dir}"
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
