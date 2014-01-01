scriptencoding utf-8
set encoding=utf-8

set nocompatible

filetype off 
execute pathogen#infect()
call pathogen#helptags()

set modelines=0
syntax on

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nowrap "don't wrap lines
set tabstop=2 "tab is 2 spaces
set tabstop=2 shiftwidth=2 expandtab
set shiftwidth=2
set softtabstop=2
set expandtab

set history=300

" Search config

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

set wildignore+=*.o,*.obj,.git,*.rbc,*.gem,*.zip,*.tar,*.tar.gz
set wildignore+=*.swp,*~
set wildignore+=vendor/rails/**
set wildignore+=vendor/gems/**
set wildignore+=vendor/ruby/**
set wildignore+=vendor/cache/**
set wildignore+=vendor/assets/**
set wildignore+=.bundle/*
set wildignore+=.sass-cache/*
set wildignore+=public/uploads/**
set wildignore+=doc/yard/**,.yardoc/**
set wildignore+=log/**
set wildignore+=tmp/**

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
set t_Co=256
colorscheme lucius
set background=dark

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

let g:kolor_italic=1                    " Enable italic. Default: 1
let g:kolor_bold=1                      " Enable bold. Default: 1
let g:kolor_underlined=0                " Enable underline for 'Underlined'. Default: 0
let g:kolor_alternative_matchparen=0    " Gray 'MatchParen' color. Default: 0


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

"Highlight conflict markers 
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"Enable matchit 
runtime  macros/matchit.vim

if has("user_commands")
   command! -bang -nargs=? -complete=file W w<bang> <args>
   command! -bang -nargs=? -complete=file Wq wq<bang> <args>
endif

""" Bindings

"
inoremap jk <esc>

"buffers
map <leader>[ :bprevious<CR>
map <leader>] :bnext<CR>


"File types
autocmd BufNewFile,BufRead {Rakefile,Gemfile,Thorfile,Vagrantfile} set filetype=ruby
autocmd BufNewFile,BufRead config.ru  set filetype=ruby
autocmd BufNewFile,Bufread *.{md,markdown,mdown,mkd,mkdn} set filetype=markdown
autocmd BufNewFile,Bufread *.yml.example set filetype=yaml
autocmd BufNewFile,BufRead *.json  set filetype=javascript

autocmd BufNewFile,BufRead ~/.vim/*  setfiletype vim
autocmd BufNewFile,BufRead ~/.bash/* setfiletype sh
autocmd BufRead,BufNewFile *.scss set filetype=scss
autocmd BufRead,BufNewFile /usr/local/etc/nginx/* set ft=nginx 


autocmd BufReadPost fugitive://* set bufhidden=delete

autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=model()
autocmd BufRead,BufNewFile *.md setlocal spell
autocmd FileType gitcommit setlocal spell

 " Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete


"Windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"ruby specific
" bind control-l to hashrocket
imap <C-l> <Space>=><Space>
let g:rubycomplete_rails = 1

"Format file
map <silent> <F5> mmgg=G`m
imap <silent> <F5> <esc> mmgg=G`m

"root save
cmap w!! %!sudo tee > /dev/null %


" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

"""PLugins

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"Gundo
nnoremap <F6> :GundoToggle<cr>

"Yank Ring
nnoremap <silent> <Leader>y :YRShow<cr>

"NERDTree 
map <leader>f :NERDTreeToggle<cr>
map <leader>r :NERDTreeFind<cr>

"NERDCommenter
let NERDSpaceDelims=1 
let NERDCreateDefaultMappings=0 "disable default mapping
map <D-/> <plug>NERDCommenterToggle

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

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

"BufferGator
let g:buffergator_viewport_split_policy="T"
let g:buffergator_sort_regime="mru"
let g:buffergator_split_size="50"

"CtrlP
"map <C-t> :CtrlP<CR>
"imap <C-t> <ESC>:CtrlP<CR>

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\',
    \ }


"TagBar
nmap <F8> :TagbarToggle<CR>

if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif

let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '/path/to/jsctags'
    \ }

"Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'

  " Use ag in CtrlP
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " Don't need to cache with ag
  let g:ctrlp_use_caching = 0
endif

nnoremap <leader>sw :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>"

"Neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_max_list = 15
let g:neocomplcache_force_overwrite_completefunc = 1

" SuperTab like snippets behavior.
imap <silent><expr><TAB> neosnippet#expandable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
        \ "\<C-e>" : "\<TAB>")
smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns._ = '\h\w*'

inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><CR> neocomplcache#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" <CR>: close popup
" <s-CR>: close popup and save indent.
"inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
"inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif

let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" Use honza's snippets.
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" Enable neosnippet snipmate compatibility mode
let g:neosnippet#enable_snipmate_compatibility = 1

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Disable the neosnippet preview candidate window
" When enabled, there can be too much visual noise
" especially when splits are used.
set completeopt-=preview

"Unite
let g:unite_source_history_yank_enable = 1
let g:unite_prompt='» '

call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <C-t> :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)

  nmap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <esc> <plug>(unite_exit)
endfunction

if executable('ag')
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
  let g:unite_source_grep_recursive_opt=''
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
  let g:unite_source_grep_recursive_opt=''
endif
