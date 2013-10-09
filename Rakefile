require 'fileutils'

desc 'Install dotfiles'
task :install do
  install_dir = Dir.pwd

  Dir.chdir ENV['HOME']

  %w[.vimrc .vim].each do |file_or_dir|
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
