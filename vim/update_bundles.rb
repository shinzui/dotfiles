#!/usr/bin/env ruby

git_bundles = [
  "https://github.com/scrooloose/nerdtree.git",
  "https://github.com/tsaleh/vim-supertab.git",
  "https://github.com/sjl/gundo.vim.git",
  "https://github.com/shinzui/vim-snipmate-ruby-snippets.git",
  "https://github.com/kien/ctrlp.vim.git",
  "https://github.com/vim-scripts/dbext.vim.git",
  "https://github.com/h1mesuke/unite-outline.git",
  "https://github.com/vim-scripts/YankRing.vim",
  "https://github.com/sjl/threesome.vim.git",
  "https://github.com/jeetsukumaran/vim-buffergator.git",
  "https://github.com/kana/vim-smartinput.git",
  "https://github.com/chrisbra/NrrwRgn",
  "https://github.com/majutsushi/tagbar.git",
]


vim_org_scripts = [
  ["IndexedSearch", "7062",  "plugin"],
  ["jquery",        "12107", "syntax"],
]

require 'fileutils'
require 'open-uri'

bundles_dir = File.join(File.dirname(__FILE__), "bundle")

FileUtils.cd(bundles_dir)

notrash = ARGV.include?('--notrash')

unless notrash
  puts "Trashing everything (lookout!)"
  Dir["*"].each {|d| FileUtils.rm_rf d }
end

git_bundles.each do |url|
  dir = url.split('/').last.sub(/\.git$/, '')
  if notrash && File.exists?(dir)
    puts "  Skipping #{dir}"
    next
  end
  puts "  Unpacking #{url} into #{dir}"
  `git clone #{url} #{dir}`
  FileUtils.rm_rf(File.join(dir, ".git"))
end

vim_org_scripts.each do |name, script_id, script_type|
  local_file = File.join(name, script_type, "#{name}.#{script_type == 'zip' ? 'zip' : 'vim'}")
  if notrash && File.exists?(local_file)
    puts "  Skipping #{local_file}"
    next
  end
  puts " Downloading #{name}"
  FileUtils.mkdir_p(File.dirname(local_file))
  File.open(local_file, "w") do |file|
    file << open("http://www.vim.org/scripts/download_script.php?src_id=#{script_id}").read
  end
  if script_type == 'zip'
    %x(unzip -d #{name} #{local_file})
  end
end
tomorrow_path = "tomorrow-theme/colors"
FileUtils.mkdir_p(tomorrow_path)
%w{Tomorrow-Night-Blue Tomorrow-Night-Eighties Tomorrow-Night Tomorrow}.each do |item|
  `curl https://raw.github.com/ChrisKempson/Tomorrow-Theme/master/Vim/#{item}.vim > #{tomorrow_path}/#{item.downcase}.vim`
end

