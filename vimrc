scriptencoding utf-8

set nocompatible

filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set modelines=0
syntax on

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nowrap "don't wrap lines
set tabstop=2 "tab is 2 spaces
set shiftwidth=2
set softtabstop=2
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
set wildignore+=*.o,*.obj,.git,*.rbc
set wildignore+=vendor/rails/**
set wildignore+=vendor/ruby/**
set wildignore+=vendor/cache/**
set wildignore+=doc/yard/**

set nowrap

filetype on
filetype indent on
filetype plugin indent on

set smartindent
set autoindent

set relativenumber

set autoread

" Do not force writing modified files to switch buffers
set hidden 

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
color solarized 

"disable beep 
set vb t_vb=

"Folding options
set nofoldenable 
set foldmethod=syntax
set foldnestmax=10
"set foldlevel=1

"Swap and backup
set directory=~/.vim/swapfiles,/tmp,.
set backupdir=~/.vim/backup

"Persistent undo
set undofile


" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"Enable matchit 
runtime  macros/matchit.vim

""" Bindings

"buffers
map <leader>[ :bprevious<CR>
map <leader>] :bnext<CR>


"File types
autocmd BufNewFile,BufRead {Rakefile,Gemfile,Thorfile} setfiletype=ruby
autocmd BufNewFile,BufRead config.ru   setfiletype ruby
autocmd BufNewFile,BufRead *.json  setfiletype javascript

autocmd BufNewFile,BufRead ~/.vim/*  setfiletype vim
autocmd BufNewFile,BufRead ~/.bash/* setfiletype sh

"Windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"ruby specific
" bind control-l to hashrocket
imap <C-l> <Space>=><Space>

"Format file
map <silent> <F5> mmgg=G`m
imap <silent> <F5> <esc> mmgg=G`m

"""PLugins

"Gundo
nnoremap <F6> :GundoToggle<cr>

"NERDTree 
map <leader>n :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>

"NERDCommenter
let NERDSpaceDelims=1 
let NERDCreateDefaultMappings=0 "disable default mapping
map <D-/> <plug>NERDCommenterToggle

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

"ConqueTerm
let g:ConqueTerm_SendVisKey = '<F7>'

"Command-T
let g:CommandTMaxHeight=30

" Git
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR> 

"Strip all trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"Unimpaired 
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" ZoomWin 
map <Leader>z :ZoomWin<CR>

"Current path
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
