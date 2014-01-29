require 'fileutils'

desc 'Link dotfiles'
task :link do
  link_dir = Dir.pwd

  Dir.chdir ENV['HOME']

  files = %w[.vimrc .vim]
  files += %w[.tmux.conf .tmux .tmux.status.conf]
  files += %w[.zlogin .zlogout .zpreztorc .zprofile .zshenv .zshrc .zprezto]
  files += %w[.ackrc]
  files += %w[.slate]

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
    bundle_dir = File.join('.vim', 'bundle')
    vundle_dir = File.join(bundle_dir, 'vundle')
    sh "git clone https://github.com/gmarik/vundle.git #{vundle_dir}" unless File.exists?(vundle_dir)

    sh "brew install ctags"
    sh "vim -c ':BundleInstall' -c ':quitall'"

    Dir.chdir File.join(bundle_dir, 'YouCompleteMe') do
      if File.exists?(File.join('python', 'ycm_core.so'))
        puts 'YouCompleteMe already compiled'
      else
        sh './install.sh --clang-completer'
      end
    end
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

  desc "Bootstrap tmux"
  task :tmux do
    sh 'brew install reattach-to-user-namespace'
  end

  desc "Bootstrap slate"
  task :slate do
    sh 'brew cask install slate'
  end

  desc "Bootstrap rbenv"
  task :rbenv do
    sh 'brew install rbenv rbenv rbenv-gemset rbenv-gem-rehash'
  end
end
