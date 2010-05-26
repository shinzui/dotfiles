scriptencoding utf-8

" Enable syntax highlighting
set nocompatible
syntax on

" Search config
set incsearch

" highlight search result
set hlsearch
set showmatch


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


