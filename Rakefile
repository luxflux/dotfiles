require 'fileutils'

desc 'Install dotfiles'
task :install do
  install_dir = Dir.pwd

  Dir.chdir ENV['HOME']

  files = %w[.vimrc .vim]
  files += %w[.tmux.conf .tmux]

  files.each do |file_or_dir|
    if File.exists?(file_or_dir)
      print "Remove #{file_or_dir} (y/n)? "
      answer = STDIN.gets
      if answer.chomp == 'y'
        FileUtils.rm_rf file_or_dir
      else
        next
      end
    end
    sh "ln -s #{install_dir}/#{file_or_dir}"
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
end
