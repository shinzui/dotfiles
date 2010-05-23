require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if %w[Rakefile README.md TODO].include? file

    file_without_erb = file.sub('.erb', '')
    dot_file = ".#{file_without_erb}"
    original = File.join(root_destination, dot_file)

    if File.exist?(original) || File.symlink?(original)
      if replace_all
        replace_file(dot_file, file)
      else
        print "overwrite #{root_destination}/.#{file_without_erb}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(dot_file, file)
        when 'y'
          replace_file(dot_file, file)
        when 'q'
          exit
        else
          puts "skipping #{root_destination}/#{dot_file}"
        end
      end
    else
      link_file(file)
    end
  end
end

def replace_file(dot_file, file_or_template)
  system %Q{rm -rf "#{root_destination}/#{dot_file}"}
  link_file(file_or_template)
end

def link_file(file_or_template)
  if file_or_template =~ /.erb$/
    file_without_erb = file_or_template.sub('.erb', '')

    puts "generating #{root_destination}/.#{file_without_erb}"
    File.open(File.join(root_destination, ".#{file_without_erb}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file_or_template)).result(binding)
    end
  else
    file = file_or_template
    puts "linking #{root_destination}/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "#{root_destination}/.#{file}"}
  end
end

def root_destination
  ENV['HOME']
end
