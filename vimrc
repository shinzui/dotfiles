scriptencoding utf-8

set nocompatible

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set modelines=0
syntax on


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
color desert


" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

