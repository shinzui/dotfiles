#!/usr/bin/env ruby
require 'irb/completion'
require 'rubygems' rescue nil
require 'pp'


IRB.conf[:PROMPT_MODE]  = :SIMPLE
IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:EVAL_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

if ENV['RAILS_ENV']
  load File.dirname(__FILE__) + '/.railsrc'
end

alias q exit

ANSI_GREEN    = "\e[32m"
ANSI_RED      = "\e[31m"
ANSI_RESET    = "\033[0m"
ANSI_BOLD       = "\033[1m"
ANSI_LGRAY    = "\033[0;34m"
ANSI_GRAY     = "\033[1;30m"

def extend_console(name, condition = true, &block)
  if condition
    require name
    yield if block_given?
    $console_extensions << "#{ANSI_GREEN}#{name}#{ANSI_RESET}"
  end
rescue LoadError
  $console_extensions << "#{ANSI_RED}#{name}#{ANSI_RESET}"
end
$console_extensions = []

extend_console 'ap' do
  alias pp ap
end

extend_console 'sketches' do
  Sketches.config :editor  => 'mate -w'
end

extend_console 'wirble' do
  Wirble.init
  Wirble.colorize
end

extend_console 'looksee/shortcuts'
extend_console 'interactive_editor'

extend_console 'hirb', ENV['RAILS_ENV'] do
  Hirb.enable
  extend Hirb::Console
end

class Object

  # Print object's methods
  def pm(*options)
    methods = self.methods
    methods -= Object.methods unless options.include? :more
    filter = options.select {|opt| opt.kind_of? Regexp}.first
    methods = methods.select {|name| name =~ filter} if filter

    data = methods.sort.collect do |name|
      method = self.method(name)
      if method.arity == 0
        args = "()"
      elsif method.arity > 0
        n = method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")})"
      elsif method.arity < 0
        n = -method.arity
        args = "(#{(1..n).collect {|i| "arg#{i}"}.join(", ")}, ...)"
      end
      klass = $1 if method.inspect =~ /Method: (.*?)#/
      [name, args, klass]
    end
    max_name = data.collect {|item| item[0].size}.max
    max_args = data.collect {|item| item[1].size}.max
    data.each do |item|
      print " #{ANSI_BOLD}#{item[0].rjust(max_name)}#{ANSI_RESET}"
      print "#{ANSI_GRAY}#{item[1].ljust(max_args)}#{ANSI_RESET}"
      print "   #{ANSI_LGRAY}#{item[2]}#{ANSI_RESET}\n"
    end
    data.size
  end
end

def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def paste
  `pbpaste`
end

def ep
  eval(paste)
end

def quick(repetitions = 100, &block)
  require "benchmark"

  Benchmark.bmbm do |b|
    b.report { repetitions.times &block}
  end
  nil
end

puts "#{ANSI_GRAY}~> Console extensions:#{ANSI_RESET} #{$console_extensions.join(' ')}#{ANSI_RESET}"