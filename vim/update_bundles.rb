#!/usr/bin/env ruby

git_bundles = [
  "https://github.com/msanders/snipmate.vim.git",
  "https://github.com/scrooloose/nerdtree.git",
  "https://github.com/scrooloose/nerdcommenter.git",
  "https://github.com/timcharper/textile.vim.git",
  "https://github.com/tpope/vim-cucumber.git",
  "https://github.com/tpope/vim-fugitive.git",
  "https://github.com/tpope/vim-git.git",
  "https://github.com/tpope/vim-haml.git",
  "https://github.com/tpope/vim-markdown.git",
  "https://github.com/tpope/vim-rails.git",
  "https://github.com/tpope/vim-rake.git",
  "https://github.com/tpope/vim-repeat.git",
  "https://github.com/tpope/vim-surround.git",
  "https://github.com/tpope/vim-vividchalk.git",
  "https://github.com/tsaleh/vim-align.git",
  "https://github.com/tsaleh/vim-supertab.git",
  "https://github.com/tomtom/tcomment_vim",
  "https://github.com/vim-ruby/vim-ruby.git",
  "https://github.com/mileszs/ack.vim.git",
  "https://github.com/pangloss/vim-javascript.git",
  "https://github.com/michaeljsmith/vim-indent-object.git",
  "https://github.com/shinzui/vim-idleFingers.git",
  "https://github.com/airblade/vim-rooter.git",
  "https://github.com/sjl/gundo.vim.git",
  "https://github.com/vim-scripts/scratch.vim.git",
  "https://github.com/shinzui/vim-snipmate-ruby-snippets.git",
  "https://github.com/vits/ZoomWin",
  "https://github.com/kchmck/vim-coffee-script.git",
  "https://github.com/tpope/vim-unimpaired.git",
  "https://github.com/kana/vim-textobj-user.git",
  "https://github.com/nelstrom/vim-textobj-rubyblock.git",
  "https://github.com/tsaleh/vim-matchit.git",
  "https://github.com/kien/ctrlp.vim.git",
  "https://github.com/altercation/vim-colors-solarized.git",
  "https://github.com/godlygeek/tabular.git",
  "https://github.com/rygwdn/vim-conque.git",
  "https://github.com/vim-scripts/dbext.vim.git",
  "https://github.com/t9md/vim-chef.git",
  "https://github.com/Shougo/unite.vim.git",
  "https://github.com/h1mesuke/unite-outline.git",
  "https://github.com/tpope/vim-endwise.git",
  "https://github.com/vim-scripts/YankRing.vim",
  "https://github.com/mattn/emmet-vim",
  "https://github.com/tpope/vim-bundler.git",
  "https://github.com/tpope/gem-ctags.git",
  "https://github.com/sjl/threesome.vim.git",
  "https://github.com/jeetsukumaran/vim-buffergator.git",
  "https://github.com/sickill/vim-pasta.git",
  "https://github.com/lunaru/vim-less.git",
  "https://github.com/cakebaker/scss-syntax.vim.git",
  "https://github.com/kana/vim-smartinput.git",
  "https://github.com/gregsexton/gitv.git",
  "https://github.com/sjl/clam.vim.git",
  "https://github.com/kurkale6ka/vim-swap.git",
  "https://github.com/scrooloose/syntastic.git",
  "https://github.com/mattn/webapi-vim.git",
  "https://github.com/chrisbra/NrrwRgn",
  "https://github.com/skalnik/vim-vroom",
  "https://github.com/lucapette/vim-ruby-doc.git",
  "https://github.com/majutsushi/tagbar.git",
  "https://github.com/29decibel/codeschool-vim-theme.git",
  "https://github.com/vim-scripts/nginx.vim.git",
  "https://github.com/mattn/gist-vim",
  "https://github.com/airblade/vim-gitgutter.git",
  "https://github.com/benmills/vimux.git",
  "https://github.com/epmatsw/ag.vim.git",
  "https://github.com/tpope/vim-dispatch",
  "https://github.com/nono/vim-handlebars.git",
  "https://github.com/zeis/vim-kolor.git",
  "https://github.com/christoomey/vim-tmux-navigator.git",
  "https://github.com/larssmit/vim-getafe.git",
  "https://github.com/othree/html5.vim.git",
  "https://github.com/bling/vim-airline.git",
  "https://github.com/henrik/vim-qargs",
  "https://github.com/noahfrederick/Hemisu.git",
  "https://github.com/rizzatti/dash.vim",
  "https://github.com/rizzatti/funcoo.vim.git",
  "https://github.com/laktek/distraction-free-writing-vim",
  "https://github.com/eddsteel/vim-vimbrant",
  "https://github.com/jonathanfilip/vim-lucius"
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

