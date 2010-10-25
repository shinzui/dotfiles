scriptencoding utf-8

set nocompatible

filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set modelines=0
syntax on

"allow backspacing
set backspace=indent,eol,start

set nowrap
set tabstop=2
set shiftwidth=2
set expandtab

" Search config
set incsearch

" highlight search result
set hlsearch
set incsearch
set ignorecase
set smartcase
set gdefault
nnoremap <leader><space> :noh<cr>

" Set temp directory for swp/tmp files
set directory=/tmp/

" Enable tab completion. First tab shows all matches, second tab cycles through them
set wildmenu
set wildmode=list:longest,full


set nowrap

filetype on
filetype indent on

set smartindent
set autoindent


" statusbar
set laststatus=2
set statusline=\ "
set statusline+=%f\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&fileformat}] " file format
set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

"enable and set title
set title
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

"default color scheme
color jellybeans

"disable beep 
set vb t_vb=

"Folding options
set foldenable "enable 

"Swap 
set directory=~/.vim/swapfiles,/tmp,.


" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

""" Bindings

"buffers
map <leader>[ :bprevious<CR>
map <leader>] :bnext<CR>


"File types
autocmd BufNewFile,BufRead Gemfile     setfiletype ruby
autocmd BufNewFile,BufRead config.ru   setfiletype ruby

autocmd BufNewFile,BufRead ~/.vim/*  setfiletype vim
autocmd BufNewFile,BufRead ~/.bash/* setfiletype sh

"ruby specific
" bind control-l to hashrocket
imap <C-l> <Space>=><Space>


"""PLugins

"NERDTree 
map <leader>d :NERDTreeToggle<cr>

"NERDCommenter
let NERDSpaceDelims=1 
let NERDCreateDefaultMappings=0 "disable default mapping
map <D-/> <plug>NERDCommenterToggle

