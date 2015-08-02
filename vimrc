scriptencoding utf-8
set encoding=utf-8

set nocompatible

filetype off
set rtp+=~/.vim/bundle/Vundle.vim

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

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
set wildignore+=bower_components/*
set wildignore+=node_modules/*
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

set number
set relativenumber

"highlight current line
set cursorline

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
colorscheme base16-ocean
set background=dark

if &term =~ '256color'
    " Disable Background Color Erase (BCE) so that color schemes
    " work properly when Vim is used inside tmux and GNU screen.
    set t_ut=
endif

"configure Kolor scheme
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

if !isdirectory(expand("~/.vim/cache"))
  call mkdir(expand("~/.vim/cache"))
endif
if !isdirectory(expand("~/.vim/cache/backup"))
  call mkdir(expand("~/.vim/cache/backup"))
endif
set backupdir=~/.vim/cache/backup

"Persistent undo
set undofile
if !isdirectory(expand("~/.vim/cache/undo"))
  call mkdir(expand("~/.vim/cache/undo"))
endif
set undodir=~/.vim/cache/undo

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

"remap Leader
let mapleader = "\<Space>"


"search
nnoremap <leader>\ :noh<cr>

"
inoremap jk <esc>

"buffers
map <leader>[ :bprevious<CR>
map <leader>] :bnext<CR>

"save file
nnoremap <Leader>w :w<CR>

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
autocmd BufNewFile,BufRead COMMIT_EDITMSG setlocal spell

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
imap <C-l> =><Space>
let g:rubycomplete_rails = 1

"Format file
map <silent> <F5> mmgg=G`m
imap <silent> <F5> <esc> mmgg=G`m

"root save
cmap w!! %!sudo tee > /dev/null %

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" Git
vmap <Leader>g :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

"Strip all trailing whitespace
nnoremap <leader>W :%!git stripspace<CR>

"Current path
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

"""PLugins


"vim-airline
let g:airline_powerline_fonts = 1

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>
map <C-\> :tnext<CR>

"Unimpaired
nmap <C-Up> [e
nmap <C-Down> ]e
vmap <C-Up> [egv
vmap <C-Down> ]egv

" ZoomWin
map <Leader>z :ZoomWin<CR>

"smooth_scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

"vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

let g:tagbar_type_javascript = {
    \ 'ctagsbin' : '/usr/local/bin/jsctags'
    \ }

"syntastic
let g:syntastic_javascript_checkers = ['eslint']

"rainbow parentheses
" augroup rainbow_javascript
"   autocmd!
"   autocmd FileType javascript RainbowParentheses
" augroup END

"Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
endif

"search for string under cursor
nnoremap <leader>sw :Ag! "\b<C-R><C-W>\b"<CR>:cw<CR>"

"accelerated j k
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"vimfiler
let g:vimfiler_as_default_explorer = 1
call vimfiler#custom#profile('default', 'context', {
    \   'safe' : 0
    \ })

let g:vimfiler_quick_look_command = 'qlmanage -p'
nnoremap <silent> <Leader>E  :VimFiler <CR>

nmap <silent> - :VimFilerBufferDir <CR>
" set fillchars=vert:│,fold:─
" let g:vimfiler_tree_leaf_icon = "⋮"
let g:vimfiler_tree_opened_icon = "▼"
let g:vimfiler_tree_closed_icon = "▷"
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'

"disable netrw
let g:loaded_netrwPlugin = 1

"""vim-multiple-cursors

"make vim-multiple-cursors work with neocomplete

function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
    echo 'Disabled autocomplete'
endfunction

function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
    echo 'Enabled autocomplete'
endfunction

"Neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'


"UtilSnips
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

""neosnippet

" Enable neosnippet snipmate compatibility mode
let g:neosnippet#enable_snipmate_compatibility = 1
imap <C-s>     <Plug>(neosnippet_expand_or_jump)
smap <C-s>     <Plug>(neosnippet_expand_or_jump)
xmap <C-s>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"       \ "\<Plug>(neosnippet_expand_or_jump)"
"       \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"       \ "\<Plug>(neosnippet_expand_or_jump)"
"       \: "\<TAB>"

" <TAB>: completion.
" inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" <CR>: close popup
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

" Use honza's snippets.
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'


" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Disable the neosnippet preview candidate window
" When enabled, there can be too much visual noise
" especially when splits are used.
set completeopt-=preview

"Unite
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_rec_max_cache_files = 0
let g:unite_prompt='» '

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
nnoremap <C-t> :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -no-split -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -no-split -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -no-split -buffer-name=buffer  -start-insert buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Play nice with supertab
  let b:SuperTabDisabled=1
  inoremap <silent><buffer><expr> <C-s>     unite#do_action('split')
  inoremap <silent><buffer><expr> <C-v>     unite#do_action('vsplit')
  inoremap <silent><buffer><expr> <C-t>     unite#do_action('tabopen')
endfunction

if executable('ag')
  let g:unite_source_find_command = 'ag -f --nocolor --nogroup --hidden -g ""'
  let g:unite_source_rec_async_command = 'ag --nocolor --ignore "node_modules" --ignore "bower_components" --ignore "tmp" --nogroup --hidden -g ""'
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
  let g:unite_source_grep_recursive_opt=''
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -a -C4'
  let g:unite_source_grep_recursive_opt=''
endif
