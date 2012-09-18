#!/usr/bin/env ruby

git_bundles = [
  #"git://github.com/astashov/vim-ruby-debugger.git",
  "git://github.com/msanders/snipmate.vim.git",
  "git://github.com/scrooloose/nerdtree.git",
  "git://github.com/shinzui/nerdcommenter.git",
  "git://github.com/timcharper/textile.vim.git",
  "git://github.com/tpope/vim-cucumber.git",
  "git://github.com/tpope/vim-fugitive.git",
  "git://github.com/tpope/vim-git.git",
  "git://github.com/tpope/vim-haml.git",
  "git://github.com/tpope/vim-markdown.git",
  "git://github.com/tpope/vim-rails.git",
  "git://github.com/tpope/vim-rake.git",
  "git://github.com/tpope/vim-repeat.git",
  "git://github.com/tpope/vim-surround.git",
  "git://github.com/tpope/vim-vividchalk.git",
  "git://github.com/tsaleh/vim-align.git",
  "git://github.com/tsaleh/vim-supertab.git",
  "git://github.com/tsaleh/vim-tcomment.git",
  "git://github.com/vim-ruby/vim-ruby.git",
  "git://github.com/mileszs/ack.vim.git",
  "git://github.com/tpope/vim-vividchalk.git",
  "git://github.com/taq/vim-rspec.git",
  "git://github.com/pangloss/vim-javascript.git",
  "git://github.com/michaeljsmith/vim-indent-object.git",
  "git://github.com/shinzui/vim-idleFingers.git",
  "git://github.com/airblade/vim-rooter.git",
  "git://github.com/sjl/gundo.vim.git",
  "git://github.com/vim-scripts/scratch.vim.git",
  "git://github.com/shinzui/vim-snipmate-ruby-snippets.git",
  "git://github.com/vim-scripts/ZoomWin.git",
  "git://github.com/kchmck/vim-coffee-script.git",
  "git://github.com/tpope/vim-unimpaired.git",
  "git://github.com/kogakure/vim-sparkup.git",
  "git://github.com/kana/vim-textobj-user.git",
  "git://github.com/nelstrom/vim-textobj-rubyblock.git",
  "git://github.com/tsaleh/vim-matchit.git",
  "git://github.com/ecomba/vim-ruby-refactoring.git",
  #"git://github.com/wincent/Command-T.git",
  "git://github.com/kien/ctrlp.vim.git",
  "git://github.com/altercation/vim-colors-solarized.git",
  "git://github.com/godlygeek/tabular.git",
  "git://github.com/rygwdn/vim-conque.git",
  "git://github.com/vim-scripts/dbext.vim.git",
  "git://github.com/t9md/vim-chef.git",
  "git://github.com/Shougo/unite.vim.git",
  "git://github.com/h1mesuke/unite-outline.git",
  "git://github.com/tpope/vim-endwise.git",
  "git://github.com/chrismetcalf/vim-yankring.git",
  "git://github.com/robgleeson/hammer.vim.git",
  "git://github.com/mattn/zencoding-vim.git",
  "git://github.com/tpope/vim-bundler.git",
  "git://github.com/tpope/gem-ctags.git",
  "git://github.com/sjl/threesome.vim.git",
  "git://github.com/jeetsukumaran/vim-buffergator.git",
  "git://github.com/sickill/vim-pasta.git",
  "git://github.com/lunaru/vim-less.git",
  "git://github.com/cakebaker/scss-syntax.vim.git",
  "git://github.com/kana/vim-smartinput.git",
  "git://github.com/gregsexton/gitv.git",
  "git://github.com/sjl/clam.vim.git",
  "git://github.com/kurkale6ka/vim-swap.git",
  "git://github.com/scrooloose/syntastic.git",
  "git://github.com/mattn/webapi-vim.git",
  "git://github.com/chrisbra/NrrwRgn",
  "git://https:github.com/skalnik/vim-vroom",
  "git://github.com/lucapette/vim-ruby-doc.git",
  "git://github.com/majutsushi/tagbar.git",
  "git://github.com/29decibel/codeschool-vim-theme.git"
]


vim_org_scripts = [
  ["IndexedSearch", "7062",  "plugin"],
  ["jquery",        "12107", "syntax"],
  ["color-sampler", "12179", "zip"]
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

