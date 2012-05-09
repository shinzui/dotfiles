require 'rubygems/command'

class Gem::Commands::CtagsCommand < Gem::Command
  def initialize
    super 'ctags', 'Generate ctags for gems'
  end

  def execute
    if Gem::Specification.respond_to?(:each)
      Gem::Specification
    else
      Gem.source_index.gems.values
    end.each do |spec|
      self.class.index(spec) do |message|
        say message
      end
    end
  end

  def self.index(spec)
    return unless File.directory?(spec.full_gem_path)

    Dir.chdir(spec.full_gem_path) do

      if !File.exist?('tags') || File.read('tags', 1) != '!'
        yield "Generating ctags for #{spec.full_name}" if block_given?
        paths = spec.require_paths.select { |p| File.directory?(p) }
        system('ctags', '-R', '--languages=ruby', *paths)
      end

      target = 'lib/bundler/cli.rb'
      if File.writable?(target) && !File.read(target).include?('load_plugins')
        yield "Injecting gem-ctags into #{spec.full_name}" if block_given?
        File.open(target, 'a') do |f|
          f.write "\nGem.load_plugins rescue nil\n"
        end
      end

    end
  end
end
